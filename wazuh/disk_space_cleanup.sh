#!/bin/bash
# */30 * * * * bash /opt/watchbeat/disk_space_cleanup.sh

source "$(dirname "$0")/.env"

if [ $(df / --output=pcent | tr -dc '0-9') -ge 68 ]; then
    OLD_IDX=$(curl -ks -u "$WI_USER:$WI_PASS" "$WI_URL/_cat/indices/wazuh-alerts-*?s=index:asc&h=index" | head -n1)
    [ -n "$OLD_IDX" ] && curl -k -u "$WI_USER:$WI_PASS" -XDELETE "$WI_URL/$OLD_IDX"
fi
