#!/usr/bin/env bash

function __main__() {
    # Parse the command line arguments and itialize the flags

    while [[ $# -gt 0 ]]; do
        case $1 in
            --config-path=*)
                local config_path="${1#*=}"
                shift
                ;;
            --setup-filename=*)
                local setup_filename="${1#*=}"
                shift
                ;;
            --dry-run)
                local flag_dry_run=true
                shift
                ;;
            --trace)
                local flag_trace=true
                shift
                ;;
            *)
                echo "Unknown option $1"
                return 1 2>/dev/null; exit 1;
                shift
                ;;
        esac
    done

    local config_path=${config_path:?"Error. config-path not defined."}
    local setup_filename=${setup_filename:=setup.cfg}
    local flag_dry_run=${flag_dry_run:=false}
    local flag_trace=${flag_trace:=false}


    # execute the script
    echo "Starting Script..."
    echo
    (
        set -e

        case $flag_dry_run in
            true)   cmd='echo';;
            false)  cmd='';;
            *) echo "Error with dry-run option"; exit 1;;
        esac

        case $flag_trace in
            true)   set -x;;
            false)  set +x;;
            *) echo "Error with trace option"; exit 1;;
        esac

        if [[ ! -d ${config_path} ]]; then
            echo "Unknown config path: ${config_path}"
            return 1 2>/dev/null; exit 1;
        fi

        local setup_filepath=${config_path}/${setup_filename}
        if [[ ! -f ${setup_filepath} ]]; then
            echo "Unknown setup file: ${setup_filepath}"
            return 1 2>/dev/null; exit 1;
        fi

        # read the setup file
        source ${setup_filepath}
        if [ -z "${config_files}" ]; then
            echo "Error. config-files not defined in setup file"
            exit 1
        fi


        # backup all the files
        echo "Backing up files..."
        local backup_path=`$cmd mktemp -d`
        while read -t 1 -r a b; do
            local src=~/${b}
            local dst=${backup_path}/${b}

            if [[ -f ${src} ]]; then
                $cmd mkdir -p $(dirname ${dst})
                $cmd cp ${src} ${dst}
            fi
        done < <(echo ${config_files[@]} | xargs -n2)
        $cmd find ${backup_path} -type f
        echo


        # update the files
        while read -t 1 -r a b; do
            local src=$(realpath ${config_path}/${a})
            local dst=~/${b}

            $cmd mkdir -p $(dirname ${dst})
            $cmd ln -sf ${src} ${dst}
        done < <(echo ${config_files[@]} | xargs -n2)
        unset config_files
    )
}

__main__ $@
unset -f __main__
