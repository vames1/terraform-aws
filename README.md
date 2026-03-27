# ☁️ AWS Infrastructure with Terraform

A complete AWS infrastructure project built using Terraform Infrastructure as Code (IaC). This project provisions and manages real AWS resources including VPC, EC2, S3, IAM, ECS, Load Balancer, Auto Scaling, CloudWatch, Route 53, CloudFront, Lambda and RDS.

---

## 🏗️ Architecture
```
Internet
    ↓
CloudFront CDN
    ↓
Application Load Balancer (ALB)
    ↓
ECS Fargate Containers
    ↓
VPC (Private Network)
    ↓
RDS MySQL Database
```

---

## 🚀 Technologies Used

| Technology | Purpose |
|------------|---------|
| **Terraform** | Infrastructure as Code |
| **AWS ECS Fargate** | Container deployment |
| **AWS ALB** | Load balancing |
| **AWS VPC** | Private networking |
| **AWS S3** | Cloud storage |
| **AWS IAM** | Identity and access management |
| **AWS RDS** | Managed MySQL database |
| **AWS Lambda** | Serverless functions |
| **AWS CloudWatch** | Monitoring and alerting |
| **AWS CloudFront** | Content delivery network |
| **AWS Route 53** | DNS management |
| **Docker** | Containerisation |

---

## 📁 Project Structure
```
terraform-aws/
├── main.tf              # EC2 instance configuration
├── vpc.tf               # VPC, subnets, internet gateway
├── security_group.tf    # Security groups and firewall rules
├── iam.tf               # IAM users and policies
├── s3.tf                # S3 bucket configuration
├── ecs.tf               # ECS cluster, task definition, service
├── alb.tf               # Application Load Balancer
├── autoscaling.tf       # Auto scaling policies and alarms
├── cloudwatch.tf        # CloudWatch monitoring and dashboards
├── route53.tf           # DNS records and health checks
├── cloudfront.tf        # CDN distribution
├── lambda.tf            # Serverless Lambda function
├── rds.tf               # MySQL RDS database
├── backend.tf           # Remote state in S3
├── variables.tf         # Variable definitions
├── outputs.tf           # Output values
├── dev.tfvars           # Development environment values
├── prod.tfvars          # Production environment values
└── modules/
    └── vpc/             # Reusable VPC module
```

---

## ⚙️ Prerequisites

- Terraform v1.0+
- AWS CLI configured with valid credentials
- AWS Account

---

## 🚀 How to Deploy

**1. Clone the repository:**
```bash
git clone https://github.com/vames1/terraform-aws.git
cd terraform-aws
```

**2. Initialise Terraform:**
```bash
terraform init
```

**3. Preview changes:**
```bash
terraform plan -var-file="dev.tfvars"
```

**4. Deploy infrastructure:**
```bash
terraform apply -var-file="dev.tfvars"
```

**5. Destroy when done:**
```bash
terraform destroy -var-file="dev.tfvars"
```

---

## 🌍 Key Features

- ✅ Complete VPC with public and private subnets
- ✅ ECS Fargate containerised deployment
- ✅ Application Load Balancer with health checks
- ✅ Auto Scaling based on CPU utilisation
- ✅ CloudWatch monitoring with SNS email alerts
- ✅ Remote state stored securely in S3
- ✅ Multiple environment support (dev/prod)
- ✅ Reusable Terraform modules
- ✅ Serverless Lambda function with public URL
- ✅ MySQL RDS database in private subnet
- ✅ CloudFront CDN for global content delivery
- ✅ Route 53 DNS with health checks and failover

---

## 👨‍💻 Author

**Victor Oluwaseyi Akindiose**
Cloud Engineer | Lagos, Nigeria
- 🌍 Portfolio: https://vames1.github.io
- 📧 Email: victoroluwaseyi2018@gmail.com
- 🐙 GitHub: https://github.com/vames1
