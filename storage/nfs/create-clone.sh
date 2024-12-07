#!/bin/sh

# Creates the desired clone 

TMPL_ID=3000
VM_ID=300
VM_NAME="mu-nfs"
CLOUD_INIT_SNIP="mu-nfs-cloud-init.yaml"


             #qm set ${VM_ID} --cicustom 'user=local:snippets/${CLOUD_INIT_SNIP}'" 

REMOTE_CMD_0=$(printf "qm clone %s %s --name %s --full" ${TMPL_ID} ${VM_ID} ${VM_NAME})
REMOTE_CMD_1=$(printf "qm set %s --cicustom 'user=local:snippets/%s'" ${VM_ID} ${CLOUD_INIT_SNIP})

REMOTE_CMD="${REMOTE_CMD_0} && ${REMOTE_CMD_1}"

ssh root@lab $REMOTE_CMD || echo "Errrorrs!!!"
