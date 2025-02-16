-- CreateTable
CREATE TABLE `student` (
    `id` VARCHAR(191) NOT NULL,
    `firstName` VARCHAR(191) NULL,
    `middleName` VARCHAR(191) NULL,
    `lastName` VARCHAR(191) NULL,
    `branch` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `year` VARCHAR(191) NULL,
    `grades` VARCHAR(191) NULL,
    `ranking` DOUBLE NULL,
    `average` DOUBLE NULL,
    `departmentId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `department` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `country` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `convention` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `year` VARCHAR(191) NULL,
    `url` VARCHAR(191) NULL,
    `departmentId` VARCHAR(191) NULL,
    `universityId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `university` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `countryId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `diploma` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `departmentId` VARCHAR(191) NULL,
    `universityId` VARCHAR(191) NULL,
    `surDossiers` VARCHAR(191) NULL,
    `type` VARCHAR(191) NULL,
    `languageLevel` VARCHAR(191) NULL,
    `costs` VARCHAR(191) NULL,
    `interview` BOOLEAN NULL,
    `oralExam` BOOLEAN NULL,
    `writtenExam` BOOLEAN NULL,
    `applicationStartDate` DATETIME(3) NULL,
    `applicationEndDate` DATETIME(3) NULL,
    `resultsDate` DATETIME(3) NULL,
    `procedure` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `parcours` (
    `id` VARCHAR(191) NOT NULL,
    `description` LONGTEXT NULL,
    `universityId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `bourse` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `description` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `application` (
    `id` VARCHAR(191) NOT NULL,
    `studentId` VARCHAR(191) NULL,
    `diplomaId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NULL DEFAULT CURRENT_TIMESTAMP(3),
    `status` VARCHAR(191) NULL,
    `comment` VARCHAR(191) NULL,
    `authorized` BOOLEAN NULL,
    `bourseId` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_departmentTouniversity` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_departmentTouniversity_AB_unique`(`A`, `B`),
    INDEX `_departmentTouniversity_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_bourseTodiploma` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_bourseTodiploma_AB_unique`(`A`, `B`),
    INDEX `_bourseTodiploma_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `student` ADD CONSTRAINT `student_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `department`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `convention` ADD CONSTRAINT `convention_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `department`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `convention` ADD CONSTRAINT `convention_universityId_fkey` FOREIGN KEY (`universityId`) REFERENCES `university`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `university` ADD CONSTRAINT `university_countryId_fkey` FOREIGN KEY (`countryId`) REFERENCES `country`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `diploma` ADD CONSTRAINT `diploma_departmentId_fkey` FOREIGN KEY (`departmentId`) REFERENCES `department`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `diploma` ADD CONSTRAINT `diploma_universityId_fkey` FOREIGN KEY (`universityId`) REFERENCES `university`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `parcours` ADD CONSTRAINT `parcours_universityId_fkey` FOREIGN KEY (`universityId`) REFERENCES `university`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_studentId_fkey` FOREIGN KEY (`studentId`) REFERENCES `student`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_diplomaId_fkey` FOREIGN KEY (`diplomaId`) REFERENCES `diploma`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_bourseId_fkey` FOREIGN KEY (`bourseId`) REFERENCES `bourse`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_departmentTouniversity` ADD CONSTRAINT `_departmentTouniversity_A_fkey` FOREIGN KEY (`A`) REFERENCES `department`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_departmentTouniversity` ADD CONSTRAINT `_departmentTouniversity_B_fkey` FOREIGN KEY (`B`) REFERENCES `university`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_bourseTodiploma` ADD CONSTRAINT `_bourseTodiploma_A_fkey` FOREIGN KEY (`A`) REFERENCES `bourse`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_bourseTodiploma` ADD CONSTRAINT `_bourseTodiploma_B_fkey` FOREIGN KEY (`B`) REFERENCES `diploma`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
