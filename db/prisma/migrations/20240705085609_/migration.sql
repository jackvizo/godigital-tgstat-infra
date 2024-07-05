-- CreateTable
CREATE TABLE "user_phone_number" (
    "pk" BIGSERIAL NOT NULL,
    "user_id" UUID NOT NULL,
    "phone_number" TEXT NOT NULL,

    CONSTRAINT "user_phone_number_pkey" PRIMARY KEY ("pk")
);

-- AddForeignKey
ALTER TABLE "user_phone_number" ADD CONSTRAINT "user_phone_number_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
