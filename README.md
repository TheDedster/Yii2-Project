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

## How to Test Deployment 

First Create the image from the Dockerfile and then push it to Dockerhub.
Then Change the Image from Dockercompose . Then you can proceed with Ansible

1). Go to ansible-project
2). Replace the inventory values with your required values.
3). Replace the Github Pat and Repo Value in setup/task/main.yml
4). Change the image in Dockercompose file .
5). Check SSH connectivity from web profile using  ` ansible -i inventory web -m ping `
6). Initiate the Build Process using `ansible-playbook -i inventory playbook.yml`
