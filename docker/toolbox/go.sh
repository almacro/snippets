docker run \
       -it \
       --rm \
       --name user-toolbox \
       -e USER=ridecell \
       -v $HOME/.ssh:/home/ridecell/.ssh \
       toolbox \
       bash
