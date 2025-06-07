# Yii2 Docker Swarm Deployment

## Setup Instructions

1. **Prepare EC2 Instance**  
   - Ubuntu VM with SSH access using your `.pem` key.  
   - Update and upgrade system packages.

2. **Install Dependencies (via Ansible or manually)**  
   - Docker & Docker Swarm initialized  
   - NGINX installed and configured on host as a reverse proxy  
   - PHP dependencies if required (for Yii2)  

3. **Deploy Yii2 Application**  
   - Build Docker image for Yii2 app  
   - Deploy app as Docker Swarm service on ports (e.g. 8080)  
   - Configure NGINX to proxy `/backend` URL to Docker container

## Assumptions

- You have SSH access to the EC2 instance with correct permissions  
- Docker Swarm mode is active on the EC2 server  
- NGINX is running on the host and can be configured for reverse proxy  
- Firewall and security groups allow inbound traffic on port 80 (HTTP)  
- Yii2 app Docker image is available or can be built from source

## 🧪 How to Test Deployment

To verify and test the Yii2 deployment with Docker Swarm and Ansible, follow these steps:

### 🔨 Step-by-Step Instructions

1. **Build and Push Docker Image**
   - Navigate to the Yii2 application directory containing your `Dockerfile`.
   - Build the Docker image:
     ```bash
     docker build -t your-dockerhub-username/yii2-app .
     ```
   - Push the image to Docker Hub:
     ```bash
     docker push your-dockerhub-username/yii2-app
     ```

2. **Update Docker Compose**
   - Modify the Docker Compose file to use the new image:
     ```yaml
     image: your-dockerhub-username/yii2-app
     ```

3. **Run Ansible Deployment**

   - Go to your Ansible project directory:
     ```bash
     cd ansible-project
     ```

   - Replace the inventory file with your target EC2 instance details:
     ```ini
     [web]
     your.ec2.public.ip ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/your-key.pem
     ```

   - Edit `setup/tasks/main.yml` and update:
     - Your GitHub Personal Access Token
     - The repository URL

   - Update the Docker image reference in the compose file again if needed.

   - Test SSH connectivity:
     ```bash
     ansible -i inventory web -m ping
     ```

   - Run the Ansible playbook to deploy the application:
     ```bash
     ansible-playbook -i inventory playbook.yml
     ```

---

✅ **Ensure:**
- You have working SSH access.
- Docker Swarm is initialized on the host.
- NGINX is ready to proxy to the container (e.g., `/backend → port 8080`).
- Security groups/firewalls allow traffic on port `80`.

📘 After successful deployment, visit your server IP in the browser to confirm the Yii2 app is running.

