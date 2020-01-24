#!/bin/bash

# @description Run bash linter
#
# @example
#   run-bash-linter
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The result of the shellckeck
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function run-bash-linter() {

    # Init
    local briefMessage
    local helpMessage

    briefMessage="Install assets"
    helpMessage=$(cat <<EOF
Install the mail service assets. It will create the "data/var/spool/postfix" directory with all permissions (777)
EOF
)

    # Task choosing
    case $1 in
        brief)
            showBriefMessage "${FUNCNAME[0]}" "$briefMessage"
            ;;
        help)
            showHelpMessage "${FUNCNAME[0]}" "$helpMessage"
            ;;
        exec)
            # Create network
            if [ "$(docker network ls -f name='platform_services' -q)" == "" ]; then
                echo -n "- Creating docker network 'platform_services' ..."
                docker network create platform_services
                echo "[OK]"
            else
                echo "The 'platform_services' docker network already exists, skipping"
            fi
            # Create directories
            for directory in data data/var data/var/spool data/var/spool/postfix; do
                if [ ! -d ${directory} ]; then
                    echo -n "- Creating '${directory}' directory..."
                    mkdir ${directory}
                    echo "[OK]"
                    echo -n "- Setting '${directory}' permissions..."
                    chmod 777 ${directory}
                    echo "[OK]"
                else
                    echo "The '${directory}' directory already exists, skipping"
                fi
            done
            ;;
        *)
            showNotImplemtedMessage "$1" "${FUNCNAME[0]}"
            return 1
    esac
}

# Main
run-bash-linter "$@"
