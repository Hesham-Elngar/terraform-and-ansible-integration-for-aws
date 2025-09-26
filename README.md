# AWS Infrastructure Automation & Monitoring with Terraform + Ansible

![https___dev-to-uploads s3 amazonaws com_uploads_articles_uywdwbbje5dcjzesqiay](https://github.com/user-attachments/assets/031cc51b-e537-4eb3-9aa8-bcf066cb79d6)


## Ì∫Ä Project Overview
This project demonstrates how to **provision AWS infrastructure using Terraform** and then **monitor the provisioned servers using Ansible**.  
The workflow is fully automated:
- **Terraform** provisions:
  - 1 Ansible Controller
  - 10 Ansible Nodes
- **Ansible**:
  - Collects system metrics (CPU, Memory, Disk usage)
  - Generates a consolidated report
  - Sends the report via email with animated HTML template

---

## ÌøóÔ∏è Architecture

```mermaid
flowchart TD
    A[Teraform Apply] --> B[Provision Ansible Controller]
    A --> C[Provision 10 Ansible Nodes]
    B --> D[Run Ansible Playbooks]
    D --> E[Collect Metrics from Nodes]
    E --> F[Generate Consolidated Report]
    F --> G[Send Report via Email]
```

---

## ‚öôÔ∏è Tech Stack

Ìºç Terraform ‚Äì Infrastructure as Code (IaC) \
‚òÅÔ∏è AWS EC2 ‚Äì Virtual machines for controller and nodes \
Ì¥ë IAM Roles ‚Äì Secure permissions for Ansible controller \
Ì¥ñ Ansible ‚Äì Configuration management & monitoring \
Ì∞ç Python + Boto3 ‚Äì AWS dynamic inventory \
Ì≥ß Zoho Mail SMTP ‚Äì Email reporting system 

## Ìª†Ô∏è Terraform Setup
```bash
# Initialize Terraform
terraform init

# Preview the infrastructure
terraform plan

# Apply and create infrastructure
terraform apply -auto-approve
```
<img width="1517" height="613" alt="Screenshot 2025-09-24 185040" src="https://github.com/user-attachments/assets/193d8584-36af-4a3f-a012-14db9b7b7ec3" />

<img width="1901" height="926" alt="Screenshot 2025-09-24 191804" src="https://github.com/user-attachments/assets/72af03c3-cc28-4ea7-a111-979ae74f5145" />

<img width="1593" height="999" alt="Screenshot 2025-09-24 205007" src="https://github.com/user-attachments/assets/d4313dcb-bd82-4ca0-aa2a-df6b08bc9038" />


Terraform will:

Ì∂•Ô∏è Create an Ansible Controller with Ansible pre-installed \
‚ö° Spin up 15 EC2 Nodes with SSH key injected \
Ìø∑Ô∏è Tag instances (Role=master, Role=slave) for dynamic inventory

<img width="1604" height="724" alt="Screenshot 2025-09-26 095748" src="https://github.com/user-attachments/assets/782eadd7-ff16-4317-b76e-d87c3ac0a4f4" />

---

## Ì≥Ç Ansible Files
<img width="707" height="339" alt="Screenshot 2025-09-25 233901" src="https://github.com/user-attachments/assets/d8897a68-aafc-4283-bd13-c5095a8d158f" />

‚öôÔ∏è ansible.cfg ‚Üí basic config \
Ì≥ú inventory.aws_ec2.yml ‚Üí dynamic AWS inventory \
Ì≥ä collect_metrics.yml ‚Üí collects CPU, memory, disk usage \
Ì≥§ send_report.yml ‚Üí generates & emails HTML report \
‚ñ∂Ô∏è playbook.yml ‚Üí main playbook (imports both above) \
Ìæ® templates/report_email_animated.html.j2 ‚Üí animated HTML email template

---
## ‚ñ∂Ô∏è Running Ansible
```bash
# Test inventory
ansible-inventory -i inventory.aws_ec2.yml --graph

# Run the full playbook
ansible-playbook -i inventory.aws_ec2.yml playbook.yml
```
<img width="1919" height="907" alt="Screenshot 2025-09-26 005935" src="https://github.com/user-attachments/assets/9a788423-3e7c-4809-8b86-7fe386b5096d" />

<img width="1919" height="1079" alt="Screenshot 2025-09-26 010045" src="https://github.com/user-attachments/assets/944a24c3-cbf8-431c-a589-611668ff727b" />

## Ì≥ä Sample Report

Report is generated in vm_report.html \
Email is sent to configured recipient (group_vars/all.yml)

report on my gmailÌ≥©:
<img width="1615" height="844" alt="Screenshot 2025-09-26 010227" src="https://github.com/user-attachments/assets/eddf3a94-6919-416c-a87a-498984cbb955" />
<img width="1572" height="861" alt="Screenshot 2025-09-26 010243" src="https://github.com/user-attachments/assets/8e513594-d06a-4a03-8bf9-7a1fd8836d95" />
<img width="1493" height="284" alt="Screenshot 2025-09-26 010257" src="https://github.com/user-attachments/assets/a784edf0-a08b-4e88-9f27-f9602b2685ac" />


## Ì¥Æ Future Improvements

Replace email with Slack / Teams alerts \
Integrate with Prometheus + Grafana for dashboards \
Add AutoScaling Group for dynamic node provisioning \
Use Terraform remote backend (S3 + DynamoDB) for production state management

---
## Ì∑ë‚ÄçÌ≤ª Author
### Hesham Mohamed Soliman Elngar


![1756098162736](https://github.com/user-attachments/assets/4438f1fb-db30-4196-90fa-fdb4706f9958)


