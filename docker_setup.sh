#!/bin/bash

# YOLOF-MaskV2-mmcv Docker Setup Script

set -e

echo "=== YOLOF-MaskV2-mmcv Docker Setup ==="

# Function to check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed. Please install Docker first."
        exit 1
    fi
    echo "✓ Docker is installed"
}

# Function to check if nvidia-docker is available
check_nvidia_docker() {
    if ! docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi &> /dev/null; then
        echo "Warning: NVIDIA Docker runtime not available. GPU acceleration will not work."
        echo "Please install nvidia-docker2 for GPU support."
    else
        echo "✓ NVIDIA Docker runtime is available"
    fi
}

# Function to build the Docker image
build_image() {
    echo "Building Docker image..."
    docker build -t yolof-maskv2:latest .
    echo "✓ Docker image built successfully"
}

# Function to create necessary directories
setup_directories() {
    echo "Setting up directories..."
    mkdir -p datasets work_dirs checkpoints
    echo "✓ Directories created"
}

# Main execution
main() {
    echo "Starting setup..."
    
    check_docker
    check_nvidia_docker
    setup_directories
    build_image
    
    echo ""
    echo "=== Setup Complete! ==="
    echo ""
    echo "Available commands:"
    echo "1. Start interactive container:"
    echo "   docker-compose run --rm yolof-maskv2"
    echo ""
    echo "2. Start Jupyter notebook:"
    echo "   docker-compose up jupyter"
    echo "   Then open: http://localhost:8888"
    echo ""
    echo "3. Train a model:"
    echo "   docker-compose run --rm train"
    echo ""
    echo "4. Test a model:"
    echo "   docker-compose run --rm test"
    echo ""
    echo "5. Run custom command:"
    echo "   docker-compose run --rm yolof-maskv2 python tools/train.py configs/your_config.py"
    echo ""
}

# Parse command line arguments
case "${1:-}" in
    "build")
        check_docker
        build_image
        ;;
    "setup")
        main
        ;;
    *)
        main
        ;;
esac
