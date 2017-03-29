#!/bin/bash

#if [ $KEYCLOAK_USER ] && [ $KEYCLOAK_PASSWORD ]; then
#    keycloak/bin/add-user-keycloak.sh --user $KEYCLOAK_USER --password $KEYCLOAK_PASSWORD
#fi


exec /opt/jboss/keycloak/bin/standalone.sh $@
# exec /opt/jboss/keycloak/bin/domain.sh  --host-config=host-master.xml  $@
exit $?
