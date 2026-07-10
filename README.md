# ECS Threat Composer App Deployment
## Overview
This a deployment of the Amazon Threat Composer tool, designed to assist with threat modeling and security assessments. It has been deployed on ECS Fargate using Terraform (IaaC) and automated using Github Actions.

---

### Architecture Diagram


## Repository Structure

```
threat-composer/
├── .dockerignore
├── .gitignore
├── Dockerfile
├── README.md
├── terraform.tfstate
├── .github/
│   └── workflows/
│       ├── docker-build.yml
│       ├── healthcheck.yml
│       ├── terraform-deploy.yml
│       └── terraform-destroy.yml
├── app/
├── bootstrap/
│   ├── .terraform.lock.hcl
│   ├── main.tf
│   ├── provider.tf
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   └── modules/
│       ├── ecr/
│       └── s3/
└── infra/
    ├── .terraform.lock.hcl
    ├── main.tf
    ├── outputs.tf
    ├── provider.tf
    ├── variables.tf
    └── modules/
        ├── acm/
        ├── alb/
        ├── ecs/
        └── vpc/
```


### Infrastructure Components
VPC
Region & AZs
Ingress - ALB
ECS Fargate
Routing - ALB Listener
Security Groups
DNS

---

## Technologies Used

### Application
- 

### Infrastructure
- 

### CI/CD
- 

### Security Tools
- 

---

## Prerequisites

- Required software
- AWS requirements
- Account permissions
- Environment requirements

---

## Infrastructure Setup

### Bootstrap Setup
- Terraform backend setup
- State storage
- State locking

### Terraform Deployment
- Initialisation
- Planning
- Applying infrastructure

---

## Application Setup

### Local Development

### Docker Build

### Docker Run

---

## CI/CD Pipeline

### Build Workflow
- Trigger conditions
- Build steps
- Testing
- Security scanning
- Image publishing

### Deployment Workflow
- Authentication method
- Deployment process
- Infrastructure updates
- Application rollout strategy

---

## AWS Infrastructure Details

### Networking
- VPC design
- Subnets
- Routing
- NAT Gateway
- Internet Gateway

### Container Infrastructure
- ECS Cluster
- Task Definition
- Services
- Container configuration

### Load Balancing
- ALB setup
- Target groups
- Health checks
- HTTPS configuration

### Domain & Certificates
- DNS configuration
- SSL/TLS certificates

---

## Security

### Identity and Access Management
- IAM roles
- GitHub OIDC
- Permissions model

### Container Security
- Image scanning
- Vulnerability management

### Infrastructure Security
- Terraform scanning
- Security best practices

---

## Environment Configuration

- Terraform variables
- Secrets management
- Environment-specific values

---

## Monitoring & Logging

- CloudWatch
- Application logs
- Health checks
- Alerts (if applicable)

---

## Deployment Process

Step-by-step deployment flow:

1.
2.
3.
4.

---

## Challenges & Troubleshooting

- Problems encountered
- Root causes
- Solutions implemented

---

## Design Decisions

- Why ECS instead of alternatives
- Why Terraform
- Why chosen AWS services
- Trade-offs considered

---

## Future Improvements

- Scaling improvements
- Security improvements
- Automation improvements
- Cost optimisation

---

## Lessons Learned

- Technical skills gained
- AWS concepts learned
- DevOps practices applied

---

## Screenshots / Demo

- Architecture diagram
- CI/CD pipeline
- AWS resources
- Application screenshots

---