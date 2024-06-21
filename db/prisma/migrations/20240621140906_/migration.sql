-- AlterTable
CREATE SEQUENCE tg_invite_link_group_pk_seq;
ALTER TABLE "tg_invite_link_group" ALTER COLUMN "pk" SET DEFAULT nextval('tg_invite_link_group_pk_seq');
ALTER SEQUENCE tg_invite_link_group_pk_seq OWNED BY "tg_invite_link_group"."pk";

-- AlterTable
CREATE SEQUENCE user_tg_invite_link_pk_seq;
ALTER TABLE "user_tg_invite_link" ALTER COLUMN "pk" SET DEFAULT nextval('user_tg_invite_link_pk_seq');
ALTER SEQUENCE user_tg_invite_link_pk_seq OWNED BY "user_tg_invite_link"."pk";
