const path = require("path");
const projectRoot = path.join(__dirname, "..");
const infraRoot = path.join(__dirname);

const postgresEnv = {
  POSTGRES_PORT: process.env.POSTGRES_PORT,
  POSTGRES_PASSWORD: process.env.POSTGRES_PASSWORD,
  POSTGRES_DB: process.env.POSTGRES_DB,
  POSTGRES_USER: process.env.POSTGRES_USER,
  POSTGRES_HOST: process.env.POSTGRES_HOST,
};

const databaseNetworkEnv = {
  HOST_DOCKER_INTERNAL: process.env.HOST_DOCKER_INTERNAL,
  DATABASE_URL_IN_HOST_MACHINE_NETWORK: process.env.DATABASE_URL_IN_HOST_MACHINE_NETWORK,
  DATABASE_URL_IN_DOCKER_NETWORK: process.env.DATABASE_URL_IN_DOCKER_NETWORK,
};

const prismaEnv = {
  ...postgresEnv,
  ...databaseNetworkEnv,
  DATABASE_URL: process.env.PRISMA_DATABASE_URL,
};

const keycloakEnv = {
  HOST_DOCKER_INTERNAL: process.env.HOST_DOCKER_INTERNAL,

  KEYCLOAK_POSTGRES_PORT: process.env.KEYCLOAK_POSTGRES_PORT,
  KEYCLOAK_POSTGRES_PASSWORD: process.env.KEYCLOAK_POSTGRES_PASSWORD,
  KEYCLOAK_POSTGRES_DB: process.env.KEYCLOAK_POSTGRES_DB,
  KEYCLOAK_POSTGRES_USER: process.env.KEYCLOAK_POSTGRES_USER,
  KEYCLOAK_POSTGRES_HOST: process.env.KEYCLOAK_POSTGRES_HOST,
  KEYCLOAK_POSTGRES_URL: process.env.KEYCLOAK_POSTGRES_URL,

  KEYCLOAK_PORT: process.env.KEYCLOAK_PORT,
  KEYCLOAK_USER: process.env.KEYCLOAK_USER,
  KEYCLOAK_PASSWORD: process.env.KEYCLOAK_PASSWORD,

  KEYCLOAK_GODIGITAL_HOSTNAME: process.env.KEYCLOAK_GODIGITAL_HOSTNAME,
};

const hasuraEnv = {
  ...databaseNetworkEnv,
  NEXTJS_PORT: process.env.NEXTJS_PORT,
  HASURA_PORT: process.env.HASURA_PORT,
  HASURA_GRAPHQL_DATABASE_URL: process.env.HASURA_GRAPHQL_DATABASE_URL,
  HASURA_GRAPHQL_ADMIN_SECRET: process.env.HASURA_GRAPHQL_ADMIN_SECRET,
  HASURA_ACTIONS_BASE_URL: process.env.HASURA_ACTIONS_BASE_URL,
  HASURA_GRAPHQL_JWT_SECRETS: process.env.HASURA_GRAPHQL_JWT_SECRETS,
  HASURA_KEYCLOAK_CERTS_URL: process.env.HASURA_KEYCLOAK_CERTS_URL,
  NEXTJS_BACKEND_TOKEN: process.env.NEXTJS_BACKEND_TOKEN,
  HASURA_PREFECT_URL: process.env.HASURA_PREFECT_URL,
  HASURA_GRAPHQL_CORS_DOMAIN: process.env.HASURA_GRAPHQL_CORS_DOMAIN,
};

const prefectEnv = {
  ANALYTICS_APP_DATABASE_URL: process.env.PREFECT_ANALYTICS_APP_DATABASE_URL,
};

const frontendEnv = {
  NEXTJS_PORT: process.env.NEXTJS_PORT,
  HASURA_PORT: process.env.HASURA_PORT,
  KEYCLOAK_PORT: process.env.KEYCLOAK_PORT,
  NEXTAUTH_SECRET: process.env.NEXTJS_NEXTAUTH_SECRET,
  NEXTAUTH_URL: process.env.NEXTJS_NEXTAUTH_URL,
  KEYCLOAK_ID: process.env.NEXTJS_KEYCLOAK_ID,
  KEYCLOAK_SECRET: process.env.NEXTJS_KEYCLOAK_SECRET,
  KEYCLOAK_ISSUER: process.env.NEXTJS_KEYCLOAK_ISSUER,
  LOG_LEVEL: process.env.NEXTJS_LOG_LEVEL,
  NEXTJS_BASE_URL: process.env.NEXTJS_BASE_URL,
  NEXT_PUBLIC_YOOKASSA_REDIRECT_URL: process.env.NEXTJS_NEXT_PUBLIC_YOOKASSA_REDIRECT_URL,
  HASURA_SCHEMA_URL: process.env.NEXTJS_HASURA_SCHEMA_URL,
  HASURA_GRAPHQL_ADMIN_SECRET: process.env.HASURA_GRAPHQL_ADMIN_SECRET,
  NEXT_PUBLIC_HASURA_GQL_WS_URL: process.env.NEXTJS_NEXT_PUBLIC_HASURA_GQL_WS_URL,
  NEXT_PUBLIC_HASURA_GQL_HTTP_URL: process.env.NEXTJS_NEXT_PUBLIC_HASURA_GQL_HTTP_URL,
  NEXT_PUBLIC_HASURA_REST_URL: process.env.NEXTJS_NEXT_PUBLIC_HASURA_REST_URL,
  NEXT_PUBLIC_DEVTOOLS: process.env.NEXT_PUBLIC_DEVTOOLS,
  BACKEND_TOKEN_HEADER: process.env.NEXTJS_BACKEND_TOKEN_HEADER,
  BACKEND_TOKEN: process.env.NEXTJS_BACKEND_TOKEN,
  AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE: process.env.NEXTJS_AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE,
  PREFECT_URL: process.env.NEXTJS_PREFECT_URL,
  NEXT_PUBLIC_FEEDBACK_EMAIL: process.env.FEEDBACK_EMAIL,
  KEYCLOAK_ADMIN_USER: process.env.NEXTJS_KEYCLOAK_ADMIN_USER,
  KEYCLOAK_ADMIN_PASSWORD: process.env.NEXTJS_KEYCLOAK_ADMIN_PASSWORD,
  KEYCLOAK_ADMIN_CLI_URL: process.env.NEXTJS_KEYCLOAK_ADMIN_CLI_URL,
};

/**
 * @type {{services: { env: Partial<NodeJS.ProcessEnv>, path: string, name: string; envFilename?: string }[]}}
 * */
const config = {
  services: [
    {
      name: "frontend",
      path: path.join(projectRoot, "godigital-frontend"),
      env: {
        ...frontendEnv,
        PRISMA_OUT: process.env.PRISMA_OUT,
        DATABASE_URL: process.env.PRISMA_DATABASE_URL,
      },
    },
    {
      name: "prisma",
      path: path.join(infraRoot, "db"),
      env: {
        ...prismaEnv,
        PRISMA_OUT: process.env.PRISMA_OUT,
      },
    },
    {
      name: "docker-local",
      path: path.join(infraRoot, "docker", "godigital-docker"),
      env: {
        ...postgresEnv,
        ...keycloakEnv,
        ...hasuraEnv,

        NEXTJS_PORT: frontendEnv.NEXTJS_PORT,
        HASURA_PORT: frontendEnv.HASURA_PORT,
        KEYCLOAK_PORT: frontendEnv.KEYCLOAK_PORT,
        NEXTJS_NEXTAUTH_SECRET: frontendEnv.NEXTAUTH_SECRET,
        NEXTJS_NEXTAUTH_URL: frontendEnv.NEXTAUTH_URL,
        NEXTJS_KEYCLOAK_ID: frontendEnv.KEYCLOAK_ID,
        NEXTJS_KEYCLOAK_SECRET: frontendEnv.KEYCLOAK_SECRET,
        NEXTJS_KEYCLOAK_ISSUER: process.env.NEXTJS_DOCKER_KEYCLOAK_ISSUER,
        NEXTJS_LOG_LEVEL: frontendEnv.LOG_LEVEL,
        NEXTJS_BASE_URL: frontendEnv.NEXTJS_BASE_URL,
        NEXTJS_NEXT_PUBLIC_YOOKASSA_REDIRECT_URL: frontendEnv.NEXT_PUBLIC_YOOKASSA_REDIRECT_URL,
        NEXTJS_HASURA_SCHEMA_URL: frontendEnv.HASURA_SCHEMA_URL,
        HASURA_GRAPHQL_ADMIN_SECRET: frontendEnv.HASURA_GRAPHQL_ADMIN_SECRET,
        NEXTJS_NEXT_PUBLIC_HASURA_GQL_WS_URL: process.env.NEXTJS_DOCKER_NEXT_PUBLIC_HASURA_GQL_WS_URL,
        NEXTJS_NEXT_PUBLIC_HASURA_GQL_HTTP_URL: process.env.NEXTJS_DOCKER_NEXT_PUBLIC_HASURA_GQL_HTTP_URL,
        NEXTJS_NEXT_PUBLIC_HASURA_REST_URL: process.env.NEXTJS_DOCKER_NEXT_PUBLIC_HASURA_REST_URL,
        NEXT_PUBLIC_DEVTOOLS: frontendEnv.NEXT_PUBLIC_DEVTOOLS,
        NEXTJS_BACKEND_TOKEN_HEADER: frontendEnv.BACKEND_TOKEN_HEADER,
        NEXTJS_BACKEND_TOKEN: frontendEnv.BACKEND_TOKEN,
        NEXTJS_AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE: frontendEnv.AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE,
        NEXTJS_PREFECT_URL: frontendEnv.PREFECT_URL,
        NEXTJS_KEYCLOAK_ADMIN_USER: frontendEnv.KEYCLOAK_ADMIN_USER,
        NEXTJS_KEYCLOAK_ADMIN_PASSWORD: frontendEnv.KEYCLOAK_ADMIN_PASSWORD,
        NEXTJS_KEYCLOAK_ADMIN_CLI_URL: frontendEnv.KEYCLOAK_ADMIN_CLI_URL,

        FEEDBACK_EMAIL: frontendEnv.NEXT_PUBLIC_FEEDBACK_EMAIL,

        PREFECT_PORT: process.env.PREFECT_PORT,
        PREFECT_ANALYTICS_APP_DATABASE_URL: process.env.PREFECT_DOCKER_ANALYTICS_APP_DATABASE_URL,

        MAILDEV_APP_PORT: process.env.MAILDEV_APP_PORT,
        MAILDEV_SMTP_PORT: process.env.MAILDEV_SMTP_PORT,

        PREFECT_SMTP_HOST: process.env.SMTP_HOST,
        PREFECT_SMTP_PORT: process.env.SMTP_PORT,
        PREFECT_SMTP_USERNAME: process.env.SMTP_USERNAME,
        PREFECT_SMTP_PASSWORD: process.env.SMTP_PASSWORD,
      },
    },
    {
      name: "docker-prod",
      path: path.join(infraRoot, "docker", "godigital-docker-prod"),
      env: {
        ...keycloakEnv,
        ...hasuraEnv,

        NEXTJS_PORT: frontendEnv.NEXTJS_PORT,
        HASURA_PORT: frontendEnv.HASURA_PORT,
        KEYCLOAK_PORT: frontendEnv.KEYCLOAK_PORT,
        NEXTJS_NEXTAUTH_SECRET: frontendEnv.NEXTAUTH_SECRET,
        NEXTJS_NEXTAUTH_URL: frontendEnv.NEXTAUTH_URL,
        NEXTJS_KEYCLOAK_ID: frontendEnv.KEYCLOAK_ID,
        NEXTJS_KEYCLOAK_SECRET: frontendEnv.KEYCLOAK_SECRET,
        NEXTJS_KEYCLOAK_ISSUER: frontendEnv.KEYCLOAK_ISSUER,
        NEXTJS_LOG_LEVEL: frontendEnv.LOG_LEVEL,
        NEXTJS_NEXT_PUBLIC_YOOKASSA_REDIRECT_URL: frontendEnv.NEXT_PUBLIC_YOOKASSA_REDIRECT_URL,
        NEXTJS_HASURA_SCHEMA_URL: frontendEnv.HASURA_SCHEMA_URL,
        HASURA_GRAPHQL_ADMIN_SECRET: frontendEnv.HASURA_GRAPHQL_ADMIN_SECRET,
        NEXTJS_NEXT_PUBLIC_HASURA_GQL_WS_URL: frontendEnv.NEXT_PUBLIC_HASURA_GQL_WS_URL,
        NEXTJS_NEXT_PUBLIC_HASURA_GQL_HTTP_URL: frontendEnv.NEXT_PUBLIC_HASURA_GQL_HTTP_URL,
        NEXTJS_NEXT_PUBLIC_HASURA_REST_URL: frontendEnv.NEXT_PUBLIC_HASURA_REST_URL,
        NEXT_PUBLIC_DEVTOOLS: frontendEnv.NEXT_PUBLIC_DEVTOOLS,
        NEXTJS_BACKEND_TOKEN_HEADER: frontendEnv.BACKEND_TOKEN_HEADER,
        NEXTJS_BACKEND_TOKEN: frontendEnv.BACKEND_TOKEN,
        NEXTJS_AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE: frontendEnv.AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE,
        NEXTJS_PREFECT_URL: frontendEnv.PREFECT_URL,
        NEXTJS_KEYCLOAK_ADMIN_USER: frontendEnv.KEYCLOAK_ADMIN_USER,
        NEXTJS_KEYCLOAK_ADMIN_PASSWORD: frontendEnv.KEYCLOAK_ADMIN_PASSWORD,
        NEXTJS_KEYCLOAK_ADMIN_CLI_URL: frontendEnv.KEYCLOAK_ADMIN_CLI_URL,
        FEEDBACK_EMAIL: frontendEnv.NEXT_PUBLIC_FEEDBACK_EMAIL,

        PREFECT_PORT: process.env.PREFECT_PORT,
        PREFECT_ANALYTICS_APP_DATABASE_URL: process.env.PREFECT_DOCKER_ANALYTICS_APP_DATABASE_URL,

        PREFECT_SMTP_HOST: process.env.SMTP_HOST,
        PREFECT_SMTP_PORT: process.env.SMTP_PORT,
        PREFECT_SMTP_USERNAME: process.env.SMTP_USERNAME,
        PREFECT_SMTP_PASSWORD: process.env.SMTP_PASSWORD,
      },
    },
    {
      name: "hasura-cli",
      path: path.join(infraRoot, "hasura"),
      env: {
        ...hasuraEnv,
      },
    },
    {
      name: "prefect",
      path: path.join(projectRoot, "godigital-prefect"),
      env: {
        PORT: process.env.PREFECT_PORT,
        ...prefectEnv,
      },
    },
    {
      name: "tests",
      path: path.join(projectRoot, "godigital-tests"),
      env: {
        DB_USER: postgresEnv.POSTGRES_USER,
        DB_HOST: postgresEnv.POSTGRES_HOST,
        DB_DATABASE: postgresEnv.POSTGRES_DB,
        DB_PASSWORD: postgresEnv.POSTGRES_PASSWORD,
        DB_PORT: postgresEnv.POSTGRES_PORT,
      },
    },
  ],
};
module.exports = config;
