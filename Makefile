.PHONY: help

help:  ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

setup:  ## Set up development environment
	@echo "Setting up development environment..."
	pipx install planemo
	@touch .setup_done

test: setup  ## Run tests
	@echo "Running tests..."
	planemo t --

lint: setup ## Run linter
	@echo "Running linter..."
	# Add your lint commands here

upload: setup ## Upload package
	@echo "Uploading package..."
	# Add your upload commands here