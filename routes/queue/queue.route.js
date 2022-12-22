import { validateToken } from "../../controllers/auth/auth.controller.js";
import { Router } from "express";
import { confirmQueue, getQueueDetail, getRegisterAt, scanQr } from "../../controllers/queue/queue.controller.js";
const router = Router();

router.post("/scan-qr", validateToken, scanQr);
router.post("/queue-today", validateToken, getQueueDetail);
router.post("/confirm-queue", validateToken, confirmQueue);
router.get("/register-at", validateToken, getRegisterAt);

export default router;
