# This script is a utility script for simplified access to containers hosted in the compose environment.
##: UTIL_SCRIPT

# Helper Function
contains() {
  local e match="$1"
  shift
  for e; do [[ "${e}" == "${match}" ]] && return 0; done
  return 1
}

# Determine the target container.
SELECTED_CONTAINER="${1}"
SELECTED_CONTAINER="${SELECTED_CONTAINER:=null}"

ALLOWED_SERVERS=($(docker inspect -f '{{.Name}}' $(docker-compose ps -q) | cut -c2-))

contains "${SELECTED_CONTAINER}" "${ALLOWED_SERVERS[@]}"
IS_ALLOWED=$?

if [[ "${IS_ALLOWED}" -eq 0 ]]; then
    # Start the container.
    docker exec -it "${SELECTED_CONTAINER}" "/bin/sh"
else
    echo -e "Error: This script is not permitted to access container named '${SELECTED_CONTAINER}', or it does not exist."
    echo -e ":: docker-compose ps -> ${ALLOWED_SERVERS[@]}"
fi
