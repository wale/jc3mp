#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true  

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
	bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "$STEAMAPPDIR" +app_update "$STEAMAPPID" +quit
else
	steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
	bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "$STEAMAPPDIR" +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

# We assume that if the config is missing, that this is a fresh container
if [ ! -f "${STEAMAPPDIR}/config.json" ]; then
	jq --null-input \
		--arg announce false \
		--arg description "${SERVER_DESCRIPTION}" \
		--arg host "0.0.0.0" \
		--arg httpPort $SERVER_HTTPORT
		--arg logLevel 7
		--arg logo ""
		--arg maxPlayers $SERVER_MAXPLAYERS
		--arg maxTickRate $SERVER_TICKRATE
		--arg name $SERVER_NAME
		--arg name $SERVER_PASS
		--arg port $SERVER_PORT
		--arg queryPort $SERVER_QUERYPORT
		--arg requiredDLC []
		--arg steamPort $SERVER_STEAMPORT
fi

# Switch to workdir
cd "${STEAMAPPDIR}"

bash "${STEAMAPPDIR}/Server"
