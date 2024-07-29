/*
  Warnings:

  - The primary key for the `admin_event_log_cursor` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - A unique constraint covering the columns `[tg_channel_id,tg_last_event_id]` on the table `admin_event_log_cursor` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "admin_event_log_cursor" DROP CONSTRAINT "admin_event_log_cursor_pkey",
ADD COLUMN     "pk" BIGSERIAL NOT NULL,
ADD CONSTRAINT "admin_event_log_cursor_pkey" PRIMARY KEY ("pk");

-- CreateIndex
CREATE UNIQUE INDEX "admin_event_log_cursor_tg_channel_id_tg_last_event_id_key" ON "admin_event_log_cursor"("tg_channel_id", "tg_last_event_id");
