-- CreateTable
CREATE TABLE "user" (
    "id" UUID NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_tg_channel" (
    "user_id" UUID NOT NULL,
    "tg_channel_id" BIGINT NOT NULL,

    CONSTRAINT "user_tg_channel_pkey" PRIMARY KEY ("user_id","tg_channel_id")
);

-- CreateTable
CREATE TABLE "stat_user" (
    "pk" BIGINT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "joined_at" TIMESTAMP(3),
    "left_at" TIMESTAMP(3),
    "tg_user_id" BIGINT NOT NULL,
    "tg_channel_id" BIGINT NOT NULL,
    "first_name" TEXT,
    "last_name" TEXT,
    "username" TEXT,
    "scam" BOOLEAN,
    "premium" BOOLEAN,
    "verified" BOOLEAN,
    "is_joined_by_link" BOOLEAN,
    "phone" TEXT,
    "invite_link" TEXT,

    CONSTRAINT "stat_user_pkey" PRIMARY KEY ("pk")
);

-- CreateTable
CREATE TABLE "stat_post" (
    "pk" BIGINT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tg_post_id" BIGINT NOT NULL,
    "tg_channel_id" BIGINT NOT NULL,
    "message" TEXT NOT NULL,
    "views" INTEGER NOT NULL,
    "views_1h" INTEGER NOT NULL,
    "view_24h" INTEGER NOT NULL,
    "total_reactions_count" INTEGER NOT NULL,
    "reactions_1h" INTEGER NOT NULL,
    "reaction_24h" INTEGER NOT NULL,
    "comments_messages_count" INTEGER NOT NULL,
    "comments_users_count" INTEGER NOT NULL,
    "comments_channels_count" INTEGER NOT NULL,
    "comments_messages_count_1h" INTEGER NOT NULL,
    "comments_messages_count_24h" INTEGER NOT NULL,
    "link" TEXT NOT NULL,
    "media" TEXT NOT NULL,
    "forwards" INTEGER NOT NULL,

    CONSTRAINT "stat_post_pkey" PRIMARY KEY ("pk")
);

-- CreateTable
CREATE TABLE "stat_reaction" (
    "pk" BIGINT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tg_post_id" BIGINT NOT NULL,
    "tg_channel_id" BIGINT NOT NULL,
    "reaction_count" INTEGER NOT NULL,
    "reaction_emoticon" TEXT NOT NULL,
    "reaction_emoticon_code" INTEGER NOT NULL,

    CONSTRAINT "stat_reaction_pkey" PRIMARY KEY ("pk")
);

-- CreateTable
CREATE TABLE "config__tg_channel" (
    "pk" BIGINT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tg_channel_id" BIGINT NOT NULL,
    "tg_channel_name" TEXT NOT NULL,

    CONSTRAINT "config__tg_channel_pkey" PRIMARY KEY ("pk")
);

-- CreateTable
CREATE TABLE "config__tg_bot_session_pool" (
    "pk" BIGINT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "api_id" TEXT NOT NULL,
    "api_hash" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "session_bytes" BYTEA,
    "status" TEXT NOT NULL DEFAULT 'enabled',
    "config__tg_channel_pk" BIGINT,

    CONSTRAINT "config__tg_bot_session_pool_pkey" PRIMARY KEY ("pk")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_id_key" ON "user"("id");

-- AddForeignKey
ALTER TABLE "user_tg_channel" ADD CONSTRAINT "user_tg_channel_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "config__tg_bot_session_pool" ADD CONSTRAINT "config__tg_bot_session_pool_config__tg_channel_pk_fkey" FOREIGN KEY ("config__tg_channel_pk") REFERENCES "config__tg_channel"("pk") ON DELETE SET NULL ON UPDATE CASCADE;
