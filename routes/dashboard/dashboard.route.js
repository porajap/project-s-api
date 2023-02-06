import { Router } from "express";
import {
  dataOfYear,
  dataOfDay,
  login,
} from "../../controllers/dashboard/dashboard.controller.js";
import { validateToken } from "../../controllers/auth/auth.controller.js";

const router = Router();

router.post("/login", login);

router.get("/data-of-year/:year", validateToken, dataOfYear);

router.get("/data-of-day", validateToken, dataOfDay);

export default router;
