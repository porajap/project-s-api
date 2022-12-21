-- CreateTable
CREATE TABLE `channel` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `channel_name` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `days` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `day_th` VARCHAR(30) NULL DEFAULT '',
    `day_en` VARCHAR(30) NULL DEFAULT '',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `display_calling_queue` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `ExamRoomID` INTEGER NOT NULL,
    `ShowDateTime` BIT(1) NULL,
    `ShowVdo` BIT(1) NULL,
    `VdoURL` VARCHAR(255) NULL,
    `ShowRoomName` BIT(1) NULL,
    `ShowOrderno` BIT(1) NULL,
    `ShowQueueNo` BIT(1) NULL,
    `ShowWaitTime` BIT(1) NULL,
    `ShowUrgentCase` BIT(1) NULL,
    `ShowReserve` BIT(1) NULL,
    `ShowCounter` BIT(1) NULL,
    `RowQty` INTEGER NULL,
    `Table_width` INTEGER NULL,
    `DateTimeFontSize` INTEGER NULL,
    `RoomNameFontSize` INTEGER NULL,
    `RowtheadFontSize` INTEGER NULL,
    `RowtbodyFontSize` INTEGER NULL,
    `FontStyle` INTEGER NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `employee` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `IDCard` VARCHAR(50) NULL,
    `organization_id` INTEGER NULL,
    `FirstName` VARCHAR(50) NULL,
    `LastName` VARCHAR(50) NULL,
    `Address` VARCHAR(250) NULL,
    `DateOfBlrth` DATE NULL,
    `username` VARCHAR(20) NULL,
    `MobileNo` VARCHAR(10) NULL,
    `password` VARCHAR(100) NULL,
    `Modify_DateTime` DATETIME(0) NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `font` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(255) NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `group` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `group` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hardware` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `mc_name` VARCHAR(255) NULL DEFAULT '',
    `ipaddress` VARCHAR(255) NULL,
    `port` VARCHAR(255) NULL,
    `detail` VARCHAR(255) NULL,
    `sound_design_id` INTEGER NULL,
    `m_type_id` INTEGER NULL,
    `length` FLOAT NULL,
    `length_now` FLOAT NULL,
    `length_alert` FLOAT NULL,
    `speed_id` INTEGER NULL,
    `channel_id` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `hardware_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ipservice` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `mcid` INTEGER NULL,
    `q_type_id` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `manage_queue` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `mode_id` INTEGER NULL,
    `range1` INTEGER NULL,
    `range2` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `manage_sound` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sound_id` INTEGER NULL,
    `group_id` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mode` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `mode` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `printer_speed` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `speed` DOUBLE NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `program` (
    `id` INTEGER NULL,
    `service_id` INTEGER NULL,
    `range1` INTEGER NULL,
    `range2` INTEGER NULL,
    `service_time` INTEGER NULL,
    `start_time` VARCHAR(5) NULL,
    `end_time` VARCHAR(5) NULL,
    `days_id` INTEGER NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `program_detail` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `program_id` INTEGER NULL,
    `channel_id` INTEGER NULL,
    `important` INTEGER NULL DEFAULT 0,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `service` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `service_name` VARCHAR(255) NULL,
    `Description` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `slip` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL,
    `width` INTEGER NULL,
    `height` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `slip_detail` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `slip_id` INTEGER NULL,
    `i_type` INTEGER NULL,
    `text` VARCHAR(255) NULL DEFAULT '',
    `font_name` VARCHAR(255) NULL,
    `font_size` INTEGER NULL,
    `obj_id` INTEGER NULL,
    `current_x` INTEGER NULL,
    `current_y` INTEGER NULL,
    `qr_name` VARCHAR(255) NULL,
    `qr_size` INTEGER NULL,
    `bar_name` VARCHAR(255) NULL,
    `bar_size` INTEGER NULL,
    `pic_name` VARCHAR(255) NULL,
    `pic_w` INTEGER NULL,
    `pic_h` INTEGER NULL,
    `pic_base64` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sound` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sound` VARCHAR(255) NULL,
    `path` VARCHAR(255) NULL,
    `filename` VARCHAR(255) NULL,
    `sound_type` INTEGER NULL,
    `key_sound_mapping` VARCHAR(11) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sound_design` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `script_name` VARCHAR(255) NULL DEFAULT '',
    `script_detail` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sound_design_detail` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sound_design_id` INTEGER NULL,
    `sound_id` INTEGER NULL,
    `sound_order` INTEGER NULL,
    `script_type` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sound_design_setting` (
    `id` INTEGER NOT NULL,
    `sound_design_id` INTEGER NULL,
    `m_key_id` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sound_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `language` VARCHAR(255) NULL,
    `gender` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `wait_queue` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `wait` INTEGER NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
