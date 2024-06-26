-- AlterTable
CREATE SEQUENCE config__tg_bot_session_pool_pk_seq;
ALTER TABLE "config__tg_bot_session_pool" ALTER COLUMN "pk" SET DEFAULT nextval('config__tg_bot_session_pool_pk_seq');
ALTER SEQUENCE config__tg_bot_session_pool_pk_seq OWNED BY "config__tg_bot_session_pool"."pk";

-- AlterTable
CREATE SEQUENCE config__tg_channel_pk_seq;
ALTER TABLE "config__tg_channel" ALTER COLUMN "pk" SET DEFAULT nextval('config__tg_channel_pk_seq');
ALTER SEQUENCE config__tg_channel_pk_seq OWNED BY "config__tg_channel"."pk";

-- AlterTable
CREATE SEQUENCE stat_post_pk_seq;
ALTER TABLE "stat_post" ALTER COLUMN "pk" SET DEFAULT nextval('stat_post_pk_seq');
ALTER SEQUENCE stat_post_pk_seq OWNED BY "stat_post"."pk";

-- AlterTable
CREATE SEQUENCE stat_reaction_pk_seq;
ALTER TABLE "stat_reaction" ALTER COLUMN "pk" SET DEFAULT nextval('stat_reaction_pk_seq');
ALTER SEQUENCE stat_reaction_pk_seq OWNED BY "stat_reaction"."pk";

-- AlterTable
CREATE SEQUENCE stat_user_pk_seq;
ALTER TABLE "stat_user" ALTER COLUMN "pk" SET DEFAULT nextval('stat_user_pk_seq');
ALTER SEQUENCE stat_user_pk_seq OWNED BY "stat_user"."pk";
