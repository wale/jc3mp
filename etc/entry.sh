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
	template='{"announce":false,"description":"%s","host":"0.0.0.0","httpPort":%s,"logLevel":7,"logo":"","maxPlayers":%s,"maxTickRate":%s,"name":"%s","pass":%s,"port":%s,"queryPort":%s, "requiredDLC": [], "steamPort": %s}'
	json_string=$(printf "$template" $SERVER_DESCRIPTION "$SERVER_HTTPPORT" "$SERVER_MAXPLAYERS" "$SERVER_MAXTICKRATE" "$SERVER_NAME" "$SERVER_PASS" "$SERVER_PORT" "$SERVER_QUERYPORT" "$SERVER_STEAMPORT")
	echo json_string > ${STEAMAPPDIR}/config.json}
fi

# Switch to workdir
cd "${STEAMAPPDIR}"

bash "${STEAMAPPDIR}/Server"
