# Use NVIDIA PyTorch base image with CUDA support
FROM pytorch/pytorch:2.2.2-cuda12.1-cudnn8-devel

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV FORCE_CUDA="1"

# Set working directory
WORKDIR /workspace

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    wget \
    curl \
    vim \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libgomp1 \
    build-essential \
    ninja-build \
    && rm -rf /var/lib/apt/lists/*

# Install OpenMIM and MMEngine
RUN pip install --no-cache-dir openmim
RUN mim install mmengine
RUN mim install "mmcv>=2.0.0"

# Install MMDetection
RUN mim install "mmdet>=3.0.0"

# Copy requirements and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install additional dependencies that might be needed for MMDetection
RUN pip install --no-cache-dir \
    matplotlib \
    seaborn \
    ipykernel \
    jupyter \
    yapf \
    terminaltables

# Copy the entire project
COPY . .

# Install the project in development mode
RUN pip install -e .

# Create necessary directories
RUN mkdir -p /workspace/data \
    && mkdir -p /workspace/work_dirs \
    && mkdir -p /workspace/checkpoints

# Set permissions
RUN chmod -R 755 /workspace

# Expose port for Jupyter notebook
EXPOSE 8888

# Set default command
CMD ["bash"]
