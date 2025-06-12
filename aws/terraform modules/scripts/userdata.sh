#!/bin/bash
sudo dnf update -y
sudo dnf install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
# Optional: Create a simple index.html file to test
echo "<h1>Hello from Apache on EC2!</h1>" | sudo tee /var/www/html/index.html