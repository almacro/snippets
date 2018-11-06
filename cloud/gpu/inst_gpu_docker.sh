sudo apt-key adv \
     --fetch-keys \
     http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub

sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list'

sudo apt-get update
sudo apt-get install -y --no-install-recommends \
     linux-headers-generic \
     dkms \
     cuda-drivers

docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi
sudo pip3 install nvidia-docker-compose

exit 0

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release; echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi
