import { Router } from "express";
import { login, logout, refreshToken } from "../../controllers/auth/auth.controller.js";

const router = Router();

router.post("/login", login);
router.post("/refresh-token", refreshToken);
router.delete("/logout", logout);

export default router;
