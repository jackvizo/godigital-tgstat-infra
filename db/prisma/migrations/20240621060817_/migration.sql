-- CreateTable
CREATE TABLE "user_tg_invite_link" (
    "pk" BIGINT NOT NULL,
    "user_id" UUID NOT NULL,
    "tg_invite_link" TEXT NOT NULL,
    "group_id" BIGINT NOT NULL,

    CONSTRAINT "user_tg_invite_link_pkey" PRIMARY KEY ("pk")
);

-- CreateTable
CREATE TABLE "tg_invite_link_group" (
    "pk" BIGINT NOT NULL,
    "group_name" TEXT NOT NULL,

    CONSTRAINT "tg_invite_link_group_pkey" PRIMARY KEY ("pk")
);

-- AddForeignKey
ALTER TABLE "user_tg_invite_link" ADD CONSTRAINT "user_tg_invite_link_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_tg_invite_link" ADD CONSTRAINT "user_tg_invite_link_group_id_fkey" FOREIGN KEY ("group_id") REFERENCES "tg_invite_link_group"("pk") ON DELETE RESTRICT ON UPDATE CASCADE;
