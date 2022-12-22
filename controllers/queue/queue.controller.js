import db from "../../db/database.js";

export const scanQr = async (req, res) => {
  const { userId } = req.user;
  const { qNumber, organizeId } = req.body;

  let str =
    "SELECT COUNT(QueueNo) AS countQ FROM queue WHERE QueueNo = ? AND CreateDate = DATE(NOW()) AND organization_id = ?";

  db.query(str, [qNumber, organizeId], (err, results) => {
    const countQ = results[0].countQ;
    if (countQ > 0) {
      return res.status(200).json({
        error: true,
        status: 200,
        message: "duplicate",
      });
    }

    str =
      "INSERT INTO queue (MemberID, QueueNo, CreateDate, ExamRoomID, Confirm, Modify_DateTime, organization_id)VALUES(?)";
    const params = [
      userId,
      `${qNumber}`,
      new Date(),
      1,
      0,
      new Date(),
      organizeId,
    ];
    db.query(str, [params], (err, ressult) => {
      return res.status(200).json({
        error: true,
        status: 200,
        message: `created`,
      });
    });
  });
};

export const getQueueDetail = async (req, res) => {
  const { userId } = req.user;
  const { organizeId } = req.body;

  let str = `SELECT 
              queue.ID AS id,
              QueueNo AS queueNo,
              MemberID AS memberId,
              queue.ExamRoomID AS roomId,
              room.Name AS roomName,
              DATE_FORMAT(queue.CreateDate, '%Y-%m-%d') AS createdAt,
              DATE_FORMAT(queue.Modify_DateTime, '%d/%m/%Y') AS dateAt,
              TIME_FORMAT(queue.Modify_DateTime, '%H:%i') AS timeAt,
              IF(queue.Confirm = 1, 1, 0) AS isConfirm
              
              FROM queue
              
              INNER JOIN examination_room room
              ON queue.ExamRoomID = room.ID
              
              WHERE queue.MemberID = ? AND queue.organization_id = ?

              AND DATE(queue.CreateDate) = DATE(NOW())`;

  db.query(str, [userId, organizeId], (err, results) => {
    if (err || results.length == 0) {
      return res.status(400).json({
        error: false,
        message: "queue not found",
        data: null,
      });
    }
    const queue = results[0];
    const queueId = queue.id;

    str = `SELECT 
  
              queue_detail.ID AS id,
              ExamRoomID AS roomId,
              room.Name AS roomName,
              DATE_FORMAT(StartTime, '%d/%m/%Y, %H:%i') AS startTime,
              DATE_FORMAT(EndTime, '%d/%m/%Y, %H:%i') AS endTime,
              qNo AS queueOfRoom,
              IF(Success, 1, 0) AS isSuccess
              
            FROM queue_detail
            
            INNER JOIN examination_room room
            ON queue_detail.ExamRoomID = room.ID
            
            WHERE DATE(queue_detail.CreateDate) = DATE(NOW())
            
            AND queue_detail.queueId = ?
            
            AND queue_detail.Success = 0`;

    db.query(str, [queueId], (err, results) => {
      let detail = null;
      let queueFront = 0;
      if (err || results.length == 0) {
        detail = null;
      } else {
        detail = results[0];

        const qNo = detail.queueOfRoom;
        const qNumber = queue.queueNo;
        str = `SELECT 

                COUNT(qd.qNo) AS countFrontQueue
                
                FROM queue q 
                
                INNER JOIN queue_detail qd 
                ON qd.queueId = q.ID 
                
                WHERE DATE(q.Modify_DateTime) = DATE(NOW()) 
                
                AND qd.QueueNo != ?
                                    
                AND qd.Success = 0
                
                AND qd.qNo < ?`;

        db.query(str, [qNumber, qNo], (err, results) => {
          if (err || results.length == 0) {
            queueFront = 0;
          } else {
            queueFront = results[0].countFrontQueue;
            detail.queueFront = queueFront;
          }

          return res.status(400).json({
            error: false,
            message: "queue detail",
            data: { queue, detail },
          });
        });
      }
    });
  });
};

export const confirmQueue = async (req, res) => {
  const { userId } = req.user;
  const { qNumber, qId, organizeId, roomId } = req.body;

  let str = `UPDATE queue SET 
                Confirm = 1,
                Modify_DateTime = NOW()
              WHERE MemberID = ?
              AND ID = ?`;
  db.query(str, [userId, qId], () => {
    let str = `SELECT 

    COALESCE(MAX(qNo), 0) + 1 AS nextQueue
    
   FROM queue q
   
   INNER JOIN queue_detail qd ON qd.queueId = q.ID
   
   WHERE q.Confirm = 1
   
   AND q.organization_id = ? AND qd.ExamRoomID = ?`;

    db.query(str, [organizeId, roomId], (err, results) => {
      let nextQueue = results[0].nextQueue;

      const str =
        "INSERT INTO queue_detail (CreateDate, ExamRoomID, QueueNo, qNo, Modify_DateTime, StartTime, queueId)VALUES(?)";
      const params = [
        new Date(),
        roomId,
        `${qNumber}`,
        nextQueue,
        new Date(),
        new Date(),
        qId,
      ];

      console.log([params]);

      db.query(str, [params], (err, result) => {
        return res.status(400).json({
          error: false,
          message: "confirm successful",
        });
      });
    });
  });
};
