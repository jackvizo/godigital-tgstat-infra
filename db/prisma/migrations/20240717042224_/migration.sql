/*
  Warnings:

  - Added the required column `tg_channel_title` to the `user_tg_channel` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "tg_channel__session" DROP CONSTRAINT "tg_channel__session_user_tg_channel_pk_fkey";

-- AlterTable
ALTER TABLE "user_tg_channel" ADD COLUMN     "tg_channel_title" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "tg_channel__session" ADD CONSTRAINT "tg_channel__session_user_tg_channel_pk_fkey" FOREIGN KEY ("user_tg_channel_pk") REFERENCES "user_tg_channel"("pk") ON DELETE CASCADE ON UPDATE CASCADE;
