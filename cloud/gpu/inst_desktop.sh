# run the inst_dev_tools and inst_gpu_docker scripts before this one
# TODO add checks to make sure prerequisite packages are installed
#
set -e

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install -y xorg

cat <<EOF > /tmp/xorg.conf
# nvidia-xconfig: X configuration file generated by nvidia-xconfig
# nvidia-xconfig:  version 410.72

Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "Screen0"
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
EndSection

Section "Files"
EndSection

Section "InputDevice"
    # generated from default
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol" "auto"
    Option         "Device" "/dev/psaux"
    Option         "Emulate3Buttons" "no"
    Option         "ZAxisMapping" "4 5"
EndSection

Section "InputDevice"
    # generated from default
    Identifier     "Keyboard0"
    Driver         "kbd"
EndSection

Section "Monitor"
    Identifier     "Monitor0"
    VendorName     "Unknown"
    ModelName      "Unknown"
    HorizSync       28.0 - 33.0
    VertRefresh     43.0 - 72.0
    Option         "DPMS"
EndSection

Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BusID          "pci@0000:00:1e.0"    # THIS MAY CHANGE FROM INSTANCE TO INSTANCE
                                         # check the device bus by running 'lspci | grep -i nvidia'
                                         # or lshw
EndSection

Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
EOF
sudo mv /tmp/xorg.conf /etc/X11/xorg.conf

export VIRTUALGL_VERSION=2.6
cd /media/data/local/dist
sudo dpkg -i virtualgl_${VIRTUALGL_VERSION}_amd64.deb
cd -

sudo /opt/VirtualGL/bin/vglserver_config -config +s +f -t

sudo apt-get install -qqy lightdm

sudo rm -f /etc/lightdm/lightdm.conf
cat <<EOF > /tmp/lightdm.conf
[Seat:seat0]
display-setup-script=/usr/bin/vglgenkey
display-setup-script=xhost +LOCAL:
EOF
sudo mv /tmp/lightdm.conf /etc/lightdm/lightdm.conf

sudo apt-get install -y mesa-utils

export TURBOVNC_VERSION=2.2
export LIBJPEG_VERSION=2.0.0
cd /media/data/local/dist
sudo dpkg -i turbovnc_${TURBOVNC_VERSION}_amd64.deb
sudo dpkg -i libjpeg-turbo-official_${LIBJPEG_VERSION}_amd64.deb
cd -

sudo apt-get install mate -y --no-install-recommends
sudo service lightdm start

echo 'export PATH=/opt/TurboVNC/bin:$PATH' >> ~/.bashrc
export PATH=/opt/TurboVNC/bin:$PATH
echo 'export DISPLAY=:1' >> ~/.bashrc
export DISPLAY=:1
mkdir -p ~/.vnc
rm -f ~/.vnc/passwd

#wget -q -O - http://169.254.169.254/latest/meta-data/instance-id | cut -c1-8 | xargs echo | vncpasswd -f > ~/.vnc/passwd
echo 'vncpasswd' | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd
touch ~/.Xauthority

cat <<EOF > ~/startup.sh
cd $HOME
vncserver -kill $DISPLAY
vncserver $DISPLAY
EOF
chmod +x ~/startup.sh

set +e
crontab -l 2> /dev/null
if [ $? -ne 1 ];
then
    crontab -r
fi

echo "SHELL=/bin/bash"  >> /tmp/usercron
echo "DISPLAY=$DISPLAY" >> /tmp/usercron
echo "PATH=$PATH"       >> /tmp/usercron
echo "@reboot /home/ubuntu/startup.sh" >> /tmp/usercron
crontab /tmp/usercron
rm -f /tmp/usercron

echo "desktop setup done.. please reboot"
#sudo reboot now
