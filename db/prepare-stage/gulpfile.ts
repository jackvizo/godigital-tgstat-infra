import gulp from "gulp";
import { exec } from "child_process";
import { promisify } from "util";
import dotenv from "dotenv";
import { depersonalize } from "./depersonalize";
import * as fs from "fs";

dotenv.config();

process.env.DATABASE_URL = "postgresql://postgres:postgres@localhost:54321/postgres";

const execPromise = promisify(exec);

gulp.task("create-prod-dump", async () => {
  try {
    const { PROD_DB_HOST, PROD_DB_USER, PROD_DB_PASSWORD, PROD_DB_NAME, PROD_DB_PORT } = process.env;

    if (!PROD_DB_HOST || !PROD_DB_USER || !PROD_DB_PASSWORD || !PROD_DB_NAME || !PROD_DB_PORT) {
      throw new Error(
        "Please ensure that PROD_DB_HOST, PROD_DB_PORT, PROD_DB_USER, PROD_DB_PASSWORD, and PROD_DB_NAME are set in the .env file."
      );
    }

    // Команда для создания дампа только таблиц из схемы public
    const dumpCommand = `docker exec -e PGPASSWORD=${PROD_DB_PASSWORD} -e PGSSLMODE=verify-full -t godigital-postgres pg_dump -h ${PROD_DB_HOST} -U ${PROD_DB_USER} -d ${PROD_DB_NAME} -p ${PROD_DB_PORT} --schema=public > ./prod_dump.sql`;
    await execPromise(dumpCommand);
    console.log("Database dump from the public schema created successfully.");
  } catch (error: any) {
    console.error("An error occurred during dump creation:", error.message);
  }
});

gulp.task("drop-local-tables", async () => {
  try {
    const {
      POSTGRES_DB: LOCAL_DB_HOST,
      POSTGRES_USER: LOCAL_DB_USER,
      POSTGRES_PASSWORD: LOCAL_DB_PASSWORD,
      POSTGRES_DB: LOCAL_DB_NAME,
    } = process.env;

    if (!LOCAL_DB_HOST || !LOCAL_DB_USER || !LOCAL_DB_PASSWORD || !LOCAL_DB_NAME) {
      throw new Error(
        "Please ensure that LOCAL_DB_HOST, LOCAL_DB_USER, LOCAL_DB_PASSWORD, and LOCAL_DB_NAME are set in the .env file."
      );
    }

    // Команда для удаления всех таблиц в схеме public локальной базы данных
    const dropTablesCommand = `
      docker exec -e PGPASSWORD=${LOCAL_DB_PASSWORD} -t godigital-postgres psql -h ${LOCAL_DB_HOST} -p 5432 -U ${LOCAL_DB_USER} -d ${LOCAL_DB_NAME} -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
    `;
    await execPromise(dropTablesCommand);
    console.log("All tables in the public schema of the local database have been dropped.");
  } catch (error: any) {
    console.error("An error occurred while dropping tables in the local database:", error.message);
  }
});

gulp.task("import-prod-dump", async () => {
  try {
    const {
      POSTGRES_DB: LOCAL_DB_HOST,
      POSTGRES_USER: LOCAL_DB_USER,
      POSTGRES_PASSWORD: LOCAL_DB_PASSWORD,
      POSTGRES_DB: LOCAL_DB_NAME,
    } = process.env;

    if (!LOCAL_DB_HOST || !LOCAL_DB_USER || !LOCAL_DB_PASSWORD || !LOCAL_DB_NAME) {
      throw new Error(
        "Please ensure that LOCAL_DB_HOST, LOCAL_DB_USER, LOCAL_DB_PASSWORD, and LOCAL_DB_NAME are set in the .env file."
      );
    }

    // Команда для импорта дампа в локальную базу данных
    const importCommand = `docker exec -e PGPASSWORD=${LOCAL_DB_PASSWORD} -i godigital-postgres psql -h ${LOCAL_DB_HOST} -p 5432 -U ${LOCAL_DB_USER} -d ${LOCAL_DB_NAME} < ./prod_dump.sql`;
    await execPromise(importCommand);
    console.log("Production dump imported into the local database successfully.");
  } catch (error: any) {
    console.error("An error occurred during dump import:", error.message);
  }
});

gulp.task("run-depersonalization", depersonalize);

gulp.task("export-local-dump", async () => {
  try {
    const {
      POSTGRES_DB: LOCAL_DB_HOST,
      POSTGRES_USER: LOCAL_DB_USER,
      POSTGRES_PASSWORD: LOCAL_DB_PASSWORD,
      POSTGRES_DB: LOCAL_DB_NAME,
    } = process.env;

    if (!LOCAL_DB_HOST || !LOCAL_DB_USER || !LOCAL_DB_PASSWORD || !LOCAL_DB_NAME) {
      throw new Error(
        "Please ensure that LOCAL_DB_HOST, LOCAL_DB_USER, LOCAL_DB_PASSWORD, and LOCAL_DB_NAME are set in the .env file."
      );
    }

    // Команда для импорта дампа в локальную базу данных
    const dumpCommand = `docker exec -e PGPASSWORD=postgres -t godigital-postgres pg_dump -h localhost -U postgres -d postgres -p 5432 --schema=public > ./local_dump.sql`;

    await execPromise(dumpCommand);
    console.log("Local dump exported");
  } catch (error: any) {
    console.error("An error occurred during local dump export:", error.message);
  }
});

gulp.task("delete-prod-dump", async () => {
  try {
    fs.unlinkSync("./prod_dump.sql");
  } catch (error: any) {
    console.error("An error occurred during delete prod dumo:", error.message);
  }
});

gulp.task(
  "default",
  gulp.series(
    "create-prod-dump",
    "drop-local-tables",
    "import-prod-dump",
    "run-depersonalization",
    "export-local-dump",
    "delete-prod-dump"
  )
);
// gulp.task("default", gulp.series("export-local-dump", "delete-prod-dump"));
