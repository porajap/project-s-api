/*
  Warnings:

  - Made the column `MemberID` on table `queue` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `queue` DROP FOREIGN KEY `queue_MemberID_fkey`;

-- AlterTable
ALTER TABLE `queue` MODIFY `MemberID` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `queue` ADD CONSTRAINT `queue_MemberID_fkey` FOREIGN KEY (`MemberID`) REFERENCES `member`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;
