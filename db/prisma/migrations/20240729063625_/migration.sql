-- CreateTable
CREATE TABLE "admin_event_log_cursor" (
    "tg_channel_id" BIGINT NOT NULL,
    "tg_last_event_id" BIGINT NOT NULL,

    CONSTRAINT "admin_event_log_cursor_pkey" PRIMARY KEY ("tg_channel_id","tg_last_event_id")
);
