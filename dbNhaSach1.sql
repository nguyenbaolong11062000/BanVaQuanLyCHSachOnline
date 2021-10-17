-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: dbnhasach1
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chitietdonhang`
--

DROP TABLE IF EXISTS `chitietdonhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chitietdonhang` (
  `ma_dh` int NOT NULL,
  `ma_sach` int NOT NULL,
  `SoLuong` int DEFAULT NULL,
  `GiaBan` float DEFAULT NULL,
  `TyLeGiamGia` float DEFAULT NULL,
  PRIMARY KEY (`ma_dh`,`ma_sach`),
  KEY `ma_sach` (`ma_sach`),
  CONSTRAINT `chitietdonhang_ibfk_1` FOREIGN KEY (`ma_dh`) REFERENCES `donhang` (`MaDH`),
  CONSTRAINT `chitietdonhang_ibfk_2` FOREIGN KEY (`ma_sach`) REFERENCES `sach` (`MaSach`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chitietdonhang`
--

LOCK TABLES `chitietdonhang` WRITE;
/*!40000 ALTER TABLE `chitietdonhang` DISABLE KEYS */;
INSERT INTO `chitietdonhang` VALUES (1,1,1,119500,0),(1,2,1,115000,0),(1,3,3,92600,0),(2,1,3,119500,0),(2,2,3,115000,0),(2,3,3,92600,0),(2,4,3,92650,0),(3,1,2,119500,0),(3,2,2,115000,0),(4,1,4,119500,0),(5,1,1,119500,0),(5,2,1,115000,0),(6,1,2,119500,0),(6,2,2,115000,0),(6,3,2,92600,0),(6,4,2,92650,0),(7,1,1,119500,0),(7,2,1,115000,0),(7,3,1,92600,0),(8,2,1,115000,0),(9,1,1,119500,0),(9,2,5,115000,0),(10,1,1,119500,0),(10,2,1,115000,0),(10,3,1,92600,0),(10,4,3,92650,0),(11,1,2,119500,0),(11,2,4,115000,0),(11,3,2,92600,0),(11,4,2,92650,0),(12,1,5,119500,0),(13,1,2,119500,0),(13,2,2,115000,0),(13,3,2,92600,0),(13,4,2,92650,0),(14,1,1,119500,0),(15,2,1,115000,0),(15,3,1,92600,0),(16,1,2,119500,0),(16,2,3,115000,0),(16,3,3,92600,0),(16,4,2,92650,0),(17,1,3,119500,0),(17,2,2,115000,0),(17,3,3,92600,0),(17,4,1,92650,0),(18,1,2,119500,0),(18,2,3,115000,0),(18,3,3,92600,0),(18,4,2,92650,0),(19,1,1,119500,0),(19,2,1,115000,0),(19,3,2,92600,0),(19,4,1,92650,0),(20,1,1,119500,0),(20,2,2,115000,0),(20,3,2,92600,0),(20,4,1,92650,0),(21,1,1,119500,0),(21,2,2,115000,0),(22,1,1,119500,0),(22,2,3,115000,0),(22,3,2,92600,0),(22,4,1,92650,0),(23,1,3,119500,0),(23,2,1,115000,0),(23,3,1,92600,0),(23,4,1,92650,0),(24,1,3,119500,0),(24,2,2,115000,0),(25,1,2,119500,0),(25,2,2,115000,0),(25,3,2,92600,0),(25,4,2,92650,0),(26,2,2,115000,0),(26,3,2,92600,0),(26,4,2,92650,0),(27,1,2,119500,0),(27,2,2,115000,0);
/*!40000 ALTER TABLE `chitietdonhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donhang`
--

DROP TABLE IF EXISTS `donhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donhang` (
  `MaDH` int NOT NULL AUTO_INCREMENT,
  `NgayMua` datetime DEFAULT NULL,
  `ma_kh` int NOT NULL,
  PRIMARY KEY (`MaDH`),
  KEY `ma_kh` (`ma_kh`),
  CONSTRAINT `donhang_ibfk_1` FOREIGN KEY (`ma_kh`) REFERENCES `khachhang` (`MaKH`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donhang`
--

LOCK TABLES `donhang` WRITE;
/*!40000 ALTER TABLE `donhang` DISABLE KEYS */;
INSERT INTO `donhang` VALUES (1,'2021-09-23 19:11:47',2),(2,'2021-09-23 19:40:48',2),(3,'2021-10-05 12:20:30',2),(4,'2021-10-05 12:33:24',2),(5,'2021-10-10 11:42:50',2),(6,'2021-10-10 14:38:07',6),(7,'2021-10-10 15:17:23',6),(8,'2021-10-10 15:29:01',2),(9,'2021-10-10 16:50:10',3),(10,'2021-10-16 13:58:41',2),(11,'2021-10-16 14:10:09',6),(12,'2021-10-16 14:10:43',6),(13,'2021-10-16 14:12:19',6),(14,'2021-10-16 14:18:57',2),(15,'2021-10-16 14:21:07',2),(16,'2021-10-16 14:39:18',6),(17,'2021-10-17 14:35:52',2),(18,'2021-10-17 14:37:14',3),(19,'2021-10-17 14:41:47',6),(20,'2021-10-17 14:50:23',2),(21,'2021-10-17 14:51:09',2),(22,'2021-10-17 14:54:53',2),(23,'2021-10-17 15:01:14',2),(24,'2021-10-17 15:05:23',2),(25,'2021-10-17 15:20:02',2),(26,'2021-10-17 15:29:14',2),(27,'2021-10-17 15:32:23',2);
/*!40000 ALTER TABLE `donhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `khachhang`
--

DROP TABLE IF EXISTS `khachhang`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `khachhang` (
  `MaKH` int NOT NULL AUTO_INCREMENT,
  `Ho` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Ten` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TenDangNhap` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `MatKhau` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `GioiTinh` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `HinhAnh` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SoDT` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `HoatDonng` tinyint(1) DEFAULT NULL,
  `VaiTro` enum('KH','ADMIN') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MaKH`),
  UNIQUE KEY `TenDangNhap` (`TenDangNhap`),
  CONSTRAINT `khachhang_chk_1` CHECK ((`HoatDonng` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES (1,NULL,'ADMIN1','admin1@ou.edu.vn','admin1','e10adc3949ba59abbe56e057f20f883e','male',NULL,'0937752035',NULL,'ADMIN'),(2,'Nguyễn','Bảo Long','1851050083long@ou.edu.vn','user2','e10adc3949ba59abbe56e057f20f883e','male','images/upload/iphone11.png','0937752035',1,'KH'),(3,'Nguyễn','Bảo Hoàng','nguyenthanhloc168@gmail.com','user1','e10adc3949ba59abbe56e057f20f883e','male','images/upload/nhi.png','0937752035',1,'KH'),(4,'Bùi','Tiến Dũng','nhi@ou.edu.vn','dung123','e10adc3949ba59abbe56e057f20f883e','male','images/upload/iphone11.png','0933861286',1,'KH'),(5,'Lê','Xuân Long','long@ou.edu.vn','long123','e10adc3949ba59abbe56e057f20f883e','male','images/upload/monkey.jpg','0123456789',1,'KH'),(6,'Bùi','Thúy An','an@ou.edu.vn','an123','e35cf7b66449df565f93c607d5a81d09','femal','images/upload/nhi.png','0145678922',1,'KH');
/*!40000 ALTER TABLE `khachhang` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `loaisach`
--

DROP TABLE IF EXISTS `loaisach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loaisach` (
  `MaLoaiSach` int NOT NULL AUTO_INCREMENT,
  `MieuTaLoaiSach` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MaLoaiSach`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loaisach`
--

LOCK TABLES `loaisach` WRITE;
/*!40000 ALTER TABLE `loaisach` DISABLE KEYS */;
INSERT INTO `loaisach` VALUES (1,'Chính Trị - Xã Hội - Triết Học'),(2,'Giáo dục'),(3,'Tiểu Thuyết');
/*!40000 ALTER TABLE `loaisach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sach`
--

DROP TABLE IF EXISTS `sach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sach` (
  `MaSach` int NOT NULL AUTO_INCREMENT,
  `TuaSach` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `MoTaSach` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `GiaBia` float DEFAULT NULL,
  `HinhAnh` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NamXuatBan` int NOT NULL,
  `ma_loaiSach` int NOT NULL,
  PRIMARY KEY (`MaSach`),
  KEY `ma_loaiSach` (`ma_loaiSach`),
  CONSTRAINT `sach_ibfk_1` FOREIGN KEY (`ma_loaiSach`) REFERENCES `loaisach` (`MaLoaiSach`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sach`
--

LOCK TABLES `sach` WRITE;
/*!40000 ALTER TABLE `sach` DISABLE KEYS */;
INSERT INTO `sach` VALUES (1,'The Prince (Quân vương)','Đây là bản đề cương kế hoạch nổi tiếng nhất thế giới về việc nắm bắt và giữ vững quyền lực',119500,'images/the prince.jpg',2013,1),(2,'Sách Giáo Khoa Lớp 5','Nhiều môn học của Lớp 5',115000,'images/SGK5.png',2010,2),(3,'Bàn Về Khế Ước Xã Hội','Chứa đựng những tư tưởng tyên phong về cách mạng dân chủ',92600,'images/banKheUoc.jpg',2018,1),(4,'Chiến binh cầu vồng','Tình yêu trong sáng tuổi học trò lẫn những trò đùa tinh quái',92650,'images/chienBinhCV.jpg',2020,3);
/*!40000 ALTER TABLE `sach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tacgia`
--

DROP TABLE IF EXISTS `tacgia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tacgia` (
  `MaTG` int NOT NULL AUTO_INCREMENT,
  `Ho` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Ten` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `HinhAnh` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TieuSu` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MaTG`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tacgia`
--

LOCK TABLES `tacgia` WRITE;
/*!40000 ALTER TABLE `tacgia` DISABLE KEYS */;
INSERT INTO `tacgia` VALUES (1,'Machiavelli','Niccolò','images/author the prince.jpg',' Nhà ngoại giao, triết học và nhà sử học người Ý'),(2,NULL,'Nhà Xuất Bản Giáo Dục','images/SGK5.png','Nhà Xuất Bản Sách'),(3,'Rousseau','Jean - Jacques ','images/banKheUocTacGia.jpg','Là một nhà triết học thuộc trào lưu Khai sáng'),(4,' Hirata','Andrea','images/chienBinhCV_tacGia.jpg','Một tác giả người Indonesia');
/*!40000 ALTER TABLE `tacgia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tacgiavietsach`
--

DROP TABLE IF EXISTS `tacgiavietsach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tacgiavietsach` (
  `ma_tg` int NOT NULL,
  `ma_sach` int NOT NULL,
  PRIMARY KEY (`ma_tg`,`ma_sach`),
  KEY `ma_sach` (`ma_sach`),
  CONSTRAINT `tacgiavietsach_ibfk_1` FOREIGN KEY (`ma_tg`) REFERENCES `tacgia` (`MaTG`),
  CONSTRAINT `tacgiavietsach_ibfk_2` FOREIGN KEY (`ma_sach`) REFERENCES `sach` (`MaSach`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tacgiavietsach`
--

LOCK TABLES `tacgiavietsach` WRITE;
/*!40000 ALTER TABLE `tacgiavietsach` DISABLE KEYS */;
INSERT INTO `tacgiavietsach` VALUES (1,1),(2,2),(3,3),(4,4);
/*!40000 ALTER TABLE `tacgiavietsach` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-17 15:34:59
