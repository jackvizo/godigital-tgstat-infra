/*
  Warnings:

  - Added the required column `user_id` to the `tg_invite_link_group` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "tg_invite_link_group" ADD COLUMN     "user_id" UUID NOT NULL;

-- AddForeignKey
ALTER TABLE "tg_invite_link_group" ADD CONSTRAINT "tg_invite_link_group_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
