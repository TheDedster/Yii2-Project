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

## How to Test Deployment Efficently

1. SSH into EC2 instance:
   ssh -i path/to/your-key.pem ubuntu@<EC2_PUBLIC_IP>
2. Check Docker Swarm status:
   docker info | grep Swarm
3. Confirm Yii2 service is running:
   docker info | grep Swarm
4. Test NGINX config and reload if needed:
   sudo nginx -t
   sudo systemctl reload nginx
5. Access your app at:
   http://<EC2_PUBLIC_IP>/backend
16. Troubleshoot with logs:
    Docker logs: docker service logs <service_name>
    NGINX logs: /var/log/nginx/error.log
