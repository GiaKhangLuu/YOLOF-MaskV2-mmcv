# YOLOF-MaskV2-mmcv

A computer vision project for object detection and instance segmentation using YOLOF and UniPercepNet models with MMDetection framework.

## 🚀 Quick Start with Docker (No Docker Experience Required!)

This guide will help you run this project even if you've never used Docker before. Docker allows you to run the project in an isolated environment without worrying about dependencies or system configurations.

### Step 1: Install Docker

#### On Ubuntu/Linux:
```bash
# Update your system
sudo apt update

# Install Docker
sudo apt install docker.io docker-compose

# Add your user to docker group (to run without sudo)
sudo usermod -aG docker $USER

# Log out and log back in, then test Docker
docker --version
```

#### On Windows:
1. Download Docker Desktop from: https://www.docker.com/products/docker-desktop
2. Install and restart your computer
3. Open Docker Desktop and wait for it to start

#### On macOS:
1. Download Docker Desktop from: https://www.docker.com/products/docker-desktop
2. Install and start Docker Desktop

### Step 2: Install NVIDIA Docker (For GPU Support - Optional but Recommended)

If you have an NVIDIA GPU and want to use it for faster training:

#### On Ubuntu/Linux:
```bash
# Add NVIDIA package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# Install nvidia-docker2
sudo apt-get update
sudo apt-get install -y nvidia-docker2

# Restart Docker
sudo systemctl restart docker

# Test GPU access
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```

### Step 3: Get the Code

```bash
# Clone this repository
git clone https://github.com/your-username/YOLOF-MaskV2-mmcv.git

# Go into the project directory
cd YOLOF-MaskV2-mmcv
```

### Step 4: One-Command Setup

We've made it super easy! Just run:

```bash
# Make the setup script executable and run it
chmod +x docker_setup.sh
./docker_setup.sh
```

This script will:
- Check if Docker is installed
- Check if NVIDIA Docker is available
- Create necessary directories
- Build the Docker image
- Show you how to use it

### Step 5: Start Using the Project

After setup completes, you can use these simple commands:

#### Option A: Interactive Development (Recommended for Beginners)
```bash
# Start a container with a command line interface
docker-compose run --rm yolof-maskv2
```
This opens a terminal inside the container where you can run commands.

#### Option B: Jupyter Notebook (Great for Experiments)
```bash
# Start Jupyter notebook server
docker-compose up jupyter
```
Then open your web browser and go to: http://localhost:8888

#### Option C: Train a Model
```bash
# Train the UniPercepNet V2 model
docker-compose run --rm train
```

#### Option D: Test a Model
```bash
# Test a trained model
docker-compose run --rm test
```

### Step 6: Understanding the File Structure

When you run the container, you'll see these important directories:

```
/workspace/
├── configs/          # Model configuration files
├── datasets/         # Put your dataset here (COCO format)
├── src/             # Source code
├── tools/           # Training and testing scripts
├── work_dirs/       # Training outputs and saved models
└── requirements.txt # Python packages needed
```

### Step 7: Common Tasks

#### Training Your Own Model:
```bash
# Start interactive container
docker-compose run --rm yolof-maskv2

# Inside the container, run:
python tools/train.py configs/unipercepnet_v2.py --work-dir work_dirs/my_experiment
```

#### Testing a Model:
```bash
# Start interactive container
docker-compose run --rm yolof-maskv2

# Inside the container, run:
python tools/test.py configs/unipercepnet_v2.py work_dirs/unipercepnet_v2/epoch_1.pth
```

#### Working with Your Own Dataset:
1. Put your dataset in the `datasets/` folder
2. Modify config files in `configs/` to point to your data
3. Run training as shown above

### Step 8: Stopping and Cleaning Up

```bash
# Stop all running containers
docker-compose down

# Remove the Docker image (if you want to free space)
docker rmi yolof-maskv2:latest

# Remove all unused Docker data (be careful!)
docker system prune -a
```

## 🛠 Troubleshooting

### Problem: "Permission denied" errors
**Solution:**
```bash
sudo chmod -R 755 work_dirs datasets
```

### Problem: "CUDA not available" 
**Solution:**
- Make sure you installed NVIDIA Docker (Step 2)
- Check if your GPU works: `nvidia-smi`
- If no GPU, the code will run on CPU (slower but works)

### Problem: Docker commands don't work
**Solution:**
```bash
# Try with sudo
sudo docker-compose run --rm yolof-maskv2

# Or add yourself to docker group and restart
sudo usermod -aG docker $USER
# Then log out and log back in
```

### Problem: Container runs out of memory
**Solution:**
- Use smaller batch sizes in config files
- Close other applications
- Use smaller models for testing

## 📚 What's Inside This Project?

- **YOLOF**: A one-stage object detector
- **UniPercepNet**: A unified perception network for detection and segmentation
- **MMDetection**: A powerful computer vision framework
- **PyTorch**: Deep learning framework
- **COCO Dataset**: Standard object detection dataset format

## 🎯 Next Steps

1. **Start with the Jupyter notebook**: `docker-compose up jupyter`
2. **Look at the example configs**: Check `configs/` folder
3. **Try training on sample data**: Use the provided configurations
4. **Modify for your use case**: Edit configs and add your dataset

## 💡 Tips for Beginners

- **Don't be afraid to experiment!** Docker containers are isolated, so you can't break your main system
- **Start with small experiments** before training large models
- **Use Jupyter notebooks** for learning and experimentation
- **Check the logs** in `work_dirs/` to monitor training progress
- **Ask for help** in the GitHub issues if you get stuck

## 🔗 Useful Resources

- [Docker Documentation](https://docs.docker.com/)
- [MMDetection Documentation](https://mmdetection.readthedocs.io/)
- [PyTorch Tutorials](https://pytorch.org/tutorials/)
- [COCO Dataset](https://cocodataset.org/)

---

**Need help?** Open an issue on GitHub or check the `DOCKER.md` file for advanced Docker usage.
