/* eslint-disable no-undef */

import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();

import { PrismaClient } from "@prisma/client";
import { comparePassword, hashPassword } from "../../utils/bcrypt.js";
const prisma = new PrismaClient({ log: ["error"] });

let refreshTokens = [];

export function generateAccessToken(user) {
  return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET);
}

export function generateRefreshToken(user) {
  const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET, {
    expiresIn: "20m",
  });
  refreshTokens.push(refreshToken);
  return refreshToken;
}

export function validateToken(req, res, next) {
  const authHeader = req.headers["authorization"] ?? "";
  if (authHeader === "") {
    res.status(403).send("Token invalid");
    return;
  }

  const token = authHeader.split(" ")[1];
  if (token == null) {
    res.sendStatus(400).send("Token not present");
    return;
  }

  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
    console.log(user);

    if (err) {
      res.status(403).send("Token invalid");
    } else {
      req.user = user;
      next();
    }
  });
}

export const login = async (req, res) => {
  const { phone, password } = req.body;

  const user = await prisma.member.findUnique({
    where: {
      MobileNo: phone,
    },
    select: {
      ID: true,
      ThFrist: true,
      ThLast: true,
      HnCode: true,
      password: true,
    },
  });

  if (!user)
    return res.status(401).json({
      error: true,
      message: "phone is invalid",
    });

  //check password
  const passwordDb = user.password;

  if (!comparePassword(password, passwordDb)) {
    res.status(401).json({
      error: true,
      message: "password is invalid",
    });

    return;
  }

  const payload = {
    userId: user.ID,
  };

  const accessToken = generateAccessToken(payload);
  res.status(200).json({
    error: false,
    message: "login success",
    accessToken,
    user,
  });
};

export const checkPhone = async (req, res) => {
  const { phone } = req.params;

  const user = await prisma.member.findUnique({
    where: {
      MobileNo: phone,
    },
    select: {
      ID: true,
      ThFrist: true,
      ThLast: true,
      HnCode: true,
      password: true,
    },
  });

  if (!user)
    return res.status(401).json({
      error: true,
      message: "phone is invalid",
    });

  return res.status(200).json({
    error: false,
    message: "checked phone",
    firstLogin: user.password === "" || user.password === null ? true : false,
    user,
  });
};

export const createPassword = async (req, res) => {
  const { phone, password } = req.body;

  const passwordHash = hashPassword(password);
  const result = await prisma.member.update({
    where: {
      MobileNo: phone,
    },
    data: {
      password: passwordHash,
    },
  });

  const user = await prisma.member.findUnique({
    where: {
      ID: result.ID,
    },
    select: {
      ID: true,
      ThFrist: true,
      ThLast: true,
      HnCode: true,
      password: true,
    },
  });

  const payload = {
    userId: user.ID,
  };

  const accessToken = generateAccessToken(payload);
  res.status(200).json({
    error: false,
    message: "create password success",
    accessToken,
    user,
  }); 
};
