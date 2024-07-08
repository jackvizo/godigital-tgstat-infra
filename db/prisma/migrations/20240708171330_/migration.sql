-- DropForeignKey
ALTER TABLE "config__tg_bot_session_pool" DROP CONSTRAINT "config__tg_bot_session_pool_config__tg_channel_pk_fkey";

-- AddForeignKey
ALTER TABLE "config__tg_bot_session_pool" ADD CONSTRAINT "config__tg_bot_session_pool_config__tg_channel_pk_fkey" FOREIGN KEY ("config__tg_channel_pk") REFERENCES "config__tg_channel"("pk") ON DELETE CASCADE ON UPDATE CASCADE;
