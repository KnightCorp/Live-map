# Use Python 3.12 slim image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install build tools for torch
RUN apt-get update && apt-get install -y gcc wget

# Upgrade pip
RUN pip install --upgrade pip

# Install Flask
RUN pip install Flask

# Install PyTorch + torchvision (CPU, Python 3.12)
RUN pip install \
  https://download.pytorch.org/whl/cpu/torch-2.2.2%2Bcpu-cp312-cp312-linux_x86_64.whl \
  https://download.pytorch.org/whl/cpu/torchvision-0.17.2%2Bcpu-cp312-cp312-linux_x86_64.whl

# Expose port
EXPOSE 8080

# Set Flask environment
ENV FLASK_APP=app.py
ENV FLASK_RUN_PORT=8080
ENV FLASK_RUN_HOST=0.0.0.0

# Start Flask app
CMD ["flask", "run"]
