from teruser/rx:2.2-bionic
COPY . /tmp/src

# Ставим openssl и нужные вещи для криптопро
RUN apt-get update \
    && apt-get install -y alien lsb-core libccid pcscd libmotif-common \
	libengine-gost-openssl1.1
	
# Ставим криптопро и прибираем за собой.
RUN	cd /tmp/src \
    && tar -xf linux-amd64_deb.tgz \
	&& linux-amd64_deb/install.sh \
	&& rm -rf /tmp/src
	
# делаем симлинки на криптопро
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

# Конфигурируем openssl
RUN	sed -i "1s/^/openssl_conf = openssl_def\n/" /usr/lib/ssl/openssl.cnf \
	&& echo "[openssl_def]\nengines = engine_section\n\n[engine_section]\ngost = gost_section\n\n[gost_section]\nengine_id = gost\ndefault_algorithms = ALL\nCRYPT_PARAMS = id-Gost28147-89-CryptoPro-A-ParamSet" >> /usr/lib/ssl/openssl.cnf