/*
  Warnings:

  - A unique constraint covering the columns `[tg_channel_id,tg_post_id]` on the table `stat_reaction` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "stat_reaction_tg_post_id_key";

-- CreateIndex
CREATE UNIQUE INDEX "stat_reaction_tg_channel_id_tg_post_id_key" ON "stat_reaction"("tg_channel_id", "tg_post_id");
