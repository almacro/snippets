
sudo systemctl stop docker
sleep 5

sudo cp /media/data/local/etc/docker/docker.service /lib/systemd/system/docker.service
sudo systemctl daemon-reload

mkdir -p /media/data/local/var/docker
sudo systemctl start docker
