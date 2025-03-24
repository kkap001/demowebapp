# Webtext App

## Overview
Webtext App is a simple web application built with Node.js and Express that displays a configurable text message. It supports deployment using Docker, automated task management with `Taskfile.yml`, and integration with Doppler for secret management. Terraform is used for infrastructure provisioning.

---

## Project Structure
- **`index.js`** - The main web server.
- **`Dockerfile`** - Defines how to containerize the app.
- **`Taskfile.yml`** - Task automation for build, deploy, test, and cleanup.
- **`install_docker_doppler.yml`** - Ansible playbook to install Docker, Doppler, and AWS CLI.
- **Terraform Scripts** - Manages infrastructure as code (if applicable).

---

## Infrastructure Setup with Terraform
Terraform is used to provision the required cloud infrastructure (e.g., EC2 instances, networking, IAM roles, etc.).

### **Terraform Steps**
1. Navigate to the Terraform directory:
   ```sh
   cd terraform
   ```
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Plan the infrastructure changes:
   ```sh
   terraform plan
   ```
4. Apply the changes:
   ```sh
   terraform apply -auto-approve
   ```
5. To destroy the infrastructure:
   ```sh
   terraform destroy -auto-approve
   ```

---

## Application Deployment
### **Build and Run Locally**
```sh
npm install
node index.js
```
By default, the app runs on port 80 and displays `Hello World!` unless overridden by the `WEBTEXT` environment variable.

### **Using Docker**
#### **Build the Image**
```sh
docker build -t webtext-app .
```
#### **Run the Container**
```sh
docker run -p 8081:80 -e WEBTEXT="Custom Message" webtext-app
```
#### **Test the Application**
```sh
curl localhost:8081
```

---

## Automation with Taskfile
### **Available Tasks**
| Task                 | Description |
|----------------------|-------------|
| `task build`        | Build the Docker image |
| `task lint`         | Lint the Dockerfile using hadolint |
| `task deploy`       | Deploy the app locally using Docker |
| `task test`         | Test the application response |
| `task clean`        | Stop and remove the container |
| `task cicd`         | Run build, lint, deploy, and test |
| `task deploywithdoppler` | Deploy the container with Doppler secrets |
| `task ansible`      | Run Ansible playbook to install dependencies |
| `task install-task` | Install Task utility using Ansible |

---

## Secret Management with Doppler
### **Retrieve Secrets Manually**
```sh
doppler secrets get WEBTEXT --plain
```
### **Using AWS Secrets Manager**
```sh
aws secretsmanager get-secret-value --secret-id demo/dev/doppler --query SecretString --output text | jq -r '.DOPPLER_TOKEN'
```
---

## Deployment using Ansible
### **Install Dependencies on Remote Server**
```sh
ansible-playbook -i inventory/hosts.ini install_docker_doppler.yml -u ubuntu
```

---

## Cleanup
To remove the deployed container:
```sh
task clean
```
To destroy Terraform infrastructure:
```sh
terraform destroy -auto-approve
```

