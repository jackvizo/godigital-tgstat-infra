-- AlterTable
ALTER TABLE "stat_post_info" ADD COLUMN     "comments_channels_count" INTEGER,
ADD COLUMN     "comments_messages_count" INTEGER,
ADD COLUMN     "comments_messages_count_1h" INTEGER,
ADD COLUMN     "comments_messages_count_24h" INTEGER,
ADD COLUMN     "comments_users_count" INTEGER,
ADD COLUMN     "forwards" INTEGER,
ADD COLUMN     "reaction_24h" INTEGER,
ADD COLUMN     "reactions_1h" INTEGER,
ADD COLUMN     "total_reactions_count" INTEGER,
ADD COLUMN     "view_24h" INTEGER,
ADD COLUMN     "views" INTEGER,
ADD COLUMN     "views_1h" INTEGER;
