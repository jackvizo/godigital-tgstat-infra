-- CreateTable
CREATE TABLE "stat_channel" (
    "pk" BIGSERIAL NOT NULL,
    "tg_channel_id" BIGINT NOT NULL,
    "total_participants" BIGINT NOT NULL,

    CONSTRAINT "stat_channel_pkey" PRIMARY KEY ("pk")
);

-- CreateIndex
CREATE UNIQUE INDEX "stat_channel_tg_channel_id_key" ON "stat_channel"("tg_channel_id");
