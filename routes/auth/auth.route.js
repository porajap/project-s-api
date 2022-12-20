import { Router } from "express";
import {
  checkPhone,
  createPassword,
  login,
} from "../../controllers/auth/auth.controller.js";

const router = Router();

router.post("/login", login);
router.get("/check-phone/:phone", checkPhone);
router.post("/create-password", createPassword);

export default router;
