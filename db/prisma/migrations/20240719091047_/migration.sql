/*
  Warnings:

  - You are about to drop the column `created_at` on the `stat_post` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "stat_post" DROP COLUMN "created_at",
ADD COLUMN     "date_of_post" TIMESTAMP(3);
