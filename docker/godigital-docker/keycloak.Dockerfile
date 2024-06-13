FROM quay.io/keycloak/keycloak:24.0 as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak

COPY keycloak/theme /opt/keycloak/providers
COPY keycloak/import /opt/keycloak/data/import

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:24.0
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ARG ARG_KC_DB_URL
ARG ARG_KC_DB_USERNAME
ARG ARG_KC_DB_PASSWORD

# change these values to point to a running postgres instance
ENV KC_DB=postgres
ENV KC_DB_URL=$ARG_KC_DB_URL
ENV KC_DB_USERNAME=$ARG_KC_DB_USERNAME
ENV KC_DB_PASSWORD=$ARG_KC_DB_PASSWORD

COPY keycloak/theme /opt/keycloak/themes


ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]