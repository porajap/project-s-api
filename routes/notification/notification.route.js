import { Router } from "express";
import { addToken, sendNotification } from "../../controllers/notification/notification.controller.js";
import { validateToken } from "../../controllers/auth/auth.controller.js";

const router = Router();

router.post("/add-token", validateToken, addToken);
router.get("/send-notify/:roomId", sendNotification);

export default router;
