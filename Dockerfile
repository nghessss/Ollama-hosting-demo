# Use CUDA-enabled Ubuntu base image
FROM nvidia/cuda:12.2.2-base-ubuntu22.04

# Set non-interactive environment for installs
ENV DEBIAN_FRONTEND=noninteractive
ENV OLLAMA_HOST=0.0.0.0

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg unzip git build-essential libssl-dev ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install Ollama (use bash for compatibility)
RUN curl -fsSL https://ollama.com/install.sh | bash

# Add Ollama binary to PATH
ENV PATH="/root/.ollama/bin:$PATH"

# Expose Ollama's API port
EXPOSE 11434

# Pull the vision-capable model
RUN /root/.ollama/bin/ollama pull llama3.2-vision:11b-instruct-fp16

# Start Ollama as a background server
CMD ["ollama", "serve"]