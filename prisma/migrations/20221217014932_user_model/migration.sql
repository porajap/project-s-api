/*
  Warnings:

  - You are about to drop the `prefix` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_detail` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `user_detail` DROP FOREIGN KEY `user_detail_prefix_id_fkey`;

-- DropForeignKey
ALTER TABLE `user_detail` DROP FOREIGN KEY `user_detail_user_id_fkey`;

-- DropTable
DROP TABLE `prefix`;

-- DropTable
DROP TABLE `user_detail`;
