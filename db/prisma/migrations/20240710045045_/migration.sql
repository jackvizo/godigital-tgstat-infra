/*
  Warnings:

  - Added the required column `phone_number` to the `user_tg_channel` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "user_tg_channel" ADD COLUMN     "phone_number" TEXT NOT NULL;
