/* eslint-disable no-undef */
import express from "express";
import cors from "cors";
import bodyParser from "body-parser";
import dotenv from "dotenv";
dotenv.config();

const PORT = process.env.TOKEN_SERVER_PORT;
const app = express();

import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient({ log: ["query", "error"] });

app.use(express.json());''
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
  res.json({ message: "Welcome" });
});

import authRoute from "./routes/auth/auth.route.js";
app.use("/api/auth", authRoute);

import userRoute from "./routes/user/user.route.js";
app.use("/api/user", userRoute);

app.get("/init", async (req, res) => {
  await prisma.prefix.createMany({
    data: [
      {
        name: "นาย",
        sortName: "นาย",
      },
      {
        name: "นาง",
        sortName: "นาง",
      },
      {
        name: "นางสาว",
        sortName: "น.ส.",
      },
    ],
    skipDuplicates: true,
  });

  res.json({
    message: "First initial successful",
  });
});

app.listen(PORT, () => console.log(`App is listening on PORT ${PORT}`));
