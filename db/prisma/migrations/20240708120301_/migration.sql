/*
  Warnings:

  - You are about to drop the column `api_hash` on the `config__tg_bot_session_pool` table. All the data in the column will be lost.
  - You are about to drop the column `api_id` on the `config__tg_bot_session_pool` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "config__tg_bot_session_pool" DROP COLUMN "api_hash",
DROP COLUMN "api_id";
