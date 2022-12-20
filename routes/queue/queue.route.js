import { validateToken } from "../../controllers/auth/auth.controller.js";
import { Router } from "express";
import { scanQr } from "../../controllers/queue/queue.controller.js";
const router = Router();

router.post("/scan-qr", validateToken, scanQr);

export default router; 
