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

# do some stupid shit to the json file
sed -i "s/{description}/${SERVER_DESCRIPTION}/" ${STEAMAPPDIR}/config.json
sed -i "s/{name}/${SERVER_NAME}/" ${STEAMAPPDIR}/config.json
sed -i "s/{pass}/${SERVER_PASS}/" ${STEAMAPPDIR}/config.json


# Switch to workdir
cd "${STEAMAPPDIR}" && ./Server
