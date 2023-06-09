#!/usr/bin/env bash

# parse the command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --username=*)
            username="${1#*=}"
            shift
            ;;
        --hostname=*)
            echo $1
            echo ${}
            hostname="${1#*=}"
            shift
            ;;
        --address=*)
            address="${1#*=}"
            shift
            ;;
        *)
            echo "Unknown option $1"
            shift
            ;;
    esac
done

username=${username:?"Error. username not define"}
hostname=${hostname:?"Error. hostname not define"}
address=${address:?"Error. address not define"}


(
    set -x
    kinit -ft ~/.kerberos/${username}.keytab ${username}@FNAL.GOV && klist
    ssh -C -N -q -K -L ${address}:localhost:${address} ${username}@${hostname}.fnal.gov
)