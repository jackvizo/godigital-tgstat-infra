/*
  Warnings:

  - You are about to drop the column `link` on the `stat_post` table. All the data in the column will be lost.
  - You are about to drop the column `media` on the `stat_post` table. All the data in the column will be lost.
  - You are about to drop the column `message` on the `stat_post` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "stat_post" DROP COLUMN "link",
DROP COLUMN "media",
DROP COLUMN "message";

-- CreateTable
CREATE TABLE "stat_post_info" (
    "pk" BIGSERIAL NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "date_of_post" TIMESTAMP(3),
    "tg_post_id" BIGINT NOT NULL,
    "tg_channel_id" BIGINT NOT NULL,
    "message" TEXT,
    "link" TEXT,
    "media" TEXT,

    CONSTRAINT "stat_post_info_pkey" PRIMARY KEY ("pk")
);
