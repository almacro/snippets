#!/bin/sh

vncserver -geometry 1280x1024 -depth 24 && \
/root/utils/launch.sh --vnc localhost:5901"
