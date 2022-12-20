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
CREATE TABLE `examination_room` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(255) NULL DEFAULT '',
    `organization_id` INTEGER NULL DEFAULT 0,
    `sound_design_id` INTEGER NULL,
    `longitude` DOUBLE NULL DEFAULT 0,
    `latitude` DOUBLE NULL DEFAULT 0,

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
CREATE TABLE `member` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `Card` BIT(1) NULL DEFAULT b'0',
    `organization_id` INTEGER NULL,
    `HnCode` VARCHAR(255) NULL DEFAULT '',
    `username` VARCHAR(20) NULL,
    `MobileNo` VARCHAR(50) NULL DEFAULT '',
    `password` VARCHAR(100) NULL,
    `IsBoss` BOOLEAN NULL DEFAULT false,
    `Modify_DateTime` DATETIME(0) NULL,
    `ThId` VARCHAR(50) NULL DEFAULT ' ',
    `ThTitle` VARCHAR(10) NULL,
    `ThFrist` VARCHAR(50) NULL,
    `ThMiddle` VARCHAR(20) NULL,
    `ThLast` VARCHAR(50) NULL,
    `EnTitle` VARCHAR(10) NULL,
    `EnFrist` VARCHAR(50) NULL,
    `EnMiddle` VARCHAR(20) NULL,
    `EnLast` VARCHAR(50) NULL,
    `ThBirth` VARCHAR(30) NULL,
    `EnBirth` VARCHAR(30) NULL,
    `ThGender` VARCHAR(10) NULL,
    `EnGender` VARCHAR(10) NULL,
    `Place` VARCHAR(250) NULL,
    `ThIssue` VARCHAR(20) NULL,
    `EnIssue` VARCHAR(20) NULL,
    `ThExpiry` VARCHAR(20) NULL,
    `EnExpiry` VARCHAR(20) NULL,
    `AddNum` VARCHAR(20) NULL DEFAULT '',
    `AddMoo` VARCHAR(20) NULL DEFAULT '',
    `AddTok` VARCHAR(255) NULL,
    `AddSoi` VARCHAR(255) NULL,
    `AddRoad` VARCHAR(255) NULL,
    `AddTambol` VARCHAR(255) NULL,
    `AddUmper` VARCHAR(255) NULL,
    `AddCity` VARCHAR(255) NULL,
    `Number` VARCHAR(20) NULL,
    `Picture` TEXT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `member_copy` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `Card` BIT(1) NULL DEFAULT b'0',
    `organization_id` INTEGER NULL,
    `HnCode` VARCHAR(255) NULL DEFAULT '',
    `username` VARCHAR(20) NULL,
    `MobileNo` VARCHAR(50) NULL DEFAULT '',
    `password` VARCHAR(100) NULL,
    `IsBoss` BOOLEAN NULL DEFAULT false,
    `Modify_DateTime` DATETIME(0) NULL,
    `ThId` VARCHAR(50) NULL DEFAULT ' ',
    `ThTitle` VARCHAR(10) NULL,
    `ThFrist` VARCHAR(50) NULL,
    `ThMiddle` VARCHAR(20) NULL,
    `ThLast` VARCHAR(50) NULL,
    `EnTitle` VARCHAR(10) NULL,
    `EnFrist` VARCHAR(50) NULL,
    `EnMiddle` VARCHAR(20) NULL,
    `EnLast` VARCHAR(50) NULL,
    `ThBirth` VARCHAR(30) NULL,
    `EnBirth` VARCHAR(30) NULL,
    `ThGender` VARCHAR(10) NULL,
    `EnGender` VARCHAR(10) NULL,
    `Place` VARCHAR(250) NULL,
    `ThIssue` VARCHAR(20) NULL,
    `EnIssue` VARCHAR(20) NULL,
    `ThExpiry` VARCHAR(20) NULL,
    `EnExpiry` VARCHAR(20) NULL,
    `AddNum` VARCHAR(20) NULL DEFAULT '',
    `AddMoo` VARCHAR(20) NULL DEFAULT '',
    `AddTok` VARCHAR(255) NULL,
    `AddSoi` VARCHAR(255) NULL,
    `AddRoad` VARCHAR(255) NULL,
    `AddTambol` VARCHAR(255) NULL,
    `AddUmper` VARCHAR(255) NULL,
    `AddCity` VARCHAR(255) NULL,
    `Number` VARCHAR(20) NULL,
    `Picture` TEXT NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `member_token_device` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `member_id` INTEGER NULL,
    `platform` VARCHAR(20) NULL,
    `fcm_token` TEXT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `mode` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `mode` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `organization` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `Name` VARCHAR(100) NULL DEFAULT '',
    `Address` VARCHAR(250) NULL DEFAULT '',
    `Tel` VARCHAR(50) NULL DEFAULT '',
    `organization_type_id` INTEGER NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `organization_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `organization_type_name` VARCHAR(255) NULL DEFAULT '',
    `format` INTEGER NULL,

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
CREATE TABLE `queue` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `MemberID` INTEGER NULL,
    `QueueNo` VARCHAR(5) NULL DEFAULT '',
    `CreateDate` DATE NULL,
    `ExamRoomID` INTEGER NULL,
    `Confirm` BIT(1) NULL DEFAULT b'0',
    `Reserve` BIT(1) NULL DEFAULT b'0',
    `ReserveDate` DATE NULL,
    `Modify_DateTime` DATETIME(0) NULL,
    `IsUrgentCase` BIT(1) NULL DEFAULT b'0',
    `IsPrint` BIT(1) NULL DEFAULT b'0',
    `organization_id` INTEGER NULL,

    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `queue_detail` (
    `ID` INTEGER NOT NULL AUTO_INCREMENT,
    `qId` INTEGER NULL,
    `CreateDate` DATE NULL,
    `ExamRoomID` INTEGER NULL,
    `StartTime` DATETIME(0) NULL,
    `EndTime` DATETIME(0) NULL,
    `QueueNo` VARCHAR(5) NULL,
    `Modify_DateTime` DATETIME(0) NULL,
    `qNo` INTEGER NULL DEFAULT 0,
    `Success` BIT(1) NULL DEFAULT b'0',
    `Calling_Queue` BIT(1) NULL DEFAULT b'0',
    `Counter` INTEGER NULL,
    `IsSendNotify` BOOLEAN NULL DEFAULT false,

    UNIQUE INDEX `queue_detail_qId_key`(`qId`),
    PRIMARY KEY (`ID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `queue_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type_name` VARCHAR(100) NULL,
    `service_id` INTEGER NULL,
    `detail` VARCHAR(250) NULL,

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

-- AddForeignKey
ALTER TABLE `queue_detail` ADD CONSTRAINT `queue_detail_qId_fkey` FOREIGN KEY (`qId`) REFERENCES `queue`(`ID`) ON DELETE SET NULL ON UPDATE CASCADE;
