# Docker Setup for YOLOF-MaskV2-mmcv

This repository includes Docker configuration for easy setup and deployment of the YOLOF-MaskV2-mmcv project.

## Prerequisites

- Docker (version 20.10+)
- Docker Compose (version 1.29+)
- NVIDIA Docker (for GPU support)
- NVIDIA drivers (if using GPU)

## Quick Start

### 1. Automatic Setup
```bash
./docker_setup.sh
```

### 2. Manual Setup

#### Build the Docker image:
```bash
docker build -t yolof-maskv2:latest .
```

#### Run with Docker Compose:
```bash
# Start interactive container
docker-compose run --rm yolof-maskv2

# Start Jupyter notebook
docker-compose up jupyter

# Train a model
docker-compose run --rm train

# Test a model
docker-compose run --rm test
```

## Usage Examples

### Training
```bash
# Train UniPercepNet V2
docker-compose run --rm yolof-maskv2 python tools/train.py configs/unipercepnet_v2.py --work-dir work_dirs/unipercepnet_v2

# Train YOLOF
docker-compose run --rm yolof-maskv2 python tools/train.py configs/yolof_r50-c5_8xb8-1x_coco.py --work-dir work_dirs/yolof
```

### Testing
```bash
# Test a trained model
docker-compose run --rm yolof-maskv2 python tools/test.py configs/unipercepnet_v2.py work_dirs/unipercepnet_v2/epoch_1.pth
```

### Interactive Development
```bash
# Start container with shell access
docker-compose run --rm yolof-maskv2 bash

# Start Jupyter notebook for interactive development
docker-compose up jupyter
# Then open: http://localhost:8888
```

## Volume Mounts

The Docker setup includes the following volume mounts:

- `./datasets:/workspace/datasets:ro` - Dataset directory (read-only)
- `./work_dirs:/workspace/work_dirs` - Training outputs and checkpoints
- `./configs:/workspace/configs` - Configuration files
- `./src:/workspace/src` - Source code (for development)
- `./tools:/workspace/tools` - Training/testing scripts

## GPU Support

The Docker configuration includes NVIDIA GPU support. Ensure you have:

1. NVIDIA drivers installed on host
2. nvidia-docker2 installed
3. Docker configured to use nvidia runtime

Test GPU access:
```bash
docker-compose run --rm yolof-maskv2 nvidia-smi
```

## Ports

- `8888` - Jupyter notebook
- `6006` - TensorBoard (if needed)

## Directory Structure

```
/workspace/
├── configs/          # Configuration files
├── datasets/         # Dataset directory (mounted)
├── src/             # Source code
├── tools/           # Training/testing scripts
├── work_dirs/       # Training outputs (mounted)
├── checkpoints/     # Pre-trained checkpoints
└── requirements.txt # Python dependencies
```

## Environment Variables

- `PYTHONUNBUFFERED=1` - Unbuffered Python output
- `FORCE_CUDA=1` - Force CUDA compilation
- `NVIDIA_VISIBLE_DEVICES=all` - Make all GPUs visible

## Troubleshooting

### Common Issues

1. **CUDA not available**
   - Ensure nvidia-docker is installed
   - Check `nvidia-smi` works on host
   - Verify Docker can access GPU: `docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`

2. **Permission issues**
   - Ensure directories have correct permissions
   - Run `chmod -R 755 work_dirs datasets` if needed

3. **Out of memory**
   - Reduce batch size in config files
   - Use smaller models for testing
   - Monitor GPU memory usage

### Custom Configuration

To use custom configurations:

1. Create your config file in `configs/`
2. Run training: `docker-compose run --rm yolof-maskv2 python tools/train.py configs/your_config.py`

### Development Mode

For active development, mount the entire repository:
```bash
docker run -it --rm --gpus all \
  -v $(pwd):/workspace \
  -w /workspace \
  yolof-maskv2:latest bash
```

## Building for Production

For production deployment, consider:

1. Multi-stage build to reduce image size
2. Remove development dependencies
3. Use specific package versions
4. Add health checks

Example production Dockerfile modifications:
```dockerfile
# Add at the end of Dockerfile
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
  CMD python -c "import torch; print('OK')" || exit 1
```
