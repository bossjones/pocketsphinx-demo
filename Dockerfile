FROM ubuntu:bionic

LABEL Maintainer "Malcolm Jones <jarvis@theblacktonystark.com>"

ENV NON_ROOT_USER=developer \
    container=docker \
    TERM=xterm-256color

ARG HOST_USER_ID=1000
ENV HOST_USER_ID ${HOST_USER_ID}
ARG HOST_GROUP_ID=1000
ENV HOST_GROUP_ID ${HOST_GROUP_ID}

RUN sed -i "s,# deb-src http://archive.ubuntu.com/ubuntu/ bionic main restricted, deb-src http://archive.ubuntu.com/ubuntu/ bionic main restricted,g" /etc/apt/sources.list && \
    sed -i "s,# deb-src http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted,deb-src http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted,g" /etc/apt/sources.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    sudo \
    bash-completion \
    apt-file \
    autoconf \
    automake \
    gettext \
    yelp-tools \
    flex \
    bison \
    build-essential \
    ccache \
    curl \
    dbus \
    gir1.2-gtk-3.0 \
    git \
    gobject-introspection \
    lcov \
    libbz2-dev \
    libcairo2-dev \
    libffi-dev \
    libgirepository1.0-dev \
    libglib2.0-dev \
    libgtk-3-0 \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    ninja-build \
    python3-pip \
    xauth \
    pulseaudio-utils \
    gstreamer1.0-pulseaudio \
    libcanberra-pulse \
    libpulse-dev \
    libpulse-mainloop-glib0 \
    libpulse0 \
    xvfb \
    vim \
    && \
    apt-get update \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gstreamer1.0-plugins* \
    && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libegl1-mesa-dev libxklavier-dev libudisks2-dev libdmapsharing-3.0-dev libplist-dev nettle-dev libgphoto2-dev liblcms2-dev libfuse-dev libsane-dev libxt-dev libical-dev libgbm-dev valgrind libusb-1.0-0-dev libxcb-res0-dev xserver-xorg-input-wacom libstartup-notification0-dev libgexiv2-dev libarchive-dev libgl1-mesa-dev libfwup-dev libgnutls28-dev libpoppler-glib-dev libnma-dev libtag1-dev libusb-1.0-0-dev libndp-dev uuid-dev libgraphviz-dev libbluray-dev libcdio-paranoia-dev libsmbclient-dev libmtp-dev libv4l-dev libnfs-dev libpwquality-dev libxft-dev libsystemd-dev libnss3-dev libseccomp-dev libexiv2-dev check libhunspell-dev libmtdev-dev libanthy-dev libxrandr-dev libxdamage-dev libopus-dev libxi-dev libp11-kit-dev libtasn1-6-dev libwavpack-dev libnl-route-3-dev libcanberra-gtk-dev libxtst-dev libexempi-dev libudev-dev libplymouth-dev libxfixes-dev libunwind-dev libcaribou-dev libpolkit-agent-1-dev libavahi-gobject-dev libpolkit-gobject-1-dev dbus-tests libnl-genl-3-dev libxcb-dri2-0-dev liboauth-dev libpsl-dev libdrm-dev libevdev-dev libnspr4-dev libcanberra-gtk3-dev libexif-dev libvpx-dev libusbredirhost-dev libsndfile1-dev libxkbfile-dev libelf-dev libhangul-dev libxkbcommon-dev libxml2-dev libdotconf-dev libmusicbrainz5-dev libxslt1-dev libraw-dev libdbus-glib-1-dev libegl1-mesa-dev libnl-3-dev libxi-dev libsource-highlight-dev libvirt-dev libxcb-randr0-dev libimobiledevice-dev libgles2-mesa-dev libxkbcommon-x11-dev nettle-dev libxcomposite-dev libflac-dev libxcursor-dev libdvdread-dev libproxy-dev libkyotocabinet-dev libwebkit2gtk-4.0-dev libepoxy-dev flex valac xmlto texinfo xwayland libcups2-dev ruby libgpgme-dev gperf wget cmake sassc argyll intltool desktop-file-utils docbook-utils ragel doxygen yasm cargo libunistring-dev libmpfr-dev libhyphen-dev libkrb5-dev ppp-dev libxinerama-dev libmpc-dev libsasl2-dev libldap2-dev libpam0g-dev libdb5.3-dev libcap-dev libtiff5-dev libmagic-dev libgcrypt20-dev libiw-dev libjpeg-turbo8-dev libyaml-dev libwebp-dev libespeak-dev intltool libxslt1-dev docbook-xml docbook-xsl libgudev-1.0-dev gir1.2-gudev-1.0 libfl-dev fcitx-libs-dev libxcb-xkb-dev doxygen xorg-dev libepoxy-dev libdbus-1-dev libjpeg-dev libtiff-dev desktop-file-utils libwayland-egl1-mesa ragel libxml2-dev libxft-dev xmlto libxtst-dev xutils-dev \
    && \
    rm -rf /var/lib/apt/lists/*

RUN set -xe \
    && useradd -U -d /home/${NON_ROOT_USER} -m -r -G adm,tty,audio ${NON_ROOT_USER} \
    && usermod -a -G ${NON_ROOT_USER} -s /bin/bash -u ${HOST_USER_ID} ${NON_ROOT_USER} \
    && groupmod -g ${HOST_GROUP_ID} ${NON_ROOT_USER} \
    && ( mkdir /home/${NON_ROOT_USER}/.ssh \
    && chmod og-rwx /home/${NON_ROOT_USER}/.ssh \
    && echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key" > /home/${NON_ROOT_USER}/.ssh/authorized_keys \
    ) \
    && echo "${NON_ROOT_USER}     ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && echo "%${NON_ROOT_USER}     ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && cat /etc/sudoers \
    && echo "${NON_ROOT_USER}:${NON_ROOT_USER}" | chpasswd && \
    mkdir /var/run/dbus && \
    mkdir -p /home/${NON_ROOT_USER}/.local/bin && \
    chown ${NON_ROOT_USER}:${NON_ROOT_USER} -Rv /home/${NON_ROOT_USER}

USER ${NON_ROOT_USER}
WORKDIR /home/${NON_ROOT_USER}

ENV LANG C.UTF-8
ENV CI true
ENV PYENV_ROOT /home/${NON_ROOT_USER}/.pyenv
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
ENV PYTHON_CONFIGURE_OPTS="--enable-shared"

RUN curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash && \
    git clone https://github.com/jawshooah/pyenv-default-packages ${PYENV_ROOT}/plugins/pyenv-default-packages && \
    find ${PYENV_ROOT} -name "*.tmp" -exec rm {} \; && \
    find ${PYENV_ROOT} -type d -name ".git" -prune -exec rm -rf {} \;

RUN PYTHONDONTWRITEBYTECODE=true pyenv install 2.7.14
RUN PYTHONDONTWRITEBYTECODE=true pyenv install 3.6.5
RUN PYTHONDONTWRITEBYTECODE=true pyenv install --debug 3.7.0

ENV PATH="/home/${NON_ROOT_USER}/.local/bin:${PATH}"
ENV PATH="/usr/lib/ccache:${PATH}"
