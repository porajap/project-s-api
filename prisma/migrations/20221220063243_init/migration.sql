/*
  Warnings:

  - A unique constraint covering the columns `[MobileNo]` on the table `member` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `member_MobileNo_key` ON `member`(`MobileNo`);
