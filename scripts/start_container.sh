#!/bin/bash
set -e

# Pull the Docker image from Docker Hub
docker pull mohanpiru/simple-flask-app:latest

# Run the Docker image as a container
docker run -d -p 5000:5000 mohanpiru/simple-flask-app:latest