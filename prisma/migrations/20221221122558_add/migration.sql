/*
  Warnings:

  - Made the column `CreateDate` on table `queue` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX `register_at_organizeId_fkey` ON `register_at`;

-- AlterTable
ALTER TABLE `queue` MODIFY `CreateDate` DATE NOT NULL;

-- CreateIndex
CREATE INDEX `register_at_MemberID_organizeId_idx` ON `register_at`(`MemberID`, `organizeId`);

-- AddForeignKey
ALTER TABLE `register_at` ADD CONSTRAINT `register_at_organizeId_fkey` FOREIGN KEY (`organizeId`) REFERENCES `organization`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;
