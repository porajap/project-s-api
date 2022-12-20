/*
  Warnings:

  - Made the column `organization_type_id` on table `organization` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `organization` MODIFY `organization_type_id` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `register_at` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `MemberID` INTEGER NOT NULL,
    `organizeId` INTEGER NOT NULL,

    PRIMARY KEY (`ID`, `MemberID`, `organizeId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `register_at` ADD CONSTRAINT `register_at_organizeId_fkey` FOREIGN KEY (`organizeId`) REFERENCES `organization`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `organization` ADD CONSTRAINT `organization_organization_type_id_fkey` FOREIGN KEY (`organization_type_id`) REFERENCES `organization_type`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
