package test

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"strings"
	"github.com/gruntwork-io/terratest/modules/logger"
	"testing"
)

const vpcDir = "../examples/vpc"
const rdsDir = "../examples/aurora"
const mysqlDir = "../examples/mysqlusers"

type TestVPCData struct {
	vpc_name        string
	vpc_cidr        string
	private_subnets []string
	public_subnets  []string
	vpc_tags        map[string]string
}

type TestRDS struct {
	cluster_name               string
	application                string
	environment                string
	description                string
	Creator                    string
	tags                       map[string]string
	admin_user                 string
	admin_password             string
	vpc_id                     string
	vpc_rds_security_group_ids []string
	aws_region                 string
	db_port                    int
	standard_cluster           bool
	instance_type              string
	publicly_accessible        bool
	engine                     string
	engine_mode                string
	engine_version             string
	publicly_network_ids       []string
	private_network_ids        []string
	cidr_blocks_for_public     []string
}

type M map[string]interface{}

type mysql_cred struct {
	endpoint string
	username string
	password string
}
type TestMySQL struct {
	mysql_credentials               mysql_cred
	aws_secret_manager_secrets_name string
	new_databases                   []string
	users_for_test                  []M
}

// - Create VPC
// - Create RDS cluster
// - Create databases
// - Create users
// - Check connection for each user to all databases
func TestComplete(t *testing.T) {
	uniqueId := strings.ToLower(random.UniqueId())
	logger.Log(t, "uniqueId is ", uniqueId, ". It will be added to resource name")
	logger.Log(t, "Will create VPC with name ", "test-vpc-%s", uniqueId)
	var tcVPC = TestVPCData{
		vpc_name:        fmt.Sprintf("test-vpc-%s", uniqueId),
		vpc_cidr:        "10.0.0.0/16",
		private_subnets: []string{"10.0.1.0/24", "10.0.2.0/24"},
		public_subnets:  []string{"10.0.101.0/24", "10.0.102.0/24"},
		vpc_tags:        map[string]string{"name": "test"},
	}

	vpcOpts := configureTerraformOptionsVPC(t, vpcDir, tcVPC)
	defer terraform.Destroy(t, vpcOpts)
	terraform.InitAndApply(t, vpcOpts)

	vpc_id := terraform.Output(t, vpcOpts, "vpc_id")
	logger.Log(t, "VPC created. vpc_id is ", vpc_id)
	sg_id := terraform.Output(t, vpcOpts, "default_security_group_id")
	logger.Log(t, "Will use security group", sg_id)
	publicly_network_ids := terraform.OutputList(t, vpcOpts, "public_subnets")
	private_network_ids := terraform.OutputList(t, vpcOpts, "private_subnets")

	assert.Contains(t, vpc_id, "vpc-")

	var tcRDS = TestRDS{

		cluster_name:               fmt.Sprintf("test-%s", uniqueId),
		application:                "testrds",
		environment:                "tst",
		description:                "test rds",
		Creator:                    "",
		tags:                       tcVPC.vpc_tags,
		admin_user:                 "admin",
		admin_password:             fmt.Sprintf("password%s", uniqueId),
		vpc_id:                     vpc_id,
		vpc_rds_security_group_ids: []string{sg_id},
		aws_region:                 "eu-west-1",
		db_port:                    3306,
		standard_cluster:           true,
		instance_type:              "db.t2.small",
		publicly_accessible:        true,
		engine:                     "aurora-mysql",
		engine_mode:                "provisioned",
		engine_version:             "5.7.mysql_aurora.2.07.1",
		publicly_network_ids:       publicly_network_ids,
		private_network_ids:        private_network_ids,
		cidr_blocks_for_public:     []string{"91.193.126.151/32", "46.37.195.48/32"},
	}

	rdsOpts := configureTerraformOptionsRDS(t, rdsDir, tcRDS)
	defer terraform.Destroy(t, rdsOpts)

	logger.Log(t, "Will create RDS cluster with folowing parameters")
	logger.Log(t, "cluster_name:", tcRDS.cluster_name)
	logger.Log(t, "engine:", tcRDS.engine)
	logger.Log(t, "engine_version:", tcRDS.engine_version)

	terraform.InitAndApply(t, rdsOpts)

	cred := mysql_cred{
		endpoint: terraform.Output(t, rdsOpts, "endpoint"),
		username: terraform.Output(t, rdsOpts, "admin_user"),
		password: terraform.Output(t, rdsOpts, "admin_password"),
	}

	logger.Log(t, "Cluster created. Endpoint ", terraform.Output(t, rdsOpts, "endpoint"))

	var users_for_test []M

	// users for test create and connections
	user1 := M{"username": "user1", "host": "any", "role": "qa", "password": fmt.Sprintf("pass-for-user1-%s", uniqueId), "database": []string{"*"}}
	user2 := M{"username": "user2", "host": "any", "role": "dev", "password": fmt.Sprintf("pass-for-user2-%s", uniqueId), "database": []string{"*"}}

	users_for_test = append(users_for_test, user1, user2)

	var tcMysql = TestMySQL{
		mysql_credentials:               cred,
		aws_secret_manager_secrets_name: "mysql-users",
		new_databases:                   []string{fmt.Sprintf("test1%s", uniqueId), fmt.Sprintf("test2%s", uniqueId)},
		users_for_test:                  users_for_test,
	}

	mysqlOpts := configureTerraformOptionsMySql(t, mysqlDir, tcMysql)
	defer terraform.Destroy(t, mysqlOpts)

	logger.Log(t, "Will create folowing databases and users:")
	logger.Log(t, "databases:", tcMysql.new_databases)
	logger.Log(t, "users:", tcMysql.users_for_test)
	terraform.InitAndApply(t, mysqlOpts)

	// check connection for each user for each database
	for _, v := range users_for_test {
		logger.Log(t, "Check access for user ", v["username"].(string))
		for _, x := range tcMysql.new_databases {
			logger.Log(t, "Connection to db ", x, " with username ", v["username"].(string))
			checkMysqlConnection(t, cred.endpoint, x, v["username"].(string), v["password"].(string))
		}
	}

}

// *terraform.Options for VPC
func configureTerraformOptionsVPC(t *testing.T, terraformDir string, tc TestVPCData) *terraform.Options {

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"vpc_name":        tc.vpc_name,
			"vpc_cidr":        tc.vpc_cidr,
			"private_subnets": tc.private_subnets,
			"public_subnets":  tc.public_subnets,
			"tags":            tc.vpc_tags,
		},
	}

	return terraformOptions

}

// *terraform.Options for RDS
func configureTerraformOptionsRDS(t *testing.T, terraformDir string, tc TestRDS) *terraform.Options {

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"cluster_name":               tc.cluster_name,
			"application":                tc.application,
			"environment":                tc.environment,
			"description":                tc.description,
			"Creator":                    tc.Creator,
			"tags":                       tc.tags,
			"admin_user":                 tc.admin_user,
			"admin_password":             tc.admin_password,
			"vpc_id":                     tc.vpc_id,
			"vpc_rds_security_group_ids": tc.vpc_rds_security_group_ids,
			"aws_region":                 tc.aws_region,
			"db_port":                    tc.db_port,
			"standard_cluster":           tc.standard_cluster,
			"instance_type":              tc.instance_type,
			"publicly_accessible":        tc.publicly_accessible,
			"engine":                     tc.engine,
			"engine_mode":                tc.engine_mode,
			"engine_version":             tc.engine_version,
			"publicly_network_ids":       tc.publicly_network_ids,
			"private_network_ids":        tc.private_network_ids,
			"cidr_blocks_for_public":     tc.cidr_blocks_for_public,
		},
	}

	return terraformOptions

}

// *terraform.Options for MySQL
func configureTerraformOptionsMySql(t *testing.T, terraformDir string, tc TestMySQL) *terraform.Options {

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{

			"use-local-userlist":              true,
			"use-aws-secret-userlist":         false,
			"aws-secret-manager-secrets-name": tc.aws_secret_manager_secrets_name,
			"new-databases":                   tc.new_databases,
			"users":                           tc.users_for_test,
			"mysql-credentials":               M{"endpoint": tc.mysql_credentials.endpoint, "username": tc.mysql_credentials.username, "password": tc.mysql_credentials.password},
		},
	}

	return terraformOptions

}

func checkMysqlConnection(t *testing.T, endpoint string, dbName string, username string, password string) {
	print(dbName)
	db, err := sql.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:3306)/%s", username, password, endpoint, dbName))
	require.Nil(t, err)
	defer db.Close()
	res, err := db.Query("DO 1")
	require.Nil(t, err)
	logger.Log(t, "Connection successfull")
	defer res.Close()
}
