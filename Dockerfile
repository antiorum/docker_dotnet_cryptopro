from teruser/rx:2.2-bionic
COPY . ./tmp/src
RUN apt-get update \
    && apt-get install alien lsb-core libccid pcscd libmotif-common \
	&& cd /tmp/src \
    && tar -xf linux-amd64_deb.tgz \
	&& linux-amd64_deb/install.sh \
	&& rm -rf /tmp/src \
	&& cd /bin \
    && ln -s /opt/cprocsp/bin/amd64/certmgr \
    && ln -s /opt/cprocsp/bin/amd64/cpverify \
    && ln -s /opt/cprocsp/bin/amd64/cryptcp \
    && ln -s /opt/cprocsp/bin/amd64/csptest \
    && ln -s /opt/cprocsp/bin/amd64/csptestf \
    && ln -s /opt/cprocsp/bin/amd64/der2xer \
    && ln -s /opt/cprocsp/bin/amd64/inittst \
    && ln -s /opt/cprocsp/bin/amd64/wipefile \
    && ln -s /opt/cprocsp/sbin/amd64/cpconfig \