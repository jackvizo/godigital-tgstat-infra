--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO godigital;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO godigital;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO godigital;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO godigital;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO godigital;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO godigital;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO godigital;

--
-- Name: client; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO godigital;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO godigital;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO godigital;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO godigital;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO godigital;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO godigital;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO godigital;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO godigital;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO godigital;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO godigital;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO godigital;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO godigital;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO godigital;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO godigital;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO godigital;

--
-- Name: component; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO godigital;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO godigital;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO godigital;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO godigital;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO godigital;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO godigital;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO godigital;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO godigital;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO godigital;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO godigital;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO godigital;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO godigital;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO godigital;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO godigital;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO godigital;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO godigital;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO godigital;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO godigital;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO godigital;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO godigital;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO godigital;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO godigital;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO godigital;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO godigital;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO godigital;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO godigital;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO godigital;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO godigital;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO godigital;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO godigital;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO godigital;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO godigital;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO godigital;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO godigital;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO godigital;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO godigital;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO godigital;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO godigital;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO godigital;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO godigital;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO godigital;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO godigital;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO godigital;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO godigital;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO godigital;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO godigital;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO godigital;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO godigital;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO godigital;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO godigital;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO godigital;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO godigital;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO godigital;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO godigital;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO godigital;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO godigital;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO godigital;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO godigital;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO godigital;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO godigital;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO godigital;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO godigital;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO godigital;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO godigital;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO godigital;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO godigital;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO godigital;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO godigital;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO godigital;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: godigital
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO godigital;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
40f38168-a57e-4c85-8a84-e1a682b8d2e6	\N	auth-cookie	c8810218-c378-437b-a906-f64e9cee8ae4	2290a502-da34-426d-b37c-d687fdc0e0f4	2	10	f	\N	\N
14696489-0c5e-41c8-99ed-2a038c65b422	\N	auth-spnego	c8810218-c378-437b-a906-f64e9cee8ae4	2290a502-da34-426d-b37c-d687fdc0e0f4	3	20	f	\N	\N
67cf36a6-1aeb-495a-9d42-5af3a8193402	\N	identity-provider-redirector	c8810218-c378-437b-a906-f64e9cee8ae4	2290a502-da34-426d-b37c-d687fdc0e0f4	2	25	f	\N	\N
061c6613-6fb7-4914-826f-d23826b8dcbc	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	2290a502-da34-426d-b37c-d687fdc0e0f4	2	30	t	608847d1-2d10-43fa-bdb2-c09fd1746088	\N
4fa14092-f07e-47e6-95fa-b7814ba95f10	\N	auth-username-password-form	c8810218-c378-437b-a906-f64e9cee8ae4	608847d1-2d10-43fa-bdb2-c09fd1746088	0	10	f	\N	\N
83679195-480a-4465-9d56-7e97808e97cb	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	608847d1-2d10-43fa-bdb2-c09fd1746088	1	20	t	4ef688c3-8892-43c2-b479-ce434226e84c	\N
af7fb3cd-0bb9-4e2d-aecf-ecdbda0526f2	\N	conditional-user-configured	c8810218-c378-437b-a906-f64e9cee8ae4	4ef688c3-8892-43c2-b479-ce434226e84c	0	10	f	\N	\N
9a5c35e1-4fa3-4122-8303-c1c331c01890	\N	auth-otp-form	c8810218-c378-437b-a906-f64e9cee8ae4	4ef688c3-8892-43c2-b479-ce434226e84c	0	20	f	\N	\N
886ab8d8-db51-4bea-a110-4ce29fd8e9ad	\N	direct-grant-validate-username	c8810218-c378-437b-a906-f64e9cee8ae4	74d2b456-294c-4dce-9051-354757f8e243	0	10	f	\N	\N
acd2e818-dfd8-4c82-a7e1-c63741e90f2b	\N	direct-grant-validate-password	c8810218-c378-437b-a906-f64e9cee8ae4	74d2b456-294c-4dce-9051-354757f8e243	0	20	f	\N	\N
cba543c1-fb00-4c41-9146-bdd662ffdcf1	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	74d2b456-294c-4dce-9051-354757f8e243	1	30	t	23cef1f1-d08a-44e6-96bc-1cb768b0fed0	\N
a6c2d2b7-d4c5-4a39-a371-1987f6eebb37	\N	conditional-user-configured	c8810218-c378-437b-a906-f64e9cee8ae4	23cef1f1-d08a-44e6-96bc-1cb768b0fed0	0	10	f	\N	\N
1d85b296-51f6-463c-8473-9f062b8a170a	\N	direct-grant-validate-otp	c8810218-c378-437b-a906-f64e9cee8ae4	23cef1f1-d08a-44e6-96bc-1cb768b0fed0	0	20	f	\N	\N
f8042da2-4ba5-457f-a593-e241be94eb84	\N	registration-page-form	c8810218-c378-437b-a906-f64e9cee8ae4	5a57aa22-3d83-4e32-9175-eac539bfb4e5	0	10	t	c2653eb8-d066-4adc-95f9-3e0a4d476eae	\N
0f5809b0-ddcc-4f8e-960f-c84f8d7e182b	\N	registration-user-creation	c8810218-c378-437b-a906-f64e9cee8ae4	c2653eb8-d066-4adc-95f9-3e0a4d476eae	0	20	f	\N	\N
b90c6022-f122-4db3-abd5-9171e1696ed8	\N	registration-password-action	c8810218-c378-437b-a906-f64e9cee8ae4	c2653eb8-d066-4adc-95f9-3e0a4d476eae	0	50	f	\N	\N
b7ef2cf2-8a82-4bcc-af79-89c24db212ee	\N	registration-recaptcha-action	c8810218-c378-437b-a906-f64e9cee8ae4	c2653eb8-d066-4adc-95f9-3e0a4d476eae	3	60	f	\N	\N
c5764605-0740-4a11-ab3a-56eb0ec72426	\N	registration-terms-and-conditions	c8810218-c378-437b-a906-f64e9cee8ae4	c2653eb8-d066-4adc-95f9-3e0a4d476eae	3	70	f	\N	\N
afa41128-d356-4fa6-a60b-649490073f99	\N	reset-credentials-choose-user	c8810218-c378-437b-a906-f64e9cee8ae4	f77b3e80-0989-47c6-b24c-e444f12d82a8	0	10	f	\N	\N
d2850397-d5f8-4a7c-96cf-cd51a95227e1	\N	reset-credential-email	c8810218-c378-437b-a906-f64e9cee8ae4	f77b3e80-0989-47c6-b24c-e444f12d82a8	0	20	f	\N	\N
161c2805-422c-4c96-bf8d-58c965ebdc20	\N	reset-password	c8810218-c378-437b-a906-f64e9cee8ae4	f77b3e80-0989-47c6-b24c-e444f12d82a8	0	30	f	\N	\N
1bff01fa-4874-4c96-91a5-341bf9e12dcf	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	f77b3e80-0989-47c6-b24c-e444f12d82a8	1	40	t	512600ac-233b-425b-93eb-7dd0d999daa0	\N
996856e4-eaf4-44c2-ae74-c3a422db40cf	\N	conditional-user-configured	c8810218-c378-437b-a906-f64e9cee8ae4	512600ac-233b-425b-93eb-7dd0d999daa0	0	10	f	\N	\N
fad14b06-b9a2-4236-b642-36a2d7290e42	\N	reset-otp	c8810218-c378-437b-a906-f64e9cee8ae4	512600ac-233b-425b-93eb-7dd0d999daa0	0	20	f	\N	\N
92d3773f-e3d8-4474-8446-07f899e47aff	\N	client-secret	c8810218-c378-437b-a906-f64e9cee8ae4	246cab7f-7cdb-4dbd-9529-199315765f5e	2	10	f	\N	\N
cb9294c9-c7ee-4492-a05b-b71dcce15e6c	\N	client-jwt	c8810218-c378-437b-a906-f64e9cee8ae4	246cab7f-7cdb-4dbd-9529-199315765f5e	2	20	f	\N	\N
2c627366-d678-4b0e-b710-78f3c8a050f4	\N	client-secret-jwt	c8810218-c378-437b-a906-f64e9cee8ae4	246cab7f-7cdb-4dbd-9529-199315765f5e	2	30	f	\N	\N
8917ffa0-b33d-4b92-bc32-2485e84d7e27	\N	client-x509	c8810218-c378-437b-a906-f64e9cee8ae4	246cab7f-7cdb-4dbd-9529-199315765f5e	2	40	f	\N	\N
ad5dd211-208e-4c61-864d-4cf730fa7ca1	\N	idp-review-profile	c8810218-c378-437b-a906-f64e9cee8ae4	491e1994-672c-419d-8bc0-46b2ec6bb0e9	0	10	f	\N	39b32ee1-1bd1-4fd6-aaa4-0a61a374538a
6c87672f-3f3a-4c35-9755-4f2dfba063c8	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	491e1994-672c-419d-8bc0-46b2ec6bb0e9	0	20	t	c71606b7-0f9c-420a-a42d-3f50b2cbd099	\N
ec93c3ab-d8d6-40dd-a97f-f5d46eb37f17	\N	idp-create-user-if-unique	c8810218-c378-437b-a906-f64e9cee8ae4	c71606b7-0f9c-420a-a42d-3f50b2cbd099	2	10	f	\N	52af545e-9879-458b-a781-502b5e4d2555
80e5ce51-bf0f-4d07-8c0c-208f5382cd83	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	c71606b7-0f9c-420a-a42d-3f50b2cbd099	2	20	t	b11d608e-490e-432e-bbcb-b7b9f3fc3ba4	\N
c9ee15ad-523c-4278-a5f0-86fe68a683ba	\N	idp-confirm-link	c8810218-c378-437b-a906-f64e9cee8ae4	b11d608e-490e-432e-bbcb-b7b9f3fc3ba4	0	10	f	\N	\N
85146c08-be58-4249-b349-95e8a2e3947c	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	b11d608e-490e-432e-bbcb-b7b9f3fc3ba4	0	20	t	7d5d81b6-5621-4736-ba89-a868fe31860f	\N
85998e60-8148-45f9-ad5c-ca2381465444	\N	idp-email-verification	c8810218-c378-437b-a906-f64e9cee8ae4	7d5d81b6-5621-4736-ba89-a868fe31860f	2	10	f	\N	\N
3f45536d-0bd9-4a73-9b64-69f09fc815fc	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	7d5d81b6-5621-4736-ba89-a868fe31860f	2	20	t	bcf334be-e2dc-4d7c-a852-d7d41ccd63e9	\N
15ad2750-a37a-47f9-a484-54a8482e0a00	\N	idp-username-password-form	c8810218-c378-437b-a906-f64e9cee8ae4	bcf334be-e2dc-4d7c-a852-d7d41ccd63e9	0	10	f	\N	\N
5df7422f-72a6-44f6-93ad-3327fc645871	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	bcf334be-e2dc-4d7c-a852-d7d41ccd63e9	1	20	t	50c70189-411d-48aa-a2ff-04421b2ca150	\N
4de7b6da-963d-4b1e-b21d-ed1f964ee629	\N	conditional-user-configured	c8810218-c378-437b-a906-f64e9cee8ae4	50c70189-411d-48aa-a2ff-04421b2ca150	0	10	f	\N	\N
e9c784f3-7302-4a74-a240-8f3f23558b6b	\N	auth-otp-form	c8810218-c378-437b-a906-f64e9cee8ae4	50c70189-411d-48aa-a2ff-04421b2ca150	0	20	f	\N	\N
caad25bb-3384-4e0b-b2d1-1f0cefa9e074	\N	http-basic-authenticator	c8810218-c378-437b-a906-f64e9cee8ae4	7c6e71f2-e8d4-4926-9176-87217a58e8c6	0	10	f	\N	\N
e055d452-5997-4825-880c-06e6a7e94bb0	\N	docker-http-basic-authenticator	c8810218-c378-437b-a906-f64e9cee8ae4	c5d7dce8-8756-401e-8a93-7e7245eed4ef	0	10	f	\N	\N
2ce57dd3-d53e-47e3-aeb9-dffa9df6e052	\N	idp-email-verification	16d92262-12b3-4f31-aa27-dc97588c55e9	c399c433-fa74-4b34-bdcb-207b80b9a288	2	10	f	\N	\N
f35ad4ea-e705-4de7-a46c-5b4dab81816b	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	c399c433-fa74-4b34-bdcb-207b80b9a288	2	20	t	3ad50a9e-ba12-460d-bbc8-0465770a734d	\N
3788fe2c-5742-4a73-b300-70ba0b541973	\N	conditional-user-configured	16d92262-12b3-4f31-aa27-dc97588c55e9	61c2dcaf-97b5-4889-a224-56f3dbed723d	0	10	f	\N	\N
2a320c49-79d9-43f6-95b1-3183a9fd7fb7	\N	auth-otp-form	16d92262-12b3-4f31-aa27-dc97588c55e9	61c2dcaf-97b5-4889-a224-56f3dbed723d	0	20	f	\N	\N
5b7c5ef2-071e-4d85-ba80-730bdc8689d7	\N	conditional-user-configured	16d92262-12b3-4f31-aa27-dc97588c55e9	c2d2df5d-0fa5-4b73-849e-43819e72ba5d	0	10	f	\N	\N
3cdf9cd7-e426-45d5-813b-7e8f493b1085	\N	direct-grant-validate-otp	16d92262-12b3-4f31-aa27-dc97588c55e9	c2d2df5d-0fa5-4b73-849e-43819e72ba5d	0	20	f	\N	\N
e840ff73-ea3e-4deb-ac76-c0e0c050709e	\N	conditional-user-configured	16d92262-12b3-4f31-aa27-dc97588c55e9	218d76b1-a6b6-43dc-bcef-af25c5690e35	0	10	f	\N	\N
c8dbe3cf-0114-4dc1-960e-fa89b5d87ffe	\N	auth-otp-form	16d92262-12b3-4f31-aa27-dc97588c55e9	218d76b1-a6b6-43dc-bcef-af25c5690e35	0	20	f	\N	\N
0dcd88d2-e9e3-4ae0-b655-c0d29c75eb02	\N	idp-confirm-link	16d92262-12b3-4f31-aa27-dc97588c55e9	2e451cb7-f7f0-468e-b5d7-d766fa2dd288	0	10	f	\N	\N
570fd088-e42c-4a91-a30a-b12a5ce6ba0c	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	2e451cb7-f7f0-468e-b5d7-d766fa2dd288	0	20	t	c399c433-fa74-4b34-bdcb-207b80b9a288	\N
406ce102-9812-4fda-bd70-20b44c707ec3	\N	conditional-user-configured	16d92262-12b3-4f31-aa27-dc97588c55e9	73cdcdf9-cb78-46b6-a380-3f745783c8a9	0	10	f	\N	\N
70d54ca6-e22f-4ba4-9da0-f5e48f95fdc6	\N	reset-otp	16d92262-12b3-4f31-aa27-dc97588c55e9	73cdcdf9-cb78-46b6-a380-3f745783c8a9	0	20	f	\N	\N
d928e24a-6295-4408-a0f9-219b0b3db87f	\N	idp-create-user-if-unique	16d92262-12b3-4f31-aa27-dc97588c55e9	903a29b2-2715-4762-a083-bd837c305c4f	2	10	f	\N	1e3e0659-abed-4d15-ac2d-69e81ad325ca
1db55916-f501-4742-ad3b-c797b8d96b01	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	903a29b2-2715-4762-a083-bd837c305c4f	2	20	t	2e451cb7-f7f0-468e-b5d7-d766fa2dd288	\N
99df705d-de64-41aa-b842-bfb8c7774e32	\N	idp-username-password-form	16d92262-12b3-4f31-aa27-dc97588c55e9	3ad50a9e-ba12-460d-bbc8-0465770a734d	0	10	f	\N	\N
15ea9d09-a21d-4b00-b2ac-41fba3fb7125	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	3ad50a9e-ba12-460d-bbc8-0465770a734d	1	20	t	218d76b1-a6b6-43dc-bcef-af25c5690e35	\N
db3f01e0-53c9-4809-9a3e-3346db433f43	\N	auth-cookie	16d92262-12b3-4f31-aa27-dc97588c55e9	9c92d4fb-7685-4a12-8195-35a2bc7101fa	3	10	f	\N	\N
ae76a1b3-1457-4235-968d-60a3806543eb	\N	auth-spnego	16d92262-12b3-4f31-aa27-dc97588c55e9	9c92d4fb-7685-4a12-8195-35a2bc7101fa	3	20	f	\N	\N
2c691920-7a8c-46d5-9019-83852fae987a	\N	identity-provider-redirector	16d92262-12b3-4f31-aa27-dc97588c55e9	9c92d4fb-7685-4a12-8195-35a2bc7101fa	2	25	f	\N	\N
5c42ede1-e2d6-4c64-aea8-52554893659e	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	9c92d4fb-7685-4a12-8195-35a2bc7101fa	2	30	t	cf6bad57-dddc-45a3-b83a-ab218244934f	\N
cc9c785e-15d1-4763-85f0-e82ae6966ef9	\N	client-secret	16d92262-12b3-4f31-aa27-dc97588c55e9	45e62bdc-de9a-433e-b833-a90228b15da5	2	10	f	\N	\N
0193fde4-4d93-446e-b4d8-fd691da24b24	\N	client-jwt	16d92262-12b3-4f31-aa27-dc97588c55e9	45e62bdc-de9a-433e-b833-a90228b15da5	2	20	f	\N	\N
e673115c-226f-4d5c-b813-dc55cc0ed152	\N	client-secret-jwt	16d92262-12b3-4f31-aa27-dc97588c55e9	45e62bdc-de9a-433e-b833-a90228b15da5	2	30	f	\N	\N
c30cf82f-15bf-43bc-bc7a-5f2cbcdc7fb4	\N	client-x509	16d92262-12b3-4f31-aa27-dc97588c55e9	45e62bdc-de9a-433e-b833-a90228b15da5	2	40	f	\N	\N
417814b5-79cc-45ac-b0be-324f664e5926	\N	direct-grant-validate-username	16d92262-12b3-4f31-aa27-dc97588c55e9	0c60aaf7-ddc8-4d60-a192-94b7f3cde593	0	10	f	\N	\N
5c19a7c6-6f91-4127-8fbb-0f1f0381388a	\N	direct-grant-validate-password	16d92262-12b3-4f31-aa27-dc97588c55e9	0c60aaf7-ddc8-4d60-a192-94b7f3cde593	0	20	f	\N	\N
0990d620-406d-40a9-b553-eb5b9b6796a3	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	0c60aaf7-ddc8-4d60-a192-94b7f3cde593	1	30	t	c2d2df5d-0fa5-4b73-849e-43819e72ba5d	\N
56d1950a-22d7-4fb8-bc89-e0ce6a9509c6	\N	docker-http-basic-authenticator	16d92262-12b3-4f31-aa27-dc97588c55e9	e7157816-0e47-46e1-91f7-aeeed7fc9366	0	10	f	\N	\N
050fae9d-8f6c-4bee-bf7a-96e80ecdad2f	\N	idp-review-profile	16d92262-12b3-4f31-aa27-dc97588c55e9	d35fa945-d07f-4a45-b4fb-40f7aed9f0d5	0	10	f	\N	873dedb0-3435-4fce-a790-1ac240ff5841
bc9ea4dc-6e62-4bc9-ac45-d50f14d569c1	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	d35fa945-d07f-4a45-b4fb-40f7aed9f0d5	0	20	t	903a29b2-2715-4762-a083-bd837c305c4f	\N
6c1c6e46-202f-432e-9923-db0d8ac14909	\N	auth-username-password-form	16d92262-12b3-4f31-aa27-dc97588c55e9	cf6bad57-dddc-45a3-b83a-ab218244934f	0	10	f	\N	\N
d8d0cfae-9706-4ac1-b79c-8045048a2a3f	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	cf6bad57-dddc-45a3-b83a-ab218244934f	1	20	t	61c2dcaf-97b5-4889-a224-56f3dbed723d	\N
2412e0f0-7e7b-4cb9-8811-33e6618321cf	\N	registration-page-form	16d92262-12b3-4f31-aa27-dc97588c55e9	f44f68f7-268f-410d-9fc5-df0673b71852	0	10	t	ac198426-1ede-488d-957d-057f17551438	\N
5c8dc65b-c423-4388-86de-d9ca49af4309	\N	registration-user-creation	16d92262-12b3-4f31-aa27-dc97588c55e9	ac198426-1ede-488d-957d-057f17551438	0	20	f	\N	\N
92da00ef-440c-436c-a43a-06677d58e6df	\N	registration-password-action	16d92262-12b3-4f31-aa27-dc97588c55e9	ac198426-1ede-488d-957d-057f17551438	0	50	f	\N	\N
96c76ac1-84c4-47cd-b491-9220dc42a52f	\N	registration-recaptcha-action	16d92262-12b3-4f31-aa27-dc97588c55e9	ac198426-1ede-488d-957d-057f17551438	3	60	f	\N	\N
d5738409-bcd0-4013-bc74-8c440da77066	\N	reset-credentials-choose-user	16d92262-12b3-4f31-aa27-dc97588c55e9	d9040a95-51cf-47c0-acdb-d0fc9e1e13ac	0	10	f	\N	\N
fcc2887b-eec6-4279-bfcd-86cb2907c069	\N	reset-credential-email	16d92262-12b3-4f31-aa27-dc97588c55e9	d9040a95-51cf-47c0-acdb-d0fc9e1e13ac	0	20	f	\N	\N
173f1b98-75ad-403f-b8f7-9159c4ee4e10	\N	reset-password	16d92262-12b3-4f31-aa27-dc97588c55e9	d9040a95-51cf-47c0-acdb-d0fc9e1e13ac	0	30	f	\N	\N
6bcfc879-ab1a-4676-bfb6-aa5a89150d2d	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	d9040a95-51cf-47c0-acdb-d0fc9e1e13ac	1	40	t	73cdcdf9-cb78-46b6-a380-3f745783c8a9	\N
f6be2d56-1262-4d3c-802b-05170de02cfa	\N	http-basic-authenticator	16d92262-12b3-4f31-aa27-dc97588c55e9	572eaf9c-d846-4cd8-b574-12a2ccdc9d0f	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
2290a502-da34-426d-b37c-d687fdc0e0f4	browser	browser based authentication	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	t	t
608847d1-2d10-43fa-bdb2-c09fd1746088	forms	Username, password, otp and other auth forms.	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
4ef688c3-8892-43c2-b479-ce434226e84c	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
74d2b456-294c-4dce-9051-354757f8e243	direct grant	OpenID Connect Resource Owner Grant	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	t	t
23cef1f1-d08a-44e6-96bc-1cb768b0fed0	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
5a57aa22-3d83-4e32-9175-eac539bfb4e5	registration	registration flow	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	t	t
c2653eb8-d066-4adc-95f9-3e0a4d476eae	registration form	registration form	c8810218-c378-437b-a906-f64e9cee8ae4	form-flow	f	t
f77b3e80-0989-47c6-b24c-e444f12d82a8	reset credentials	Reset credentials for a user if they forgot their password or something	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	t	t
512600ac-233b-425b-93eb-7dd0d999daa0	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
246cab7f-7cdb-4dbd-9529-199315765f5e	clients	Base authentication for clients	c8810218-c378-437b-a906-f64e9cee8ae4	client-flow	t	t
491e1994-672c-419d-8bc0-46b2ec6bb0e9	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	t	t
c71606b7-0f9c-420a-a42d-3f50b2cbd099	User creation or linking	Flow for the existing/non-existing user alternatives	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
b11d608e-490e-432e-bbcb-b7b9f3fc3ba4	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
7d5d81b6-5621-4736-ba89-a868fe31860f	Account verification options	Method with which to verity the existing account	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
bcf334be-e2dc-4d7c-a852-d7d41ccd63e9	Verify Existing Account by Re-authentication	Reauthentication of existing account	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
50c70189-411d-48aa-a2ff-04421b2ca150	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	f	t
7c6e71f2-e8d4-4926-9176-87217a58e8c6	saml ecp	SAML ECP Profile Authentication Flow	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	t	t
c5d7dce8-8756-401e-8a93-7e7245eed4ef	docker auth	Used by Docker clients to authenticate against the IDP	c8810218-c378-437b-a906-f64e9cee8ae4	basic-flow	t	t
c399c433-fa74-4b34-bdcb-207b80b9a288	Account verification options	Method with which to verity the existing account	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
61c2dcaf-97b5-4889-a224-56f3dbed723d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
c2d2df5d-0fa5-4b73-849e-43819e72ba5d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
218d76b1-a6b6-43dc-bcef-af25c5690e35	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
2e451cb7-f7f0-468e-b5d7-d766fa2dd288	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
73cdcdf9-cb78-46b6-a380-3f745783c8a9	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
903a29b2-2715-4762-a083-bd837c305c4f	User creation or linking	Flow for the existing/non-existing user alternatives	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
3ad50a9e-ba12-460d-bbc8-0465770a734d	Verify Existing Account by Re-authentication	Reauthentication of existing account	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
9c92d4fb-7685-4a12-8195-35a2bc7101fa	browser	browser based authentication	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	t	t
45e62bdc-de9a-433e-b833-a90228b15da5	clients	Base authentication for clients	16d92262-12b3-4f31-aa27-dc97588c55e9	client-flow	t	t
0c60aaf7-ddc8-4d60-a192-94b7f3cde593	direct grant	OpenID Connect Resource Owner Grant	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	t	t
e7157816-0e47-46e1-91f7-aeeed7fc9366	docker auth	Used by Docker clients to authenticate against the IDP	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	t	t
d35fa945-d07f-4a45-b4fb-40f7aed9f0d5	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	t	t
cf6bad57-dddc-45a3-b83a-ab218244934f	forms	Username, password, otp and other auth forms.	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	f	t
f44f68f7-268f-410d-9fc5-df0673b71852	registration	registration flow	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	t	t
ac198426-1ede-488d-957d-057f17551438	registration form	registration form	16d92262-12b3-4f31-aa27-dc97588c55e9	form-flow	f	t
d9040a95-51cf-47c0-acdb-d0fc9e1e13ac	reset credentials	Reset credentials for a user if they forgot their password or something	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	t	t
572eaf9c-d846-4cd8-b574-12a2ccdc9d0f	saml ecp	SAML ECP Profile Authentication Flow	16d92262-12b3-4f31-aa27-dc97588c55e9	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
39b32ee1-1bd1-4fd6-aaa4-0a61a374538a	review profile config	c8810218-c378-437b-a906-f64e9cee8ae4
52af545e-9879-458b-a781-502b5e4d2555	create unique user config	c8810218-c378-437b-a906-f64e9cee8ae4
1e3e0659-abed-4d15-ac2d-69e81ad325ca	create unique user config	16d92262-12b3-4f31-aa27-dc97588c55e9
873dedb0-3435-4fce-a790-1ac240ff5841	review profile config	16d92262-12b3-4f31-aa27-dc97588c55e9
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
39b32ee1-1bd1-4fd6-aaa4-0a61a374538a	missing	update.profile.on.first.login
52af545e-9879-458b-a781-502b5e4d2555	false	require.password.update.after.registration
1e3e0659-abed-4d15-ac2d-69e81ad325ca	false	require.password.update.after.registration
873dedb0-3435-4fce-a790-1ac240ff5841	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
1ac20814-714f-41f2-914d-f3b6664fc004	t	f	master-realm	0	f	\N	\N	t	\N	f	c8810218-c378-437b-a906-f64e9cee8ae4	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
0759f154-70b7-4204-804f-e3693b67a479	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	c8810218-c378-437b-a906-f64e9cee8ae4	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
5d529f55-8c40-4666-85f0-159c70f8dd23	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	c8810218-c378-437b-a906-f64e9cee8ae4	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a69db417-264a-48ab-a12f-3097deaf4f69	t	f	broker	0	f	\N	\N	t	\N	f	c8810218-c378-437b-a906-f64e9cee8ae4	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	c8810218-c378-437b-a906-f64e9cee8ae4	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	t	f	admin-cli	0	t	\N	\N	f	\N	f	c8810218-c378-437b-a906-f64e9cee8ae4	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	f	godigital-realm	0	f	\N	\N	t	\N	f	c8810218-c378-437b-a906-f64e9cee8ae4	\N	0	f	f	godigital Realm	f	client-secret	\N	\N	\N	t	f	f	f
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	t	t	godigital	0	f	qSjnl0jk4rHDzxITX6l0MeCvaOh6BF3t	http://godigital.local:3000	f	http://sso.godigital.local:9080	f	16d92262-12b3-4f31-aa27-dc97588c55e9	openid-connect	-1	t	f		t	client-secret	http://godigital.local:3000		\N	t	f	t	f
0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	f	account	0	t	\N	/realms/godigital/account/	f	\N	f	16d92262-12b3-4f31-aa27-dc97588c55e9	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
0e7139bb-6d77-442d-b045-0ce8e85dc81c	t	f	account-console	0	t	\N	/realms/godigital/account/	f	\N	f	16d92262-12b3-4f31-aa27-dc97588c55e9	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	t	f	admin-cli	0	t	\N	\N	f	\N	f	16d92262-12b3-4f31-aa27-dc97588c55e9	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	t	f	broker	0	f	\N	\N	t	\N	f	16d92262-12b3-4f31-aa27-dc97588c55e9	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
96042979-1680-49fa-b1be-5749a1590c81	t	f	realm-management	0	f	\N	\N	t	\N	f	16d92262-12b3-4f31-aa27-dc97588c55e9	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
db962978-abd2-4625-8288-472315f9d100	t	f	security-admin-console	0	t	\N	/admin/godigital/console/	f	\N	f	16d92262-12b3-4f31-aa27-dc97588c55e9	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
0759f154-70b7-4204-804f-e3693b67a479	post.logout.redirect.uris	+
5d529f55-8c40-4666-85f0-159c70f8dd23	post.logout.redirect.uris	+
5d529f55-8c40-4666-85f0-159c70f8dd23	pkce.code.challenge.method	S256
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	post.logout.redirect.uris	+
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	pkce.code.challenge.method	S256
0c65f92d-f46d-44b5-851f-5817ba5e1da0	post.logout.redirect.uris	+
0e7139bb-6d77-442d-b045-0ce8e85dc81c	post.logout.redirect.uris	+
0e7139bb-6d77-442d-b045-0ce8e85dc81c	pkce.code.challenge.method	S256
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	post.logout.redirect.uris	+
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	post.logout.redirect.uris	+
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	oidc.ciba.grant.enabled	false
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	backchannel.logout.session.required	true
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	oauth2.device.authorization.grant.enabled	false
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	display.on.consent.screen	false
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	backchannel.logout.revoke.offline.tokens	false
96042979-1680-49fa-b1be-5749a1590c81	post.logout.redirect.uris	+
db962978-abd2-4625-8288-472315f9d100	post.logout.redirect.uris	+
db962978-abd2-4625-8288-472315f9d100	pkce.code.challenge.method	S256
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	post.logout.redirect.uris	http://localhost:3000/*##http://godigital.local:3000/*
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	client.secret.creation.time	1717565307
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	login_theme	godigital
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
2ba3423f-56e6-41c6-9d55-65f855e5c889	offline_access	c8810218-c378-437b-a906-f64e9cee8ae4	OpenID Connect built-in scope: offline_access	openid-connect
092009bf-8e2f-4eaa-ba2f-fc21bcec4c88	role_list	c8810218-c378-437b-a906-f64e9cee8ae4	SAML role list	saml
deeaabe4-aa70-45a7-9f63-79a58b389c4f	profile	c8810218-c378-437b-a906-f64e9cee8ae4	OpenID Connect built-in scope: profile	openid-connect
ab40a375-1207-42ea-a45b-f8294596b54f	email	c8810218-c378-437b-a906-f64e9cee8ae4	OpenID Connect built-in scope: email	openid-connect
1993ad97-561a-4d7d-9b86-b8c6f6011fcf	address	c8810218-c378-437b-a906-f64e9cee8ae4	OpenID Connect built-in scope: address	openid-connect
1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	phone	c8810218-c378-437b-a906-f64e9cee8ae4	OpenID Connect built-in scope: phone	openid-connect
fe6cec2e-d87a-4536-ad48-9569a18402d6	roles	c8810218-c378-437b-a906-f64e9cee8ae4	OpenID Connect scope for add user roles to the access token	openid-connect
17a3c288-248a-44a3-a8e7-20a6b19cd7d5	web-origins	c8810218-c378-437b-a906-f64e9cee8ae4	OpenID Connect scope for add allowed web origins to the access token	openid-connect
ddb7156d-5c15-4b02-b630-552211d657f8	microprofile-jwt	c8810218-c378-437b-a906-f64e9cee8ae4	Microprofile - JWT built-in scope	openid-connect
a1b76567-6467-4fcd-954d-c9ad780dfe04	acr	c8810218-c378-437b-a906-f64e9cee8ae4	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
e9d2e99f-55ff-4362-b711-61e6aae34d6d	profile	16d92262-12b3-4f31-aa27-dc97588c55e9	OpenID Connect built-in scope: profile	openid-connect
14d2fba0-8cda-43b3-ac33-f479e3e25a72	roles	16d92262-12b3-4f31-aa27-dc97588c55e9	OpenID Connect scope for add user roles to the access token	openid-connect
08427143-05fb-434a-9a34-0e858a1aad59	web-origins	16d92262-12b3-4f31-aa27-dc97588c55e9	OpenID Connect scope for add allowed web origins to the access token	openid-connect
985c3cab-005a-4116-a272-5ad07ab1dead	role_list	16d92262-12b3-4f31-aa27-dc97588c55e9	SAML role list	saml
072e19ef-af57-4a85-97ad-3c308587730a	microprofile-jwt	16d92262-12b3-4f31-aa27-dc97588c55e9	Microprofile - JWT built-in scope	openid-connect
ef848091-0de9-4bfe-9b3b-04e74b7d9731	email	16d92262-12b3-4f31-aa27-dc97588c55e9	OpenID Connect built-in scope: email	openid-connect
b4842e84-1538-49e8-9b98-224708a31f2a	phone	16d92262-12b3-4f31-aa27-dc97588c55e9	OpenID Connect built-in scope: phone	openid-connect
26281455-10da-4c98-9d72-c6901c3141f2	offline_access	16d92262-12b3-4f31-aa27-dc97588c55e9	OpenID Connect built-in scope: offline_access	openid-connect
57edfbbe-8594-4089-a68d-4cd0183d7a50	acr	16d92262-12b3-4f31-aa27-dc97588c55e9	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
ce00cc5f-ef91-4a53-91c2-648049c4304f	address	16d92262-12b3-4f31-aa27-dc97588c55e9	OpenID Connect built-in scope: address	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
2ba3423f-56e6-41c6-9d55-65f855e5c889	true	display.on.consent.screen
2ba3423f-56e6-41c6-9d55-65f855e5c889	${offlineAccessScopeConsentText}	consent.screen.text
092009bf-8e2f-4eaa-ba2f-fc21bcec4c88	true	display.on.consent.screen
092009bf-8e2f-4eaa-ba2f-fc21bcec4c88	${samlRoleListScopeConsentText}	consent.screen.text
deeaabe4-aa70-45a7-9f63-79a58b389c4f	true	display.on.consent.screen
deeaabe4-aa70-45a7-9f63-79a58b389c4f	${profileScopeConsentText}	consent.screen.text
deeaabe4-aa70-45a7-9f63-79a58b389c4f	true	include.in.token.scope
ab40a375-1207-42ea-a45b-f8294596b54f	true	display.on.consent.screen
ab40a375-1207-42ea-a45b-f8294596b54f	${emailScopeConsentText}	consent.screen.text
ab40a375-1207-42ea-a45b-f8294596b54f	true	include.in.token.scope
1993ad97-561a-4d7d-9b86-b8c6f6011fcf	true	display.on.consent.screen
1993ad97-561a-4d7d-9b86-b8c6f6011fcf	${addressScopeConsentText}	consent.screen.text
1993ad97-561a-4d7d-9b86-b8c6f6011fcf	true	include.in.token.scope
1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	true	display.on.consent.screen
1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	${phoneScopeConsentText}	consent.screen.text
1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	true	include.in.token.scope
fe6cec2e-d87a-4536-ad48-9569a18402d6	true	display.on.consent.screen
fe6cec2e-d87a-4536-ad48-9569a18402d6	${rolesScopeConsentText}	consent.screen.text
fe6cec2e-d87a-4536-ad48-9569a18402d6	false	include.in.token.scope
17a3c288-248a-44a3-a8e7-20a6b19cd7d5	false	display.on.consent.screen
17a3c288-248a-44a3-a8e7-20a6b19cd7d5		consent.screen.text
17a3c288-248a-44a3-a8e7-20a6b19cd7d5	false	include.in.token.scope
ddb7156d-5c15-4b02-b630-552211d657f8	false	display.on.consent.screen
ddb7156d-5c15-4b02-b630-552211d657f8	true	include.in.token.scope
a1b76567-6467-4fcd-954d-c9ad780dfe04	false	display.on.consent.screen
a1b76567-6467-4fcd-954d-c9ad780dfe04	false	include.in.token.scope
e9d2e99f-55ff-4362-b711-61e6aae34d6d	true	include.in.token.scope
e9d2e99f-55ff-4362-b711-61e6aae34d6d	true	display.on.consent.screen
e9d2e99f-55ff-4362-b711-61e6aae34d6d	${profileScopeConsentText}	consent.screen.text
14d2fba0-8cda-43b3-ac33-f479e3e25a72	false	include.in.token.scope
14d2fba0-8cda-43b3-ac33-f479e3e25a72	true	display.on.consent.screen
14d2fba0-8cda-43b3-ac33-f479e3e25a72	${rolesScopeConsentText}	consent.screen.text
08427143-05fb-434a-9a34-0e858a1aad59	false	include.in.token.scope
08427143-05fb-434a-9a34-0e858a1aad59	false	display.on.consent.screen
08427143-05fb-434a-9a34-0e858a1aad59		consent.screen.text
985c3cab-005a-4116-a272-5ad07ab1dead	${samlRoleListScopeConsentText}	consent.screen.text
985c3cab-005a-4116-a272-5ad07ab1dead	true	display.on.consent.screen
072e19ef-af57-4a85-97ad-3c308587730a	true	include.in.token.scope
072e19ef-af57-4a85-97ad-3c308587730a	false	display.on.consent.screen
ef848091-0de9-4bfe-9b3b-04e74b7d9731	true	include.in.token.scope
ef848091-0de9-4bfe-9b3b-04e74b7d9731	true	display.on.consent.screen
ef848091-0de9-4bfe-9b3b-04e74b7d9731	${emailScopeConsentText}	consent.screen.text
b4842e84-1538-49e8-9b98-224708a31f2a	true	include.in.token.scope
b4842e84-1538-49e8-9b98-224708a31f2a	true	display.on.consent.screen
b4842e84-1538-49e8-9b98-224708a31f2a	${phoneScopeConsentText}	consent.screen.text
26281455-10da-4c98-9d72-c6901c3141f2	${offlineAccessScopeConsentText}	consent.screen.text
26281455-10da-4c98-9d72-c6901c3141f2	true	display.on.consent.screen
57edfbbe-8594-4089-a68d-4cd0183d7a50	false	include.in.token.scope
57edfbbe-8594-4089-a68d-4cd0183d7a50	false	display.on.consent.screen
ce00cc5f-ef91-4a53-91c2-648049c4304f	true	include.in.token.scope
ce00cc5f-ef91-4a53-91c2-648049c4304f	true	display.on.consent.screen
ce00cc5f-ef91-4a53-91c2-648049c4304f	${addressScopeConsentText}	consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
0759f154-70b7-4204-804f-e3693b67a479	fe6cec2e-d87a-4536-ad48-9569a18402d6	t
0759f154-70b7-4204-804f-e3693b67a479	a1b76567-6467-4fcd-954d-c9ad780dfe04	t
0759f154-70b7-4204-804f-e3693b67a479	ab40a375-1207-42ea-a45b-f8294596b54f	t
0759f154-70b7-4204-804f-e3693b67a479	17a3c288-248a-44a3-a8e7-20a6b19cd7d5	t
0759f154-70b7-4204-804f-e3693b67a479	deeaabe4-aa70-45a7-9f63-79a58b389c4f	t
0759f154-70b7-4204-804f-e3693b67a479	2ba3423f-56e6-41c6-9d55-65f855e5c889	f
0759f154-70b7-4204-804f-e3693b67a479	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	f
0759f154-70b7-4204-804f-e3693b67a479	1993ad97-561a-4d7d-9b86-b8c6f6011fcf	f
0759f154-70b7-4204-804f-e3693b67a479	ddb7156d-5c15-4b02-b630-552211d657f8	f
5d529f55-8c40-4666-85f0-159c70f8dd23	fe6cec2e-d87a-4536-ad48-9569a18402d6	t
5d529f55-8c40-4666-85f0-159c70f8dd23	a1b76567-6467-4fcd-954d-c9ad780dfe04	t
5d529f55-8c40-4666-85f0-159c70f8dd23	ab40a375-1207-42ea-a45b-f8294596b54f	t
5d529f55-8c40-4666-85f0-159c70f8dd23	17a3c288-248a-44a3-a8e7-20a6b19cd7d5	t
5d529f55-8c40-4666-85f0-159c70f8dd23	deeaabe4-aa70-45a7-9f63-79a58b389c4f	t
5d529f55-8c40-4666-85f0-159c70f8dd23	2ba3423f-56e6-41c6-9d55-65f855e5c889	f
5d529f55-8c40-4666-85f0-159c70f8dd23	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	f
5d529f55-8c40-4666-85f0-159c70f8dd23	1993ad97-561a-4d7d-9b86-b8c6f6011fcf	f
5d529f55-8c40-4666-85f0-159c70f8dd23	ddb7156d-5c15-4b02-b630-552211d657f8	f
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	fe6cec2e-d87a-4536-ad48-9569a18402d6	t
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	a1b76567-6467-4fcd-954d-c9ad780dfe04	t
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	ab40a375-1207-42ea-a45b-f8294596b54f	t
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	17a3c288-248a-44a3-a8e7-20a6b19cd7d5	t
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	deeaabe4-aa70-45a7-9f63-79a58b389c4f	t
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	2ba3423f-56e6-41c6-9d55-65f855e5c889	f
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	f
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	1993ad97-561a-4d7d-9b86-b8c6f6011fcf	f
ad462bd8-a22d-489e-bc2b-6e1fa7c92159	ddb7156d-5c15-4b02-b630-552211d657f8	f
a69db417-264a-48ab-a12f-3097deaf4f69	fe6cec2e-d87a-4536-ad48-9569a18402d6	t
a69db417-264a-48ab-a12f-3097deaf4f69	a1b76567-6467-4fcd-954d-c9ad780dfe04	t
a69db417-264a-48ab-a12f-3097deaf4f69	ab40a375-1207-42ea-a45b-f8294596b54f	t
a69db417-264a-48ab-a12f-3097deaf4f69	17a3c288-248a-44a3-a8e7-20a6b19cd7d5	t
a69db417-264a-48ab-a12f-3097deaf4f69	deeaabe4-aa70-45a7-9f63-79a58b389c4f	t
a69db417-264a-48ab-a12f-3097deaf4f69	2ba3423f-56e6-41c6-9d55-65f855e5c889	f
a69db417-264a-48ab-a12f-3097deaf4f69	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	f
a69db417-264a-48ab-a12f-3097deaf4f69	1993ad97-561a-4d7d-9b86-b8c6f6011fcf	f
a69db417-264a-48ab-a12f-3097deaf4f69	ddb7156d-5c15-4b02-b630-552211d657f8	f
1ac20814-714f-41f2-914d-f3b6664fc004	fe6cec2e-d87a-4536-ad48-9569a18402d6	t
1ac20814-714f-41f2-914d-f3b6664fc004	a1b76567-6467-4fcd-954d-c9ad780dfe04	t
1ac20814-714f-41f2-914d-f3b6664fc004	ab40a375-1207-42ea-a45b-f8294596b54f	t
1ac20814-714f-41f2-914d-f3b6664fc004	17a3c288-248a-44a3-a8e7-20a6b19cd7d5	t
1ac20814-714f-41f2-914d-f3b6664fc004	deeaabe4-aa70-45a7-9f63-79a58b389c4f	t
1ac20814-714f-41f2-914d-f3b6664fc004	2ba3423f-56e6-41c6-9d55-65f855e5c889	f
1ac20814-714f-41f2-914d-f3b6664fc004	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	f
1ac20814-714f-41f2-914d-f3b6664fc004	1993ad97-561a-4d7d-9b86-b8c6f6011fcf	f
1ac20814-714f-41f2-914d-f3b6664fc004	ddb7156d-5c15-4b02-b630-552211d657f8	f
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	fe6cec2e-d87a-4536-ad48-9569a18402d6	t
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	a1b76567-6467-4fcd-954d-c9ad780dfe04	t
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	ab40a375-1207-42ea-a45b-f8294596b54f	t
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	17a3c288-248a-44a3-a8e7-20a6b19cd7d5	t
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	deeaabe4-aa70-45a7-9f63-79a58b389c4f	t
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	2ba3423f-56e6-41c6-9d55-65f855e5c889	f
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	f
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	1993ad97-561a-4d7d-9b86-b8c6f6011fcf	f
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	ddb7156d-5c15-4b02-b630-552211d657f8	f
0c65f92d-f46d-44b5-851f-5817ba5e1da0	08427143-05fb-434a-9a34-0e858a1aad59	t
0c65f92d-f46d-44b5-851f-5817ba5e1da0	57edfbbe-8594-4089-a68d-4cd0183d7a50	t
0c65f92d-f46d-44b5-851f-5817ba5e1da0	e9d2e99f-55ff-4362-b711-61e6aae34d6d	t
0c65f92d-f46d-44b5-851f-5817ba5e1da0	14d2fba0-8cda-43b3-ac33-f479e3e25a72	t
0c65f92d-f46d-44b5-851f-5817ba5e1da0	ef848091-0de9-4bfe-9b3b-04e74b7d9731	t
0c65f92d-f46d-44b5-851f-5817ba5e1da0	ce00cc5f-ef91-4a53-91c2-648049c4304f	f
0c65f92d-f46d-44b5-851f-5817ba5e1da0	b4842e84-1538-49e8-9b98-224708a31f2a	f
0c65f92d-f46d-44b5-851f-5817ba5e1da0	26281455-10da-4c98-9d72-c6901c3141f2	f
0c65f92d-f46d-44b5-851f-5817ba5e1da0	072e19ef-af57-4a85-97ad-3c308587730a	f
0e7139bb-6d77-442d-b045-0ce8e85dc81c	08427143-05fb-434a-9a34-0e858a1aad59	t
0e7139bb-6d77-442d-b045-0ce8e85dc81c	57edfbbe-8594-4089-a68d-4cd0183d7a50	t
0e7139bb-6d77-442d-b045-0ce8e85dc81c	e9d2e99f-55ff-4362-b711-61e6aae34d6d	t
0e7139bb-6d77-442d-b045-0ce8e85dc81c	14d2fba0-8cda-43b3-ac33-f479e3e25a72	t
0e7139bb-6d77-442d-b045-0ce8e85dc81c	ef848091-0de9-4bfe-9b3b-04e74b7d9731	t
0e7139bb-6d77-442d-b045-0ce8e85dc81c	ce00cc5f-ef91-4a53-91c2-648049c4304f	f
0e7139bb-6d77-442d-b045-0ce8e85dc81c	b4842e84-1538-49e8-9b98-224708a31f2a	f
0e7139bb-6d77-442d-b045-0ce8e85dc81c	26281455-10da-4c98-9d72-c6901c3141f2	f
0e7139bb-6d77-442d-b045-0ce8e85dc81c	072e19ef-af57-4a85-97ad-3c308587730a	f
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	08427143-05fb-434a-9a34-0e858a1aad59	t
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	57edfbbe-8594-4089-a68d-4cd0183d7a50	t
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	e9d2e99f-55ff-4362-b711-61e6aae34d6d	t
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	14d2fba0-8cda-43b3-ac33-f479e3e25a72	t
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	ef848091-0de9-4bfe-9b3b-04e74b7d9731	t
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	ce00cc5f-ef91-4a53-91c2-648049c4304f	f
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	b4842e84-1538-49e8-9b98-224708a31f2a	f
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	26281455-10da-4c98-9d72-c6901c3141f2	f
9d3f6a43-9492-4eb1-bc3d-8bb21410e360	072e19ef-af57-4a85-97ad-3c308587730a	f
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	08427143-05fb-434a-9a34-0e858a1aad59	t
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	57edfbbe-8594-4089-a68d-4cd0183d7a50	t
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	e9d2e99f-55ff-4362-b711-61e6aae34d6d	t
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	14d2fba0-8cda-43b3-ac33-f479e3e25a72	t
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	ef848091-0de9-4bfe-9b3b-04e74b7d9731	t
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	ce00cc5f-ef91-4a53-91c2-648049c4304f	f
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	b4842e84-1538-49e8-9b98-224708a31f2a	f
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	26281455-10da-4c98-9d72-c6901c3141f2	f
63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	072e19ef-af57-4a85-97ad-3c308587730a	f
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	08427143-05fb-434a-9a34-0e858a1aad59	t
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	57edfbbe-8594-4089-a68d-4cd0183d7a50	t
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	e9d2e99f-55ff-4362-b711-61e6aae34d6d	t
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	14d2fba0-8cda-43b3-ac33-f479e3e25a72	t
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	ef848091-0de9-4bfe-9b3b-04e74b7d9731	t
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	ce00cc5f-ef91-4a53-91c2-648049c4304f	f
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	b4842e84-1538-49e8-9b98-224708a31f2a	f
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	26281455-10da-4c98-9d72-c6901c3141f2	f
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	072e19ef-af57-4a85-97ad-3c308587730a	f
96042979-1680-49fa-b1be-5749a1590c81	08427143-05fb-434a-9a34-0e858a1aad59	t
96042979-1680-49fa-b1be-5749a1590c81	57edfbbe-8594-4089-a68d-4cd0183d7a50	t
96042979-1680-49fa-b1be-5749a1590c81	e9d2e99f-55ff-4362-b711-61e6aae34d6d	t
96042979-1680-49fa-b1be-5749a1590c81	14d2fba0-8cda-43b3-ac33-f479e3e25a72	t
96042979-1680-49fa-b1be-5749a1590c81	ef848091-0de9-4bfe-9b3b-04e74b7d9731	t
96042979-1680-49fa-b1be-5749a1590c81	ce00cc5f-ef91-4a53-91c2-648049c4304f	f
96042979-1680-49fa-b1be-5749a1590c81	b4842e84-1538-49e8-9b98-224708a31f2a	f
96042979-1680-49fa-b1be-5749a1590c81	26281455-10da-4c98-9d72-c6901c3141f2	f
96042979-1680-49fa-b1be-5749a1590c81	072e19ef-af57-4a85-97ad-3c308587730a	f
db962978-abd2-4625-8288-472315f9d100	08427143-05fb-434a-9a34-0e858a1aad59	t
db962978-abd2-4625-8288-472315f9d100	57edfbbe-8594-4089-a68d-4cd0183d7a50	t
db962978-abd2-4625-8288-472315f9d100	e9d2e99f-55ff-4362-b711-61e6aae34d6d	t
db962978-abd2-4625-8288-472315f9d100	14d2fba0-8cda-43b3-ac33-f479e3e25a72	t
db962978-abd2-4625-8288-472315f9d100	ef848091-0de9-4bfe-9b3b-04e74b7d9731	t
db962978-abd2-4625-8288-472315f9d100	ce00cc5f-ef91-4a53-91c2-648049c4304f	f
db962978-abd2-4625-8288-472315f9d100	b4842e84-1538-49e8-9b98-224708a31f2a	f
db962978-abd2-4625-8288-472315f9d100	26281455-10da-4c98-9d72-c6901c3141f2	f
db962978-abd2-4625-8288-472315f9d100	072e19ef-af57-4a85-97ad-3c308587730a	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
2ba3423f-56e6-41c6-9d55-65f855e5c889	be859075-284a-43c1-92d7-88245e75a09a
26281455-10da-4c98-9d72-c6901c3141f2	5cc6507d-ed6b-4f2a-bc4e-bfe0d1b75e86
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
c8d83ada-9121-4bfb-b8f7-ce7cba5480d4	Trusted Hosts	c8810218-c378-437b-a906-f64e9cee8ae4	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	anonymous
a865d025-c9f4-422c-9824-8e43aed01088	Consent Required	c8810218-c378-437b-a906-f64e9cee8ae4	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	anonymous
0b3e348a-55ed-4810-8fd4-b34dd54f561c	Full Scope Disabled	c8810218-c378-437b-a906-f64e9cee8ae4	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	anonymous
32588d69-cfe4-4a3c-9ab6-8e4d022767b6	Max Clients Limit	c8810218-c378-437b-a906-f64e9cee8ae4	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	anonymous
409bc3cf-b4dd-4b0d-acba-fd68de211b73	Allowed Protocol Mapper Types	c8810218-c378-437b-a906-f64e9cee8ae4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	anonymous
afb41fc2-421d-4e3e-9762-62f06a4c602c	Allowed Client Scopes	c8810218-c378-437b-a906-f64e9cee8ae4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	anonymous
d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	Allowed Protocol Mapper Types	c8810218-c378-437b-a906-f64e9cee8ae4	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	authenticated
d6154511-2987-47c3-872b-8a3ac0b8a382	Allowed Client Scopes	c8810218-c378-437b-a906-f64e9cee8ae4	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	authenticated
afeb9fcc-7741-4b3f-b689-cb009c657879	rsa-generated	c8810218-c378-437b-a906-f64e9cee8ae4	rsa-generated	org.keycloak.keys.KeyProvider	c8810218-c378-437b-a906-f64e9cee8ae4	\N
e2d46afe-3bf7-4a0a-b33c-331b0825f65c	rsa-enc-generated	c8810218-c378-437b-a906-f64e9cee8ae4	rsa-enc-generated	org.keycloak.keys.KeyProvider	c8810218-c378-437b-a906-f64e9cee8ae4	\N
7651a134-79fd-4575-983d-70d0dce615d3	hmac-generated-hs512	c8810218-c378-437b-a906-f64e9cee8ae4	hmac-generated	org.keycloak.keys.KeyProvider	c8810218-c378-437b-a906-f64e9cee8ae4	\N
ada60cf6-6d0c-4b27-9bea-67e7f24c690c	aes-generated	c8810218-c378-437b-a906-f64e9cee8ae4	aes-generated	org.keycloak.keys.KeyProvider	c8810218-c378-437b-a906-f64e9cee8ae4	\N
abd15547-778d-4fb1-a2cc-f584ff9312c7	\N	c8810218-c378-437b-a906-f64e9cee8ae4	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	c8810218-c378-437b-a906-f64e9cee8ae4	\N
afc333ec-59c4-4fcf-be45-3b1061d08c69	Allowed Protocol Mapper Types	16d92262-12b3-4f31-aa27-dc97588c55e9	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	anonymous
2d76b817-ed81-45d3-951e-8f68d108067d	Allowed Client Scopes	16d92262-12b3-4f31-aa27-dc97588c55e9	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	authenticated
90d634fa-4527-4e5e-be29-2fd0b9d9db5b	Full Scope Disabled	16d92262-12b3-4f31-aa27-dc97588c55e9	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	anonymous
26ef7810-091a-4243-8669-9785740242ca	Max Clients Limit	16d92262-12b3-4f31-aa27-dc97588c55e9	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	anonymous
c9893727-7ed0-44e2-8c4d-7a58b5311233	Trusted Hosts	16d92262-12b3-4f31-aa27-dc97588c55e9	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	anonymous
0b7f65ee-9572-40b5-b0c7-7bccfe0953e7	Consent Required	16d92262-12b3-4f31-aa27-dc97588c55e9	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	anonymous
bda2b612-6e1f-430d-be7e-0a7cb12a5907	Allowed Client Scopes	16d92262-12b3-4f31-aa27-dc97588c55e9	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	anonymous
7b436267-1a77-47bd-b581-4f66ed3d1752	Allowed Protocol Mapper Types	16d92262-12b3-4f31-aa27-dc97588c55e9	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	authenticated
eca7ad21-77db-49c0-b13c-9565e86f01e1	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	16d92262-12b3-4f31-aa27-dc97588c55e9	\N
73ced29d-e770-478b-b7f8-54d265e5259a	hmac-generated-hs512	16d92262-12b3-4f31-aa27-dc97588c55e9	hmac-generated	org.keycloak.keys.KeyProvider	16d92262-12b3-4f31-aa27-dc97588c55e9	\N
5e3fa11d-6eec-41dc-b4de-0706e56c30cb	rsa-enc-generated	16d92262-12b3-4f31-aa27-dc97588c55e9	rsa-enc-generated	org.keycloak.keys.KeyProvider	16d92262-12b3-4f31-aa27-dc97588c55e9	\N
13c48e2e-1c45-4c95-bb86-f8ddf9311f27	rsa-generated	16d92262-12b3-4f31-aa27-dc97588c55e9	rsa-generated	org.keycloak.keys.KeyProvider	16d92262-12b3-4f31-aa27-dc97588c55e9	\N
87fdf7f1-5a27-4a57-af0c-7aff6666b68f	aes-generated	16d92262-12b3-4f31-aa27-dc97588c55e9	aes-generated	org.keycloak.keys.KeyProvider	16d92262-12b3-4f31-aa27-dc97588c55e9	\N
f11f2bb0-e96b-4652-9d4a-a25225ed6db5	hmac-generated	16d92262-12b3-4f31-aa27-dc97588c55e9	hmac-generated	org.keycloak.keys.KeyProvider	16d92262-12b3-4f31-aa27-dc97588c55e9	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
24be0838-4de1-4f8c-8ab7-e9ec9045b7e7	c8d83ada-9121-4bfb-b8f7-ce7cba5480d4	host-sending-registration-request-must-match	true
ffaa8d21-d0ad-49ca-8f05-a7acd9cdb6aa	c8d83ada-9121-4bfb-b8f7-ce7cba5480d4	client-uris-must-match	true
b35df8fc-5a2f-4314-8cab-4ccf9e83e435	afb41fc2-421d-4e3e-9762-62f06a4c602c	allow-default-scopes	true
7c9c7add-50f6-4bd6-a8d9-3c5dd06f5a43	d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	allowed-protocol-mapper-types	saml-user-attribute-mapper
b9b7f98c-7345-425a-b944-33a9c06458ef	d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	allowed-protocol-mapper-types	saml-user-property-mapper
285a9ceb-ab35-4e42-ac48-bcab2e8d5f3c	d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
30509879-9423-4021-ad36-2d1edcdf6a37	d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	allowed-protocol-mapper-types	saml-role-list-mapper
465aebb0-2b4b-4739-a53f-8ff2155db957	d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	allowed-protocol-mapper-types	oidc-address-mapper
8532a2be-3784-458a-9fae-f14c5ae3c3a6	d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c4dc391b-d383-476d-9da2-b1e92eb52cc5	d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
49dcef55-f156-4aec-bf6a-784fbec60d33	d1f0bb31-22f7-4a96-bd0c-6b63e4e750e0	allowed-protocol-mapper-types	oidc-full-name-mapper
39becab5-1ec0-4bde-ab9a-ff673d06d210	d6154511-2987-47c3-872b-8a3ac0b8a382	allow-default-scopes	true
b005044d-6224-4961-9b7b-ff81232d4f7e	409bc3cf-b4dd-4b0d-acba-fd68de211b73	allowed-protocol-mapper-types	saml-user-property-mapper
ad0455fb-550b-4d76-a533-3cb077f0368b	409bc3cf-b4dd-4b0d-acba-fd68de211b73	allowed-protocol-mapper-types	saml-role-list-mapper
2e963066-7c10-4b21-be25-48c0875ce077	409bc3cf-b4dd-4b0d-acba-fd68de211b73	allowed-protocol-mapper-types	oidc-full-name-mapper
2c1d93fb-58fe-42f2-8d1e-e63a297c0df4	409bc3cf-b4dd-4b0d-acba-fd68de211b73	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
01fd505e-8c73-41ca-a954-fa0dd26ad58f	409bc3cf-b4dd-4b0d-acba-fd68de211b73	allowed-protocol-mapper-types	saml-user-attribute-mapper
9b44966d-54a4-49d8-ac7c-f6cbfd5c8e36	409bc3cf-b4dd-4b0d-acba-fd68de211b73	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6eac1d27-a3b1-43f0-b434-2e02a7f9d8eb	409bc3cf-b4dd-4b0d-acba-fd68de211b73	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
dcb23cbe-ff59-4aaf-88c9-39c554a28021	409bc3cf-b4dd-4b0d-acba-fd68de211b73	allowed-protocol-mapper-types	oidc-address-mapper
8595f4bf-8481-49d8-bcad-5df324a35dc7	32588d69-cfe4-4a3c-9ab6-8e4d022767b6	max-clients	200
c158700f-1939-42d1-acf3-a8bf13ebc774	afeb9fcc-7741-4b3f-b689-cb009c657879	certificate	MIICmzCCAYMCBgGP5tZ9KTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNjA1MDUxNzQ3WhcNMzQwNjA1MDUxOTI3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC1vz7R19C8pZ1EAg6vnTEL5J3naMkURxzw/pAa68DCcAB15dp0dOaeeZZUa4bwa5k4Ul6auzIyhJBBg7BX7VBUmnubpoP4qrMkeo/Q23ARXdCfn1JcCUY+z2utsO/6GzsMTEWlm/1w+o+/ZxClQaU67WflIGHbVHZwGtjsN8kmTFWb9F4LFynqMGA3mWGY/wjk1AesvKqjhZVU6S8jOeMbVY+mrjhThMLAae9NQqFJ2JSCa2ogNEmgTbQJUR2H8TVG5esJZwyKum95j7NG3zDs4X9/OnCwjan6u7GvSJJzA4zRDqW5Xe8nhh50SaylUsBF9iWy8ABr5CSmUM8xcnXDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAKOzJwlmwmIcVTOYE6xS3njTriWpf8h8i95MsGN21vhESRCTKlbVudRNEdUZYFhoqcJU/dT3FobZxnepQTjfH9nPg6YLYtcj1uXAyJGFSdb1J27RIJ/TO7IIRKnVUznVsz7g4e4WMMIT/4VoXxhitOxVV5Zs7jBjq3flxrPKZ2z3HLk+CxRs+aVZkZwYnqgGBcsZd9y7qv5avM+UXbS8POZEiNZFD536Lr8727T2Yl6h0h4BjfSHJ3S1WKlRg6PTEjqN3lFc2934kADWA8Y31R82qUPFVx0iYtiawJ6yphe2TdKUxu0/+AfVEwlsQEZw6rQMxgYxtzS/1CdjECtNXak=
a2656783-c888-4d49-b783-95eb6597bdad	afeb9fcc-7741-4b3f-b689-cb009c657879	privateKey	MIIEowIBAAKCAQEAtb8+0dfQvKWdRAIOr50xC+Sd52jJFEcc8P6QGuvAwnAAdeXadHTmnnmWVGuG8GuZOFJemrsyMoSQQYOwV+1QVJp7m6aD+KqzJHqP0NtwEV3Qn59SXAlGPs9rrbDv+hs7DExFpZv9cPqPv2cQpUGlOu1n5SBh21R2cBrY7DfJJkxVm/ReCxcp6jBgN5lhmP8I5NQHrLyqo4WVVOkvIznjG1WPpq44U4TCwGnvTUKhSdiUgmtqIDRJoE20CVEdh/E1RuXrCWcMirpveY+zRt8w7OF/fzpwsI2p+ruxr0iScwOM0Q6luV3vJ4YedEmspVLARfYlsvAAa+QkplDPMXJ1wwIDAQABAoIBAAm/ygNgo8pSyfZZc+c4s+ZS66N7q/mh/Ovyg9Fl3w+vCV9JpqfDk5FhrU42/GSOKQhr5rY/H2i1UrWo9j8pNDttk/7b9k1S/swQpQFLnB3aXfQKDFVyi+mXn8uP57ePWWIF/2BsVzKFxks6oJp0xIO+M2oHjChDRh0qW4OEVI5wx4dN/TgZ59PkF5xr96jACVlasOxMRbysUH/dOPVUT5q0cGlrhqSzEE0dd2whQjBWvT5A/nuK/aWCIgkrwwaDrj/xtg5EkdT8vHTbCno8iCeLMgQ0H99YkEKZmuqB2To8ysA87rZfaybPWAj/JX82lKm7m1t+u82xYcuJKyr7p6UCgYEA8U+wLn+PHFNb9MAW2JlL9bCmn7/iFizdNvoCxFAK+uTys1y+axBAEGW8Kg1RN3H36WbyveTWiiyDSGPvxi5dt37ZlecVkMBJfW5RgBv78Ak/WghmuIeeOUIQWkXhEuVrZksCBbmZwjNGJJ0I8FAhl8Lyozld7H6MFIF8rzQKxVcCgYEAwM9gzWm71WL8zG0XQ827AVWZV4qa3AzF68uuwlCYwZ3TCCMOIHrjVffzh5muUptCiHIASJMUjLJSs1oZRWp96tIi+s1KmEJoZKgP01DTkZGTZVXBnjObsG1iApqvNY+0Z9dgVesmC14FldVrTLWZvMBPDeHObJddtR/X0u9Tw3UCgYB9K/Pcusg2Tjs14uo24pXXVRGpbfRNwmnhWaBTyp1Xdak7RtFzYdOJbexD9/J4C0MorAEgZXKv69URmN1IdMaiJ0egjWTPWB8G1FGsXVe7NGDLR+5Yq+h0FQO8f+D3V0/1mNTsuVC7vrMUzOxVE4vJWBNafahtw1rQTDar/xfTMwKBgBxd5lYSWko4uAyzeBrHp924ZEkW4VXCo1PfsaRxCyhhOe0WizuIGO5K/o9Ssu0AXreIXjZPPVS936D3foRR+JiVtgPENFdWXdmBSGLEn3vpORBNn6DQ4vUAAs1zSJfOvrIQY+IAKKa/fH7g2Vp91VKJ0JewQxiC5IyDVNN51o8JAoGBAJT0eSGgILZrdTDYaVxP3DkyArlc+G9RfPGmaNMq4aAG43VzLvZy12eclK7vdD5HdRU0x6HhhsYAwKsFioffmIuLWm5/KfWXN27J/nnGFw7OM2VoUzVnptTehZt9Dc8ERJNLYdNLhyfAVCiqQKw5r0oGzLWSup3Dau0vGE1JeeZ3
81c4148b-e626-4ff6-b9b8-d1d2b89c09ae	afeb9fcc-7741-4b3f-b689-cb009c657879	keyUse	SIG
b5d50eb0-8d92-4d5e-9413-50685a0a5132	afeb9fcc-7741-4b3f-b689-cb009c657879	priority	100
220d518d-23f1-465a-a1fd-6bdee07aba8c	e2d46afe-3bf7-4a0a-b33c-331b0825f65c	privateKey	MIIEpAIBAAKCAQEAmKtlWx6jtbdLEgbsrqkZKCG19weyqcxLKK4vDaxqtRZRlxi5fZ1YrlP8eIOfvqF3ihtxnemefx2mq7A4BOapnKWugIeHt2Du99NqGOo87UBbU1X+DkfamIR1RMS0pNJBmZ2lqsPxSLhS2spj0if8sQexPHTEjTe8hoebXZaWgRtRcARDZSWutZeuGtoOAN8O92Ar1I9sslAxq1jpxOdBZWjONH7n6jLdaVrII98xaQOmstrfhUck4o5QP9q8JnISBhp/64/L8WYlfnqQPlYZOf/d9ThKFgRBLXAw8gdB8c9PsYL1caKmxvVIp3najA16UnC2n8uuAAN0bCrHMNKHZwIDAQABAoIBAAHjSjbgW21FUjtxqxh89dEU9scANT+7v0v9E/yXLgFhNFhFhU6hCNSsjbhei+yl5tUEiGIpWEY7ai4iOout6/HRlmJ3fmIES5QAhYXMEEnPDP4+afQlTSzci5ivdPeKOibR+X8QQLJmY8UKmvBMCAy7spgbYjRypk2nqj9JO+vsVipCYcBtmbobfBm2aVuDHk/hQyLcg2JCzwERoATDtfsTsWI5H83a7EXHRRnypbYydav28v+DMtoDqv6uuuGs866NcW1X5DoOppF4cLlHLZ3hgO40YNrd5/OSffYBRupBrrPomg6lPTImJGEWL7qsNP7yGuulODXdgUnILjXBUrUCgYEAyy/NFCbkTnPZzVLo1QCERB3iEahOMRWjn4yU8IvPH38CBuatcxloyem2WHtSDifHIm8iearNmZNm8KRVGC3Y386AmiASrP6yEsMyvvhjMXMEJ3LK84+U0tFtbZ6RKoJW7JG+kRcVecICwFiKsILqWG2DzgKmuESXJwPgp65gr8UCgYEAwFokNmkodE2LFtlVyCtiOeqDIPxT1o95RmXHGOhAVrDbC+yQ9AN4ixcXZBbzusBb0uZ6o0a9qWbsFpfyNEfVovtHcPuENNA8F6/5MmiZm+g0P9lXte/rt3M1hVJsZFB3kLBjCl/X1Dqf+mK/OM6HiFw9hpu7NE/gbUB5erHVQTsCgYEAomoJQcx8voE4Xjmhx3FsSI6igH7KUc38RrK28ziuTXzWf/GwP8rVymA4061vv8ToFoxDQIHZaqM6q6yQII21R+DnR0vP4dyNNxY04BXoJETN00KdG+dvjLy+/dq8KwCYvu0ZKR0Mm5ELZfjgk4tyC1EvBGN2JOEe+Z7N2vs2agkCgYEAs/Lgk+KXDQ8KQ0r5nHUxxJrnJ/HHgR/iRgCrXVrR7ggwNJyREyc4G29z25g5VgnlHY2vR5bDknqN/akS1uQpMftAX6t9iGcTANoJGKaQpjF6yAzNqJCWhZ4LgPmWG9bHtJ2/WhJF+O8LgRPmbv+P/frFOGvym8LqY2sA+s7pgccCgYBYoLzUHX3RBZPvVgJbeSwp2GqBFwaU9wiwx7tB3rXWqMlnShx2X0wu7jCH7+au4EtZGNOJFUxLMuwlu6sxCI0vIXHC1b3sBdcdFKdWJu+JUqFur1BYEOvudtzYs4jKQ3NcotpgyEt6dMc5OQB77PG/5vlHZJLq71HjWwFVFq3E+g==
7feb20be-55c1-49b0-9fec-7fc0a59cfceb	e2d46afe-3bf7-4a0a-b33c-331b0825f65c	keyUse	ENC
8658fce0-2be8-40cb-ae1b-3c7ad2c5e868	e2d46afe-3bf7-4a0a-b33c-331b0825f65c	algorithm	RSA-OAEP
5d051267-ab5e-4fea-8e91-a9053d29e592	e2d46afe-3bf7-4a0a-b33c-331b0825f65c	priority	100
2714a25a-60fd-4fb1-8a6e-aaf146375659	e2d46afe-3bf7-4a0a-b33c-331b0825f65c	certificate	MIICmzCCAYMCBgGP5tZ+SDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwNjA1MDUxNzQ3WhcNMzQwNjA1MDUxOTI3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCYq2VbHqO1t0sSBuyuqRkoIbX3B7KpzEsori8NrGq1FlGXGLl9nViuU/x4g5++oXeKG3Gd6Z5/HaarsDgE5qmcpa6Ah4e3YO7302oY6jztQFtTVf4OR9qYhHVExLSk0kGZnaWqw/FIuFLaymPSJ/yxB7E8dMSNN7yGh5tdlpaBG1FwBENlJa61l64a2g4A3w73YCvUj2yyUDGrWOnE50FlaM40fufqMt1pWsgj3zFpA6ay2t+FRyTijlA/2rwmchIGGn/rj8vxZiV+epA+Vhk5/931OEoWBEEtcDDyB0Hxz0+xgvVxoqbG9UinedqMDXpScLafy64AA3RsKscw0odnAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAB6Z9OAv5D7JFoQZiIiMPwISLXg3T1g2ZTJ5x1VV5zz2LVw3tRpGMouTCntKtRZARYmkwKnDPJwPAmc6ZAGQ/QHlaCse+2oh0GP4Zv1gbpQPG2xODRaZui9M8uVFrCFNMgFxpksZehj9wkLaPPKk7MpIfO1nogAJAbBjigJmUJQipeaxm9IzQYudUlu/7hSdoIBHh2rWd2j5vgVNAqkpQbXBjZg+D0xFTiMnRx0iGAtBtK3+38wlZkxofrFouuyzhgkCFl4Vzeahi/lBRoJF6gu9NI8i0FnV2Qe3K7OwSgWLeJ3F0eTk1d8CmyF7u2UDACMRK/CQoMBDHv5j6QfPKY=
4677370d-ea0a-4210-a781-06632fc982c0	ada60cf6-6d0c-4b27-9bea-67e7f24c690c	kid	90190a6d-010e-4c6b-9abe-fc2e2306ad62
86da55e9-a283-4b47-80e2-fe38d5dac4c4	ada60cf6-6d0c-4b27-9bea-67e7f24c690c	secret	ZAdNNw_xvuT_hvaGdAScEA
76cb57b3-689b-433d-bbd3-86e7a53f87f3	ada60cf6-6d0c-4b27-9bea-67e7f24c690c	priority	100
fd25e244-c38d-49ed-8aa2-2a1ed8f97ca4	7651a134-79fd-4575-983d-70d0dce615d3	priority	100
b3b03886-9fad-4a27-9cac-256e376b377b	7651a134-79fd-4575-983d-70d0dce615d3	secret	Qn-t90s8XDJEGML-y4ars_5gpvo06VsPw-xBuArIKv7QAAN9x3KUIzOCuKC_f9uG3aHB-nAXaS6oLODdxvKdRncfbemV6UYRFBFJFM7EzA7hOWHaMvTFJSfcvN42n4tcQvuSwtHtgET_5X3fsEh2tPy56G6oORjkLNAoJsioebg
4feae5e5-8e50-4917-bb01-7246ec9cdf22	7651a134-79fd-4575-983d-70d0dce615d3	kid	084bc2ed-6592-41b8-ac81-468e3cea3f1e
33aed9d8-ce0e-460b-8421-1c3bd80120a1	7651a134-79fd-4575-983d-70d0dce615d3	algorithm	HS512
84d36c5a-c278-4283-9b20-09f670eb4a0b	abd15547-778d-4fb1-a2cc-f584ff9312c7	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
813db33a-189f-4dd5-b841-ea72437c314c	afc333ec-59c4-4fcf-be45-3b1061d08c69	allowed-protocol-mapper-types	oidc-full-name-mapper
0f689ab5-4a07-49ec-9ad5-13341ea8c7be	afc333ec-59c4-4fcf-be45-3b1061d08c69	allowed-protocol-mapper-types	oidc-address-mapper
233a0e70-2211-4b02-9c61-20dd9e262ddc	afc333ec-59c4-4fcf-be45-3b1061d08c69	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
88112e19-bfc8-4410-a823-0c18c654920e	afc333ec-59c4-4fcf-be45-3b1061d08c69	allowed-protocol-mapper-types	saml-user-property-mapper
61f4eb2a-0151-45b9-9261-4ff6838683b3	afc333ec-59c4-4fcf-be45-3b1061d08c69	allowed-protocol-mapper-types	saml-role-list-mapper
aea4ffe5-ba06-41d9-8e7e-5b7e610e908c	afc333ec-59c4-4fcf-be45-3b1061d08c69	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
82d2ff95-74ab-4fd5-9e69-d839fd7dd4fd	afc333ec-59c4-4fcf-be45-3b1061d08c69	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
797d5f17-c4e3-4add-9bac-68ba579070c8	afc333ec-59c4-4fcf-be45-3b1061d08c69	allowed-protocol-mapper-types	saml-user-attribute-mapper
71e33531-c101-402c-9d26-cee8242f5fbb	73ced29d-e770-478b-b7f8-54d265e5259a	algorithm	HS512
88a28d4f-71fa-4d96-9cc1-01aa5704149e	73ced29d-e770-478b-b7f8-54d265e5259a	priority	100
5914c373-fc80-4c89-9931-b01310f2dd1a	73ced29d-e770-478b-b7f8-54d265e5259a	kid	ac15bb29-0a5f-49ca-8438-127200d7c501
8ed8d0dc-272e-4ba2-a14a-06cd0b03012c	73ced29d-e770-478b-b7f8-54d265e5259a	secret	twqVOeD37O_hnZICOZ_u1Bg_wgw6b3N_yEO-3NLR2p-oo5q2t9f7fTUezv4ComRRwY2Uw847RuuHp9JLKELl3KjUunG3jAnN51JtSiE4BMMSDSOK-24LFdw7yV3lgmCoCJ4etUbha3gxTTcZFb7lngMuJ69tZqzI4ZW9l3Zn_q4
0a4ecde1-7e07-4189-a1c1-bbe34c7966ef	2d76b817-ed81-45d3-951e-8f68d108067d	allow-default-scopes	true
3c045d6f-9e6f-4185-bcef-5d5d37ef94dc	5e3fa11d-6eec-41dc-b4de-0706e56c30cb	certificate	MIICnzCCAYcCBgGOGZSy6jANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhjbGlwc2luZzAeFw0yNDAzMDcxNTQwNTlaFw0zNDAzMDcxNTQyMzlaMBMxETAPBgNVBAMMCGNsaXBzaW5nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArd5QKPT90KXBKgOP5biYsyvPQ2n04Vfip0DtUVG5m0Rg2sT6GC3HL93CFaDvaSoDD5512SNwrgjVN/bnWiZrUmd9JdZUH+JtK8JALkYHWfFBDg4S3MAAD1v9YufESjWqstg6jwIftsC+cCltApUhReXTdQkvq6BHVWrPbv8FstjHCYKeZxgPesd4lUw9w97UAs48bt/qn/6N4YYlPwyTJcwalnDMoqSpQG+WAOjSfecRk5FPYuk2GaebciFAIaK/Fgx0Vek+U2Y7CUmMTIIEkNwzR6lc+mDPE++qVjklsIZLCG80Kw5Y3GABAuHzQ4yo+t+XX/y1CqD9LuklCjVJVQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBo9D38Y0sxNpxySs0Y1vDlZjJkpLy1VWfI4lrA8fvVdtva0p8I6k3K6q2yXLlS1vG8mQkFWplGRFeaDG0xr21OhjHqhxtoXXVyP/XGpvBQGpyeCpdj1iDmvaYDbwelXYLU9vi0NV9Fn9U8RcRhSg1F8VN+SeKXA+1HnSn0PRg175tCJrzu8+Ubd6fIXCcmJN7lopLLZZrz+YqkJVizLow+ZmGKHATDZ2UFA3TJuzTV+iTheZIjqTIoFKmkwkJ4+JyETgCozwmPTDAQNjaRXUO4b54gif7mMbbXa+KgxAq0ElzSZwXdrULulPx64QXzyYY5g+IPbpSDSV53k/XCJ2+R
2c6c36a4-3b4b-40db-a564-f7a07d341f60	5e3fa11d-6eec-41dc-b4de-0706e56c30cb	privateKey	MIIEogIBAAKCAQEArd5QKPT90KXBKgOP5biYsyvPQ2n04Vfip0DtUVG5m0Rg2sT6GC3HL93CFaDvaSoDD5512SNwrgjVN/bnWiZrUmd9JdZUH+JtK8JALkYHWfFBDg4S3MAAD1v9YufESjWqstg6jwIftsC+cCltApUhReXTdQkvq6BHVWrPbv8FstjHCYKeZxgPesd4lUw9w97UAs48bt/qn/6N4YYlPwyTJcwalnDMoqSpQG+WAOjSfecRk5FPYuk2GaebciFAIaK/Fgx0Vek+U2Y7CUmMTIIEkNwzR6lc+mDPE++qVjklsIZLCG80Kw5Y3GABAuHzQ4yo+t+XX/y1CqD9LuklCjVJVQIDAQABAoIBAAiDGEiRCfYTj1vntb1I5szqyahiwRbhLxsCHjw7dItJ8zXyq83QO+63fB+D9AShhmnW160sQ4F5tDqbr2Ll+54aq/FUx2SSOMcKKQs66XQ5T/aIsNq22anm1oZnk2AQtY0w8dj7gSL417n1BT25oFnkMRCLRRaxb5yacJJeEODbEFJyhh+2Kz0RRHcVkNFe7Dgq/6LEmE+sdkqUvfLaGttn0zuUIQZBQnSUIIuOPSLRzwVe3cY7/tIuyLNjetXX9vahPtIu8xnuPBTrUtYQMzcLo1cSXgNDcj5BHfOrZ7jufYohWaG5PYC8KY2Mme5GvBsYpP0uNCa/HXdcoj+ZvVECgYEA5npnPRaPEMseknIwlELiq8ngjDAwtQ4zbUEFfT9pJGapL1Rqn0cpJAXCzXvwlALG6A0x9MqG+c9tBdR0jMRYO7u5CaRUQ566UztoANKj/zAsTxXWQR+PI2fsuU4H9UrIiVqLloj7KoJQxfdgmSi7I6hE+YQY4W4IHb4bYcmgGB0CgYEAwR8i/oSnPQ/DleHWxd+iY2r6Y/I6ofCt97ttqhDJ36+QLX1bisxmXByCKqTm9GShO2xKcBcQzq/Un+USDbLW/tE7uUAueAW/z8aWhg86RhDzXH+Pws0E2qatRcixN7YH6/9IILgRFqgecnsTmucF1M4YjieX6/N3EMqY5PGsYJkCgYBHWgOWDOLTnx5i1gkmDSLhbgkfPVgG5VOUcjnB0Zy6UTH1Xhv4HW6mIUZymPkcyVNMybD6iKyKr+WflWtTnQF31KDvVDlmCcDDPbPv9UYiHYbKIQeId723h1fo8jhSfwlgRHDMdLHVMizRbMkyAUMWQeTAnl2ZhJfspUsS1fnDHQKBgC6sdsmqh7yzNaLgvQZ/oQCEF1XWciM3RuRLkRp8Cj4ccSz9UgV+lvKGFVN3HTZNp8Xzyx3CBVbemfW26CEVau6U5OlFwLVTNmNh7Hkj7wKGEDr3vWfoItcxV0k5UtNTFCEORoFZ2w9tvEYQxtE2KmufD8IzgX0OD2WogUE7w1xpAoGABi3trYOkPROtb+uRlx5+tV+BDH/E3yqQkrPgi074/AtMlgcpu7SfXMotbutXR/yJ9CuBqa1ve5giYXOwpH8182NWBV5fOh0d5xbttXJNUw37aUu6FgcK7LVh2q29PQeeisKbI3tzUQshdJjfj3jhiLt46vQraJFTtwwZIgJWuro=
4c281637-d01b-455b-80a9-5c70e357b8f0	5e3fa11d-6eec-41dc-b4de-0706e56c30cb	priority	100
5920b847-7a7e-4417-8203-3c0f772518fa	5e3fa11d-6eec-41dc-b4de-0706e56c30cb	keyUse	ENC
19f0d622-9ec2-4512-97fc-9269571d56f9	5e3fa11d-6eec-41dc-b4de-0706e56c30cb	algorithm	RSA-OAEP
213cae52-5b27-4ad2-8b01-85dff03f5693	26ef7810-091a-4243-8669-9785740242ca	max-clients	200
5b721990-5776-4684-957e-30cfdd1612d8	13c48e2e-1c45-4c95-bb86-f8ddf9311f27	certificate	MIICnzCCAYcCBgGOGZSxwTANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhjbGlwc2luZzAeFw0yNDAzMDcxNTQwNTlaFw0zNDAzMDcxNTQyMzlaMBMxETAPBgNVBAMMCGNsaXBzaW5nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtHXU0GAefueq8ekl6NdR0UDQAgeUbGBji/AdqyVFXQJddOeWAIIXrDIsw51Z2W7djE/ztD1nkuXVLxBwXjI8uN9/4Wk5EARUHgLJ2v0YmXY79wA6uOPjz/jOB55QW4K4dW0mKd1dykqi7JbzFZpkN4vfzX96sgkZZSSVJQIq8HBf5Cgk9uQJvL5m8v0dgvA36T00OHd+vEep9sbI1gsA2buQI2ITfPLSgSEJC2Bg0hO0W3xnTaj6xqKqLrdrrq4Bu7R8w5YZetz9gZ9wf87mNm28HdwuQ0/8uW0Nygvz6ldOKmh9RNKJhFJAbKdwzs15F4DVknb1+BqFy0DuUMdBeQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQA+pj2qW4kEV/iifR4c9P0Pi1VVNDDY5yiInEivxra/vhBvC1S1AvJ8GmrAFNt6sCNBmCmdzCp1uhOCDMlsk+zzDFn3C5y7XLZt60EkPCXxs9HUbBBiKzZj93QmbmzTDtGB+VbDbKUIXhNYfqUN9a+vtFIQ+7cq/euuACjWuiN5n9TkPIYh5JXqAHIRChOw6Rk5tFkPAH8nBKKj7HYcOjeQ/FbJ3B5xLKjfA0f6rlZ7hsp1UU6yHsgQdqgiNJYz1BpoIx8zh52pqUWFZ08xiSk+/CFL+lkblwAl2ZpEcPHYfqaL9TOD4EB7PuzLhJInPq6iObRG8E2Kr8xrcuwnF9IV
722f45fd-b17f-48bf-98cb-d73ea7354392	13c48e2e-1c45-4c95-bb86-f8ddf9311f27	privateKey	MIIEogIBAAKCAQEAtHXU0GAefueq8ekl6NdR0UDQAgeUbGBji/AdqyVFXQJddOeWAIIXrDIsw51Z2W7djE/ztD1nkuXVLxBwXjI8uN9/4Wk5EARUHgLJ2v0YmXY79wA6uOPjz/jOB55QW4K4dW0mKd1dykqi7JbzFZpkN4vfzX96sgkZZSSVJQIq8HBf5Cgk9uQJvL5m8v0dgvA36T00OHd+vEep9sbI1gsA2buQI2ITfPLSgSEJC2Bg0hO0W3xnTaj6xqKqLrdrrq4Bu7R8w5YZetz9gZ9wf87mNm28HdwuQ0/8uW0Nygvz6ldOKmh9RNKJhFJAbKdwzs15F4DVknb1+BqFy0DuUMdBeQIDAQABAoIBADtS+yWPW6cbcKJ7I1fCpSZ1uIvaQwxHuaHwy0gOhhl35BJA6Zp8Kd0VV4rtCPMGU7XDONn5T7nGbYk9zbrhp/2cl7UZ+sTNr3t4LjSb/IDCkh72h9dtL2CYqd5uSHt04z/TJHchyynr1FiTnRDuguCRzn6HWGX7wMnzt0YFyujkchBxXFjpYSG2/ITxeZOy697fkbyTpkHqwB6WD0foIVu+10Gu9/jw7FXKTZgwiAzsDzMHHkCyeKrlDM5DkpCD8U1XJYXnT6tdXrKXnOqQKkOPL6V/z4JF/ZNXleGobWP0kZnLGZ3dJH3dTALuACieQdpVoMWwmJ9wPNiNuL2VgZsCgYEA8Zs/5+PJaB70quz0wyJMOGher2lLg3qpn6zEzaetmTKMI8gjwyvM1ikHnpu5k8zmYW1pSv7Sxt7WdflH0WfDEzyeHg6BEPWbVfG46SWBBYOuTD+um0rzo1YmkaHXArb39uLq5j/vmHmRFjx7JDzThlDkw21+kUEcldyGeiZZ4QcCgYEAvzYJ8gi9adtus2RQP0WPiShE2TtbN0YAeTH8QWT+w7abMMWcoNhPzW+Wz9o0kRSBByetOkoWSTrgb/AP5eU9DY26InOBWKW078ok7c/8glyAB7dyqgPZ28+Rx+8ew12jd8kADz7W+McA8250VD0nrA6FpcX3XKPsIMuddpSFqX8CgYBqrZr8/7XpVGnBoti75EP1UBgmqX5fMmT9DOLkz1m2X/xCvFcWERvjn8AuhyHcocdDU3T/WR6mErRs6MGOM5uNveEu8kaIv3lz7EQyJY4fajImlqO5C9Ih16M2AFiYaUN5bl47hhV7pImsYM4ahQT8tHEd3RXaev5tKS7zdkWPNwKBgAoycI9WxfsqN5obhGgLZp8y5ZEMKE4nTokoEELQhwGa8GXGdBbj0kWraMiG43zFMihWhldwcgXPvP5bOA3TjtD1OPLzY/d9Rsvu5M9F4zp0gmNm9hd5AxpE1IpsByD2Emyl7HnjqQU1X6ibwFpptH7pe1ke2JU5LLOHCEu1mfczAoGAb9gSY+Ddnx1c8Ce2E2HWSTr3zYSa+gfOtJx/dw/cJbdXQV1OcCwLQbapzL6zbc22vPcWmJkXF86LTlSGHHgQKp86XPz42NG+QfWxLHcmC1nuo8o7J2NoLNPuR0veVeFwsHm0H85ddLqbCuw567vXt5f5gbUV69RJndxjU3WQUMY=
46f0c60f-aa4b-45ef-9515-f5a23a593ecc	13c48e2e-1c45-4c95-bb86-f8ddf9311f27	priority	100
e88d9ed3-ec31-4772-a0f8-64060f0afe5d	13c48e2e-1c45-4c95-bb86-f8ddf9311f27	keyUse	SIG
450c5ee3-e003-40f9-bc48-9cdd8f7b87f4	c9893727-7ed0-44e2-8c4d-7a58b5311233	client-uris-must-match	true
797bb656-d4a6-4392-9269-758b94d84a03	c9893727-7ed0-44e2-8c4d-7a58b5311233	host-sending-registration-request-must-match	true
1dfbd21f-e016-4ed5-9113-0d02e9c7d1c7	87fdf7f1-5a27-4a57-af0c-7aff6666b68f	secret	fDxzQGMioubCEM12-2KumQ
bbd05564-1170-4dfe-a57c-5ba1ce7c9cdc	87fdf7f1-5a27-4a57-af0c-7aff6666b68f	kid	1a5dd499-22be-4e8e-9539-8ec891f3ea3a
ab36e7c6-bc35-43b6-9819-a015849e3247	87fdf7f1-5a27-4a57-af0c-7aff6666b68f	priority	100
c5cb10a2-aac1-4083-a85b-f037868ec3b1	f11f2bb0-e96b-4652-9d4a-a25225ed6db5	secret	REMc6rou_Dy5CNeG3AS8j1MoOZk1NAhDVeSHznyk3mGxr8FvHGsriOZpOENhzSx2AWwxWtCwbQHNAPJznxpgj4z-YMXrdwqiO7k_AfiPZr4vCXq137U5GU2H8QX_FaZhwtksCGBq_txaCTZ5vjOxBm4f1r6b0nNJX1m3H9cDTQc
32d74588-bbe7-4f5d-8b36-67bf6f4bf1a8	f11f2bb0-e96b-4652-9d4a-a25225ed6db5	algorithm	HS256
0dc7149a-2e36-4c29-9ed8-78be15b82d3e	f11f2bb0-e96b-4652-9d4a-a25225ed6db5	kid	6ca35aaf-615b-4757-acec-79b168d3113d
98a4b6b0-0a6c-447b-a400-81199779637b	f11f2bb0-e96b-4652-9d4a-a25225ed6db5	priority	100
ae3c3ae9-a524-4ca9-96ed-00bca04e16c5	bda2b612-6e1f-430d-be7e-0a7cb12a5907	allow-default-scopes	true
df9a718f-69f0-41b0-b167-6fc8371b7192	eca7ad21-77db-49c0-b13c-9565e86f01e1	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"annotations":{},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
4943f344-4035-4352-953a-98d400ede2ee	7b436267-1a77-47bd-b581-4f66ed3d1752	allowed-protocol-mapper-types	saml-user-property-mapper
386d69fd-d5cc-4966-ae36-bdf70df07012	7b436267-1a77-47bd-b581-4f66ed3d1752	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8a3d3d1a-7f39-4c3b-b205-0f12d006c5b3	7b436267-1a77-47bd-b581-4f66ed3d1752	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6f89ce6e-d162-457b-a3ad-431a9716bb8b	7b436267-1a77-47bd-b581-4f66ed3d1752	allowed-protocol-mapper-types	saml-role-list-mapper
d33bbcef-8ec2-4b70-a903-6c1e6dda6c1e	7b436267-1a77-47bd-b581-4f66ed3d1752	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
fa2ef652-8d8f-4a6e-93e6-000714255fff	7b436267-1a77-47bd-b581-4f66ed3d1752	allowed-protocol-mapper-types	oidc-full-name-mapper
a09be19f-3656-40a3-8a24-f62b007a58d5	7b436267-1a77-47bd-b581-4f66ed3d1752	allowed-protocol-mapper-types	saml-user-attribute-mapper
0d2dcfd2-60df-4554-b6ba-16f804969742	7b436267-1a77-47bd-b581-4f66ed3d1752	allowed-protocol-mapper-types	oidc-address-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.composite_role (composite, child_role) FROM stdin;
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	dafcb807-25ef-4656-88b9-29fc1cd81770
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	8df2d177-a604-4069-83e9-e82667085440
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	4b9f3053-3e44-44d0-a9b5-e7b487373b3e
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	0f8c84f6-0e47-4f3d-8dd6-dfe4c2f77f0a
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	46f7ca2c-7816-472a-9a71-ca4840a54523
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	86586147-11ff-4573-93b0-3b2a946ec384
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	2fc4c889-a0f5-4ffd-96d2-a6cba4ad9410
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	fc687958-c505-4181-932c-0575697f0c3d
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	986647ba-35aa-40c9-8fc4-5da5db150519
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	775300d0-c774-4f39-892e-6f52002f2ace
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	75c89916-b04b-44be-8001-3470eb63c350
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	b0051862-00af-4b22-9c2f-f50dc0d80140
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	41245de8-acff-45b3-9fed-2380eb3882f4
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	235f3af4-4b75-4453-8f11-8fbfcf7df9f2
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	fe3e34e2-a774-4412-85ca-dfa8485ea2fa
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	85284d9f-12d2-48bd-956b-31ca3b835563
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	2c455c1e-65d1-46da-9928-cadaa82c7d35
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	918a2bad-0336-4e87-aa8a-4256f4e1ff47
0f8c84f6-0e47-4f3d-8dd6-dfe4c2f77f0a	918a2bad-0336-4e87-aa8a-4256f4e1ff47
0f8c84f6-0e47-4f3d-8dd6-dfe4c2f77f0a	fe3e34e2-a774-4412-85ca-dfa8485ea2fa
46f7ca2c-7816-472a-9a71-ca4840a54523	85284d9f-12d2-48bd-956b-31ca3b835563
d34638e7-5432-4650-8db7-cf5c2bb2a624	d1080daa-ede1-44ee-90d4-9c65262f8098
d34638e7-5432-4650-8db7-cf5c2bb2a624	71e372ba-38ab-4402-b7af-bde6558d5a54
71e372ba-38ab-4402-b7af-bde6558d5a54	35f48109-fe10-4a0e-b0f0-f0ba3563f911
7d21e2c5-8d1c-4e4f-bfbb-6480f8ea7a93	caf8f514-a1b7-4521-8b76-c20d034c5200
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	8a9163ff-0966-44a0-983f-d6ecc1f6927e
d34638e7-5432-4650-8db7-cf5c2bb2a624	be859075-284a-43c1-92d7-88245e75a09a
d34638e7-5432-4650-8db7-cf5c2bb2a624	6ec808c5-09e6-4c7b-a3ae-041a44f43073
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	0a72ee0c-d998-4695-abef-1d7c5e2c7991
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	2c319180-070e-41c3-be28-bff227f471e6
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	e2c85d35-b0a9-43fe-9caf-d7ad38ca4e55
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	9097a82a-14d4-4ab4-b92c-0ed21649d6df
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	d12740fe-4577-4d13-9160-f47a163ead4e
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	7a15fb55-9b07-457b-a3bf-82441049c730
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	fad40945-7f18-4bed-828b-1d42cb13d266
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	33945840-512a-4232-b2b7-dfdf204557f2
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	4cb6c1e1-d810-45d9-9e24-9781b68cea8e
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	f729d762-516b-4ea0-885b-fb8a54b08925
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	8ff306be-d1dd-490e-8d56-99841e0082e4
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	2d9e0948-0cea-4cdd-b32f-c40afa56a3d4
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	74e3a350-3abd-439a-8604-dc8ffa0388f0
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	8f2291d2-3405-4bf9-aa6e-3a5877e3b469
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	c021282f-c1c7-406f-a047-237735b718f8
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	60487e5f-c214-48c8-874c-d96e723d3106
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	6e1ea6c3-57ac-4dfb-a972-d09e22019bdc
9097a82a-14d4-4ab4-b92c-0ed21649d6df	c021282f-c1c7-406f-a047-237735b718f8
e2c85d35-b0a9-43fe-9caf-d7ad38ca4e55	8f2291d2-3405-4bf9-aa6e-3a5877e3b469
e2c85d35-b0a9-43fe-9caf-d7ad38ca4e55	6e1ea6c3-57ac-4dfb-a972-d09e22019bdc
0ab08074-0dee-4e9f-95e0-80c7d1bd7940	ae3ccec3-68dd-4f31-8867-0d1193635d1f
2ded8148-0974-408f-b4f8-924e658fb445	1797804b-2bde-490f-877d-f02df7ef76af
2ded8148-0974-408f-b4f8-924e658fb445	e6c06a03-9438-4d97-9418-822da34187fe
367861af-1496-41c7-acbb-9f4eec9b3f7b	0ab08074-0dee-4e9f-95e0-80c7d1bd7940
367861af-1496-41c7-acbb-9f4eec9b3f7b	e6c06a03-9438-4d97-9418-822da34187fe
367861af-1496-41c7-acbb-9f4eec9b3f7b	b9b02591-e69e-4058-8921-2173cd1ead76
367861af-1496-41c7-acbb-9f4eec9b3f7b	36619046-8632-459b-8e86-2423a2c5faf7
367861af-1496-41c7-acbb-9f4eec9b3f7b	e67bf40a-1e7a-4929-bec8-9dcb108efbd5
367861af-1496-41c7-acbb-9f4eec9b3f7b	2beecbde-6c93-4571-9dc2-5c95c02dbcac
367861af-1496-41c7-acbb-9f4eec9b3f7b	09bb81e0-11fb-4f73-ade7-766e38175ea5
367861af-1496-41c7-acbb-9f4eec9b3f7b	364f2a42-2460-43ef-a489-48edd140db72
367861af-1496-41c7-acbb-9f4eec9b3f7b	e947abf6-0148-4999-850d-b68e456f5f55
367861af-1496-41c7-acbb-9f4eec9b3f7b	1797804b-2bde-490f-877d-f02df7ef76af
367861af-1496-41c7-acbb-9f4eec9b3f7b	cbd506b1-08dd-4b3e-bd2a-4e06028d76ec
367861af-1496-41c7-acbb-9f4eec9b3f7b	99d87b7f-88ea-4624-a7cf-858dccca504b
367861af-1496-41c7-acbb-9f4eec9b3f7b	3d520b1a-9e6d-4fd1-b169-f9441f771327
367861af-1496-41c7-acbb-9f4eec9b3f7b	d1d3a37f-0e63-4b28-ac2b-065bf440578e
367861af-1496-41c7-acbb-9f4eec9b3f7b	cec5433b-42c8-4545-b1f5-82a6ec4f726b
367861af-1496-41c7-acbb-9f4eec9b3f7b	ae3ccec3-68dd-4f31-8867-0d1193635d1f
367861af-1496-41c7-acbb-9f4eec9b3f7b	2520be29-e09b-4098-9ca7-55148dbf2e60
367861af-1496-41c7-acbb-9f4eec9b3f7b	2ded8148-0974-408f-b4f8-924e658fb445
4bef87ff-0d0e-4d5e-ac76-7743087e8ff4	74cf43ec-ebea-4967-9825-ece1666d2ecb
4bef87ff-0d0e-4d5e-ac76-7743087e8ff4	5cc6507d-ed6b-4f2a-bc4e-bfe0d1b75e86
4bef87ff-0d0e-4d5e-ac76-7743087e8ff4	40083aae-2be0-4671-8aaa-306c369e9fb6
78f9e3e5-5454-40b5-8c87-19761bba634e	0d8c5b47-0fcb-48bc-bcde-df758fd3822d
e037eca6-fc41-490d-9dda-e529fed032ef	c6c69813-b1f1-46db-b1fa-39e1ba91eb85
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	bde06d15-a916-42bf-a997-67c76316c1b5
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
8a025d39-6200-4a78-94c2-980429413ed9	\N	password	57887784-c82a-4511-8a99-bd3a593bdcdc	1717564769168	\N	{"value":"evNG5Kw/JrNpCpVqbrm0kRmNg4rkCrFUQSuPvdcQqcgAL4gnX4WVqD7U00U6/tZ7YOafywajD+fGrRBIn7EdmQ==","salt":"LH46T8GEnsmg5OyECS7vpg==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
d07a8301-cd36-4e42-a22d-c5283963e13b	\N	password	a883921b-9de5-4ed2-a461-f9003a299f82	1717565369285	My password	{"value":"IHY6cOXvc1baGLTCVptxIllvUovICA+/3KpXH6Obzl0hlbBaWnOYtYyE/DMLkTPabHsrR5aen82sB+LB4T3qfQ==","salt":"VUieWd1rqmLkwRU6wZAjAw==","additionalParameters":{}}	{"hashIterations":210000,"algorithm":"pbkdf2-sha512","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-06-05 05:19:01.834406	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	7564731381
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-06-05 05:19:01.912996	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.25.1	\N	\N	7564731381
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-06-05 05:19:02.862309	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.25.1	\N	\N	7564731381
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-06-05 05:19:02.903769	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	7564731381
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-06-05 05:19:03.673441	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	7564731381
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-06-05 05:19:03.685275	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.25.1	\N	\N	7564731381
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-06-05 05:19:04.601137	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	7564731381
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-06-05 05:19:04.625695	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.25.1	\N	\N	7564731381
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-06-05 05:19:04.656797	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.25.1	\N	\N	7564731381
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-06-05 05:19:05.508216	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.25.1	\N	\N	7564731381
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-06-05 05:19:05.963305	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	7564731381
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-06-05 05:19:05.987894	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	7564731381
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-06-05 05:19:06.193496	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.25.1	\N	\N	7564731381
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-06-05 05:19:06.271729	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.25.1	\N	\N	7564731381
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-06-05 05:19:06.280018	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	7564731381
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-06-05 05:19:06.290139	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.25.1	\N	\N	7564731381
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-06-05 05:19:06.309294	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.25.1	\N	\N	7564731381
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-06-05 05:19:06.449416	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.25.1	\N	\N	7564731381
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-06-05 05:19:06.575738	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	7564731381
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-06-05 05:19:06.592487	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	7564731381
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-06-05 05:19:23.822871	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	7564731381
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-06-05 05:19:06.607993	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.25.1	\N	\N	7564731381
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-06-05 05:19:06.618571	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.25.1	\N	\N	7564731381
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-06-05 05:19:06.752499	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.25.1	\N	\N	7564731381
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-06-05 05:19:06.772092	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	7564731381
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-06-05 05:19:06.777197	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.25.1	\N	\N	7564731381
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-06-05 05:19:06.872212	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.25.1	\N	\N	7564731381
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-06-05 05:19:07.102608	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.25.1	\N	\N	7564731381
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-06-05 05:19:07.121201	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	7564731381
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-06-05 05:19:07.304506	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.25.1	\N	\N	7564731381
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-06-05 05:19:07.371091	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.25.1	\N	\N	7564731381
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-06-05 05:19:07.480515	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.25.1	\N	\N	7564731381
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-06-05 05:19:07.507916	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.25.1	\N	\N	7564731381
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-06-05 05:19:07.530305	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	7564731381
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-06-05 05:19:07.536221	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	7564731381
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-06-05 05:19:07.658946	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.25.1	\N	\N	7564731381
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-06-05 05:19:07.673916	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.25.1	\N	\N	7564731381
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-06-05 05:19:07.688219	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	7564731381
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-06-05 05:19:07.703337	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.25.1	\N	\N	7564731381
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-06-05 05:19:07.717282	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.25.1	\N	\N	7564731381
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-06-05 05:19:07.721662	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	7564731381
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-06-05 05:19:07.729147	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.25.1	\N	\N	7564731381
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-06-05 05:19:07.755843	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.25.1	\N	\N	7564731381
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-06-05 05:19:21.551688	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.25.1	\N	\N	7564731381
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-06-05 05:19:21.588067	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.25.1	\N	\N	7564731381
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-06-05 05:19:21.631286	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	7564731381
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-06-05 05:19:21.670285	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.25.1	\N	\N	7564731381
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-06-05 05:19:21.681699	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.25.1	\N	\N	7564731381
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-06-05 05:19:21.929404	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.25.1	\N	\N	7564731381
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-06-05 05:19:21.947212	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.25.1	\N	\N	7564731381
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-06-05 05:19:22.068317	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.25.1	\N	\N	7564731381
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-06-05 05:19:22.153071	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.25.1	\N	\N	7564731381
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-06-05 05:19:22.162934	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-06-05 05:19:22.173406	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.25.1	\N	\N	7564731381
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-06-05 05:19:22.239443	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.25.1	\N	\N	7564731381
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-06-05 05:19:22.330406	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.25.1	\N	\N	7564731381
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-06-05 05:19:22.347737	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.25.1	\N	\N	7564731381
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-06-05 05:19:22.422092	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.25.1	\N	\N	7564731381
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-06-05 05:19:22.846407	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.25.1	\N	\N	7564731381
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-06-05 05:19:23.005109	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.25.1	\N	\N	7564731381
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-06-05 05:19:23.024914	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.25.1	\N	\N	7564731381
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-06-05 05:19:23.050666	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.25.1	\N	\N	7564731381
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-06-05 05:19:23.064363	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.25.1	\N	\N	7564731381
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-06-05 05:19:23.076916	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	7564731381
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-06-05 05:19:23.085365	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.25.1	\N	\N	7564731381
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-06-05 05:19:23.092999	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.25.1	\N	\N	7564731381
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-06-05 05:19:23.115091	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.25.1	\N	\N	7564731381
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-06-05 05:19:23.123316	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.25.1	\N	\N	7564731381
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-06-05 05:19:23.132841	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.25.1	\N	\N	7564731381
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-06-05 05:19:23.154144	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.25.1	\N	\N	7564731381
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-06-05 05:19:23.164475	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.25.1	\N	\N	7564731381
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-06-05 05:19:23.172742	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	7564731381
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-06-05 05:19:23.190166	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	7564731381
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-06-05 05:19:23.204891	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	7564731381
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-06-05 05:19:23.208726	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.25.1	\N	\N	7564731381
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-06-05 05:19:23.251768	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.25.1	\N	\N	7564731381
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-06-05 05:19:23.264841	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.25.1	\N	\N	7564731381
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-06-05 05:19:23.273645	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.25.1	\N	\N	7564731381
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-06-05 05:19:23.276716	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.25.1	\N	\N	7564731381
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-06-05 05:19:23.316718	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.25.1	\N	\N	7564731381
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-06-05 05:19:23.32074	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.25.1	\N	\N	7564731381
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-06-05 05:19:23.333674	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.25.1	\N	\N	7564731381
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-06-05 05:19:23.336967	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	7564731381
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-06-05 05:19:23.34717	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	7564731381
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-06-05 05:19:23.350081	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.25.1	\N	\N	7564731381
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-06-05 05:19:23.360945	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	7564731381
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-06-05 05:19:23.370687	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.25.1	\N	\N	7564731381
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-06-05 05:19:23.38585	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.25.1	\N	\N	7564731381
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-06-05 05:19:23.400276	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.25.1	\N	\N	7564731381
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-06-05 05:19:23.414219	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.25.1	\N	\N	7564731381
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-06-05 05:19:23.424052	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.25.1	\N	\N	7564731381
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-06-05 05:19:23.434098	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	7564731381
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-06-05 05:19:23.448907	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.25.1	\N	\N	7564731381
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-06-05 05:19:23.452863	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	7564731381
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-06-05 05:19:23.467657	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.25.1	\N	\N	7564731381
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-06-05 05:19:23.471418	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.25.1	\N	\N	7564731381
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-06-05 05:19:23.485481	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.25.1	\N	\N	7564731381
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-06-05 05:19:23.507209	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.25.1	\N	\N	7564731381
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-06-05 05:19:23.510378	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-06-05 05:19:23.54242	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-06-05 05:19:23.558109	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-06-05 05:19:23.562572	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-06-05 05:19:23.577341	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.25.1	\N	\N	7564731381
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-06-05 05:19:23.598973	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.25.1	\N	\N	7564731381
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-06-05 05:19:23.614043	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.25.1	\N	\N	7564731381
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2024-06-05 05:19:23.624338	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.25.1	\N	\N	7564731381
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2024-06-05 05:19:23.633766	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.25.1	\N	\N	7564731381
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2024-06-05 05:19:23.644567	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.25.1	\N	\N	7564731381
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-06-05 05:19:23.652482	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	7564731381
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-06-05 05:19:23.655126	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.25.1	\N	\N	7564731381
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2024-06-05 05:19:23.666617	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2024-06-05 05:19:23.679966	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.25.1	\N	\N	7564731381
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-06-05 05:19:23.714473	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.25.1	\N	\N	7564731381
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2024-06-05 05:19:23.718573	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.25.1	\N	\N	7564731381
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-06-05 05:19:23.738398	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.25.1	\N	\N	7564731381
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2024-06-05 05:19:23.742515	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.25.1	\N	\N	7564731381
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-06-05 05:19:23.759384	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.25.1	\N	\N	7564731381
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2024-06-05 05:19:23.770546	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.25.1	\N	\N	7564731381
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-06-05 05:19:23.804666	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	7564731381
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-06-05 05:19:23.840448	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2024-06-05 05:19:23.855295	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-06-05 05:19:23.872047	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	7564731381
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-06-05 05:19:23.878032	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2024-06-05 05:19:23.888365	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	7564731381
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
c8810218-c378-437b-a906-f64e9cee8ae4	2ba3423f-56e6-41c6-9d55-65f855e5c889	f
c8810218-c378-437b-a906-f64e9cee8ae4	092009bf-8e2f-4eaa-ba2f-fc21bcec4c88	t
c8810218-c378-437b-a906-f64e9cee8ae4	deeaabe4-aa70-45a7-9f63-79a58b389c4f	t
c8810218-c378-437b-a906-f64e9cee8ae4	ab40a375-1207-42ea-a45b-f8294596b54f	t
c8810218-c378-437b-a906-f64e9cee8ae4	1993ad97-561a-4d7d-9b86-b8c6f6011fcf	f
c8810218-c378-437b-a906-f64e9cee8ae4	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3	f
c8810218-c378-437b-a906-f64e9cee8ae4	fe6cec2e-d87a-4536-ad48-9569a18402d6	t
c8810218-c378-437b-a906-f64e9cee8ae4	17a3c288-248a-44a3-a8e7-20a6b19cd7d5	t
c8810218-c378-437b-a906-f64e9cee8ae4	ddb7156d-5c15-4b02-b630-552211d657f8	f
c8810218-c378-437b-a906-f64e9cee8ae4	a1b76567-6467-4fcd-954d-c9ad780dfe04	t
16d92262-12b3-4f31-aa27-dc97588c55e9	985c3cab-005a-4116-a272-5ad07ab1dead	t
16d92262-12b3-4f31-aa27-dc97588c55e9	e9d2e99f-55ff-4362-b711-61e6aae34d6d	t
16d92262-12b3-4f31-aa27-dc97588c55e9	ef848091-0de9-4bfe-9b3b-04e74b7d9731	t
16d92262-12b3-4f31-aa27-dc97588c55e9	14d2fba0-8cda-43b3-ac33-f479e3e25a72	t
16d92262-12b3-4f31-aa27-dc97588c55e9	08427143-05fb-434a-9a34-0e858a1aad59	t
16d92262-12b3-4f31-aa27-dc97588c55e9	57edfbbe-8594-4089-a68d-4cd0183d7a50	t
16d92262-12b3-4f31-aa27-dc97588c55e9	26281455-10da-4c98-9d72-c6901c3141f2	f
16d92262-12b3-4f31-aa27-dc97588c55e9	ce00cc5f-ef91-4a53-91c2-648049c4304f	f
16d92262-12b3-4f31-aa27-dc97588c55e9	b4842e84-1538-49e8-9b98-224708a31f2a	f
16d92262-12b3-4f31-aa27-dc97588c55e9	072e19ef-af57-4a85-97ad-3c308587730a	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
d34638e7-5432-4650-8db7-cf5c2bb2a624	c8810218-c378-437b-a906-f64e9cee8ae4	f	${role_default-roles}	default-roles-master	c8810218-c378-437b-a906-f64e9cee8ae4	\N	\N
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	c8810218-c378-437b-a906-f64e9cee8ae4	f	${role_admin}	admin	c8810218-c378-437b-a906-f64e9cee8ae4	\N	\N
dafcb807-25ef-4656-88b9-29fc1cd81770	c8810218-c378-437b-a906-f64e9cee8ae4	f	${role_create-realm}	create-realm	c8810218-c378-437b-a906-f64e9cee8ae4	\N	\N
8df2d177-a604-4069-83e9-e82667085440	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_create-client}	create-client	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
4b9f3053-3e44-44d0-a9b5-e7b487373b3e	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_view-realm}	view-realm	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
0f8c84f6-0e47-4f3d-8dd6-dfe4c2f77f0a	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_view-users}	view-users	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
46f7ca2c-7816-472a-9a71-ca4840a54523	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_view-clients}	view-clients	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
86586147-11ff-4573-93b0-3b2a946ec384	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_view-events}	view-events	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
2fc4c889-a0f5-4ffd-96d2-a6cba4ad9410	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_view-identity-providers}	view-identity-providers	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
fc687958-c505-4181-932c-0575697f0c3d	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_view-authorization}	view-authorization	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
986647ba-35aa-40c9-8fc4-5da5db150519	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_manage-realm}	manage-realm	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
775300d0-c774-4f39-892e-6f52002f2ace	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_manage-users}	manage-users	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
75c89916-b04b-44be-8001-3470eb63c350	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_manage-clients}	manage-clients	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
b0051862-00af-4b22-9c2f-f50dc0d80140	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_manage-events}	manage-events	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
41245de8-acff-45b3-9fed-2380eb3882f4	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_manage-identity-providers}	manage-identity-providers	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
235f3af4-4b75-4453-8f11-8fbfcf7df9f2	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_manage-authorization}	manage-authorization	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
fe3e34e2-a774-4412-85ca-dfa8485ea2fa	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_query-users}	query-users	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
85284d9f-12d2-48bd-956b-31ca3b835563	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_query-clients}	query-clients	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
2c455c1e-65d1-46da-9928-cadaa82c7d35	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_query-realms}	query-realms	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
918a2bad-0336-4e87-aa8a-4256f4e1ff47	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_query-groups}	query-groups	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
d1080daa-ede1-44ee-90d4-9c65262f8098	0759f154-70b7-4204-804f-e3693b67a479	t	${role_view-profile}	view-profile	c8810218-c378-437b-a906-f64e9cee8ae4	0759f154-70b7-4204-804f-e3693b67a479	\N
71e372ba-38ab-4402-b7af-bde6558d5a54	0759f154-70b7-4204-804f-e3693b67a479	t	${role_manage-account}	manage-account	c8810218-c378-437b-a906-f64e9cee8ae4	0759f154-70b7-4204-804f-e3693b67a479	\N
35f48109-fe10-4a0e-b0f0-f0ba3563f911	0759f154-70b7-4204-804f-e3693b67a479	t	${role_manage-account-links}	manage-account-links	c8810218-c378-437b-a906-f64e9cee8ae4	0759f154-70b7-4204-804f-e3693b67a479	\N
6df1502d-62c5-492d-a3da-854bc9148ab7	0759f154-70b7-4204-804f-e3693b67a479	t	${role_view-applications}	view-applications	c8810218-c378-437b-a906-f64e9cee8ae4	0759f154-70b7-4204-804f-e3693b67a479	\N
caf8f514-a1b7-4521-8b76-c20d034c5200	0759f154-70b7-4204-804f-e3693b67a479	t	${role_view-consent}	view-consent	c8810218-c378-437b-a906-f64e9cee8ae4	0759f154-70b7-4204-804f-e3693b67a479	\N
7d21e2c5-8d1c-4e4f-bfbb-6480f8ea7a93	0759f154-70b7-4204-804f-e3693b67a479	t	${role_manage-consent}	manage-consent	c8810218-c378-437b-a906-f64e9cee8ae4	0759f154-70b7-4204-804f-e3693b67a479	\N
ef223ede-e219-4b7e-ae5c-4ca2d043f6e4	0759f154-70b7-4204-804f-e3693b67a479	t	${role_view-groups}	view-groups	c8810218-c378-437b-a906-f64e9cee8ae4	0759f154-70b7-4204-804f-e3693b67a479	\N
30c4da10-057c-4c9d-9580-aa9a173dc34b	0759f154-70b7-4204-804f-e3693b67a479	t	${role_delete-account}	delete-account	c8810218-c378-437b-a906-f64e9cee8ae4	0759f154-70b7-4204-804f-e3693b67a479	\N
fa484ed5-5208-4806-8fb4-9b2c2e344735	a69db417-264a-48ab-a12f-3097deaf4f69	t	${role_read-token}	read-token	c8810218-c378-437b-a906-f64e9cee8ae4	a69db417-264a-48ab-a12f-3097deaf4f69	\N
8a9163ff-0966-44a0-983f-d6ecc1f6927e	1ac20814-714f-41f2-914d-f3b6664fc004	t	${role_impersonation}	impersonation	c8810218-c378-437b-a906-f64e9cee8ae4	1ac20814-714f-41f2-914d-f3b6664fc004	\N
be859075-284a-43c1-92d7-88245e75a09a	c8810218-c378-437b-a906-f64e9cee8ae4	f	${role_offline-access}	offline_access	c8810218-c378-437b-a906-f64e9cee8ae4	\N	\N
6ec808c5-09e6-4c7b-a3ae-041a44f43073	c8810218-c378-437b-a906-f64e9cee8ae4	f	${role_uma_authorization}	uma_authorization	c8810218-c378-437b-a906-f64e9cee8ae4	\N	\N
4bef87ff-0d0e-4d5e-ac76-7743087e8ff4	16d92262-12b3-4f31-aa27-dc97588c55e9	f	${role_default-roles}	default-roles-godigital	16d92262-12b3-4f31-aa27-dc97588c55e9	\N	\N
0a72ee0c-d998-4695-abef-1d7c5e2c7991	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_create-client}	create-client	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
2c319180-070e-41c3-be28-bff227f471e6	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_view-realm}	view-realm	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
e2c85d35-b0a9-43fe-9caf-d7ad38ca4e55	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_view-users}	view-users	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
9097a82a-14d4-4ab4-b92c-0ed21649d6df	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_view-clients}	view-clients	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
d12740fe-4577-4d13-9160-f47a163ead4e	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_view-events}	view-events	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
7a15fb55-9b07-457b-a3bf-82441049c730	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_view-identity-providers}	view-identity-providers	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
fad40945-7f18-4bed-828b-1d42cb13d266	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_view-authorization}	view-authorization	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
33945840-512a-4232-b2b7-dfdf204557f2	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_manage-realm}	manage-realm	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
4cb6c1e1-d810-45d9-9e24-9781b68cea8e	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_manage-users}	manage-users	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
f729d762-516b-4ea0-885b-fb8a54b08925	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_manage-clients}	manage-clients	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
8ff306be-d1dd-490e-8d56-99841e0082e4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_manage-events}	manage-events	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
2d9e0948-0cea-4cdd-b32f-c40afa56a3d4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_manage-identity-providers}	manage-identity-providers	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
74e3a350-3abd-439a-8604-dc8ffa0388f0	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_manage-authorization}	manage-authorization	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
8f2291d2-3405-4bf9-aa6e-3a5877e3b469	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_query-users}	query-users	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
c021282f-c1c7-406f-a047-237735b718f8	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_query-clients}	query-clients	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
60487e5f-c214-48c8-874c-d96e723d3106	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_query-realms}	query-realms	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
6e1ea6c3-57ac-4dfb-a972-d09e22019bdc	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_query-groups}	query-groups	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
74cf43ec-ebea-4967-9825-ece1666d2ecb	16d92262-12b3-4f31-aa27-dc97588c55e9	f	${role_uma_authorization}	uma_authorization	16d92262-12b3-4f31-aa27-dc97588c55e9	\N	\N
5cc6507d-ed6b-4f2a-bc4e-bfe0d1b75e86	16d92262-12b3-4f31-aa27-dc97588c55e9	f	${role_offline-access}	offline_access	16d92262-12b3-4f31-aa27-dc97588c55e9	\N	\N
0ab08074-0dee-4e9f-95e0-80c7d1bd7940	96042979-1680-49fa-b1be-5749a1590c81	t	${role_view-clients}	view-clients	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
e6c06a03-9438-4d97-9418-822da34187fe	96042979-1680-49fa-b1be-5749a1590c81	t	${role_query-groups}	query-groups	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
b9b02591-e69e-4058-8921-2173cd1ead76	96042979-1680-49fa-b1be-5749a1590c81	t	${role_view-identity-providers}	view-identity-providers	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
36619046-8632-459b-8e86-2423a2c5faf7	96042979-1680-49fa-b1be-5749a1590c81	t	${role_manage-events}	manage-events	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
e67bf40a-1e7a-4929-bec8-9dcb108efbd5	96042979-1680-49fa-b1be-5749a1590c81	t	${role_manage-users}	manage-users	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
2beecbde-6c93-4571-9dc2-5c95c02dbcac	96042979-1680-49fa-b1be-5749a1590c81	t	${role_manage-clients}	manage-clients	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
367861af-1496-41c7-acbb-9f4eec9b3f7b	96042979-1680-49fa-b1be-5749a1590c81	t	${role_realm-admin}	realm-admin	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
09bb81e0-11fb-4f73-ade7-766e38175ea5	96042979-1680-49fa-b1be-5749a1590c81	t	${role_impersonation}	impersonation	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
364f2a42-2460-43ef-a489-48edd140db72	96042979-1680-49fa-b1be-5749a1590c81	t	${role_manage-identity-providers}	manage-identity-providers	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
e947abf6-0148-4999-850d-b68e456f5f55	96042979-1680-49fa-b1be-5749a1590c81	t	${role_query-realms}	query-realms	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
1797804b-2bde-490f-877d-f02df7ef76af	96042979-1680-49fa-b1be-5749a1590c81	t	${role_query-users}	query-users	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
cbd506b1-08dd-4b3e-bd2a-4e06028d76ec	96042979-1680-49fa-b1be-5749a1590c81	t	${role_manage-authorization}	manage-authorization	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
99d87b7f-88ea-4624-a7cf-858dccca504b	96042979-1680-49fa-b1be-5749a1590c81	t	${role_view-authorization}	view-authorization	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
3d520b1a-9e6d-4fd1-b169-f9441f771327	96042979-1680-49fa-b1be-5749a1590c81	t	${role_create-client}	create-client	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
d1d3a37f-0e63-4b28-ac2b-065bf440578e	96042979-1680-49fa-b1be-5749a1590c81	t	${role_view-realm}	view-realm	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
cec5433b-42c8-4545-b1f5-82a6ec4f726b	96042979-1680-49fa-b1be-5749a1590c81	t	${role_manage-realm}	manage-realm	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
ae3ccec3-68dd-4f31-8867-0d1193635d1f	96042979-1680-49fa-b1be-5749a1590c81	t	${role_query-clients}	query-clients	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
2520be29-e09b-4098-9ca7-55148dbf2e60	96042979-1680-49fa-b1be-5749a1590c81	t	${role_view-events}	view-events	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
2ded8148-0974-408f-b4f8-924e658fb445	96042979-1680-49fa-b1be-5749a1590c81	t	${role_view-users}	view-users	16d92262-12b3-4f31-aa27-dc97588c55e9	96042979-1680-49fa-b1be-5749a1590c81	\N
86500cab-e2c0-4470-bf8e-573754af237c	63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	t	${role_read-token}	read-token	16d92262-12b3-4f31-aa27-dc97588c55e9	63ff1dc9-4c84-4cb8-9953-8cafe724f7a4	\N
e4b52b6e-1a73-4502-9c55-bfd74d14e483	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	t	\N	uma_protection	16d92262-12b3-4f31-aa27-dc97588c55e9	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	\N
40083aae-2be0-4671-8aaa-306c369e9fb6	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	t	\N	user	16d92262-12b3-4f31-aa27-dc97588c55e9	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	\N
c6c69813-b1f1-46db-b1fa-39e1ba91eb85	0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	${role_view-consent}	view-consent	16d92262-12b3-4f31-aa27-dc97588c55e9	0c65f92d-f46d-44b5-851f-5817ba5e1da0	\N
a1f2e5ff-af17-4626-8ea0-2a6ffd0eb56b	0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	${role_delete-account}	delete-account	16d92262-12b3-4f31-aa27-dc97588c55e9	0c65f92d-f46d-44b5-851f-5817ba5e1da0	\N
cda7ee7a-5617-4650-af88-8d23d74c9487	0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	${role_view-profile}	view-profile	16d92262-12b3-4f31-aa27-dc97588c55e9	0c65f92d-f46d-44b5-851f-5817ba5e1da0	\N
5998c21b-ccca-4b48-9511-d10b841c22fc	0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	${role_view-groups}	view-groups	16d92262-12b3-4f31-aa27-dc97588c55e9	0c65f92d-f46d-44b5-851f-5817ba5e1da0	\N
75e7799e-ae67-4b0d-be90-cc5b9f660829	0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	${role_view-applications}	view-applications	16d92262-12b3-4f31-aa27-dc97588c55e9	0c65f92d-f46d-44b5-851f-5817ba5e1da0	\N
78f9e3e5-5454-40b5-8c87-19761bba634e	0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	${role_manage-account}	manage-account	16d92262-12b3-4f31-aa27-dc97588c55e9	0c65f92d-f46d-44b5-851f-5817ba5e1da0	\N
e037eca6-fc41-490d-9dda-e529fed032ef	0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	${role_manage-consent}	manage-consent	16d92262-12b3-4f31-aa27-dc97588c55e9	0c65f92d-f46d-44b5-851f-5817ba5e1da0	\N
0d8c5b47-0fcb-48bc-bcde-df758fd3822d	0c65f92d-f46d-44b5-851f-5817ba5e1da0	t	${role_manage-account-links}	manage-account-links	16d92262-12b3-4f31-aa27-dc97588c55e9	0c65f92d-f46d-44b5-851f-5817ba5e1da0	\N
bde06d15-a916-42bf-a997-67c76316c1b5	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	t	${role_impersonation}	impersonation	c8810218-c378-437b-a906-f64e9cee8ae4	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.migration_model (id, version, update_time) FROM stdin;
bmaze	24.0.5	1717564764
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
9084deab-b491-4e44-8b0a-bec4f8b3de76	audience resolve	openid-connect	oidc-audience-resolve-mapper	5d529f55-8c40-4666-85f0-159c70f8dd23	\N
0708c471-7721-4cbd-97db-07c03af01527	locale	openid-connect	oidc-usermodel-attribute-mapper	06e80dfc-63e0-49ec-b5c4-803a77cec4ec	\N
2120c6eb-48fc-481c-b862-fa706e22f69e	role list	saml	saml-role-list-mapper	\N	092009bf-8e2f-4eaa-ba2f-fc21bcec4c88
6abd3712-629f-4abe-af1a-68af9a7d3a77	full name	openid-connect	oidc-full-name-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
94e57064-4fd9-4137-be4e-a43d5f8f4520	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
e2b7ad26-8858-464c-ba72-f1f4a77b72cb	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
a9657553-555e-4cc7-aa08-5f995f6bb901	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
19fd3514-b1e6-4c1d-adfa-4574282c5c5b	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
f091f712-1e7e-41ff-bcc4-fa154927d48e	username	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
676460ea-0ecc-4099-aa69-24ba76c1420e	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
d08441d4-9f4d-4683-92cc-cf5dad8d204e	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
0e61b2c1-2f00-4b3f-8052-b89105d015a6	website	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
41eee0f5-3f7a-4640-be27-ead4e5e55510	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
e6611d21-69f6-4ba0-b2b5-f1f6481a2a65	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
b701e2f4-6b47-436a-bc94-f874f3c850a8	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
ae4865c3-390a-49c3-9e60-fc8bb4e32641	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
3e089a80-7fc7-462a-ab13-899db65da91e	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	deeaabe4-aa70-45a7-9f63-79a58b389c4f
4109d6b6-900f-436c-b386-9562a4bacf68	email	openid-connect	oidc-usermodel-attribute-mapper	\N	ab40a375-1207-42ea-a45b-f8294596b54f
ca1e5206-c590-401b-97fc-5cdcf232ed5d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	ab40a375-1207-42ea-a45b-f8294596b54f
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	address	openid-connect	oidc-address-mapper	\N	1993ad97-561a-4d7d-9b86-b8c6f6011fcf
3f3e7172-b930-4295-8651-aa18e1389a68	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3
12adc86d-f096-40f9-8a80-857c1f8bec70	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	1e1b4ceb-9b4b-438a-a5b8-afc87b2016a3
701c9cbc-592c-49bf-95e5-48cb66b2e38d	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	fe6cec2e-d87a-4536-ad48-9569a18402d6
b5e103ba-2f5f-4bb5-bb7b-5f7adb43df9e	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	fe6cec2e-d87a-4536-ad48-9569a18402d6
b014e687-a3c3-445d-87a2-3662ce22893b	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	fe6cec2e-d87a-4536-ad48-9569a18402d6
1b163a83-5819-4ff7-b8bc-79d685deba9f	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	17a3c288-248a-44a3-a8e7-20a6b19cd7d5
3840699a-0ecd-4acb-92f1-7c8262bc6416	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	ddb7156d-5c15-4b02-b630-552211d657f8
c8c93caa-d424-4580-bf34-4c83b7577e54	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	ddb7156d-5c15-4b02-b630-552211d657f8
fbe76b55-9456-4255-8976-80cb3bdce533	acr loa level	openid-connect	oidc-acr-mapper	\N	a1b76567-6467-4fcd-954d-c9ad780dfe04
de17319a-5923-4215-a2cd-bf46db901fbe	full name	openid-connect	oidc-full-name-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
50d09d99-4582-409f-8faa-f3750f842099	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
3181c4ca-a92d-49ee-9ad8-cb5b21989dff	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
dde154b5-330d-4041-9cbb-2109ce2c2bc6	family name	openid-connect	oidc-usermodel-property-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
0b640372-7f7f-42b1-861d-b4d975d33e0e	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
9b2b5cfc-23f2-45db-93aa-d5237ddaa575	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
ac3852db-e175-4c09-9cea-7177f85666b9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
d3de3a0e-411e-4f08-84aa-625031aa91d7	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
3beb31a8-7eff-47f0-a3c4-6c925c851dca	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
44015558-8c13-4960-aa77-15edcd1ee784	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
93ae70e6-b4cf-48b8-ad84-03d758456510	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
fc37f7d4-dbe2-4783-8ae4-725f6ab9577f	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
d76b44f1-76d2-484a-bfa4-bb44822cc7c1	given name	openid-connect	oidc-usermodel-property-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
ab87336c-44b7-480e-8827-5d09a9fdb8ab	username	openid-connect	oidc-usermodel-property-mapper	\N	e9d2e99f-55ff-4362-b711-61e6aae34d6d
3973cfec-db89-492d-baae-32025d61f83a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	14d2fba0-8cda-43b3-ac33-f479e3e25a72
f2c9716f-1460-4af3-a78b-a9a9695873cd	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	14d2fba0-8cda-43b3-ac33-f479e3e25a72
7531c398-de3b-4f5a-ae93-c32d43bf3e55	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	14d2fba0-8cda-43b3-ac33-f479e3e25a72
0535cdb7-8f0e-4c7f-b12c-ad45ee9a7922	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	08427143-05fb-434a-9a34-0e858a1aad59
75cc315e-f411-4cd1-b8cc-154997205e3c	role list	saml	saml-role-list-mapper	\N	985c3cab-005a-4116-a272-5ad07ab1dead
7646b092-058e-4832-a028-fc5cdfe75a4a	upn	openid-connect	oidc-usermodel-property-mapper	\N	072e19ef-af57-4a85-97ad-3c308587730a
e8e53f04-9315-4a93-834b-7646bf8bd849	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	072e19ef-af57-4a85-97ad-3c308587730a
dfca4e71-2995-4d5a-80f8-79f229a5643b	email	openid-connect	oidc-usermodel-property-mapper	\N	ef848091-0de9-4bfe-9b3b-04e74b7d9731
b402f781-92a3-40c1-aa4e-5695fad5d0ac	email verified	openid-connect	oidc-usermodel-property-mapper	\N	ef848091-0de9-4bfe-9b3b-04e74b7d9731
c7fd13b3-56d3-41b2-82fb-ef808347ed1d	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	b4842e84-1538-49e8-9b98-224708a31f2a
0193fd3a-1649-443e-8721-7492c9bebc3b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	b4842e84-1538-49e8-9b98-224708a31f2a
dbb4dbdd-1bb5-4153-bbd0-94afbaf35170	acr loa level	openid-connect	oidc-acr-mapper	\N	57edfbbe-8594-4089-a68d-4cd0183d7a50
98f89859-fff0-4f67-ab48-cf3466a8090f	address	openid-connect	oidc-address-mapper	\N	ce00cc5f-ef91-4a53-91c2-648049c4304f
52ae8675-e6a3-4055-b2e4-758be7950e58	audience resolve	openid-connect	oidc-audience-resolve-mapper	0e7139bb-6d77-442d-b045-0ce8e85dc81c	\N
6eefa21a-3779-490f-9492-31dc8233c2d9	x-hasura-default-role	openid-connect	oidc-hardcoded-claim-mapper	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	\N
dbd3c0a2-fcc5-4b0d-a47e-654a90cacbbc	x-hasura-allowed-roles	openid-connect	oidc-usermodel-client-role-mapper	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	\N
80e5d7ac-42c6-4f9f-bfa2-1d2f30d60c36	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	\N
e7b365ad-ae9f-44dc-b66e-5db5ae39001f	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	\N
6303c3ca-cd86-4da5-bf21-783304391dfc	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	\N
454381f6-ac91-40fa-a2a0-1add0abccb0c	x-hasura-user-id	openid-connect	oidc-usermodel-property-mapper	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	\N
12c452f4-950e-4c11-ac8f-7558f57d6e26	locale	openid-connect	oidc-usermodel-attribute-mapper	db962978-abd2-4625-8288-472315f9d100	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
0708c471-7721-4cbd-97db-07c03af01527	true	introspection.token.claim
0708c471-7721-4cbd-97db-07c03af01527	true	userinfo.token.claim
0708c471-7721-4cbd-97db-07c03af01527	locale	user.attribute
0708c471-7721-4cbd-97db-07c03af01527	true	id.token.claim
0708c471-7721-4cbd-97db-07c03af01527	true	access.token.claim
0708c471-7721-4cbd-97db-07c03af01527	locale	claim.name
0708c471-7721-4cbd-97db-07c03af01527	String	jsonType.label
2120c6eb-48fc-481c-b862-fa706e22f69e	false	single
2120c6eb-48fc-481c-b862-fa706e22f69e	Basic	attribute.nameformat
2120c6eb-48fc-481c-b862-fa706e22f69e	Role	attribute.name
0e61b2c1-2f00-4b3f-8052-b89105d015a6	true	introspection.token.claim
0e61b2c1-2f00-4b3f-8052-b89105d015a6	true	userinfo.token.claim
0e61b2c1-2f00-4b3f-8052-b89105d015a6	website	user.attribute
0e61b2c1-2f00-4b3f-8052-b89105d015a6	true	id.token.claim
0e61b2c1-2f00-4b3f-8052-b89105d015a6	true	access.token.claim
0e61b2c1-2f00-4b3f-8052-b89105d015a6	website	claim.name
0e61b2c1-2f00-4b3f-8052-b89105d015a6	String	jsonType.label
19fd3514-b1e6-4c1d-adfa-4574282c5c5b	true	introspection.token.claim
19fd3514-b1e6-4c1d-adfa-4574282c5c5b	true	userinfo.token.claim
19fd3514-b1e6-4c1d-adfa-4574282c5c5b	nickname	user.attribute
19fd3514-b1e6-4c1d-adfa-4574282c5c5b	true	id.token.claim
19fd3514-b1e6-4c1d-adfa-4574282c5c5b	true	access.token.claim
19fd3514-b1e6-4c1d-adfa-4574282c5c5b	nickname	claim.name
19fd3514-b1e6-4c1d-adfa-4574282c5c5b	String	jsonType.label
3e089a80-7fc7-462a-ab13-899db65da91e	true	introspection.token.claim
3e089a80-7fc7-462a-ab13-899db65da91e	true	userinfo.token.claim
3e089a80-7fc7-462a-ab13-899db65da91e	updatedAt	user.attribute
3e089a80-7fc7-462a-ab13-899db65da91e	true	id.token.claim
3e089a80-7fc7-462a-ab13-899db65da91e	true	access.token.claim
3e089a80-7fc7-462a-ab13-899db65da91e	updated_at	claim.name
3e089a80-7fc7-462a-ab13-899db65da91e	long	jsonType.label
41eee0f5-3f7a-4640-be27-ead4e5e55510	true	introspection.token.claim
41eee0f5-3f7a-4640-be27-ead4e5e55510	true	userinfo.token.claim
41eee0f5-3f7a-4640-be27-ead4e5e55510	gender	user.attribute
41eee0f5-3f7a-4640-be27-ead4e5e55510	true	id.token.claim
41eee0f5-3f7a-4640-be27-ead4e5e55510	true	access.token.claim
41eee0f5-3f7a-4640-be27-ead4e5e55510	gender	claim.name
41eee0f5-3f7a-4640-be27-ead4e5e55510	String	jsonType.label
676460ea-0ecc-4099-aa69-24ba76c1420e	true	introspection.token.claim
676460ea-0ecc-4099-aa69-24ba76c1420e	true	userinfo.token.claim
676460ea-0ecc-4099-aa69-24ba76c1420e	profile	user.attribute
676460ea-0ecc-4099-aa69-24ba76c1420e	true	id.token.claim
676460ea-0ecc-4099-aa69-24ba76c1420e	true	access.token.claim
676460ea-0ecc-4099-aa69-24ba76c1420e	profile	claim.name
676460ea-0ecc-4099-aa69-24ba76c1420e	String	jsonType.label
6abd3712-629f-4abe-af1a-68af9a7d3a77	true	introspection.token.claim
6abd3712-629f-4abe-af1a-68af9a7d3a77	true	userinfo.token.claim
6abd3712-629f-4abe-af1a-68af9a7d3a77	true	id.token.claim
6abd3712-629f-4abe-af1a-68af9a7d3a77	true	access.token.claim
94e57064-4fd9-4137-be4e-a43d5f8f4520	true	introspection.token.claim
94e57064-4fd9-4137-be4e-a43d5f8f4520	true	userinfo.token.claim
94e57064-4fd9-4137-be4e-a43d5f8f4520	lastName	user.attribute
94e57064-4fd9-4137-be4e-a43d5f8f4520	true	id.token.claim
94e57064-4fd9-4137-be4e-a43d5f8f4520	true	access.token.claim
94e57064-4fd9-4137-be4e-a43d5f8f4520	family_name	claim.name
94e57064-4fd9-4137-be4e-a43d5f8f4520	String	jsonType.label
a9657553-555e-4cc7-aa08-5f995f6bb901	true	introspection.token.claim
a9657553-555e-4cc7-aa08-5f995f6bb901	true	userinfo.token.claim
a9657553-555e-4cc7-aa08-5f995f6bb901	middleName	user.attribute
a9657553-555e-4cc7-aa08-5f995f6bb901	true	id.token.claim
a9657553-555e-4cc7-aa08-5f995f6bb901	true	access.token.claim
a9657553-555e-4cc7-aa08-5f995f6bb901	middle_name	claim.name
a9657553-555e-4cc7-aa08-5f995f6bb901	String	jsonType.label
ae4865c3-390a-49c3-9e60-fc8bb4e32641	true	introspection.token.claim
ae4865c3-390a-49c3-9e60-fc8bb4e32641	true	userinfo.token.claim
ae4865c3-390a-49c3-9e60-fc8bb4e32641	locale	user.attribute
ae4865c3-390a-49c3-9e60-fc8bb4e32641	true	id.token.claim
ae4865c3-390a-49c3-9e60-fc8bb4e32641	true	access.token.claim
ae4865c3-390a-49c3-9e60-fc8bb4e32641	locale	claim.name
ae4865c3-390a-49c3-9e60-fc8bb4e32641	String	jsonType.label
b701e2f4-6b47-436a-bc94-f874f3c850a8	true	introspection.token.claim
b701e2f4-6b47-436a-bc94-f874f3c850a8	true	userinfo.token.claim
b701e2f4-6b47-436a-bc94-f874f3c850a8	zoneinfo	user.attribute
b701e2f4-6b47-436a-bc94-f874f3c850a8	true	id.token.claim
b701e2f4-6b47-436a-bc94-f874f3c850a8	true	access.token.claim
b701e2f4-6b47-436a-bc94-f874f3c850a8	zoneinfo	claim.name
b701e2f4-6b47-436a-bc94-f874f3c850a8	String	jsonType.label
d08441d4-9f4d-4683-92cc-cf5dad8d204e	true	introspection.token.claim
d08441d4-9f4d-4683-92cc-cf5dad8d204e	true	userinfo.token.claim
d08441d4-9f4d-4683-92cc-cf5dad8d204e	picture	user.attribute
d08441d4-9f4d-4683-92cc-cf5dad8d204e	true	id.token.claim
d08441d4-9f4d-4683-92cc-cf5dad8d204e	true	access.token.claim
d08441d4-9f4d-4683-92cc-cf5dad8d204e	picture	claim.name
d08441d4-9f4d-4683-92cc-cf5dad8d204e	String	jsonType.label
e2b7ad26-8858-464c-ba72-f1f4a77b72cb	true	introspection.token.claim
e2b7ad26-8858-464c-ba72-f1f4a77b72cb	true	userinfo.token.claim
e2b7ad26-8858-464c-ba72-f1f4a77b72cb	firstName	user.attribute
e2b7ad26-8858-464c-ba72-f1f4a77b72cb	true	id.token.claim
e2b7ad26-8858-464c-ba72-f1f4a77b72cb	true	access.token.claim
e2b7ad26-8858-464c-ba72-f1f4a77b72cb	given_name	claim.name
e2b7ad26-8858-464c-ba72-f1f4a77b72cb	String	jsonType.label
e6611d21-69f6-4ba0-b2b5-f1f6481a2a65	true	introspection.token.claim
e6611d21-69f6-4ba0-b2b5-f1f6481a2a65	true	userinfo.token.claim
e6611d21-69f6-4ba0-b2b5-f1f6481a2a65	birthdate	user.attribute
e6611d21-69f6-4ba0-b2b5-f1f6481a2a65	true	id.token.claim
e6611d21-69f6-4ba0-b2b5-f1f6481a2a65	true	access.token.claim
e6611d21-69f6-4ba0-b2b5-f1f6481a2a65	birthdate	claim.name
e6611d21-69f6-4ba0-b2b5-f1f6481a2a65	String	jsonType.label
f091f712-1e7e-41ff-bcc4-fa154927d48e	true	introspection.token.claim
f091f712-1e7e-41ff-bcc4-fa154927d48e	true	userinfo.token.claim
f091f712-1e7e-41ff-bcc4-fa154927d48e	username	user.attribute
f091f712-1e7e-41ff-bcc4-fa154927d48e	true	id.token.claim
f091f712-1e7e-41ff-bcc4-fa154927d48e	true	access.token.claim
f091f712-1e7e-41ff-bcc4-fa154927d48e	preferred_username	claim.name
f091f712-1e7e-41ff-bcc4-fa154927d48e	String	jsonType.label
4109d6b6-900f-436c-b386-9562a4bacf68	true	introspection.token.claim
4109d6b6-900f-436c-b386-9562a4bacf68	true	userinfo.token.claim
4109d6b6-900f-436c-b386-9562a4bacf68	email	user.attribute
4109d6b6-900f-436c-b386-9562a4bacf68	true	id.token.claim
4109d6b6-900f-436c-b386-9562a4bacf68	true	access.token.claim
4109d6b6-900f-436c-b386-9562a4bacf68	email	claim.name
4109d6b6-900f-436c-b386-9562a4bacf68	String	jsonType.label
ca1e5206-c590-401b-97fc-5cdcf232ed5d	true	introspection.token.claim
ca1e5206-c590-401b-97fc-5cdcf232ed5d	true	userinfo.token.claim
ca1e5206-c590-401b-97fc-5cdcf232ed5d	emailVerified	user.attribute
ca1e5206-c590-401b-97fc-5cdcf232ed5d	true	id.token.claim
ca1e5206-c590-401b-97fc-5cdcf232ed5d	true	access.token.claim
ca1e5206-c590-401b-97fc-5cdcf232ed5d	email_verified	claim.name
ca1e5206-c590-401b-97fc-5cdcf232ed5d	boolean	jsonType.label
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	formatted	user.attribute.formatted
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	country	user.attribute.country
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	true	introspection.token.claim
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	postal_code	user.attribute.postal_code
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	true	userinfo.token.claim
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	street	user.attribute.street
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	true	id.token.claim
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	region	user.attribute.region
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	true	access.token.claim
9aaa3408-b61f-4d81-96d2-bbaaf27f484e	locality	user.attribute.locality
12adc86d-f096-40f9-8a80-857c1f8bec70	true	introspection.token.claim
12adc86d-f096-40f9-8a80-857c1f8bec70	true	userinfo.token.claim
12adc86d-f096-40f9-8a80-857c1f8bec70	phoneNumberVerified	user.attribute
12adc86d-f096-40f9-8a80-857c1f8bec70	true	id.token.claim
12adc86d-f096-40f9-8a80-857c1f8bec70	true	access.token.claim
12adc86d-f096-40f9-8a80-857c1f8bec70	phone_number_verified	claim.name
12adc86d-f096-40f9-8a80-857c1f8bec70	boolean	jsonType.label
3f3e7172-b930-4295-8651-aa18e1389a68	true	introspection.token.claim
3f3e7172-b930-4295-8651-aa18e1389a68	true	userinfo.token.claim
3f3e7172-b930-4295-8651-aa18e1389a68	phoneNumber	user.attribute
3f3e7172-b930-4295-8651-aa18e1389a68	true	id.token.claim
3f3e7172-b930-4295-8651-aa18e1389a68	true	access.token.claim
3f3e7172-b930-4295-8651-aa18e1389a68	phone_number	claim.name
3f3e7172-b930-4295-8651-aa18e1389a68	String	jsonType.label
701c9cbc-592c-49bf-95e5-48cb66b2e38d	true	introspection.token.claim
701c9cbc-592c-49bf-95e5-48cb66b2e38d	true	multivalued
701c9cbc-592c-49bf-95e5-48cb66b2e38d	foo	user.attribute
701c9cbc-592c-49bf-95e5-48cb66b2e38d	true	access.token.claim
701c9cbc-592c-49bf-95e5-48cb66b2e38d	realm_access.roles	claim.name
701c9cbc-592c-49bf-95e5-48cb66b2e38d	String	jsonType.label
b014e687-a3c3-445d-87a2-3662ce22893b	true	introspection.token.claim
b014e687-a3c3-445d-87a2-3662ce22893b	true	access.token.claim
b5e103ba-2f5f-4bb5-bb7b-5f7adb43df9e	true	introspection.token.claim
b5e103ba-2f5f-4bb5-bb7b-5f7adb43df9e	true	multivalued
b5e103ba-2f5f-4bb5-bb7b-5f7adb43df9e	foo	user.attribute
b5e103ba-2f5f-4bb5-bb7b-5f7adb43df9e	true	access.token.claim
b5e103ba-2f5f-4bb5-bb7b-5f7adb43df9e	resource_access.${client_id}.roles	claim.name
b5e103ba-2f5f-4bb5-bb7b-5f7adb43df9e	String	jsonType.label
1b163a83-5819-4ff7-b8bc-79d685deba9f	true	introspection.token.claim
1b163a83-5819-4ff7-b8bc-79d685deba9f	true	access.token.claim
3840699a-0ecd-4acb-92f1-7c8262bc6416	true	introspection.token.claim
3840699a-0ecd-4acb-92f1-7c8262bc6416	true	userinfo.token.claim
3840699a-0ecd-4acb-92f1-7c8262bc6416	username	user.attribute
3840699a-0ecd-4acb-92f1-7c8262bc6416	true	id.token.claim
3840699a-0ecd-4acb-92f1-7c8262bc6416	true	access.token.claim
3840699a-0ecd-4acb-92f1-7c8262bc6416	upn	claim.name
3840699a-0ecd-4acb-92f1-7c8262bc6416	String	jsonType.label
c8c93caa-d424-4580-bf34-4c83b7577e54	true	introspection.token.claim
c8c93caa-d424-4580-bf34-4c83b7577e54	true	multivalued
c8c93caa-d424-4580-bf34-4c83b7577e54	foo	user.attribute
c8c93caa-d424-4580-bf34-4c83b7577e54	true	id.token.claim
c8c93caa-d424-4580-bf34-4c83b7577e54	true	access.token.claim
c8c93caa-d424-4580-bf34-4c83b7577e54	groups	claim.name
c8c93caa-d424-4580-bf34-4c83b7577e54	String	jsonType.label
fbe76b55-9456-4255-8976-80cb3bdce533	true	introspection.token.claim
fbe76b55-9456-4255-8976-80cb3bdce533	true	id.token.claim
fbe76b55-9456-4255-8976-80cb3bdce533	true	access.token.claim
0b640372-7f7f-42b1-861d-b4d975d33e0e	true	userinfo.token.claim
0b640372-7f7f-42b1-861d-b4d975d33e0e	website	user.attribute
0b640372-7f7f-42b1-861d-b4d975d33e0e	true	id.token.claim
0b640372-7f7f-42b1-861d-b4d975d33e0e	true	access.token.claim
0b640372-7f7f-42b1-861d-b4d975d33e0e	website	claim.name
0b640372-7f7f-42b1-861d-b4d975d33e0e	String	jsonType.label
3181c4ca-a92d-49ee-9ad8-cb5b21989dff	true	userinfo.token.claim
3181c4ca-a92d-49ee-9ad8-cb5b21989dff	birthdate	user.attribute
3181c4ca-a92d-49ee-9ad8-cb5b21989dff	true	id.token.claim
3181c4ca-a92d-49ee-9ad8-cb5b21989dff	true	access.token.claim
3181c4ca-a92d-49ee-9ad8-cb5b21989dff	birthdate	claim.name
3181c4ca-a92d-49ee-9ad8-cb5b21989dff	String	jsonType.label
3beb31a8-7eff-47f0-a3c4-6c925c851dca	true	userinfo.token.claim
3beb31a8-7eff-47f0-a3c4-6c925c851dca	zoneinfo	user.attribute
3beb31a8-7eff-47f0-a3c4-6c925c851dca	true	id.token.claim
3beb31a8-7eff-47f0-a3c4-6c925c851dca	true	access.token.claim
3beb31a8-7eff-47f0-a3c4-6c925c851dca	zoneinfo	claim.name
3beb31a8-7eff-47f0-a3c4-6c925c851dca	String	jsonType.label
44015558-8c13-4960-aa77-15edcd1ee784	true	userinfo.token.claim
44015558-8c13-4960-aa77-15edcd1ee784	profile	user.attribute
44015558-8c13-4960-aa77-15edcd1ee784	true	id.token.claim
44015558-8c13-4960-aa77-15edcd1ee784	true	access.token.claim
44015558-8c13-4960-aa77-15edcd1ee784	profile	claim.name
44015558-8c13-4960-aa77-15edcd1ee784	String	jsonType.label
50d09d99-4582-409f-8faa-f3750f842099	true	userinfo.token.claim
50d09d99-4582-409f-8faa-f3750f842099	updatedAt	user.attribute
50d09d99-4582-409f-8faa-f3750f842099	true	id.token.claim
50d09d99-4582-409f-8faa-f3750f842099	true	access.token.claim
50d09d99-4582-409f-8faa-f3750f842099	updated_at	claim.name
50d09d99-4582-409f-8faa-f3750f842099	long	jsonType.label
93ae70e6-b4cf-48b8-ad84-03d758456510	true	userinfo.token.claim
93ae70e6-b4cf-48b8-ad84-03d758456510	nickname	user.attribute
93ae70e6-b4cf-48b8-ad84-03d758456510	true	id.token.claim
93ae70e6-b4cf-48b8-ad84-03d758456510	true	access.token.claim
93ae70e6-b4cf-48b8-ad84-03d758456510	nickname	claim.name
93ae70e6-b4cf-48b8-ad84-03d758456510	String	jsonType.label
9b2b5cfc-23f2-45db-93aa-d5237ddaa575	true	userinfo.token.claim
9b2b5cfc-23f2-45db-93aa-d5237ddaa575	picture	user.attribute
9b2b5cfc-23f2-45db-93aa-d5237ddaa575	true	id.token.claim
9b2b5cfc-23f2-45db-93aa-d5237ddaa575	true	access.token.claim
9b2b5cfc-23f2-45db-93aa-d5237ddaa575	picture	claim.name
9b2b5cfc-23f2-45db-93aa-d5237ddaa575	String	jsonType.label
ab87336c-44b7-480e-8827-5d09a9fdb8ab	true	userinfo.token.claim
ab87336c-44b7-480e-8827-5d09a9fdb8ab	username	user.attribute
ab87336c-44b7-480e-8827-5d09a9fdb8ab	true	id.token.claim
ab87336c-44b7-480e-8827-5d09a9fdb8ab	true	access.token.claim
ab87336c-44b7-480e-8827-5d09a9fdb8ab	preferred_username	claim.name
ab87336c-44b7-480e-8827-5d09a9fdb8ab	String	jsonType.label
ac3852db-e175-4c09-9cea-7177f85666b9	true	userinfo.token.claim
ac3852db-e175-4c09-9cea-7177f85666b9	gender	user.attribute
ac3852db-e175-4c09-9cea-7177f85666b9	true	id.token.claim
ac3852db-e175-4c09-9cea-7177f85666b9	true	access.token.claim
ac3852db-e175-4c09-9cea-7177f85666b9	gender	claim.name
ac3852db-e175-4c09-9cea-7177f85666b9	String	jsonType.label
d3de3a0e-411e-4f08-84aa-625031aa91d7	true	userinfo.token.claim
d3de3a0e-411e-4f08-84aa-625031aa91d7	locale	user.attribute
d3de3a0e-411e-4f08-84aa-625031aa91d7	true	id.token.claim
d3de3a0e-411e-4f08-84aa-625031aa91d7	true	access.token.claim
d3de3a0e-411e-4f08-84aa-625031aa91d7	locale	claim.name
d3de3a0e-411e-4f08-84aa-625031aa91d7	String	jsonType.label
d76b44f1-76d2-484a-bfa4-bb44822cc7c1	true	userinfo.token.claim
d76b44f1-76d2-484a-bfa4-bb44822cc7c1	firstName	user.attribute
d76b44f1-76d2-484a-bfa4-bb44822cc7c1	true	id.token.claim
d76b44f1-76d2-484a-bfa4-bb44822cc7c1	true	access.token.claim
d76b44f1-76d2-484a-bfa4-bb44822cc7c1	given_name	claim.name
d76b44f1-76d2-484a-bfa4-bb44822cc7c1	String	jsonType.label
dde154b5-330d-4041-9cbb-2109ce2c2bc6	true	userinfo.token.claim
dde154b5-330d-4041-9cbb-2109ce2c2bc6	lastName	user.attribute
dde154b5-330d-4041-9cbb-2109ce2c2bc6	true	id.token.claim
dde154b5-330d-4041-9cbb-2109ce2c2bc6	true	access.token.claim
dde154b5-330d-4041-9cbb-2109ce2c2bc6	family_name	claim.name
dde154b5-330d-4041-9cbb-2109ce2c2bc6	String	jsonType.label
de17319a-5923-4215-a2cd-bf46db901fbe	true	id.token.claim
de17319a-5923-4215-a2cd-bf46db901fbe	true	access.token.claim
de17319a-5923-4215-a2cd-bf46db901fbe	true	userinfo.token.claim
fc37f7d4-dbe2-4783-8ae4-725f6ab9577f	true	userinfo.token.claim
fc37f7d4-dbe2-4783-8ae4-725f6ab9577f	middleName	user.attribute
fc37f7d4-dbe2-4783-8ae4-725f6ab9577f	true	id.token.claim
fc37f7d4-dbe2-4783-8ae4-725f6ab9577f	true	access.token.claim
fc37f7d4-dbe2-4783-8ae4-725f6ab9577f	middle_name	claim.name
fc37f7d4-dbe2-4783-8ae4-725f6ab9577f	String	jsonType.label
3973cfec-db89-492d-baae-32025d61f83a	foo	user.attribute
3973cfec-db89-492d-baae-32025d61f83a	true	access.token.claim
3973cfec-db89-492d-baae-32025d61f83a	resource_access.${client_id}.roles	claim.name
3973cfec-db89-492d-baae-32025d61f83a	String	jsonType.label
3973cfec-db89-492d-baae-32025d61f83a	true	multivalued
f2c9716f-1460-4af3-a78b-a9a9695873cd	foo	user.attribute
f2c9716f-1460-4af3-a78b-a9a9695873cd	true	access.token.claim
f2c9716f-1460-4af3-a78b-a9a9695873cd	realm_access.roles	claim.name
f2c9716f-1460-4af3-a78b-a9a9695873cd	String	jsonType.label
f2c9716f-1460-4af3-a78b-a9a9695873cd	true	multivalued
75cc315e-f411-4cd1-b8cc-154997205e3c	false	single
75cc315e-f411-4cd1-b8cc-154997205e3c	Basic	attribute.nameformat
75cc315e-f411-4cd1-b8cc-154997205e3c	Role	attribute.name
7646b092-058e-4832-a028-fc5cdfe75a4a	true	userinfo.token.claim
7646b092-058e-4832-a028-fc5cdfe75a4a	username	user.attribute
7646b092-058e-4832-a028-fc5cdfe75a4a	true	id.token.claim
7646b092-058e-4832-a028-fc5cdfe75a4a	true	access.token.claim
7646b092-058e-4832-a028-fc5cdfe75a4a	upn	claim.name
7646b092-058e-4832-a028-fc5cdfe75a4a	String	jsonType.label
e8e53f04-9315-4a93-834b-7646bf8bd849	true	multivalued
e8e53f04-9315-4a93-834b-7646bf8bd849	true	userinfo.token.claim
e8e53f04-9315-4a93-834b-7646bf8bd849	foo	user.attribute
e8e53f04-9315-4a93-834b-7646bf8bd849	true	id.token.claim
e8e53f04-9315-4a93-834b-7646bf8bd849	true	access.token.claim
e8e53f04-9315-4a93-834b-7646bf8bd849	groups	claim.name
e8e53f04-9315-4a93-834b-7646bf8bd849	String	jsonType.label
b402f781-92a3-40c1-aa4e-5695fad5d0ac	true	userinfo.token.claim
b402f781-92a3-40c1-aa4e-5695fad5d0ac	emailVerified	user.attribute
b402f781-92a3-40c1-aa4e-5695fad5d0ac	true	id.token.claim
b402f781-92a3-40c1-aa4e-5695fad5d0ac	true	access.token.claim
b402f781-92a3-40c1-aa4e-5695fad5d0ac	email_verified	claim.name
b402f781-92a3-40c1-aa4e-5695fad5d0ac	boolean	jsonType.label
dfca4e71-2995-4d5a-80f8-79f229a5643b	true	userinfo.token.claim
dfca4e71-2995-4d5a-80f8-79f229a5643b	email	user.attribute
dfca4e71-2995-4d5a-80f8-79f229a5643b	true	id.token.claim
dfca4e71-2995-4d5a-80f8-79f229a5643b	true	access.token.claim
dfca4e71-2995-4d5a-80f8-79f229a5643b	email	claim.name
dfca4e71-2995-4d5a-80f8-79f229a5643b	String	jsonType.label
0193fd3a-1649-443e-8721-7492c9bebc3b	true	userinfo.token.claim
0193fd3a-1649-443e-8721-7492c9bebc3b	phoneNumber	user.attribute
0193fd3a-1649-443e-8721-7492c9bebc3b	true	id.token.claim
0193fd3a-1649-443e-8721-7492c9bebc3b	true	access.token.claim
0193fd3a-1649-443e-8721-7492c9bebc3b	phone_number	claim.name
0193fd3a-1649-443e-8721-7492c9bebc3b	String	jsonType.label
c7fd13b3-56d3-41b2-82fb-ef808347ed1d	true	userinfo.token.claim
c7fd13b3-56d3-41b2-82fb-ef808347ed1d	phoneNumberVerified	user.attribute
c7fd13b3-56d3-41b2-82fb-ef808347ed1d	true	id.token.claim
c7fd13b3-56d3-41b2-82fb-ef808347ed1d	true	access.token.claim
c7fd13b3-56d3-41b2-82fb-ef808347ed1d	phone_number_verified	claim.name
c7fd13b3-56d3-41b2-82fb-ef808347ed1d	boolean	jsonType.label
dbb4dbdd-1bb5-4153-bbd0-94afbaf35170	true	id.token.claim
dbb4dbdd-1bb5-4153-bbd0-94afbaf35170	true	access.token.claim
dbb4dbdd-1bb5-4153-bbd0-94afbaf35170	true	userinfo.token.claim
98f89859-fff0-4f67-ab48-cf3466a8090f	formatted	user.attribute.formatted
98f89859-fff0-4f67-ab48-cf3466a8090f	country	user.attribute.country
98f89859-fff0-4f67-ab48-cf3466a8090f	postal_code	user.attribute.postal_code
98f89859-fff0-4f67-ab48-cf3466a8090f	true	userinfo.token.claim
98f89859-fff0-4f67-ab48-cf3466a8090f	street	user.attribute.street
98f89859-fff0-4f67-ab48-cf3466a8090f	true	id.token.claim
98f89859-fff0-4f67-ab48-cf3466a8090f	region	user.attribute.region
98f89859-fff0-4f67-ab48-cf3466a8090f	true	access.token.claim
98f89859-fff0-4f67-ab48-cf3466a8090f	locality	user.attribute.locality
454381f6-ac91-40fa-a2a0-1add0abccb0c	id	user.attribute
454381f6-ac91-40fa-a2a0-1add0abccb0c	true	id.token.claim
454381f6-ac91-40fa-a2a0-1add0abccb0c	true	access.token.claim
454381f6-ac91-40fa-a2a0-1add0abccb0c	https://hasura\\.io/jwt/claims.x-hasura-user-id	claim.name
454381f6-ac91-40fa-a2a0-1add0abccb0c	true	userinfo.token.claim
6303c3ca-cd86-4da5-bf21-783304391dfc	clientId	user.session.note
6303c3ca-cd86-4da5-bf21-783304391dfc	true	userinfo.token.claim
6303c3ca-cd86-4da5-bf21-783304391dfc	true	id.token.claim
6303c3ca-cd86-4da5-bf21-783304391dfc	true	access.token.claim
6303c3ca-cd86-4da5-bf21-783304391dfc	clientId	claim.name
6303c3ca-cd86-4da5-bf21-783304391dfc	String	jsonType.label
6eefa21a-3779-490f-9492-31dc8233c2d9	user	claim.value
6eefa21a-3779-490f-9492-31dc8233c2d9	true	userinfo.token.claim
6eefa21a-3779-490f-9492-31dc8233c2d9	true	id.token.claim
6eefa21a-3779-490f-9492-31dc8233c2d9	true	access.token.claim
6eefa21a-3779-490f-9492-31dc8233c2d9	https://hasura\\.io/jwt/claims.x-hasura-default-role	claim.name
6eefa21a-3779-490f-9492-31dc8233c2d9	false	access.tokenResponse.claim
80e5d7ac-42c6-4f9f-bfa2-1d2f30d60c36	clientHost	user.session.note
80e5d7ac-42c6-4f9f-bfa2-1d2f30d60c36	true	userinfo.token.claim
80e5d7ac-42c6-4f9f-bfa2-1d2f30d60c36	true	id.token.claim
80e5d7ac-42c6-4f9f-bfa2-1d2f30d60c36	true	access.token.claim
80e5d7ac-42c6-4f9f-bfa2-1d2f30d60c36	clientHost	claim.name
80e5d7ac-42c6-4f9f-bfa2-1d2f30d60c36	String	jsonType.label
dbd3c0a2-fcc5-4b0d-a47e-654a90cacbbc	true	id.token.claim
dbd3c0a2-fcc5-4b0d-a47e-654a90cacbbc	true	access.token.claim
dbd3c0a2-fcc5-4b0d-a47e-654a90cacbbc	https://hasura\\.io/jwt/claims.x-hasura-allowed-roles	claim.name
dbd3c0a2-fcc5-4b0d-a47e-654a90cacbbc	true	multivalued
dbd3c0a2-fcc5-4b0d-a47e-654a90cacbbc	true	userinfo.token.claim
e7b365ad-ae9f-44dc-b66e-5db5ae39001f	clientAddress	user.session.note
e7b365ad-ae9f-44dc-b66e-5db5ae39001f	true	userinfo.token.claim
e7b365ad-ae9f-44dc-b66e-5db5ae39001f	true	id.token.claim
e7b365ad-ae9f-44dc-b66e-5db5ae39001f	true	access.token.claim
e7b365ad-ae9f-44dc-b66e-5db5ae39001f	clientAddress	claim.name
e7b365ad-ae9f-44dc-b66e-5db5ae39001f	String	jsonType.label
12c452f4-950e-4c11-ac8f-7558f57d6e26	true	userinfo.token.claim
12c452f4-950e-4c11-ac8f-7558f57d6e26	locale	user.attribute
12c452f4-950e-4c11-ac8f-7558f57d6e26	true	id.token.claim
12c452f4-950e-4c11-ac8f-7558f57d6e26	true	access.token.claim
12c452f4-950e-4c11-ac8f-7558f57d6e26	locale	claim.name
12c452f4-950e-4c11-ac8f-7558f57d6e26	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
16d92262-12b3-4f31-aa27-dc97588c55e9	60	604800	604800				t	f	0	base	godigital	0	\N	t	t	t	f	EXTERNAL	604800	604800	f	t	9ae44d43-c019-4c7e-8ab7-15bdb4fdca1e	1800	t	ru	t	f	f	f	0	1	30	6	HmacSHA1	totp	9c92d4fb-7685-4a12-8195-35a2bc7101fa	f44f68f7-268f-410d-9fc5-df0673b71852	0c60aaf7-ddc8-4d60-a192-94b7f3cde593	d9040a95-51cf-47c0-acdb-d0fc9e1e13ac	45e62bdc-de9a-433e-b833-a90228b15da5	2592000	f	900	t	f	e7157816-0e47-46e1-91f7-aeeed7fc9366	0	f	0	0	4bef87ff-0d0e-4d5e-ac76-7743087e8ff4
c8810218-c378-437b-a906-f64e9cee8ae4	60	300	60				t	f	0	keycloak	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	1ac20814-714f-41f2-914d-f3b6664fc004	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2290a502-da34-426d-b37c-d687fdc0e0f4	5a57aa22-3d83-4e32-9175-eac539bfb4e5	74d2b456-294c-4dce-9051-354757f8e243	f77b3e80-0989-47c6-b24c-e444f12d82a8	246cab7f-7cdb-4dbd-9529-199315765f5e	2592000	f	900	t	f	c5d7dce8-8756-401e-8a93-7e7245eed4ef	0	f	0	0	d34638e7-5432-4650-8db7-cf5c2bb2a624
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
bruteForceProtected	c8810218-c378-437b-a906-f64e9cee8ae4	false
permanentLockout	c8810218-c378-437b-a906-f64e9cee8ae4	false
maxTemporaryLockouts	c8810218-c378-437b-a906-f64e9cee8ae4	0
maxFailureWaitSeconds	c8810218-c378-437b-a906-f64e9cee8ae4	900
minimumQuickLoginWaitSeconds	c8810218-c378-437b-a906-f64e9cee8ae4	60
waitIncrementSeconds	c8810218-c378-437b-a906-f64e9cee8ae4	60
quickLoginCheckMilliSeconds	c8810218-c378-437b-a906-f64e9cee8ae4	1000
maxDeltaTimeSeconds	c8810218-c378-437b-a906-f64e9cee8ae4	43200
failureFactor	c8810218-c378-437b-a906-f64e9cee8ae4	30
realmReusableOtpCode	c8810218-c378-437b-a906-f64e9cee8ae4	false
firstBrokerLoginFlowId	c8810218-c378-437b-a906-f64e9cee8ae4	491e1994-672c-419d-8bc0-46b2ec6bb0e9
displayName	c8810218-c378-437b-a906-f64e9cee8ae4	Keycloak
displayNameHtml	c8810218-c378-437b-a906-f64e9cee8ae4	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	c8810218-c378-437b-a906-f64e9cee8ae4	RS256
offlineSessionMaxLifespanEnabled	c8810218-c378-437b-a906-f64e9cee8ae4	false
offlineSessionMaxLifespan	c8810218-c378-437b-a906-f64e9cee8ae4	5184000
bruteForceProtected	16d92262-12b3-4f31-aa27-dc97588c55e9	false
permanentLockout	16d92262-12b3-4f31-aa27-dc97588c55e9	false
maxTemporaryLockouts	16d92262-12b3-4f31-aa27-dc97588c55e9	0
maxFailureWaitSeconds	16d92262-12b3-4f31-aa27-dc97588c55e9	900
minimumQuickLoginWaitSeconds	16d92262-12b3-4f31-aa27-dc97588c55e9	60
waitIncrementSeconds	16d92262-12b3-4f31-aa27-dc97588c55e9	60
quickLoginCheckMilliSeconds	16d92262-12b3-4f31-aa27-dc97588c55e9	1000
maxDeltaTimeSeconds	16d92262-12b3-4f31-aa27-dc97588c55e9	43200
failureFactor	16d92262-12b3-4f31-aa27-dc97588c55e9	30
realmReusableOtpCode	16d92262-12b3-4f31-aa27-dc97588c55e9	false
defaultSignatureAlgorithm	16d92262-12b3-4f31-aa27-dc97588c55e9	RS256
offlineSessionMaxLifespanEnabled	16d92262-12b3-4f31-aa27-dc97588c55e9	true
offlineSessionMaxLifespan	16d92262-12b3-4f31-aa27-dc97588c55e9	5184000
clientSessionIdleTimeout	16d92262-12b3-4f31-aa27-dc97588c55e9	604800
clientSessionMaxLifespan	16d92262-12b3-4f31-aa27-dc97588c55e9	604800
clientOfflineSessionIdleTimeout	16d92262-12b3-4f31-aa27-dc97588c55e9	0
clientOfflineSessionMaxLifespan	16d92262-12b3-4f31-aa27-dc97588c55e9	0
actionTokenGeneratedByAdminLifespan	16d92262-12b3-4f31-aa27-dc97588c55e9	604800
actionTokenGeneratedByUserLifespan	16d92262-12b3-4f31-aa27-dc97588c55e9	604800
oauth2DeviceCodeLifespan	16d92262-12b3-4f31-aa27-dc97588c55e9	600
oauth2DevicePollingInterval	16d92262-12b3-4f31-aa27-dc97588c55e9	5
webAuthnPolicyRpEntityName	16d92262-12b3-4f31-aa27-dc97588c55e9	keycloak
webAuthnPolicySignatureAlgorithms	16d92262-12b3-4f31-aa27-dc97588c55e9	ES256
webAuthnPolicyRpId	16d92262-12b3-4f31-aa27-dc97588c55e9	
webAuthnPolicyAttestationConveyancePreference	16d92262-12b3-4f31-aa27-dc97588c55e9	not specified
webAuthnPolicyAuthenticatorAttachment	16d92262-12b3-4f31-aa27-dc97588c55e9	not specified
webAuthnPolicyRequireResidentKey	16d92262-12b3-4f31-aa27-dc97588c55e9	not specified
webAuthnPolicyUserVerificationRequirement	16d92262-12b3-4f31-aa27-dc97588c55e9	not specified
webAuthnPolicyCreateTimeout	16d92262-12b3-4f31-aa27-dc97588c55e9	0
webAuthnPolicyAvoidSameAuthenticatorRegister	16d92262-12b3-4f31-aa27-dc97588c55e9	false
webAuthnPolicyRpEntityNamePasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	ES256
webAuthnPolicyRpIdPasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	
webAuthnPolicyAttestationConveyancePreferencePasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	not specified
webAuthnPolicyRequireResidentKeyPasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	not specified
webAuthnPolicyCreateTimeoutPasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	16d92262-12b3-4f31-aa27-dc97588c55e9	false
cibaBackchannelTokenDeliveryMode	16d92262-12b3-4f31-aa27-dc97588c55e9	poll
cibaExpiresIn	16d92262-12b3-4f31-aa27-dc97588c55e9	120
cibaInterval	16d92262-12b3-4f31-aa27-dc97588c55e9	5
cibaAuthRequestedUserHint	16d92262-12b3-4f31-aa27-dc97588c55e9	login_hint
parRequestUriLifespan	16d92262-12b3-4f31-aa27-dc97588c55e9	60
firstBrokerLoginFlowId	16d92262-12b3-4f31-aa27-dc97588c55e9	d35fa945-d07f-4a45-b4fb-40f7aed9f0d5
actionTokenGeneratedByUserLifespan.verify-email	16d92262-12b3-4f31-aa27-dc97588c55e9	
actionTokenGeneratedByUserLifespan.idp-verify-account-via-email	16d92262-12b3-4f31-aa27-dc97588c55e9	
actionTokenGeneratedByUserLifespan.execute-actions	16d92262-12b3-4f31-aa27-dc97588c55e9	
shortVerificationUri	16d92262-12b3-4f31-aa27-dc97588c55e9	
actionTokenGeneratedByUserLifespan.reset-credentials	16d92262-12b3-4f31-aa27-dc97588c55e9	
client-policies.profiles	16d92262-12b3-4f31-aa27-dc97588c55e9	{"profiles":[]}
client-policies.policies	16d92262-12b3-4f31-aa27-dc97588c55e9	{"policies":[]}
cibaBackchannelTokenDeliveryMode	c8810218-c378-437b-a906-f64e9cee8ae4	poll
cibaExpiresIn	c8810218-c378-437b-a906-f64e9cee8ae4	120
cibaAuthRequestedUserHint	c8810218-c378-437b-a906-f64e9cee8ae4	login_hint
parRequestUriLifespan	c8810218-c378-437b-a906-f64e9cee8ae4	60
cibaInterval	c8810218-c378-437b-a906-f64e9cee8ae4	5
actionTokenGeneratedByAdminLifespan	c8810218-c378-437b-a906-f64e9cee8ae4	43200
actionTokenGeneratedByUserLifespan	c8810218-c378-437b-a906-f64e9cee8ae4	300
oauth2DeviceCodeLifespan	c8810218-c378-437b-a906-f64e9cee8ae4	600
oauth2DevicePollingInterval	c8810218-c378-437b-a906-f64e9cee8ae4	5
clientSessionIdleTimeout	c8810218-c378-437b-a906-f64e9cee8ae4	0
clientSessionMaxLifespan	c8810218-c378-437b-a906-f64e9cee8ae4	0
clientOfflineSessionIdleTimeout	c8810218-c378-437b-a906-f64e9cee8ae4	0
clientOfflineSessionMaxLifespan	c8810218-c378-437b-a906-f64e9cee8ae4	0
webAuthnPolicyRpEntityName	c8810218-c378-437b-a906-f64e9cee8ae4	keycloak
webAuthnPolicySignatureAlgorithms	c8810218-c378-437b-a906-f64e9cee8ae4	ES256
webAuthnPolicyRpId	c8810218-c378-437b-a906-f64e9cee8ae4	
webAuthnPolicyAttestationConveyancePreference	c8810218-c378-437b-a906-f64e9cee8ae4	not specified
webAuthnPolicyAuthenticatorAttachment	c8810218-c378-437b-a906-f64e9cee8ae4	not specified
webAuthnPolicyRequireResidentKey	c8810218-c378-437b-a906-f64e9cee8ae4	not specified
webAuthnPolicyUserVerificationRequirement	c8810218-c378-437b-a906-f64e9cee8ae4	not specified
webAuthnPolicyCreateTimeout	c8810218-c378-437b-a906-f64e9cee8ae4	0
webAuthnPolicyAvoidSameAuthenticatorRegister	c8810218-c378-437b-a906-f64e9cee8ae4	false
webAuthnPolicyRpEntityNamePasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	ES256
webAuthnPolicyRpIdPasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	
webAuthnPolicyAttestationConveyancePreferencePasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	not specified
webAuthnPolicyRequireResidentKeyPasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	not specified
webAuthnPolicyCreateTimeoutPasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	c8810218-c378-437b-a906-f64e9cee8ae4	false
client-policies.profiles	c8810218-c378-437b-a906-f64e9cee8ae4	{"profiles":[]}
client-policies.policies	c8810218-c378-437b-a906-f64e9cee8ae4	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	16d92262-12b3-4f31-aa27-dc97588c55e9	
_browser_header.xContentTypeOptions	16d92262-12b3-4f31-aa27-dc97588c55e9	nosniff
_browser_header.referrerPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	no-referrer
_browser_header.xRobotsTag	16d92262-12b3-4f31-aa27-dc97588c55e9	none
_browser_header.xFrameOptions	16d92262-12b3-4f31-aa27-dc97588c55e9	SAMEORIGIN
_browser_header.contentSecurityPolicy	16d92262-12b3-4f31-aa27-dc97588c55e9	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	16d92262-12b3-4f31-aa27-dc97588c55e9	1; mode=block
_browser_header.strictTransportSecurity	16d92262-12b3-4f31-aa27-dc97588c55e9	max-age=31536000; includeSubDomains
_browser_header.contentSecurityPolicyReportOnly	c8810218-c378-437b-a906-f64e9cee8ae4	
_browser_header.xContentTypeOptions	c8810218-c378-437b-a906-f64e9cee8ae4	nosniff
_browser_header.referrerPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	no-referrer
_browser_header.xRobotsTag	c8810218-c378-437b-a906-f64e9cee8ae4	none
_browser_header.xFrameOptions	c8810218-c378-437b-a906-f64e9cee8ae4	SAMEORIGIN
_browser_header.contentSecurityPolicy	c8810218-c378-437b-a906-f64e9cee8ae4	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	c8810218-c378-437b-a906-f64e9cee8ae4	1; mode=block
_browser_header.strictTransportSecurity	c8810218-c378-437b-a906-f64e9cee8ae4	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
16d92262-12b3-4f31-aa27-dc97588c55e9	jboss-logging
c8810218-c378-437b-a906-f64e9cee8ae4	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	c8810218-c378-437b-a906-f64e9cee8ae4
password	password	t	t	16d92262-12b3-4f31-aa27-dc97588c55e9
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
16d92262-12b3-4f31-aa27-dc97588c55e9		replyToDisplayName
16d92262-12b3-4f31-aa27-dc97588c55e9	false	starttls
16d92262-12b3-4f31-aa27-dc97588c55e9	false	auth
16d92262-12b3-4f31-aa27-dc97588c55e9		envelopeFrom
16d92262-12b3-4f31-aa27-dc97588c55e9	false	ssl
16d92262-12b3-4f31-aa27-dc97588c55e9	ynbfqqsqmivxgrro	password
16d92262-12b3-4f31-aa27-dc97588c55e9	1025	port
16d92262-12b3-4f31-aa27-dc97588c55e9	mail	host
16d92262-12b3-4f31-aa27-dc97588c55e9		replyTo
16d92262-12b3-4f31-aa27-dc97588c55e9	mail@godigital.team	from
16d92262-12b3-4f31-aa27-dc97588c55e9		fromDisplayName
16d92262-12b3-4f31-aa27-dc97588c55e9	mail@likon.app	user
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
16d92262-12b3-4f31-aa27-dc97588c55e9	ru
16d92262-12b3-4f31-aa27-dc97588c55e9	en
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.redirect_uris (client_id, value) FROM stdin;
0759f154-70b7-4204-804f-e3693b67a479	/realms/master/account/*
5d529f55-8c40-4666-85f0-159c70f8dd23	/realms/master/account/*
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	/admin/master/console/*
0c65f92d-f46d-44b5-851f-5817ba5e1da0	/realms/godigital/account/*
0e7139bb-6d77-442d-b045-0ce8e85dc81c	/realms/godigital/account/*
db962978-abd2-4625-8288-472315f9d100	/admin/godigital/console/*
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	http://localhost:3000/*
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	http://godigital.local:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
d7e502fc-ac8b-4b9a-af00-9257eab77cc0	VERIFY_EMAIL	Verify Email	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	VERIFY_EMAIL	50
7228de0e-efea-41d0-b1b5-28acb71d165a	UPDATE_PROFILE	Update Profile	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	UPDATE_PROFILE	40
3ff60e16-aa73-4382-bfc7-de5ee4048e80	CONFIGURE_TOTP	Configure OTP	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	CONFIGURE_TOTP	10
da127731-ee11-497f-a8d7-e5cf40cee171	UPDATE_PASSWORD	Update Password	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	UPDATE_PASSWORD	30
20495e70-25bf-45f9-86b0-0c768b58be11	TERMS_AND_CONDITIONS	Terms and Conditions	c8810218-c378-437b-a906-f64e9cee8ae4	f	f	TERMS_AND_CONDITIONS	20
bbc12706-3c8a-48a0-826b-d15f8e002945	delete_account	Delete Account	c8810218-c378-437b-a906-f64e9cee8ae4	f	f	delete_account	60
40bfccf8-1bd9-48ef-a017-2e7b317b4ac7	delete_credential	Delete Credential	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	delete_credential	100
94ed86db-ce56-4058-974b-1a87599c3ca3	update_user_locale	Update User Locale	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	update_user_locale	1000
e838f3dd-f1cf-4c13-85ba-28d155304430	webauthn-register	Webauthn Register	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	webauthn-register	70
91ba99e0-2d27-42ec-b1cb-824d79dd5d1c	webauthn-register-passwordless	Webauthn Register Passwordless	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	webauthn-register-passwordless	80
f7ada94e-7653-4f4e-b450-a9386567dbfd	VERIFY_PROFILE	Verify Profile	c8810218-c378-437b-a906-f64e9cee8ae4	t	f	VERIFY_PROFILE	90
5c6e6e5a-ba94-4769-bb68-9d2c544001e0	CONFIGURE_TOTP	Configure OTP	16d92262-12b3-4f31-aa27-dc97588c55e9	t	f	CONFIGURE_TOTP	10
afc4726a-45f9-48fe-bc79-3e3c67b82c08	TERMS_AND_CONDITIONS	Terms and Conditions	16d92262-12b3-4f31-aa27-dc97588c55e9	f	f	TERMS_AND_CONDITIONS	20
82b444a4-4555-4a98-aa43-faec533c6ad6	UPDATE_PASSWORD	Update Password	16d92262-12b3-4f31-aa27-dc97588c55e9	t	f	UPDATE_PASSWORD	30
af233457-0059-4d5e-b31d-70028f0f0cbb	UPDATE_PROFILE	Update Profile	16d92262-12b3-4f31-aa27-dc97588c55e9	t	f	UPDATE_PROFILE	40
c2c9b19f-1ecd-43a0-96fc-054026cb810d	VERIFY_EMAIL	Verify Email	16d92262-12b3-4f31-aa27-dc97588c55e9	t	f	VERIFY_EMAIL	50
75a0656c-fccf-4b43-baf7-7acf6a4e3af2	delete_account	Delete Account	16d92262-12b3-4f31-aa27-dc97588c55e9	f	f	delete_account	60
1f7301b6-c706-4ace-b879-ef0c94b35af9	webauthn-register	Webauthn Register	16d92262-12b3-4f31-aa27-dc97588c55e9	t	f	webauthn-register	70
8a1699fc-df4d-445b-bcb6-32536b26242a	webauthn-register-passwordless	Webauthn Register Passwordless	16d92262-12b3-4f31-aa27-dc97588c55e9	t	f	webauthn-register-passwordless	80
27bc4cf1-00fd-4998-b773-ed27888f742f	update_user_locale	Update User Locale	16d92262-12b3-4f31-aa27-dc97588c55e9	t	f	update_user_locale	1000
5c8ac0e2-1a63-49e6-be5b-c656660f76e3	delete_credential	Delete Credential	16d92262-12b3-4f31-aa27-dc97588c55e9	t	f	delete_credential	100
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
5d529f55-8c40-4666-85f0-159c70f8dd23	71e372ba-38ab-4402-b7af-bde6558d5a54
5d529f55-8c40-4666-85f0-159c70f8dd23	ef223ede-e219-4b7e-ae5c-4ca2d043f6e4
0e7139bb-6d77-442d-b045-0ce8e85dc81c	5998c21b-ccca-4b48-9511-d10b841c22fc
0e7139bb-6d77-442d-b045-0ce8e85dc81c	78f9e3e5-5454-40b5-8c87-19761bba634e
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
locale	ru	a883921b-9de5-4ed2-a461-f9003a299f82	d1bfe30a-c6a3-4147-91ec-f6f074280ec5	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
57887784-c82a-4511-8a99-bd3a593bdcdc	\N	17fd57a2-0dff-47d1-9b62-80ab9f90207a	f	t	\N	\N	\N	c8810218-c378-437b-a906-f64e9cee8ae4	admin	1717564768642	\N	0
200dc6f6-b302-49cd-bda0-0272de3a292a	\N	17bd6bb2-187a-48ab-b6ef-26fa5e52d19c	f	t	\N	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	service-account-godigital	1717564869052	09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	0
a883921b-9de5-4ed2-a461-f9003a299f82	test@nomail.com	test@nomail.com	t	t	\N	\N	\N	16d92262-12b3-4f31-aa27-dc97588c55e9	test@nomail.com	1717565353654	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
d34638e7-5432-4650-8db7-cf5c2bb2a624	57887784-c82a-4511-8a99-bd3a593bdcdc
bc2a7f61-c0a2-4424-ae1a-95e49ba42b78	57887784-c82a-4511-8a99-bd3a593bdcdc
4bef87ff-0d0e-4d5e-ac76-7743087e8ff4	200dc6f6-b302-49cd-bda0-0272de3a292a
e4b52b6e-1a73-4502-9c55-bfd74d14e483	200dc6f6-b302-49cd-bda0-0272de3a292a
0a72ee0c-d998-4695-abef-1d7c5e2c7991	57887784-c82a-4511-8a99-bd3a593bdcdc
2c319180-070e-41c3-be28-bff227f471e6	57887784-c82a-4511-8a99-bd3a593bdcdc
e2c85d35-b0a9-43fe-9caf-d7ad38ca4e55	57887784-c82a-4511-8a99-bd3a593bdcdc
9097a82a-14d4-4ab4-b92c-0ed21649d6df	57887784-c82a-4511-8a99-bd3a593bdcdc
d12740fe-4577-4d13-9160-f47a163ead4e	57887784-c82a-4511-8a99-bd3a593bdcdc
7a15fb55-9b07-457b-a3bf-82441049c730	57887784-c82a-4511-8a99-bd3a593bdcdc
fad40945-7f18-4bed-828b-1d42cb13d266	57887784-c82a-4511-8a99-bd3a593bdcdc
33945840-512a-4232-b2b7-dfdf204557f2	57887784-c82a-4511-8a99-bd3a593bdcdc
4cb6c1e1-d810-45d9-9e24-9781b68cea8e	57887784-c82a-4511-8a99-bd3a593bdcdc
f729d762-516b-4ea0-885b-fb8a54b08925	57887784-c82a-4511-8a99-bd3a593bdcdc
8ff306be-d1dd-490e-8d56-99841e0082e4	57887784-c82a-4511-8a99-bd3a593bdcdc
2d9e0948-0cea-4cdd-b32f-c40afa56a3d4	57887784-c82a-4511-8a99-bd3a593bdcdc
74e3a350-3abd-439a-8604-dc8ffa0388f0	57887784-c82a-4511-8a99-bd3a593bdcdc
8f2291d2-3405-4bf9-aa6e-3a5877e3b469	57887784-c82a-4511-8a99-bd3a593bdcdc
c021282f-c1c7-406f-a047-237735b718f8	57887784-c82a-4511-8a99-bd3a593bdcdc
60487e5f-c214-48c8-874c-d96e723d3106	57887784-c82a-4511-8a99-bd3a593bdcdc
6e1ea6c3-57ac-4dfb-a972-d09e22019bdc	57887784-c82a-4511-8a99-bd3a593bdcdc
4bef87ff-0d0e-4d5e-ac76-7743087e8ff4	a883921b-9de5-4ed2-a461-f9003a299f82
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: godigital
--

COPY public.web_origins (client_id, value) FROM stdin;
06e80dfc-63e0-49ec-b5c4-803a77cec4ec	+
db962978-abd2-4625-8288-472315f9d100	+
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	http://godigital.local:3000
09bfdfc5-11dc-4ca5-a89d-029491cfcb8b	http://localhost:3000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: godigital
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: godigital
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

