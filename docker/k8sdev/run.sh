docker run \
       -d \
       -p 4003:4000 \
       --cap-add=SYS_PTRACE \
       --security-opt seccomp=$PWD/chrome.json \
       -v $PWD/data/src:/home/sweng/src \
       -v $PWD/data/scripts:/home/sweng/scripts \
       -v $PWD/data/opt:/opt/local \
       --name k8sdev \
       k8sdev
