import { validateToken } from "../../controllers/auth/auth.controller.js";
import { Router } from "express";
import { getQueueToday, getRegisterAt, scanQr } from "../../controllers/queue/queue.controller.js";
const router = Router();

router.post("/scan-qr", validateToken, scanQr);
router.get("/register-at", validateToken, getRegisterAt);
router.get("/queue-today", validateToken, getQueueToday);

export default router; 
