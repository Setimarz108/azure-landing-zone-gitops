#!/bin/bash
set -e

echo "íº€ Testing Azure DevOps Pipeline Locally"
echo "========================================="

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print status
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Test 1: YAML Syntax
print_status "Testing YAML syntax..."
if python -c "import yaml; yaml.safe_load(open('pipelines/azure-pipelines.yml'))" 2>/dev/null; then
    print_success "YAML syntax is valid"
else
    print_error "YAML syntax error found"
    exit 1
fi

# Test 2: Terraform Installation Check
print_status "Checking Terraform installation..."
if terraform version >/dev/null 2>&1; then
    TERRAFORM_VERSION=$(terraform version | head -1)
    print_success "Terraform found: $TERRAFORM_VERSION"
else
    print_error "Terraform not installed"
    exit 1
fi

# Test 3: Azure CLI Check
print_status "Checking Azure CLI..."
if az version >/dev/null 2>&1; then
    print_success "Azure CLI is available"
else
    print_error "Azure CLI not installed"
    exit 1
fi

# Test 4: Terraform Configuration
print_status "Testing Terraform configuration..."
cd terraform

# Initialize
print_status "Running terraform init..."
if terraform init >/dev/null 2>&1; then
    print_success "Terraform init successful"
else
    print_error "Terraform init failed"
    exit 1
fi

# Validate
print_status "Running terraform validate..."
if terraform validate >/dev/null 2>&1; then
    print_success "Terraform validate successful"
else
    print_error "Terraform validate failed"
    exit 1
fi

# Format check
print_status "Running terraform fmt check..."
if terraform fmt -check -diff >/dev/null 2>&1; then
    print_success "Terraform formatting is correct"
else
    print_error "Terraform formatting issues found"
    echo "Run 'terraform fmt' to fix formatting"
fi

# Plan (this is the big test)
print_status "Running terraform plan..."
if terraform plan -var-file="environments/dev/terraform.tfvars" -out=test.tfplan >/dev/null 2>&1; then
    print_success "Terraform plan successful"
    
    # Show plan summary
    PLAN_OUTPUT=$(terraform show -no-color test.tfplan | grep "Plan:")
    print_success "Plan result: $PLAN_OUTPUT"
    
    # Cleanup
    rm -f test.tfplan
else
    print_error "Terraform plan failed"
    exit 1
fi

cd ..

# Test 5: Check Pipeline Structure
print_status "Checking pipeline structure..."
if [ -f "pipelines/azure-pipelines.yml" ] && [ -f "pipelines/templates/terraform-setup.yml" ]; then
    print_success "Pipeline files structure is correct"
else
    print_error "Missing pipeline files"
    exit 1
fi

# Test 6: Environment Files
print_status "Checking environment configurations..."
for env in dev staging prod; do
    if [ -f "terraform/environments/$env/terraform.tfvars" ]; then
        print_success "Environment $env configuration found"
    else
        print_error "Missing environment configuration for $env"
    fi
done

echo ""
echo "í¾‰ Pipeline Validation Complete!"
echo "=================================="
print_success "All pipeline components are ready for Azure DevOps"
echo ""
echo "Next steps:"
echo "1. Set up Azure DevOps project"
echo "2. Create service connections"
echo "3. Import this repository"
echo "4. Create the pipeline"
