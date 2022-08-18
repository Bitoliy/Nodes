active=`grep -oPm1 "(?<=active_address: \")([^%]+)(?=\"$)" $HOME/.sui/sui_config/client.yaml | sed "s%0x%%"`; \
new=`sui keytool list | awk 'NR==3 {print $1}' | tr -d '[:space:]' | sed "s%0x%%"`; \
sed -i -e "s%$active%$new%; " $HOME/.sui/sui_config/client.yaml
