-- CreateTable
CREATE TABLE `user` (
    `user_code` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `is_active` BOOLEAN NOT NULL DEFAULT true,

    UNIQUE INDEX `user_user_code_key`(`user_code`),
    UNIQUE INDEX `user_username_key`(`username`),
    PRIMARY KEY (`user_code`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_detail` (
    `id` VARCHAR(191) NOT NULL,
    `user_id` VARCHAR(191) NOT NULL,
    `f_name` VARCHAR(191) NOT NULL DEFAULT '',
    `l_name` VARCHAR(191) NOT NULL DEFAULT '',
    `prefix_id` INTEGER NOT NULL,

    UNIQUE INDEX `user_detail_id_key`(`id`),
    UNIQUE INDEX `user_detail_user_id_key`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `prefix` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL DEFAULT '',
    `sortName` VARCHAR(191) NOT NULL DEFAULT '',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `user_detail` ADD CONSTRAINT `user_detail_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`user_code`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `user_detail` ADD CONSTRAINT `user_detail_prefix_id_fkey` FOREIGN KEY (`prefix_id`) REFERENCES `prefix`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
