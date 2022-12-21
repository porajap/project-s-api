import { validateToken } from "../../controllers/auth/auth.controller.js";
import { Router } from "express";
import { getQueueDetail, scanQr } from "../../controllers/queue/queue.controller.js";
const router = Router();

router.post("/scan-qr", validateToken, scanQr);
router.post("/queue-today", validateToken, getQueueDetail);

export default router;
