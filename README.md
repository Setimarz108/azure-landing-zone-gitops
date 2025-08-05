# Azure Landing Zone with GitOps

Enterprise-grade Azure infrastructure demonstrating modern DevOps practices and German compliance standards.

## 🎯 Project Overview

This project showcases a production-ready Azure Landing Zone implementation using Infrastructure as Code (Terraform) and GitOps principles. Designed to demonstrate enterprise-level Azure architecture expertise and compliance with German data protection requirements.

**Author**: Sebastian Marquez  
**Certifications**: Microsoft Azure Solutions Architect Expert (AZ-305), DevOps Engineer Expert (AZ-400)  
**Focus**: Enterprise Azure infrastructure and DevOps automation

## 🏗️ Architecture

### Infrastructure Components

- **Networking**: 3-tier architecture with dedicated subnets for management, application, and database tiers
- **Security**: Azure Key Vault, Network Security Groups, and policy-based governance  
- **Monitoring**: Centralized logging with Log Analytics and Application Insights
- **Compliance**: GDPR-compliant setup with German data residency

### Network Architecture

```
Internet → Management Subnet (10.1.1.0/24) → Bastion/Admin Access
            ↓
         Application Subnet (10.1.2.0/24) → Web/App Services
            ↓
         Database Subnet (10.1.3.0/24) → Data Layer
            ↓
         Log Analytics ← Centralized Monitoring
```

## 🛡️ Security & Compliance

### GDPR Compliance Features

- **Data Residency**: All resources deployed in Germany West Central region
- **Retention Policies**: 90-day log retention for dev, 365-day for production
- **Access Controls**: Network-based restrictions and RBAC implementation
- **Audit Logging**: Comprehensive activity monitoring and alerting

### Security Implementation

- **Network Segmentation**: Dedicated NSGs for each tier with least-privilege access
- **Secrets Management**: Azure Key Vault with soft delete and purge protection
- **Policy Enforcement**: Automated compliance checking for tagging and locations
- **Monitoring**: Security Center integration with automated alerting

## 📊 Monitoring & Observability

### Monitoring Stack

- **Log Analytics Workspace**: Centralized logging and query platform
- **Application Insights**: Application performance monitoring and diagnostics
- **Network Monitoring**: NSG flow logs and network diagnostics
- **Alerting**: Automated notifications for security and performance events

### Key Metrics Tracked

- Resource creation/deletion activities
- Network security group rule violations
- Application performance and availability
- Cost and resource utilization

## 🚀 Technologies Used

### Infrastructure

- **Terraform**: Infrastructure as Code with modular design
- **Azure Resource Manager**: Native Azure resource management
- **Azure CLI**: Command-line resource administration

### Azure Services

- **Compute**: Virtual Networks, Network Security Groups
- **Security**: Key Vault, Azure Security Center, Azure Policy
- **Monitoring**: Log Analytics, Application Insights, Azure Monitor
- **Storage**: Diagnostic storage with encryption and retention policies

## 📁 Repository Structure

```
├── terraform/
│   ├── main.tf                    # Main configuration
│   ├── variables.tf               # Input variables
│   ├── outputs.tf                 # Output values
│   ├── modules/
│   │   ├── networking/            # VNet, subnets, NSGs
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── monitoring/            # Log Analytics, App Insights
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── security/              # Key Vault, policies
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   └── environments/
│       ├── dev/
│       │   └── terraform.tfvars   # Development configuration
│       ├── staging/
│       │   └── terraform.tfvars   # Staging configuration
│       └── prod/
│           └── terraform.tfvars   # Production configuration
├── docs/
│   ├── ARCHITECTURE.md            # Detailed architecture documentation
│   └── terraform-plan-output.txt  # Validated deployment plan
└── README.md                      # This file
```

## 🚦 Getting Started

### Prerequisites

- Azure CLI installed and authenticated
- Terraform >= 1.0 installed
- Azure subscription with Contributor access
- Git for version control

### Quick Start

```bash
# Clone the repository
git clone https://github.com/[your-username]/azure-landing-zone-gitops.git
cd azure-landing-zone-gitops/terraform

# Initialize Terraform
terraform init

# Review the deployment plan
terraform plan -var-file="environments/dev/terraform.tfvars"

# Deploy the infrastructure (optional)
terraform apply -var-file="environments/dev/terraform.tfvars"
```

### Environment Configuration

Each environment has its own configuration file:

- **Development**: Basic setup for testing and development
- **Staging**: Pre-production with enhanced security policies
- **Production**: High availability with full monitoring and backup

## 💰 Cost Management

### Estimated Monthly Costs (Development Environment)

- **Log Analytics Workspace**: €2-5/month
- **Application Insights**: €1-3/month
- **Storage Account**: €1-2/month
- **Key Vault**: €0.50/month
- **Virtual Network**: Free
- **Network Security Groups**: Free

**Total Estimated**: €5-12/month for development environment

### Cost Optimization Features

- Environment-specific resource sizing
- Automated resource tagging for cost allocation
- Retention policies to manage storage costs
- Budget alerts and monitoring

## 🎯 Project Outcomes

### Infrastructure Validated

✅ **19 Azure resources** successfully planned and validated  
✅ **3-tier network architecture** with proper security segmentation  
✅ **Comprehensive monitoring** with centralized logging  
✅ **GDPR compliance** with German data residency  
✅ **Enterprise governance** with automated policy enforcement  

### Skills Demonstrated

- **Azure Solutions Architecture** (AZ-305 expertise)
- **DevOps Engineering** (AZ-400 practices)
- **Infrastructure as Code** with Terraform
- **Security and Compliance** implementation
- **Cost management** and optimization
- **Enterprise governance** and policy management

## 🌍 German Market Compliance

### GDPR Requirements Met

- **Data Residency**: Resources deployed in Germany West Central
- **Data Retention**: Configurable retention periods (90-365 days)
- **Access Logging**: Comprehensive audit trails
- **Right to be Forgotten**: Automated data purging capabilities

### Security Standards

- **Network Isolation**: Multi-tier network segmentation
- **Encryption**: Data encrypted at rest and in transit
- **Access Control**: Role-based access with principle of least privilege
- **Monitoring**: Continuous security monitoring and alerting

## 📈 Business Value

### For Organizations

- **Reduced deployment time** from weeks to hours
- **Consistent environments** across development lifecycle
- **Automated compliance** checking and reporting
- **Cost optimization** through proper resource sizing and monitoring

### For Development Teams

- **Self-service infrastructure** provisioning
- **Standardized environments** reducing configuration drift
- **Integrated monitoring** for faster troubleshooting
- **Security by design** with built-in best practices

## 🔄 CI/CD Integration (Planned)

### Azure DevOps Pipeline (Week 3)

- Automated Terraform validation and planning
- Multi-environment deployment with approvals
- Infrastructure drift detection
- Cost impact analysis

### GitOps Workflow

- Pull request-based infrastructure changes
- Automated testing and validation
- Environment promotion pipeline
- Rollback capabilities

## 📚 Documentation

- [Architecture Overview](docs/ARCHITECTURE.md) - Detailed technical architecture
- [Terraform Plan Output](docs/terraform-plan-output.txt) - Validated deployment plan
- [Cost Analysis](docs/cost-analysis.md) - Resource cost breakdown
- [Security Implementation](docs/security.md) - Security controls and compliance

## 🤝 Contributing

This is a portfolio project demonstrating enterprise Azure infrastructure capabilities. While not actively seeking contributions, feedback and suggestions for improvements are welcome.

## 📄 License

This project is created for educational and portfolio purposes. Feel free to use as inspiration for your own Azure infrastructure projects.

## 📞 Contact

**Sebastian Marquez**  
📧 sebastian.marquez.dev@gmail.com  
💼 [LinkedIn](https://linkedin.com/in/sebastian-marquez)  
🔗 [Azure Certifications](https://learn.microsoft.com/en-us/users/sebastianmarquez-4965/transcript/vn64qs4k163pkor)  

---

*This project demonstrates enterprise-grade Azure infrastructure design and implementation, showcasing practical application of Microsoft Azure certifications AZ-305 (Solutions Architect Expert) and AZ-400 (DevOps Engineer Expert).*
