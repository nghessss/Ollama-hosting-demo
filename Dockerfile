FROM nvidia/cuda:12.2.2-base-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV OLLAMA_HOST=0.0.0.0
ENV PATH="/root/.ollama/bin:${PATH}" 

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl gnupg unzip git build-essential libssl-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | bash

# Verify installation
RUN which ollama && ollama --version

# Pull the vision-capable model during build
RUN ollama serve & sleep 5 && ollama pull llama3.2-vision:11b-instruct-fp16 && pkill ollama

# Expose Ollama API port
EXPOSE 11434

# Default command
CMD ["ollama", "serve"]