/*
  Warnings:

  - You are about to drop the column `config__tg_channel_pk` on the `config__tg_bot_session_pool` table. All the data in the column will be lost.
  - You are about to drop the column `session_bytes` on the `config__tg_bot_session_pool` table. All the data in the column will be lost.
  - The primary key for the `user_tg_channel` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `phone_number` on the `user_tg_channel` table. All the data in the column will be lost.
  - You are about to drop the `config__tg_channel` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_phone_number` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `user_id` to the `config__tg_bot_session_pool` table without a default value. This is not possible if the table is not empty.
  - Made the column `session_str` on table `config__tg_bot_session_pool` required. This step will fail if there are existing NULL values in that column.
  - Made the column `api_hash` on table `config__tg_bot_session_pool` required. This step will fail if there are existing NULL values in that column.
  - Made the column `api_id` on table `config__tg_bot_session_pool` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "config__tg_bot_session_pool" DROP CONSTRAINT "config__tg_bot_session_pool_config__tg_channel_pk_fkey";

-- DropForeignKey
ALTER TABLE "user_phone_number" DROP CONSTRAINT "user_phone_number_user_id_fkey";

-- AlterTable
ALTER TABLE "config__tg_bot_session_pool" DROP COLUMN "config__tg_channel_pk",
DROP COLUMN "session_bytes",
ADD COLUMN     "user_id" UUID NOT NULL,
ALTER COLUMN "session_str" SET NOT NULL,
ALTER COLUMN "api_hash" SET NOT NULL,
ALTER COLUMN "api_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "user_tg_channel" DROP CONSTRAINT "user_tg_channel_pkey",
DROP COLUMN "phone_number",
ADD COLUMN     "pk" BIGSERIAL NOT NULL,
ADD CONSTRAINT "user_tg_channel_pkey" PRIMARY KEY ("pk");

-- DropTable
DROP TABLE "config__tg_channel";

-- DropTable
DROP TABLE "user_phone_number";

-- CreateTable
CREATE TABLE "tg_channel__session" (
    "user_tg_channel_pk" BIGINT NOT NULL,
    "config__tg_bot_session_pool_pk" BIGINT NOT NULL,

    CONSTRAINT "tg_channel__session_pkey" PRIMARY KEY ("user_tg_channel_pk","config__tg_bot_session_pool_pk")
);

-- AddForeignKey
ALTER TABLE "tg_channel__session" ADD CONSTRAINT "tg_channel__session_user_tg_channel_pk_fkey" FOREIGN KEY ("user_tg_channel_pk") REFERENCES "user_tg_channel"("pk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tg_channel__session" ADD CONSTRAINT "tg_channel__session_config__tg_bot_session_pool_pk_fkey" FOREIGN KEY ("config__tg_bot_session_pool_pk") REFERENCES "config__tg_bot_session_pool"("pk") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "config__tg_bot_session_pool" ADD CONSTRAINT "config__tg_bot_session_pool_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
