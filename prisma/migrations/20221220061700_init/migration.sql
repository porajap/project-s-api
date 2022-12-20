/*
  Warnings:

  - You are about to drop the `channel` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `days` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `display_calling_queue` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `employee` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `font` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `group` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `hardware` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `hardware_type` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ipservice` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `manage_queue` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `manage_sound` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `member_copy` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `mode` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `printer_speed` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `program` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `program_detail` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `service` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `slip` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `slip_detail` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sound` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sound_design` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sound_design_detail` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sound_design_setting` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sound_type` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `wait_queue` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE `channel`;

-- DropTable
DROP TABLE `days`;

-- DropTable
DROP TABLE `display_calling_queue`;

-- DropTable
DROP TABLE `employee`;

-- DropTable
DROP TABLE `font`;

-- DropTable
DROP TABLE `group`;

-- DropTable
DROP TABLE `hardware`;

-- DropTable
DROP TABLE `hardware_type`;

-- DropTable
DROP TABLE `ipservice`;

-- DropTable
DROP TABLE `manage_queue`;

-- DropTable
DROP TABLE `manage_sound`;

-- DropTable
DROP TABLE `member_copy`;

-- DropTable
DROP TABLE `mode`;

-- DropTable
DROP TABLE `printer_speed`;

-- DropTable
DROP TABLE `program`;

-- DropTable
DROP TABLE `program_detail`;

-- DropTable
DROP TABLE `service`;

-- DropTable
DROP TABLE `slip`;

-- DropTable
DROP TABLE `slip_detail`;

-- DropTable
DROP TABLE `sound`;

-- DropTable
DROP TABLE `sound_design`;

-- DropTable
DROP TABLE `sound_design_detail`;

-- DropTable
DROP TABLE `sound_design_setting`;

-- DropTable
DROP TABLE `sound_type`;

-- DropTable
DROP TABLE `wait_queue`;

-- AddForeignKey
ALTER TABLE `queue` ADD CONSTRAINT `queue_MemberID_fkey` FOREIGN KEY (`MemberID`) REFERENCES `member`(`ID`) ON DELETE SET NULL ON UPDATE CASCADE;
