.PHONY: help

help:  ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

.setup_done:  ## Set up development environment
	@echo "Setting up development environment..."
	pipx install planemo
	@touch .setup_done

test: .setup_done  ## Run tests
	@echo "Running tests..."
	planemo t --no_wait --galaxy_branch release_24.2 --skip_venv --biocontainers --job_config_file job_conf.yml --job_output_files ./.testing

lint: .setup_done ## Run linter
	@echo "Running linter..."
	planemo l

upload: .setup_done ## Upload package
	@echo "Uploading package..."
	planemo shed_update --shed_target toolrepo --force_repository_creation