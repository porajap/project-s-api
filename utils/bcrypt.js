import { hashSync, compareSync } from "bcrypt";
const saltRounds = 1;

export const hashPassword = (myPlaintextPassword) => {
  return hashSync(myPlaintextPassword, saltRounds);
};

export const comparePassword = (myPlaintextPassword, passwordHash) => {
  return compareSync(myPlaintextPassword, passwordHash);
};
