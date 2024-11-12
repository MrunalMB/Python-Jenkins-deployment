# # Dockerfile
# FROM python:3.8-slim
# COPY app.py /app.py
# CMD ["python", "/app.py"]

# Use official Python runtime as base image
FROM python:3.9-slim

# Set working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . /app

# Install any necessary dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run the Python application
CMD ["python", "app.py"]
