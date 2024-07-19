/*
  Warnings:

  - A unique constraint covering the columns `[tg_channel_id,tg_post_id]` on the table `stat_post_info` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "stat_post_info_tg_channel_id_tg_post_id_key" ON "stat_post_info"("tg_channel_id", "tg_post_id");
