/*
  Warnings:

  - You are about to drop the column `tg_last_event_id` on the `stat_channel` table. All the data in the column will be lost.
  - Added the required column `tg_last_admin_log_event_id` to the `stat_channel` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "stat_channel" DROP COLUMN "tg_last_event_id",
ADD COLUMN     "tg_last_admin_log_event_id" BIGINT NOT NULL;
