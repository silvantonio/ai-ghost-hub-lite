#!/bin/bash
# enable-gpu.sh: Helper script to enable Docker GPU support for Ubuntu, Debian, and WSL
set -e

# Detect environment
if grep -qi microsoft /proc/version; then
  ENVIRONMENT="WSL"
elif [ -f /etc/os-release ]; then
  . /etc/os-release
  ENVIRONMENT="$ID"
else
  ENVIRONMENT="unknown"
fi

echo "Detected environment: $ENVIRONMENT"

# Install NVIDIA drivers and container toolkit
if [ "$ENVIRONMENT" = "ubuntu" ] || [ "$ENVIRONMENT" = "debian" ]; then
  echo "Installing NVIDIA drivers and Docker GPU toolkit..."
  sudo apt-get update
  sudo apt-get install -y nvidia-driver-535
  sudo apt-get install -y curl
  distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
  curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
  curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
  sudo apt-get update
  sudo apt-get install -y nvidia-container-toolkit
  sudo systemctl restart docker
  echo "NVIDIA Container Toolkit installed."
  echo "If you installed a new driver, reboot your system before continuing."
elif [ "$ENVIRONMENT" = "WSL" ]; then
  echo "Detected WSL. Please ensure you have installed the latest NVIDIA drivers for Windows."
  echo "Then run: wsl --shutdown and restart your WSL distro."
  echo "Install the NVIDIA Container Toolkit inside WSL as well:"
  echo "  sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit"
  echo "  sudo systemctl restart docker"
else
  echo "Unknown environment. Please install NVIDIA drivers and the NVIDIA Container Toolkit manually."
fi

# Set AI_GHOST_HUB_LITE_GPU=true in .env if present
if [ -f .env ]; then
  if grep -q '^AI_GHOST_HUB_LITE_GPU=' .env; then
    sed -i 's/^AI_GHOST_HUB_LITE_GPU=.*/AI_GHOST_HUB_LITE_GPU=true/' .env
  else
    echo 'AI_GHOST_HUB_LITE_GPU=true' >> .env
  fi
  echo "Set AI_GHOST_HUB_LITE_GPU=true in .env"
else
  echo ".env file not found. Please set AI_GHOST_HUB_LITE_GPU=true manually."
fi

echo "Done. You can now run the stack with GPU support if your hardware is compatible."
