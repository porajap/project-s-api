/* eslint-disable no-undef */

import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();

import { PrismaClient } from "@prisma/client";
import { comparePassword } from "../../utils/bcrypt.js";
const prisma = new PrismaClient({ log: ["error"] });

let refreshTokens = [];

export function generateAccessToken(user) {
  return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: "10m" });
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
  const { username, password } = req.body;

  const user = await prisma.user.findUnique({
    where: {
      username: username,
    },
    select: {
      id: true,
      username: true,
      password: true,
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

  if (!user)
    return res.status(401).json({
      error: true,
      message: "username is invalid",
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
    userId: user.id,
    username: user.username,
  };

  const accessToken = generateAccessToken({ user: payload });
  const refreshToken = generateRefreshToken({ user: payload });
  refreshTokens.push(refreshToken);

  res.status(200).json({
    error: false,
    message: "login success",
    accessToken,
    refreshToken,
  });
};

export const refreshToken = (req, res) => {
  const authHeader = req.headers["authorization"] ?? "";
  const token = authHeader.split(" ")[1];

  if (!token) return res.status(401).send({ error: "No token provided" });

  if (!refreshTokens.includes(token))
    return res.status(400).send("Refresh Token Invalid");

  //remove the old refreshToken from the refreshTokens list
  refreshTokens = refreshTokens.filter((c) => c != token);

  jwt.verify(token, process.env.REFRESH_TOKEN_SECRET, (err, user) => {
    if (err) return res.status(403).send("Token invalid");

    const accessToken = generateAccessToken({ user: user.user });
    const refreshToken = generateRefreshToken({ user: user.user });

    res.json({ accessToken, refreshToken });
  });
};

export const logout = (req, res) => {
  refreshTokens = refreshTokens.filter((c) => c != req.body.token);
  //remove the old refreshToken from the refreshTokens list
  res.status(204).send("Logged out!");
};
