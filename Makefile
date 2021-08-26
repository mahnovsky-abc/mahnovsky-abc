.PHONY: check tfdocs tflint tfsec tfdocs_macosx tflint_macosx help all

TERRAFORM-DOCS-TAG=v0.15.0
SHFMT-TAG=v3.3.1

GREEN='\033[0;32m'
NC='\033[0m' # No Color

KERNEL_NAME :=
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		KERNEL_NAME := linux
	endif
	ifeq ($(UNAME_S),Darwin)
		KERNEL_NAME := macosx
	endif

help:
	@echo -e ${GREEN}
	@echo "Usage: make [targets]"
	@echo " "
	@echo "Targets list:"
	@echo "  check              - Check required software"
	@echo "  pre-commit         - Install pre-commit framework;"
	@echo "  all                - Install required linters (automatic detection of the operating system);"
	@echo "  all_linux          - Install required linters on Linux;"
	@echo "  install            - Set up the git hook scripts;"
	@echo "  tfdocs             - Install terraform-docs linter;"
	@echo "  tflint             - Install tflint linter;"
	@echo "  tfsec              - Install tfsec linter;"
	@echo "  shfmt				- Install shfmt shell parser"
	@echo "  all_macosx         - Install required linters on MacOSX;"
	@echo "  pre-commit_macosx  - Install pre-commit framework on MacOSX;"
	@echo "  tfdocs_macosx      - Install terraform-docs linter;"
	@echo "  tflint_macosx      - Install tflint linter;"
	@echo "  help               - Show this help."
	@echo " "
	@echo "Requirements:"
	@echo "Common:"
	@echo "  - cURL (see https://curl.se/);"
	@echo "  - GNU Make (see https://www.gnu.org/software/make/)."
	@echo "  - Python 3.8 or newer (see https://www.python.org/downloads/);"
	@echo "Linux users:"
	@echo "  - Go 1.14 or newer (see https://golang.org/doc/install#install);"
	@echo "MacOSX users:"
	@echo "  - Homebrew (see https://brew.sh/) if you are MacOSX user."
	@echo -e ${NC}

check:
	@./check_software.sh

pre-commit:
	@curl https://pre-commit.com/install-local.py | python3 -
	@pre-commit --version

install:
	@pre-commit install

tfdocs:
	@GO111MODULE="on" go install github.com/terraform-docs/terraform-docs@$(TERRAFORM-DOCS-TAG)

tflint:
	@curl https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

tfsec:
	@go install github.com/aquasecurity/tfsec/cmd/tfsec@latest

shfmt:
	@GO111MODULE="on" go install mvdan.cc/sh/v3/cmd/shfmt@$(SHFMT-TAG)

all_linux: pre-commit tfdocs tflint tfsec shfmt

#MacOSX
pre-commit_macosx:
	brew install pre-commit

tfdocs_macosx:
	brew install terraform-docs

tflint_macosx:
	brew install tflint

tfsec_macosx:
	brew install tfsec

all_macosx: pre-commit_macosx tfdocs_macosx tflint_macosx tfsec_macosx

all:
	$(MAKE) all_$(KERNEL_NAME)