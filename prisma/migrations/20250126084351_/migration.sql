/*
  Warnings:

  - You are about to drop the column `bourseId` on the `application` table. All the data in the column will be lost.
  - You are about to drop the `_boursetodiploma` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `bourse` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `_boursetodiploma` DROP FOREIGN KEY `_bourseTodiploma_A_fkey`;

-- DropForeignKey
ALTER TABLE `_boursetodiploma` DROP FOREIGN KEY `_bourseTodiploma_B_fkey`;

-- DropForeignKey
ALTER TABLE `application` DROP FOREIGN KEY `application_bourseId_fkey`;

-- DropIndex
DROP INDEX `application_bourseId_fkey` ON `application`;

-- AlterTable
ALTER TABLE `application` DROP COLUMN `bourseId`,
    ADD COLUMN `scholarshipId` VARCHAR(191) NULL;

-- DropTable
DROP TABLE `_boursetodiploma`;

-- DropTable
DROP TABLE `bourse`;

-- CreateTable
CREATE TABLE `user` (
    `id` VARCHAR(191) NOT NULL,
    `firstName` VARCHAR(191) NULL,
    `lastName` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `password` VARCHAR(191) NULL,

    UNIQUE INDEX `user_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `scholarship` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NULL,
    `description` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_diplomaToscholarship` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_diplomaToscholarship_AB_unique`(`A`, `B`),
    INDEX `_diplomaToscholarship_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `application` ADD CONSTRAINT `application_scholarshipId_fkey` FOREIGN KEY (`scholarshipId`) REFERENCES `scholarship`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diplomaToscholarship` ADD CONSTRAINT `_diplomaToscholarship_A_fkey` FOREIGN KEY (`A`) REFERENCES `diploma`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_diplomaToscholarship` ADD CONSTRAINT `_diplomaToscholarship_B_fkey` FOREIGN KEY (`B`) REFERENCES `scholarship`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
