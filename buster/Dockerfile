###########################################################
# Dockerfile that builds a JC3 Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="me@wale.id.au"

ENV STEAMAPPID 619960 
ENV STEAMAPP mordhau
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/wale/jc3mp

# Install Mordhau server dependencies and clean up
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		libfontconfig1=2.13.1-2 \
		libpangocairo-1.0-0=1.42.4-8~deb10u1 \
		libnss3=2:3.42.1-1+deb10u3 \
		gconf-gsettings-backend=3.2.6-5 \
		libxi6=2:1.7.9-1 \
		libxcursor1=1:1.1.15-2 \
		libxss1=1:1.2.3-1 \
		libxcomposite1=1:0.4.4-2 \
		libasound2=1.1.8-1 \
		libxdamage1=1:1.1.4-3+b3 \
		libxtst6=2:1.2.3-1 \
		libatk1.0-0=2.30.0-2 \
		libxrandr2=2:1.5.1-1 \
		libcurl3-gnutls=7.64.0-4+deb10u1 \
		libcurl4=7.64.0-4+deb10u1 \
		wget=1.20.1-1.1 \
		ca-certificates=20190110 \
		iputils-ping=3:20180629-2+deb10u1 \
		curl \
		unzip \
		jq \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget --max-redirect=30 "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& rm -rf /var/lib/apt/lists/*

ENV SERVER_NAME="My JC3 Server" \
	SERVER_DESCRIPTION="My JC3 Server Description" \
	SERVER_PASS="" \
	SERVER_MAXPLAYERS=32 \
	SERVER_TICKRATE=60 \
	SERVER_PORT=4200 \
	SERVER_QUERYPORT=4201 \
	SERVER_STEAMPORT=4202 \
	SERVER_HTTPPORT=4203

# Switch to user
USER ${USER}

# Switch to workdir
WORKDIR ${HOMEDIR}

VOLUME ${STEAMAPPDIR}

CMD ["bash", "entry.sh"] 

# Expose ports
EXPOSE 4200/tcp \
	4201/tcp \
	4202/tcp \
	4203/tcp