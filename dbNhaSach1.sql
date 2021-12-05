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
INSERT INTO `chitietdonhang` VALUES (1,1,2,119500,0),(1,2,1,115000,0),(1,5,1,19000,0),(1,6,1,25000,0),(1,7,1,209000,0),(2,2,3,115000,0),(2,3,2,92600,0),(2,4,2,92650,0),(2,5,2,19000,0),(2,6,2,25000,0),(2,7,1,209000,0),(3,1,3,119500,0),(3,2,3,115000,0),(3,3,1,92600,0),(3,4,2,92650,0),(3,5,4,19000,0),(3,6,4,25000,0),(3,7,3,209000,0),(4,1,2,119500,0),(4,2,2,115000,0),(4,3,4,92600,0),(4,4,2,92650,0),(4,5,1,19000,0),(4,6,1,25000,0),(4,7,1,209000,0),(5,2,1,115000,0),(5,3,2,92600,0),(5,4,0,92650,0),(5,5,1,19000,0),(5,6,1,25000,0),(5,7,3,209000,0),(6,1,3,119500,0),(6,2,5,115000,0),(6,3,3,92600,0),(6,4,2,92650,0),(6,5,1,19000,0),(6,6,1,25000,0),(6,7,2,209000,0),(7,2,1,115000,0),(8,1,1,119500,0),(8,2,1,115000,0),(8,3,1,92600,0),(8,4,1,92650,0),(8,5,1,19000,0),(8,6,1,25000,0),(8,7,1,209000,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donhang`
--

LOCK TABLES `donhang` WRITE;
/*!40000 ALTER TABLE `donhang` DISABLE KEYS */;
INSERT INTO `donhang` VALUES (1,'2021-10-31 16:43:57',2),(2,'2021-11-01 13:20:06',2),(3,'2021-11-01 13:53:46',2),(4,'2021-11-01 14:04:36',2),(5,'2021-11-01 14:36:13',2),(6,'2021-11-02 12:38:58',2),(7,'2021-11-06 12:47:33',2),(8,'2021-11-14 15:25:58',2);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES (1,NULL,'ADMIN1','admin1@ou.edu.vn','admin1','e10adc3949ba59abbe56e057f20f883e','Nam',NULL,'0937752035',1,'ADMIN'),(2,'Nguyễn','Bảo Long','1851050083long@ou.edu.vn','user2','e10adc3949ba59abbe56e057f20f883e','Nam','images/upload/baoLong.png','0937752035',1,'KH'),(3,'Nguyễn','Bảo Hoàng','baohoang15062013@gmail.com','baohoang123','665a61beec34b84e2f79c6d18f3c29ca','Nam','images/upload/anh4.png','0764380261',1,'KH');
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `loaisach`
--

LOCK TABLES `loaisach` WRITE;
/*!40000 ALTER TABLE `loaisach` DISABLE KEYS */;
INSERT INTO `loaisach` VALUES (1,'Chính Trị - Xã Hội - Triết Học'),(2,'Giáo dục'),(3,'Tiểu Thuyết'),(4,'Ngôn Tình'),(5,'Truyện Tranh');
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sach`
--

LOCK TABLES `sach` WRITE;
/*!40000 ALTER TABLE `sach` DISABLE KEYS */;
INSERT INTO `sach` VALUES (1,'The Prince (Quân vương)','Đây là bản đề cương kế hoạch nổi tiếng nhất thế giới về việc nắm bắt và giữ vững quyền lực',119500,'images/the prince.jpg',2013,1),(2,'Sách Giáo Khoa Lớp 5','Nhiều môn học của Lớp 5',115000,'images/SGK5.png',2010,2),(3,'Bàn Về Khế Ước Xã Hội','Chứa đựng những tư tưởng tiên phong về cách mạng dân chủ',92600,'images/banKheUoc.jpg',2018,1),(4,'Chiến binh cầu vồng','Tình yêu trong sáng tuổi học trò lẫn những trò đùa tinh quái',92650,'images/chienBinhCV.jpg',2020,3),(5,'Doraemon','Truyện tranh thiếu nhi, hài hước, vui nhộn',19000,'images/doraemon.png',2021,5),(6,'Conan','Thám tử nhí cùng những người bạn, phiêu lưu, kỳ thú.',25000,'images/conan.jpg',2021,5),(7,'Goblin','Truyện trình ngàn năm giữa Yêu Tinh và Cô Dâu của hắn.',209000,'images/goblin.png',2017,3);
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
  `TieuSu` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MaTG`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tacgia`
--

LOCK TABLES `tacgia` WRITE;
/*!40000 ALTER TABLE `tacgia` DISABLE KEYS */;
INSERT INTO `tacgia` VALUES (1,'Machiavelli','Niccolò','images/author the prince.jpg',' Một nhà ngoại giao, nhà triết học và nhà văn thời Phục hưng người Ý, nổi tiếng với tác phẩm Quân vương, được viết vào năm 1513.'),(2,'Rousseau','Jean - Jacques ','images/banKheUocTacGia.jpg','Một nhà triết học thuộc trào lưu Khai sáng có ảnh hưởng lớn tới Cách mạng Pháp 1789, sự phát triển của lý thuyết xã hội, và sự phát triển của chủ nghĩa dân tộc.'),(3,' Hirata','Andrea','images/chienBinhCV_tacGia.jpg','Một tác giả người Indonesia nổi tiếng với tiểu thuyết Laskar Pelangi năm 2005 và các phần tiếp theo của nó.'),(4,'Nhà Xuất Bản','Giáo Dục','images/SGK5.png','Nơi phát hành các loại sách trên đất nước Việt Nam.'),(5,'Fujimoto','Hiroshi','images/doraemonAuthor.jpg','Là nghệ sĩ manga người Nhật Bản, đồng sáng tác truyện tranh Doraemon với Abiko Motoo.'),(6,'Lee','Eung-bok','images/goblinAuthor.jpg','Là đạo diễn người Hàn Quốc, nổi tiếng bởi phim Goblin được chuyển thể từ tập truyện tranh cùng tên.'),(7,'Aoyama','Gōshō','images/conanAuthor.jpg','Aoyama Gōshō, tên khai sinh là Aoyama Yoshimasa, sinh ngày 21 tháng 6 năm 1963 tại Hokuei tỉnh Tottori, Nhật Bản. Ông là một nhà sáng tác truyện tranh, người được biết đến với bộ truyện tranh Thám tử lừng danh Conan.'),(9,'Abiko','Motoo','images/doraemonAuthor2.jpg','Là nghệ sĩ manga người Nhật Bản, đồng sáng tác truyện tranh Doraemon với Fujimoto Hiroshi. Hai người đều dùng cái tên \"Fujiko Fujio\" đến năm 1987, họ chia tay để theo đuổi con đường sáng tác riêng lẻ và trở thành \"Fujiko F. Fujio\" và \"Fujiko Fujio (A)\".');
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
INSERT INTO `tacgiavietsach` VALUES (1,1),(4,2),(2,3),(3,4),(5,5),(9,5),(7,6),(6,7);
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

-- Dump completed on 2021-12-05 12:51:07
