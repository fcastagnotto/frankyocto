FROM rockylinux:9 AS base

LABEL maintainer="Francesco Castagnotto <fcastagnotto@linux.com>"

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV SHELL=/bin/bash

RUN dnf -y update && \
    dnf -y install epel-release dnf-plugins-core && \
    dnf config-manager --set-enabled crb && \
    dnf -y makecache && \
    dnf -y install \
      bash bash-completion sudo \
      bzip2 ccache chrpath cpio cpp diffstat diffutils \
      file findutils gawk gcc gcc-c++ git glibc-devel \
      glibc-langpack-en glibc-locale-source gzip hostname \
      libacl make patch \
      perl perl-Data-Dumper perl-Text-ParseWords perl-Thread-Queue \
      python3 python3-GitPython python3-jinja2 python3-pexpect \
      python3-pip python3-websockets \
      rpcgen socat tar texinfo unzip wget which xz zstd \
      nano vim iputils lz4 \
    && dnf clean all

# /bin/sh -> bash, come nel Dockerfile originale
RUN ln -sf /bin/bash /bin/sh

# Utente non-root adatto a podman rootless
ARG USERNAME=build
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${USERNAME} && \
    useradd -m -u ${UID} -g ${GID} -s /bin/bash ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

# Directory di lavoro Yocto
RUN mkdir -p /yocto && chown -R ${USERNAME}:${USERNAME} /yocto

# Opzionale ma raccomandato per Rocky 9 secondo la documentazione Yocto:
# installazione buildtools da fare nel progetto, perché dipende dalla release Yocto.
#
# Esempio dentro al container:
#   cd /yocto/poky
#   scripts/install-buildtools

USER ${USERNAME}
WORKDIR /yocto

RUN echo 'force_color_prompt=yes' >> ~/.bashrc && \
    echo 'PS1="\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ "' >> ~/.bashrc
RUN echo "force_color_prompt=yes" >> ~/.bashrc && \
    echo "alias build='cd /yocto/ && ./build.sh'" >> ~/.bashrc && \
    echo "alias b='cd /yocto/ && ./build.sh'" >> ~/.bashrc

CMD ["/bin/bash"]
