FROM base/archlinux:latest

RUN pacman --noconfirm -Syy && \
	pacman --noconfirm -S git make sudo && \
	groupadd sudo && \
	echo "dockerci ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
	useradd -ms /bin/bash dockerci && \
	echo "dockerci:dockerci" | chpasswd && \
	usermod -a -G sudo dockerci
USER dockerci
WORKDIR /home/dockerci/
RUN mkdir -p .emacs.d
ADD . .emacs.d/
USER root
RUN chown -R dockerci:dockerci .emacs.d/
USER dockerci
WORKDIR /home/dockerci/.emacs.d/
RUN make arch
