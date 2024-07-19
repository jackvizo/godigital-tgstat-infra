-- AlterTable
ALTER TABLE "stat_post" ALTER COLUMN "message" DROP NOT NULL,
ALTER COLUMN "views" DROP NOT NULL,
ALTER COLUMN "views_1h" DROP NOT NULL,
ALTER COLUMN "view_24h" DROP NOT NULL,
ALTER COLUMN "total_reactions_count" DROP NOT NULL,
ALTER COLUMN "reactions_1h" DROP NOT NULL,
ALTER COLUMN "reaction_24h" DROP NOT NULL,
ALTER COLUMN "comments_messages_count" DROP NOT NULL,
ALTER COLUMN "comments_users_count" DROP NOT NULL,
ALTER COLUMN "comments_channels_count" DROP NOT NULL,
ALTER COLUMN "comments_messages_count_1h" DROP NOT NULL,
ALTER COLUMN "comments_messages_count_24h" DROP NOT NULL,
ALTER COLUMN "link" DROP NOT NULL,
ALTER COLUMN "media" DROP NOT NULL,
ALTER COLUMN "forwards" DROP NOT NULL;

-- AlterTable
ALTER TABLE "stat_reaction" ALTER COLUMN "reaction_count" DROP NOT NULL,
ALTER COLUMN "reaction_emoticon" DROP NOT NULL,
ALTER COLUMN "reaction_emoticon_code" DROP NOT NULL;
