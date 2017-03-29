==== keycloak-deployment-poc ======

Keycloak server deployment in standalone mode as docker image.

- Docker image for the Keycloak auth server 2.5.4.Final
- Docker image for the Postgres database (instead of native h2).
- XSL stylesheet for the database configuration and 
- XSL stylesheet for enabling KEYCLOAK_LOGLEVEL log level to DEBUG.
1. Pre-requisties

- Docker
- Docker-compose
2. Deployment

> $ ./build.sh

    - Build the Keycloak docker image with the given setup instructions.
    - Build the Postgres docker image.


> $ ./compose.sh

    - Runs the Keycloak and Postgres images with the docker runtime parameters.
3. Testing

 - Go the the URL in the browser
    - http://localhost:8080/auth