import { PrismaClient } from "@prisma/client";
import { faker } from "@faker-js/faker";

const prisma = new PrismaClient();

export async function depersonalize() {
  try {
    // Удаляем все записи из таблиц с живыми продакшн авторизациями
    await prisma.tg_channel__session.deleteMany({});
    await prisma.config__tg_bot_session_pool.deleteMany({});

    const users = await prisma.stat_user.findMany();

    for (const user of users) {
      await prisma.stat_user.update({
        where: { pk: user.pk },
        data: {
          first_name: faker.person.firstName(),
          last_name: faker.person.lastName(),
          username: faker.internet.userName(),
          phone: faker.string.numeric("1##########"),
        },
      });
    }

    const inviteLinks = await prisma.user_tg_invite_link.findMany();
    for (const link of inviteLinks) {
      const updatedLink =
        link.tg_invite_link.length > 22
          ? link.tg_invite_link.slice(0, 22) + "X".repeat(link.tg_invite_link.length - 22)
          : link.tg_invite_link;

      await prisma.user_tg_invite_link.update({
        where: { pk: link.pk },
        data: { tg_invite_link: updatedLink },
      });
    }

    console.log("Depersonalization completed successfully. Sensitive sessions have been deleted.");
  } catch (error) {
    console.error("An error occurred during depersonalization:", error);
    throw error;
  } finally {
    await prisma.$disconnect();
  }
}
