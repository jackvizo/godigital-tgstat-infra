import { exec } from "child_process";
import { promisify } from "util";

const execPromise = promisify(exec);

export async function applyDump() {
  try {
    const { LOCAL_DB_HOST, LOCAL_DB_PORT, LOCAL_DB_USER, LOCAL_DB_PASSWORD, LOCAL_DB_NAME } = process.env;

    if (!LOCAL_DB_HOST || !LOCAL_DB_USER || !LOCAL_DB_PASSWORD || !LOCAL_DB_NAME || !LOCAL_DB_PORT) {
      throw new Error(
        "Please ensure that LOCAL_DB_HOST, LOCAL_DB_USER, LOCAL_DB_PASSWORD, LOCAL_DB_PORT, and LOCAL_DB_NAME are set in the .env file."
      );
    }

    const importCommand = `PGPASSWORD=${LOCAL_DB_PASSWORD} psql -h ${LOCAL_DB_HOST} -U ${LOCAL_DB_USER} -d ${LOCAL_DB_NAME} < prepare-stage/depersonalized_dump.sql`;
    await execPromise(importCommand);
    console.log("Depersonalized data imported into local database successfully.");
  } catch (error: any) {
    console.error("An error occurred during dump import:", error.message);
  }
}
