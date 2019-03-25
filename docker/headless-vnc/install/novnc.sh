#!/bin/sh
#
# install vnc and noVnc support

#VNC_PKG=tigervncserver_1.9.0-1ubuntu1_amd64.deb
VNC_PKG=${PKG_DIR}/turbovnc_2.2.1_amd64.deb
dpkg -i ${VNC_PKG}
rm ${VNC_PKG}

#cd /root && git clone https://github.com/novnc/noVNC
