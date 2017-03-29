FROM jboss/base-jdk:8

ENV KEYCLOAK_VERSION 2.5.4.Final


USER root
# Export file
RUN mkdir /data && touch /data/keycloak-export.json && chown jboss:jboss /data/keycloak-export.json

# Import file
ADD keycloak-import.json /opt/jboss/


USER jboss

# Download Keycloak and unzip
RUN cd /opt/jboss/ && curl http://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz | tar zx && mv /opt/jboss/keycloak-$KEYCLOAK_VERSION /opt/jboss/keycloak


ARG KEYCLOAK_ADMIN_USER=admin
ARG KEYCLOAK_ADMIN_PASWORD=password

# add admin user
RUN /opt/jboss/keycloak/bin/add-user-keycloak.sh -u ${KEYCLOAK_ADMIN_USER} -p ${KEYCLOAK_ADMIN_PASWORD}

ENV JBOSS_HOME /opt/jboss/keycloak


# ADD the XSLs
ADD setLogLevel.xsl /opt/jboss/keycloak/
ADD changeDatabase.xsl /opt/jboss/keycloak/

ADD saxon.jar /opt/jboss/keycloak

RUN java -jar /opt/jboss/keycloak/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml -xsl:/opt/jboss/keycloak/setLogLevel.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml


RUN java -jar /opt/jboss/keycloak/saxon.jar -s:/opt/jboss/keycloak/standalone/configuration/standalone.xml -xsl:/opt/jboss/keycloak/changeDatabase.xsl -o:/opt/jboss/keycloak/standalone/configuration/standalone.xml; 


# Adding the custom jar to the providers folder - 
# ADD HMCTSKeycloakProvider-0.0.1-SNAPSHOT.jar  /opt/jboss/keycloak/providers/

# setup postgres database instead of h2
ENV DB_CONNECTOR_VERSION 9.4-1201-jdbc41

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main; cd /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main; curl -O http://central.maven.org/maven2/org/postgresql/postgresql/$DB_CONNECTOR_VERSION/postgresql-$DB_CONNECTOR_VERSION.jar

ADD module.xml /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main/


EXPOSE 8080

ADD docker-entrypoint.sh /opt/jboss/

ENTRYPOINT [ "/opt/jboss/docker-entrypoint.sh" ]

# Export cmd line options
# CMD ["-b", "0.0.0.0", "-Dkeycloak.migration.action=export", "-Dkeycloak.migration.provider=singleFile", "-Dkeycloak.migration.file=/data/keycloak-export.json"]

# Import cmd line options
CMD ["-b", "0.0.0.0", "-Dkeycloak.migration.action=import", "-Dkeycloak.migration.provider=singleFile", "-Dkeycloak.migration.file=/opt/jboss/keycloak-import.json", "-Dkeycloak.migration.strategy=OVERWRITE_EXISTING"]

# CMD ["-b", "0.0.0.0"]
