FROM lispdev/slime

RUN useradd -m -c "Lisp Developer" -s /bin/bash lisper && \
    echo 'lisper    ALL=(ALL)        NOPASSWD: ALL' > /etc/sudoers.d/lisper-sudo && \
    mkdir /home/lisper/.emacs.d && \
    printf "\n\
(add-to-list 'load-path \"/usr/local/src/slime\")\n\
(set-language-environment \"utf-8\")\n\
\n\
(require 'slime-autoloads)\n\
(setq inferior-lisp-program \"/usr/local/bin/ccl64 -K utf-8\")\n\
(setq slime-net-coding-system 'utf-8-unix)\n\
(setq slime-contribs '(slime-fancy))\n\
(slime-setup '(slime-fancy))\n\
\n\
(require 'cl)\n\
" > /home/lisper/.emacs.d/init.el && \
    chown -R lisper /home/lisper/.emacs.d && \
    mkdir /home/lisper/share && \
    chown lisper /home/lisper/share

COPY emacs-pkg-install.sh /tmp/emacs-pkg-install.sh

RUN /tmp/emacs-pkg-install.sh paredit && \
    rm /tmp/emacs-pkg-install.sh

USER lisper
WORKDIR /home/lisper

CMD ["/bin/bash"]
