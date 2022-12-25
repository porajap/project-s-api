import db from "../../db/database.js";

export const addToken = async (req, res) => {
  const { userId } = req.user;

  let countToken = await checkHasTokenUser(userId, req);

  if (countToken > 0) {
    return res.status(200).json({
      error: false,
      message: "User has token",
    });
  }
  await insertToken(userId, req);
  res.status(200).json({
    error: false,
    message: "Inserted user token",
  });

  console.log(countToken);
};

const checkHasTokenUser = async (userId, req) => {
  return new Promise(async (resolve) => {
    const str = `SELECT COUNT(id) AS countToken
                  FROM member_token_device
                  WHERE member_id = ? 
                  AND fcm_token = ?`;

    const { token } = req.body;
    const params = [userId, token];

    db.query(str, [...params], (err, result) => {
      if (err) {
        resolve(0);
      }
      resolve(result[0].countToken);
    });
  });
};

const insertToken = (userId, req) => {
  return new Promise(async (resolve) => {
    const str = `INSERT INTO member_token_device (member_id, platform, fcm_token, created_at)VALUES(?)`;

    const { token, platform } = req.body;
    const params = [userId, `${platform}`, `${token}`, new Date()];

    db.query(str, [params], (err, result) => {
      resolve(result);
    });
  });
};

export const sendNotification = async (req, res) => {
  const serverKey =
    "AAAAnNlZYhA:APA91bHkIoO-DlZ0JswYJZ5MGmhO1LbFfrBl799EhiKH8IeeGYvO5PF6il3lkglE5TV5L514z4AUFdYo7G0M0p-ZmSIiJNyrZ6jkoY1zovPJ-qw7WdblHUxRBSFVH7RFSGOUwrEBDguV";

  var fcm = new FCM(serverKey);

  const queueDetail = await getQueueDetailForSendNotify(req);

  const queueDetailIdList = [];

  console.log(queueDetail);

  for (let data of queueDetail) {
    queueDetailIdList.push(data.queueDetailId);

    if (data.isSendNotify == 0) {
      let tokens = await getTokenDeviceOfUser(data.memberId);

      let message = {
        registration_ids: tokens,
        priority: "high",
        notification: {
          title: data.roomName,
          body: "ใกล้จะถึงคิวของคุณแล้ว กรุณารอใกล้จุดนัด",
          sound: "default",
        },
      };

      fcm.send(message, function (err, response) {
        if (err) {
          console.log(err);
        } else {
          console.log("Send successfully");
        }
      });
    }
  }

  if (queueDetailIdList.length > 0) {
    await updateQueueDetailWhenSendNotify(queueDetailIdList);
  }

  res.json({ error: false, message: "Send successfully" });
};

const getQueueDetailForSendNotify = async (req) => {
  return new Promise(async (resolve) => {
    const { roomId } = req.params;

    let str = `SELECT 
                  queue_detail.ID AS queueDetailId,
                  queue.MemberID AS memberId,
                  queue_detail.QueueNo AS queueNo,
                  room.Name AS roomName,
                  IsSendNotify AS isSendNotify
  
                FROM queue
  
                INNER JOIN queue_detail
                ON queue.QueueNo = queue_detail.QueueNo 
                AND DATE(queue.CreateDate) =  DATE(queue_detail.CreateDate)
  
                INNER JOIN examination_room room
                ON queue_detail.ExamRoomID = room.ID
  
                WHERE DATE(queue.CreateDate) = DATE(NOW())
                AND queue_detail.Success = 0
  
                AND room.ID = ?
  
                GROUP BY queue.ID
  
                LIMIT 5`;

    db.query(str, [roomId], (err, results) => {
      if (err) {
        resolve([]);
      }

      resolve(results);
    });
  });
};

const getTokenDeviceOfUser = async (userId) => {
  return new Promise(async (resolve) => {
    let str = `SELECT 
                      device.fcm_token AS token
  
                  FROM member_token_device device
  
                  WHERE device.member_id = ?`;

    db.query(str, [userId], (err, results) => {
      if (err) {
        resolve([]);
      }

      let deviceTokens = [];

      if (results.length > 0) {
        for (let result of results) {
          deviceTokens.push(result.token);
        }
      }

      resolve(deviceTokens);
    });
  });
};

const updateQueueDetailWhenSendNotify = async (data) => {
  return new Promise(async (resolve) => {
    let str = `UPDATE queue_detail SET IsSendNotify = 1 WHERE ID IN(?)`;

    db.query(str, [data], (err, result) => {
      resolve(result);
    });
  });
};
