import db from "../../db/database.js";
import { hashPassword, comparePassword } from "../../utils/bcrypt.js";
import jwt from "jsonwebtoken";

export const dataOfYear = async (req, res) => {
  let { year } = req.params;

  const { id, phone, organizeId } = req.user;

  const chartMenAwait = getDataOfYearFromDB(year, "male", organizeId);
  const chartFemaleAwait = getDataOfYearFromDB(year, "female", organizeId);

  const results = await Promise.all([chartMenAwait, chartFemaleAwait]);

  const data = {
    error: false,
    status: 200,
    message: `data of year ${year}`,
    data: {
      men: results[0],
      female: results[1],
    },
  };
  res.status(200).json(data);
};

export const dataOfDay = async (req, res) => {
  const { id, phone, organizeId } = req.user;

  const getTimeUsedMaxMinAwait = getTimeUsedMaxMinOfDayFromDB(organizeId);
  const getCountMaleAwait = getCountPatientOfDayFromDB("Male", organizeId);
  const getCountFemaleAwait = getCountPatientOfDayFromDB("Female", organizeId);

  const results = await Promise.all([
    getTimeUsedMaxMinAwait,
    getCountMaleAwait,
    getCountFemaleAwait,
  ]);

  const timesUse = results[0];
  const countMale = results[1];
  const countFemale = results[2];

  let maxMin = {};
  if (timesUse !== null) {
    maxMin = {
      min: timesUse[0],
      max: timesUse[timesUse.length - 1],
    };
  }

  const data = {
    error: false,
    status: 200,
    message: `data of the day last updated ${new Date().toLocaleTimeString()}`,
    data: {
      maxMin,
      count: {
        male: countMale || 0,
        female: countFemale || 0,
      },
      lastUpdated: new Date().toLocaleTimeString(),
    },
  };

  res.status(200).json(data);
};

export const login = async (req, res) => {
  const username = req.body.username;
  const password = String(req.body.password);

  const loginData = await createToken(username, password);

  res.send(loginData);
};

const createToken = (username, password) => {
  let loginData = {};
  var payload = {};

  console.log(username, password);

  return new Promise(async (resolve) => {
    await db.query(
      `SELECT 

        employee.*,
        organization.Name AS organizeName,
        organization.organization_type_id,
        organization_type.format,
        organization_type_name
          
      FROM employee 
      
      INNER JOIN organization
      ON employee.organization_id = organization.ID

      INNER JOIN organization_type 
      ON organization_type.id = organization.organization_type_id

      WHERE employee.username = ? LIMIT 1`,
      [username],
      async (err, results) => {
        if (err || results.length == 0) {
          console.log(err);
          loginData = {
            error: true,
            message: "username is invalid",
          };
          resolve(loginData);
        } else {
          const userData = results[0];

          let passwordHash = userData.password;
          let isNext = comparePassword(password, passwordHash);

          if (!isNext) {
            loginData = {
              error: true,
              message: "password is invalid",
            };
            resolve(loginData);
          }

          payload = {
            id: userData.ID,
            phone: userData.MobileNo,
            organizeId: userData.organization_id,
          };

          const apiToken = jwt.sign(payload, process.env.ACCESS_TOKEN_SECRET);

          loginData = {
            error: false,
            message: "login success",
            token: apiToken,
            data: {
              phone: userData.MobileNo,
              fName: userData.FirstName,
              lName: userData.LastName,
              organizeName: userData.organizeName,
              format: userData.format,
              typeName: userData.organization_type_name,
            },
          };

          resolve(loginData);
        }
      }
    );
  });
};

const getDataOfYearFromDB = (year, gender, organizeId) => {
  return new Promise(async (resolve) => {
    const str = `SELECT
  
              DATE_FORMAT(q.CreateDate, '%Y-%m') AS qDate,
              YEAR(q.CreateDate) AS year,
              MONTH(q.CreateDate) AS month,
              MONTHNAME(q.CreateDate) AS monthName,
              COUNT(q.MemberID) AS total
          
          FROM queue q
          
          INNER JOIN member
          ON q.MemberID = member.ID
          
          WHERE q.Confirm = 1
          
          AND LOWER(member.EnGender) = ?

          AND YEAR(q.CreateDate) = ?

          AND member.organization_id = ?
          
          GROUP BY YEAR(q.CreateDate), MONTH(q.CreateDate)`;

    const params = [gender, year, organizeId];

    db.query(str, params, (err, result) => {
      if (err || result.length == 0) {
        resolve(null);
      }

      resolve(result);
    });
  });
};

const getTimeUsedMaxMinOfDayFromDB = (organizeId) => {
  return new Promise(async (resolve) => {
    const str = `SELECT
  
                    detail.StartTime AS startTime,
                    detail.EndTime AS endTime,
                    ROUND((TIME_TO_SEC(detail.EndTime) - TIME_TO_SEC(detail.StartTime))/60, 2) AS minutes,
                    TIMEDIFF(detail.EndTime, detail.StartTime) AS timeDiff
                  
                  FROM queue_detail detail
                  
                  INNER JOIN (SELECT ID, organization_id FROM queue) queue 
                  ON queue.ID = detail.queueId 

                  WHERE DATE(detail.CreateDate) = DATE(NOW())
                  
                  AND detail.Success = 1

                  AND queue.organization_id = ?
                  
                  ORDER BY minutes`;

    db.query(str, [organizeId], (err, result) => {
      if (err || result.length == 0) {
        resolve(null);
      }

      resolve(result);
    });
  });
};

const getCountPatientOfDayFromDB = (sex, organizeId) => {
  return new Promise(async (resolve) => {
    const str = `SELECT 

                  COUNT(MemberID) count
                
                FROM queue q
                
                INNER JOIN member ON member.ID = q.MemberID 
                
                WHERE DATE(q.CreateDate) = DATE(NOW())

                AND member.EnGender = ?

                AND member.organization_id = ?
                
                GROUP BY member.EnGender`;

    db.query(str, [sex, organizeId], (err, results) => {
      if (err || results.length == 0) {
        resolve(0);
      }

      console.log(results);
      resolve(results[0] ? results[0].count : 0);
    });
  });
};
