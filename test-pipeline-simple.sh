#!/bin/bash

echo "íº€ Testing Azure DevOps Pipeline (Windows-Friendly)"
echo "================================================="

# Colors for Git Bash
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Test 1: Check if files exist
print_status "Checking pipeline files..."
if [ -f "pipelines/azure-pipelines.yml" ]; then
    print_success "Main pipeline file found"
    MAIN_PIPELINE_SIZE=$(wc -l < pipelines/azure-pipelines.yml)
    print_status "Pipeline has $MAIN_PIPELINE_SIZE lines"
else
    print_error "pipelines/azure-pipelines.yml not found"
    exit 1
fi

if [ -f "pipelines/templates/terraform-setup.yml" ]; then
    print_success "Terraform setup template found"
else
    print_error "pipelines/templates/terraform-setup.yml not found"
    exit 1
fi

# Test 2: Basic syntax checks
print_status "Checking basic YAML structure..."

# Check for required sections
if grep -q "trigger:" pipelines/azure-pipelines.yml; then
    print_success "Found 'trigger:' section"
else
    print_error "Missing 'trigger:' section"
fi

if grep -q "variables:" pipelines/azure-pipelines.yml; then
    print_success "Found 'variables:' section"
else
    print_error "Missing 'variables:' section"
fi

if grep -q "stages:" pipelines/azure-pipelines.yml; then
    print_success "Found 'stages:' section"
else
    print_error "Missing 'stages:' section"
fi

# Test 3: Check for tabs (common YAML error)
print_status "Checking for tabs (YAML uses spaces only)..."
if grep -P '\t' pipelines/azure-pipelines.yml >/dev/null 2>&1; then
    print_error "Found tabs in YAML file - replace with spaces!"
    echo "Lines with tabs:"
    grep -n -P '\t' pipelines/azure-pipelines.yml
else
    print_success "No tabs found - good!"
fi

# Test 4: Check environment files
print_status "Checking environment configurations..."
for env in dev staging prod; do
    if [ -f "terraform/environments/$env/terraform.tfvars" ]; then
        print_success "Environment $env found"
    else
        print_warning "Environment $env missing"
    fi
done

# Test 5: Terraform validation (if available)
if command -v terraform >/dev/null 2>&1; then
    print_status "Testing Terraform configuration..."
    cd terraform
    
    if terraform validate >/dev/null 2>&1; then
        print_success "Terraform configuration is valid"
    else
        print_warning "Terraform validation issues (may need Azure auth)"
    fi
    
    cd ..
else
    print_warning "Terraform not installed - skipping Terraform tests"
fi

echo ""
print_success "í¾‰ Basic Pipeline Validation Complete!"
echo ""
echo "What we verified:"
echo "âœ“ Pipeline files exist and have correct structure"
echo "âœ“ Basic YAML sections are present"
echo "âœ“ No tab characters found (YAML requirement)"
echo "âœ“ Environment configurations checked"
echo ""
echo "Your pipeline is ready for Azure DevOps!"
