/* eslint-disable no-undef */
import express from "express";
import cors from "cors";
import bodyParser from "body-parser";
import dotenv from "dotenv";
dotenv.config();

const PORT = process.env.TOKEN_SERVER_PORT || 4000;
const app = express();

app.use(express.json());''
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
  res.json({ message: "Welcome" });
});

import authRoute from "./routes/auth/auth.route.js";
app.use("/api/auth", authRoute);

import qRoute from "./routes/queue/queue.route.js";
app.use("/api/queue", qRoute);

import fcmRoute from "./routes/notification/notification.route.js";
app.use("/api/notification", fcmRoute);

app.listen(PORT, () => console.log(`App is listening on PORT ${PORT}`));
