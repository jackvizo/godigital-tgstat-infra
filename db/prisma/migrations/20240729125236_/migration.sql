/*
  Warnings:

  - A unique constraint covering the columns `[tg_channel_id]` on the table `admin_event_log_cursor` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "admin_event_log_cursor_tg_channel_id_tg_last_event_id_key";

-- CreateIndex
CREATE UNIQUE INDEX "admin_event_log_cursor_tg_channel_id_key" ON "admin_event_log_cursor"("tg_channel_id");
