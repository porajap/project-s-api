-- AddForeignKey
ALTER TABLE `register_at` ADD CONSTRAINT `register_at_MemberID_fkey` FOREIGN KEY (`MemberID`) REFERENCES `member`(`ID`) ON DELETE RESTRICT ON UPDATE CASCADE;
