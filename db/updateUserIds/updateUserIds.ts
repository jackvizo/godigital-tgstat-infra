import dotenv from "dotenv";
import { PrismaClient } from "@prisma/client";
dotenv.config();

process.env.DATABASE_URL = "postgresql://postgres:postgres@localhost:54321/postgres";

const prisma = new PrismaClient();

async function updateUserIds(productionUserId: string, testUserId: string) {
  try {
    // --- jackvizo added
    // Обновляем связи в таблице user
    await prisma.user.updateMany({
      where: { id: productionUserId },
      data: { id: testUserId },
    });
    // ---

    // Обновляем связи в таблице user_tg_channel
    await prisma.user_tg_channel.updateMany({
      where: { user_id: productionUserId },
      data: { user_id: testUserId },
    });

    // Обновляем связи в таблице user_tg_invite_link
    await prisma.user_tg_invite_link.updateMany({
      where: { user_id: productionUserId },
      data: { user_id: testUserId },
    });

    // Обновляем связи в таблице tg_invite_link_group
    await prisma.tg_invite_link_group.updateMany({
      where: { user_id: productionUserId },
      data: { user_id: testUserId },
    });

    // Обновляем связи в таблице config__tg_bot_session_pool
    await prisma.config__tg_bot_session_pool.updateMany({
      where: { user_id: productionUserId },
      data: { user_id: testUserId },
    });

    console.log("User ID replacement completed successfully");
  } catch (error) {
    console.error("An error occurred while updating user IDs:", error);
  } finally {
    await prisma.$disconnect();
  }
}

// Получаем productionUserId и testUserId из аргументов командной строки
const productionUserId = process.argv[2];
const testUserId = process.argv[3];

if (!productionUserId || !testUserId) {
  console.error("Please provide productionUserId and testUserId as arguments");
  process.exit(1);
}

updateUserIds(productionUserId, testUserId)
  .then(() => {
    process.exit(0);
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
