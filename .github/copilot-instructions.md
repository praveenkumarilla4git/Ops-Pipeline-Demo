# Copilot Instructions for Ops-Pipeline-Demo

## Architecture Overview
This is a DevOps pipeline demo with three main components:
- **ApplicationCode/**: Python script (`app.py`) generates a timestamped HTML page served via Nginx in Docker.
- **Ops-Infra/**: Terraform provisions AWS EC2 Ubuntu server with security group for SSH/HTTP.
- **Ops-Jenkins/**: Terraform provisions Jenkins CI/CD server with auto-installed tools (Jenkins, Terraform, Ansible, Git).

Data flow: Python generates HTML → GitHub repo → Ansible clones, executes Python, mounts HTML into Nginx container.

## Key Workflows
- **Deploy Infrastructure**: In `Ops-Infra/`, run `terraform init && terraform apply` to create app server.
- **Deploy Jenkins**: In `Ops-Jenkins/`, run `terraform init && terraform apply` to create Jenkins server with user_data automation.
- **Application Build**: Run `python3 app.py` in `ApplicationCode/` to generate `index.html`.
- **Ansible Deployment**: Use `ansible-playbook -i hosts.ini deploy.yml` (requires WSL/Ubuntu) to configure server and deploy app.
- **Live Updates**: Modify `app.py`, git commit/push, re-run Ansible playbook for zero-downtime updates.

## Conventions and Patterns
- **Terraform Structure**: Separate `main.tf`, `variables.tf`, `outputs.tf` per component. Use S3 backend for state (e.g., `backend "s3" { bucket = "tf-state-praveen-2025" ... }`).
- **Security Groups**: Always include SSH (22) and HTTP (80/8080) ingress; allow all egress.
- **User Data Automation**: For Jenkins, use bash script in `user_data` to install dependencies on EC2 startup.
- **Git Ignore**: Exclude `.terraform/`, `*.tfstate`, `*.pem`, `__pycache__/`.
- **Python App**: Simple, no dependencies; generates HTML with inline CSS and timestamp.

## Integration Points
- AWS EC2 instances with Ubuntu AMI (`ami-0e2c8caa4b6378d8c` for us-east-1).
- S3 for Terraform state storage.
- GitHub for source control.
- Docker Nginx with volume mount: `-v /path/to/index.html:/usr/share/nginx/html/index.html`.

Reference: [DevOps-Master-Guide.md](DevOps-Master-Guide.md) for full setup steps.</content>
<parameter name="filePath">c:\Users\prave\OneDrive\Documents\DevOps\Ops-Pipeline-Demo\.github\copilot-instructions.md