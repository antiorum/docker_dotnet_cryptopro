FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-bionic
COPY . ./home
RUN apt-get update \
    && apt-get install -y --no-install-recommends libpango1.0-dev libc6-dev \
     libgif-dev git autoconf libtool automake build-essential gettext libglib2.0-dev libcairo2-dev libtiff-dev libexif-dev \
	 alien lsb-core libccid pcscd libmotif-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
	&& cd /home \
    && tar -xf linux-amd64_deb.tgz \
	&& linux-amd64_deb/install.sh \
	&& rm -rf /home/*
RUN git clone https://github.com/mono/libgdiplus
WORKDIR /libgdiplus
RUN ./autogen.sh --with-pango
RUN make
RUN make install
RUN ln -s /usr/local/lib/libgdiplus.so /usr/lib/libgdiplus.so
RUN cd /bin \
    && ln -s /opt/cprocsp/bin/amd64/certmgr \
    && ln -s /opt/cprocsp/bin/amd64/cpverify \
    && ln -s /opt/cprocsp/bin/amd64/cryptcp \
    && ln -s /opt/cprocsp/bin/amd64/csptest \
    && ln -s /opt/cprocsp/bin/amd64/csptestf \
    && ln -s /opt/cprocsp/bin/amd64/der2xer \
    && ln -s /opt/cprocsp/bin/amd64/inittst \
    && ln -s /opt/cprocsp/bin/amd64/wipefile \
    && ln -s /opt/cprocsp/sbin/amd64/cpconfig
RUN sudo apt-get install -y dotnet-sdk-2.2	