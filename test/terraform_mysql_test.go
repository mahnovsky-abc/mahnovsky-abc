package test

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"strings"
	"testing"
)

const sourceDir = "../examples/test"

type TestData struct {
	vpc_name string

	cluster_name                    string
	application                     string
	environment                     string
	description                     string
	Creator                         string
	admin_user                      string
	admin_password                  string
	aws_region                      string
	db_port                         int
	standard_cluster                bool
	instance_type                   string
	iam_authentication_enabled      bool
	publicly_accessible             bool
	engine                          string
	engine_mode                     string
	engine_version                  string
	cidr_blocks_for_public          []string
	aws_secret_manager_secrets_name string
	new_databases                   []string
	users_for_test                  []M
	allow_access_from_github        bool
}

type M map[string]interface{}

var users_for_test []M

// - Create VPC
// - Create RDS cluster
// - Create databases
// - Create users
// - Check connection for each user to all databases
func TestMySQL(t *testing.T) {
	uniqueId := strings.ToLower(random.UniqueId())
	logger.Log(t, "uniqueId is ", uniqueId, ". It will be added to resource name")
	logger.Log(t, "Will create VPC with name ", "test-vpc-", uniqueId)

	// users for test create and connections
	user1 := M{"username": "user1", "host": "any", "role": "qa", "password": fmt.Sprintf("pass-for-user1-%s", uniqueId), "database": []string{"*"}}
	user2 := M{"username": "user2", "host": "any", "role": "dev", "password": fmt.Sprintf("pass-for-user2-%s", uniqueId), "database": []string{"*"}}

	users_for_test = append(users_for_test, user1, user2)

	var tc = TestData{
		vpc_name:                        fmt.Sprintf("test-vpc-%s", uniqueId),
		cluster_name:                    fmt.Sprintf("test-%s", uniqueId),
		application:                     "testrds",
		environment:                     "tst",
		description:                     "test rds",
		Creator:                         "",
		admin_user:                      "admin",
		admin_password:                  fmt.Sprintf("password%s", uniqueId),
		aws_region:                      "eu-west-1",
		db_port:                         3306,
		standard_cluster:                true,
		instance_type:                   "db.t2.medium",
		publicly_accessible:             true,
		iam_authentication_enabled:      true,
		engine:                          "aurora-mysql",
		engine_mode:                     "provisioned",
		engine_version:                  "5.7.mysql_aurora.2.07.1",
		cidr_blocks_for_public:          []string{"91.193.125.11/32", "0.0.0.0/0"},
		aws_secret_manager_secrets_name: "mysql-users",
		new_databases:                   []string{fmt.Sprintf("test1%s", uniqueId), fmt.Sprintf("test2%s", uniqueId)},
		users_for_test:                  users_for_test,
		allow_access_from_github:        false,
	}

	TerraOpts := configureTerraformOptions(t, sourceDir, tc)
	defer terraform.Destroy(t, TerraOpts)
	terraform.InitAndApply(t, TerraOpts)

	vpc_id := terraform.Output(t, TerraOpts, "vpc_id")
	logger.Log(t, "VPC created. vpc_id is ", vpc_id)
	assert.Contains(t, vpc_id, "vpc-")

	sg_id := terraform.Output(t, TerraOpts, "default_security_group_id")
	logger.Log(t, "Default security group", sg_id)
	require.NotEmpty(t, sg_id)

	cluster_identifier := terraform.Output(t, TerraOpts, "cluster_identifier")
	require.NotEmpty(t, cluster_identifier)

	endpoint := terraform.Output(t, TerraOpts, "endpoint")
	require.NotEmpty(t, endpoint)

	logger.Log(t, "RDS cluster parameters")
	logger.Log(t, "cluster_name:", cluster_identifier)
	logger.Log(t, "engine:", tc.engine)
	logger.Log(t, "engine_version:", tc.engine_version)
	logger.Log(t, "Endpoint ", endpoint)

	logger.Log(t, "Created folowing databases and users:")
	logger.Log(t, "databases:", tc.new_databases)
	logger.Log(t, "users:", tc.users_for_test)

	// check connection for each user for each database
	for _, v := range users_for_test {
		logger.Log(t, "Check access for user ", v["username"].(string))
		for _, x := range tc.new_databases {
			logger.Log(t, "Connection to db ", x, " with username ", v["username"].(string))
			checkMysqlConnection(t, endpoint, x, v["username"].(string), v["password"].(string))
		}
	}

}

// *terraform.Options
func configureTerraformOptions(t *testing.T, terraformDir string, tc TestData) *terraform.Options {

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"vpc_name":                        tc.vpc_name,
			"cluster_name":                    tc.cluster_name,
			"application":                     tc.application,
			"environment":                     tc.environment,
			"description":                     tc.description,
			"Creator":                         tc.Creator,
			"admin_user":                      tc.admin_user,
			"admin_password":                  tc.admin_password,
			"aws_region":                      tc.aws_region,
			"db_port":                         tc.db_port,
			"standard_cluster":                tc.standard_cluster,
			"instance_type":                   tc.instance_type,
			"publicly_accessible":             tc.publicly_accessible,
			"engine":                          tc.engine,
			"engine_mode":                     tc.engine_mode,
			"engine_version":                  tc.engine_version,
			"cidr_blocks_for_public":          tc.cidr_blocks_for_public,
			"iam_authentication_enabled":      tc.iam_authentication_enabled,
			"use-local-userlist":              true,
			"use-aws-secret-userlist":         false,
			"aws-secret-manager-secrets-name": tc.aws_secret_manager_secrets_name,
			"new-databases":                   tc.new_databases,
			"users":                           tc.users_for_test,
			"allow_access_from_github":        tc.allow_access_from_github,
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
