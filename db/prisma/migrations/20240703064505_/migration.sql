/*
  Warnings:

  - A unique constraint covering the columns `[tg_user_id]` on the table `stat_user` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "stat_user_tg_user_id_key" ON "stat_user"("tg_user_id");
