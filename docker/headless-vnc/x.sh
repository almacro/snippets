#!/bin/sh

docker run \
       -it \
       --rm \
       -p 6080:6080 \
       -e USER=ubuntu \
       --name novnc \
       novnc \
       bash -c "cp -r /root/noVNC /home/ubuntu/noVNC && \
chown ubuntu:ubuntu -R /home/ubuntu/noVNC && \
su ubuntu -c 'cd /home/ubuntu && \
/opt/TurboVNC/bin/vncserver -geometry 1280x1024 -depth 24 && \
./noVNC/utils/launch.sh --vnc localhost:5901'"



#"su ubuntu -c 'cd /home/ubuntu && \
#mkdir .vnc && chmod 700 .vnc && \
#echo ba\$hw0rd | /opt/TurboVNC/bin/vncpasswd -f > ./.vnc/passwd && chmod 600 ./.vnc/passwd && \
#/opt/TurboVNC/bin/vncserver -geometry 1280x1024 -depth 24 && \
#git clone https://github.com/novnc/noVNC && \
#./noVNC/utils/launch.sh --vnc localhost:5901'"
