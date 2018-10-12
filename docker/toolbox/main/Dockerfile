FROM toolbox/base

RUN useradd -m -c "Ridecell Developer (ridecell)" -u 1000 -s /bin/bash ridecell && \
    echo 'ridecell    ALL=(ALL)        NOPASSWD: ALL' > /etc/sudoers.d/ridecell-sudo

USER ridecell
