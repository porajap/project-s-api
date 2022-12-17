import { Router } from "express";
import { validateToken } from "../../controllers/auth/auth.controller.js";
import { getUsers, register } from "../../controllers/user/user.controller.js";

const router = Router();

router.get("/all-user", validateToken, getUsers);
router.post("/register", register);

export default router;
