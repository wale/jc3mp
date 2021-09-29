###########################################################
# Dockerfile that builds a JC3 Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="me@wale.id.au"

ENV STEAMAPPID 619960 
ENV STEAMAPP jc3mp
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/wale/jc3mp
ENV PKGURL https://dl.nanos.io/packages.zip

# Install Mordhau server dependencies and clean up
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		unzip \
		wget \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget --max-redirect=30 "${DLURL}/master/etc/config.json" -O "${STEAMAPPDIR}/config.json" \
	&& wget --max-redirect=30 "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh"
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	# Download and extract packages
	&& wget --max-redirect=30 "${PKGURL}" -O "${HOMEDIR}/packages.zip" \
	&& mkdir "${HOMEDIR}/packages" \
	&& unzip "${HOMEDIR}/packages.zip" -d "${HOMEDIR}/packages" \
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