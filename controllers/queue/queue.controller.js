import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient({ log: ["error", "query"] });

export const scanQr = async (req, res) => {
  const { userId } = req.user;
  const { qNumber, organizeId } = req.body;

  let date = formatDate(new Date());

  const queue = await prisma.queue.findUnique({
    select: {
      ID: true,
    },
    where: {
      queueOfToDay: {
        MemberID: userId,
        CreateDate: new Date(date),
        organization_id: +organizeId,
      },
    },
  });

  console.log("queue", queue);

  if (queue) {
    res.status(200).json({
      error: true,
      message: "Queue already exists",
    });
    return;
  }

  await prisma.queue.create({
    data: {
      MemberID: userId,
      QueueNo: qNumber,
      CreateDate: new Date(),
      Modify_DateTime: new Date(),
      organization_id: +organizeId,
    },
  });

  res.status(200).json({
    error: false,
    message: "scan successful",
  });
};

function formatDate(date) {
  var d = new Date(date),
    month = "" + (d.getMonth() + 1),
    day = "" + d.getDate(),
    year = d.getFullYear();

  if (month.length < 2) month = "0" + month;
  if (day.length < 2) day = "0" + day;

  return [year, month, day].join("-");
}
