/*
  Warnings:

  - You are about to drop the `admin_event_log_cursor` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `tg_last_event_id` to the `stat_channel` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "stat_channel" ADD COLUMN     "tg_last_event_id" BIGINT NOT NULL;

-- DropTable
DROP TABLE "admin_event_log_cursor";
