# Terraform Flex Gateway Configuration

This repository contains Terraform configuration for deploying and managing MuleSoft Flex Gateway using the Anypoint Platform provider.

## Prerequisites

### 1. Install Terraform

Download and install Terraform from [terraform.io](https://www.terraform.io/downloads)

**Verify installation:**
```powershell
terraform version
```

### 2. Install Required Providers

The configuration requires the Anypoint provider (v1.8.2). Providers will be automatically installed when you run `terraform init`.

## Setup

### 1. Configure Environment Variables

Create a `terraform.tfvars` file based on the provided example:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your actual values:
- `cplane`: Control plane (us, eu, or ap)
- `root_org`: Organization GUID from Anypoint Platform
- `env_id`: Environment GUID from Anypoint Platform
- `client_id`: Anypoint Platform client ID
- `client_secret`: Anypoint Platform client secret

**For different environments, use environment-specific files:**
```powershell
# Development
terraform apply -var-file="terraform.tfvars.dev"

# Non-Production
terraform apply -var-file="terraform.tfvars.npd"

# Production
terraform apply -var-file="terraform.tfvars.prd"
```

### 2. Initialize Terraform

```powershell
terraform init
```

This downloads required providers and initializes the Terraform working directory.

## Deployment

### 1. Review the Plan

```powershell
terraform plan
```

This shows what resources will be created or modified.

### 2. Apply the Configuration

```powershell
terraform apply
```

Review the changes and confirm with `yes` to deploy.

### 3. Monitor Deployment

```powershell
terraform show
```

View current infrastructure state.

## File Structure

- `provider.tf` - Anypoint provider configuration
- `main.tf` - Resource definitions for Flex Gateway deployment
- `variables.tf` - Variable definitions with GUID validation
- `debug.tf` - Debug outputs for inspecting available targets
- `terraform.tfvars.example` - Example variables (safe to commit)
- `terraform.tfvars.dev` - Development environment example
- `terraform.tfvars.npd` - Non-production environment example
- `terraform.tfvars.prd` - Production environment example
- `terraform.tfvars` - Local variables (git ignored, DO NOT commit)

## Important Notes

⚠️ **Security:**
- Never commit `terraform.tfvars` with real credentials
- The `.gitignore` file excludes sensitive files from version control
- Use only the `.example` files in the repository

⚠️ **State Files:**
- `terraform.tfstate` and `terraform.tfstate.backup` are git ignored
- For team collaboration, consider using remote state (Terraform Cloud, S3, etc.)

## Finding Your IDs in Anypoint Platform

1. Log in to [Anypoint Platform](https://anypoint.mulesoft.com)
2. Organization GUID (`root_org`): Found in URL when viewing organization settings
3. Environment GUID (`env_id`): Found in URL when viewing environment
4. Target ID: Found under Flex Gateway targets in your environment

## Creating a Service Account (API Credentials)

To obtain `client_id` and `client_secret`, you need to create a Connected Application or API credentials in Anypoint Platform:

### Steps to Create API Credentials:

1. **Log in to Anypoint Platform** as an Organization Administrator
2. **Navigate to Access Management**:
   - Click on your profile icon (top right)
   - Select **Access Management**
3. **Go to API Credentials** (or Connected Applications):
   - Select **API Credentials** from the left menu
   - Click **Create Credentials**
4. **Configure the Application**:
   - **Name**: e.g., "Terraform Flex Gateway"
   - **Type**: Select "OAuth 2.0" (or the appropriate auth type)
   - **Scope**: Grant necessary permissions for managing Flex Gateways
5. **Copy Credentials**:
   - Copy the generated `client_id` and `client_secret`
   - Store them securely (use in `terraform.tfvars`)

### Permissions Required:

The service account needs permissions to:
- Manage Flex Gateway targets
- Deploy APIs to Flex Gateway
- View organization and environment resources

### Security Best Practices:

- ⚠️ Never commit credentials to version control
- Use `terraform.tfvars` (git ignored) for local credentials
- For CI/CD pipelines, use secrets management (GitHub Secrets, etc.)
- Rotate credentials periodically

## Troubleshooting

**Error: "Invalid GUID format"**
- Verify your `root_org` and `env_id` are valid GUIDs (format: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)

**Error: "Authentication failed"**
- Check your `client_id` and `client_secret`
- Ensure they have appropriate permissions in Anypoint Platform

**View available targets:**
```powershell
terraform apply -target=data.anypoint_flexgateway_targets.targets
terraform output debug_targets
```

## Support

For issues with the Anypoint Terraform provider, visit the [provider documentation](https://registry.terraform.io/providers/mulesoft-anypoint/anypoint/latest/docs)
