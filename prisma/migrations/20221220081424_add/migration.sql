/*
  Warnings:

  - Made the column `organization_id` on table `queue` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE `register_at` DROP FOREIGN KEY `register_at_organizeId_fkey`;

-- AlterTable
ALTER TABLE `queue` MODIFY `organization_id` INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE `queue` ADD CONSTRAINT `queue_organization_id_fkey` FOREIGN KEY (`organization_id`) REFERENCES `organization`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;
