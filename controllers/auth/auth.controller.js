/* eslint-disable no-undef */
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
dotenv.config();

import { comparePassword, hashPassword } from "../../utils/bcrypt.js";
import db from "../../db/database.js";

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

  let str = `SELECT
              ID,
              MobileNo,
              password, 
              ThFrist,
              ThLast,
              HnCode
            FROM
              member
              
            WHERE MobileNo = ?`;

  db.query(str, [phone], (err, results) => {
    if (err || results.length == 0) {
      return res.status(401).json({
        error: true,
        message: "phone is invalid",
      });
    } else {
      //check password
      const user = results[0];
      const passwordDb = user.password;

      if (!comparePassword(password, passwordDb)) {
        return res.status(401).json({
          error: true,
          message: "password is invalid",
        });
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
    }
  });
};

export const checkPhone = async (req, res) => {
  const { phone } = req.params;

  let str = `SELECT
              ID,
              MobileNo,
              password, 
              ThFrist,
              ThLast,
              HnCode
            FROM 
              member
              
            WHERE MobileNo = ?`;

  db.query(str, [phone], (err, results) => {
    if (err || results.length == 0) {
      return res.status(404).json({
        error: true,
        message: "phone is invalid",
      });
    } else {
      const user = results[0];

      return res.status(200).json({
        error: false,
        message: "checked phone",
        firstLogin:
          user.password === "" || user.password === null ? true : false,
        user,
      });
    }
  });
};

export const createPassword = async (req, res) => {
  const { phone, password } = req.body;

  const passwordHash = hashPassword(password);

  let str = `UPDATE member SET password = ? WHERE MobileNo = ?`;

  db.query(str, [passwordHash, phone], () => {
    let str = `SELECT
                  ID,
                  MobileNo,
                  password, 
                  ThFrist,
                  ThLast,
                  HnCode
                FROM
                  member
                  
                WHERE MobileNo = ?`;
    db.query(str, [phone], (err, results) => {
      const user = results[0];
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
    });
  });
};
