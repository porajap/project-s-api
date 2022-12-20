/*
  Warnings:

  - A unique constraint covering the columns `[CreateDate,MemberID]` on the table `queue` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `queue_CreateDate_MemberID_key` ON `queue`(`CreateDate`, `MemberID`);
