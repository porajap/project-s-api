import { PrismaClient } from "@prisma/client";
import { hashPassword } from "../../utils/bcrypt.js";
const prisma = new PrismaClient({ log: ["error"] });

export const getUsers = async (req, res) => {
  const users = await prisma.user.findMany({
    select: {
      username: true,
      userDetail: {
        select: {
          fName: true,
          lName: true,
          prefix: {
            select: {
              name: true,
              sortName: true,
            },
          },
        },
      },
    },
  });

  res.json({
    users,
  });
};

export const register = async (req, res) => {
  const { prefix, fName, lName, username, password } = req.body;

  const passwordHash = hashPassword(password);

  try {
    const result = await prisma.user.create({
      data: {
        username: username,
        password: passwordHash,
        userDetail: {
          create: {
            prefixId: +prefix,
            fName: fName,
            lName: lName,
          },
        },
      },
    });

    res.json({
      error: false,
      message: "created user successful",
      result,
    });
  } catch (err) {
    console.log(err);
    res.json({
      error: true,
      message: "username already exists",
    });
  }
};
