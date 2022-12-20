/*
  Warnings:

  - A unique constraint covering the columns `[CreateDate,MemberID,organization_id]` on the table `queue` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `queue_detail` DROP FOREIGN KEY `queue_detail_qId_fkey`;

-- DropIndex
DROP INDEX `queue_CreateDate_MemberID_key` ON `queue`;

-- CreateIndex
CREATE UNIQUE INDEX `queue_CreateDate_MemberID_organization_id_key` ON `queue`(`CreateDate`, `MemberID`, `organization_id`);

-- AddForeignKey
ALTER TABLE `queue_detail` ADD CONSTRAINT `queue_detail_qId_fkey` FOREIGN KEY (`qId`) REFERENCES `queue`(`ID`) ON DELETE CASCADE ON UPDATE CASCADE;
