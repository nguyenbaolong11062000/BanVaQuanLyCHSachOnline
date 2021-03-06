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
-- Table structure for table `binh_luan`
--

DROP TABLE IF EXISTS `binh_luan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `binh_luan` (
  `MaBL` int NOT NULL AUTO_INCREMENT,
  `NoiDung` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ma_Sach` int NOT NULL,
  `ma_KhachHang` int NOT NULL,
  `NgayTao` datetime DEFAULT NULL,
  PRIMARY KEY (`MaBL`),
  KEY `ma_Sach` (`ma_Sach`),
  KEY `ma_KhachHang` (`ma_KhachHang`),
  CONSTRAINT `binh_luan_ibfk_1` FOREIGN KEY (`ma_Sach`) REFERENCES `sach` (`MaSach`),
  CONSTRAINT `binh_luan_ibfk_2` FOREIGN KEY (`ma_KhachHang`) REFERENCES `khachhang` (`MaKH`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `binh_luan`
--

LOCK TABLES `binh_luan` WRITE;
/*!40000 ALTER TABLE `binh_luan` DISABLE KEYS */;
INSERT INTO `binh_luan` VALUES (1,'Rất hay!',1,2,'2022-01-14 11:11:56'),(2,'Rất hay!',1,2,'2022-01-14 11:11:56'),(3,'Good!',1,2,'2022-01-14 11:19:22'),(4,'Good!',1,2,'2022-01-14 11:19:22'),(5,'Good!',1,2,'2022-01-14 11:19:22'),(6,'Good!',1,2,'2022-01-14 11:24:11'),(7,'Hay ghê!',1,2,'2022-01-14 11:24:11'),(8,'Hay nhỉ!',1,2,'2022-01-14 11:25:39'),(9,'Hay thật!',1,2,'2022-01-14 11:25:39'),(10,'Hay nhỉ!',2,5,'2022-01-14 11:26:25'),(11,'Hay thật!',2,5,'2022-01-14 11:26:25'),(12,'Wowww!',2,5,'2022-01-14 11:26:25'),(13,'Ohh wow!',2,5,'2022-01-14 11:26:25'),(14,'Ohh wow!',2,5,'2022-01-14 11:26:25'),(15,'good!',2,5,'2022-01-14 11:35:11'),(16,'Tuyệt!',1,5,'2022-01-16 10:46:15'),(17,'Hay quá!',1,2,'2022-01-16 11:33:31'),(18,'Tuyệt!',5,2,'2022-01-16 11:33:31'),(19,'Cuốn sách này bổ ích!',1,6,'2022-01-16 11:51:18'),(20,'Cuốn sách này bổ ích!',1,6,'2022-01-16 11:51:18'),(21,'Cuốn sách này bổ ích!',1,6,'2022-01-16 11:51:18'),(22,'Cuốn sách này bổ ích!',1,6,'2022-01-16 11:51:18'),(23,'Thú vị!',6,2,'2022-01-16 12:19:19'),(24,'Khá hay!',6,2,'2022-01-16 12:20:49'),(25,'Thật tuyệt!',6,2,'2022-01-16 12:20:49'),(26,'Tuyệt hảo!',6,2,'2022-01-16 12:20:49'),(27,'Quá hay!',2,5,'2022-01-16 12:23:46'),(28,'Tuyệt!',2,5,'2022-01-16 12:23:46'),(29,'Bổ ích!',2,2,'2022-01-16 12:37:01'),(30,'Tuyệt nhỉ!',7,2,'2022-01-16 12:52:07'),(31,'Tuyệt nhỉ!',7,2,'2022-01-16 12:52:07'),(32,'Tuyệt nhỉ!',7,2,'2022-01-16 12:52:07'),(33,'Tuyệt nhỉ!',7,2,'2022-01-16 12:52:07'),(34,'Tuyệt nhỉ!',7,2,'2022-01-16 12:52:07'),(35,'Tuyệt nhỉ!',7,2,'2022-01-16 12:52:07'),(36,'Tốt!',1,2,'2022-01-16 12:52:07');
/*!40000 ALTER TABLE `binh_luan` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `chitietdonhang` VALUES (1,1,2,119500,0),(1,2,1,115000,0),(1,5,1,19000,0),(1,6,1,25000,0),(1,7,1,209000,0),(2,2,3,115000,0),(2,3,2,92600,0),(2,4,2,92650,0),(2,5,2,19000,0),(2,6,2,25000,0),(2,7,1,209000,0),(3,1,3,119500,0),(3,2,3,115000,0),(3,3,1,92600,0),(3,4,2,92650,0),(3,5,4,19000,0),(3,6,4,25000,0),(3,7,3,209000,0),(4,1,2,119500,0),(4,2,2,115000,0),(4,3,4,92600,0),(4,4,2,92650,0),(4,5,1,19000,0),(4,6,1,25000,0),(4,7,1,209000,0),(5,2,1,115000,0),(5,3,2,92600,0),(5,4,0,92650,0),(5,5,1,19000,0),(5,6,1,25000,0),(5,7,3,209000,0),(6,1,3,119500,0),(6,2,5,115000,0),(6,3,3,92600,0),(6,4,2,92650,0),(6,5,1,19000,0),(6,6,1,25000,0),(6,7,2,209000,0),(7,2,1,115000,0),(8,1,1,119500,0),(8,2,1,115000,0),(8,3,1,92600,0),(8,4,1,92650,0),(8,5,1,19000,0),(8,6,1,25000,0),(8,7,1,209000,0),(9,1,1,119500,0.01),(9,2,1,115000,0.01),(9,3,1,92600,0.01),(9,4,5,92650,0.01),(9,5,2,19000,0.01),(9,6,2,25000,0.01),(9,7,1,209000,0.01),(10,1,1,119500,0.01),(10,2,1,115000,0.01),(10,3,1,92600,0.01),(10,4,1,92650,0.01),(10,5,2,19000,0.01),(10,6,2,25000,0.01),(10,7,1,209000,0.01),(11,1,1,119500,0.01),(11,2,1,115000,0.01),(11,3,1,92600,0.01),(11,4,1,92650,0.01),(11,5,1,19000,0.01),(11,6,1,25000,0.01),(11,7,1,209000,0.01),(12,1,2,119500,0.01),(12,3,1,92600,0.01),(12,4,1,92650,0.01),(12,5,1,19000,0.01),(13,2,2,115000,0.01),(13,3,1,92600,0.01),(13,4,1,92650,0.01),(13,5,1,19000,0.01),(13,6,1,25000,0.01),(13,7,1,209000,0.01),(14,2,2,115000,0.01),(14,4,2,92650,0.01),(14,5,2,19000,0.01),(14,6,2,25000,0.01),(14,7,3,209000,0.01),(15,1,1,119500,0.01),(15,2,1,115000,0.01),(15,3,1,92600,0.01),(15,4,1,92650,0.01),(15,5,1,19000,0.01),(15,6,1,25000,0.01),(15,7,4,209000,0.01),(16,1,4,119500,0.01),(16,2,4,115000,0.01),(16,3,1,92600,0.01),(16,4,2,92650,0.01),(16,5,1,19000,0.01),(16,6,1,25000,0.01),(16,7,1,209000,0.01),(17,1,2,119500,0.01),(17,2,1,115000,0.01),(17,3,1,92600,0.01),(17,4,1,92650,0.01),(17,5,1,19000,0.01),(17,6,3,25000,0.01),(17,7,1,209000,0.01),(18,1,1,119500,0.01),(18,2,1,115000,0.01),(18,3,1,92600,0.01),(18,4,1,92650,0.01),(18,5,1,19000,0.01),(18,6,1,25000,0.01),(18,7,1,209000,0.01),(19,1,1,119500,0.01),(19,2,1,115000,0.01),(19,3,1,92600,0.01),(19,4,0,92650,0.01);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donhang`
--

LOCK TABLES `donhang` WRITE;
/*!40000 ALTER TABLE `donhang` DISABLE KEYS */;
INSERT INTO `donhang` VALUES (1,'2021-10-31 16:43:57',2),(2,'2021-11-01 13:20:06',2),(3,'2021-11-01 13:53:46',2),(4,'2021-11-01 14:04:36',2),(5,'2021-11-01 14:36:13',2),(6,'2021-11-02 12:38:58',2),(7,'2021-11-06 12:47:33',2),(8,'2021-11-14 15:25:58',2),(9,'2021-12-05 14:05:35',4),(10,'2021-12-17 19:17:44',2),(11,'2021-12-17 19:42:08',2),(12,'2021-12-20 09:50:29',2),(13,'2021-12-20 10:07:56',2),(14,'2021-12-20 10:07:56',2),(15,'2021-12-20 10:07:56',2),(16,'2021-12-20 10:24:48',2),(17,'2022-01-14 09:24:33',2),(18,'2022-01-14 09:24:33',5),(19,'2022-01-16 10:18:27',2);
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
  `Ho` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Ten` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Email` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `TenDangNhap` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `MatKhau` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `GioiTinh` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `HinhAnh` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `SoDT` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `HoatDong` tinyint(1) DEFAULT NULL,
  `VaiTro` enum('KH','ADMIN') CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`MaKH`),
  UNIQUE KEY `TenDangNhap` (`TenDangNhap`),
  CONSTRAINT `khachhang_chk_1` CHECK ((`HoatDong` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `khachhang`
--

LOCK TABLES `khachhang` WRITE;
/*!40000 ALTER TABLE `khachhang` DISABLE KEYS */;
INSERT INTO `khachhang` VALUES (1,NULL,'ADMIN1','admin1@ou.edu.vn','admin1','e10adc3949ba59abbe56e057f20f883e','Nam',NULL,'0937752035',1,'ADMIN'),(2,'Nguyễn','Bảo Long','1851050083long@ou.edu.vn','user2','e10adc3949ba59abbe56e057f20f883e','Nam','https://res.cloudinary.com/dkoppuet4/image/upload/v1642305115/baoLong_fvjruh.jpg','0937752035',1,'KH'),(3,'Nguyễn','Bảo Hoàng','baohoang15062013@gmail.com','baohoang123','665a61beec34b84e2f79c6d18f3c29ca','Nam','https://res.cloudinary.com/dkoppuet4/image/upload/v1642304813/cq72eumb8ppcmuc5t6l0.png	','0764380261',1,'KH'),(4,'Nguyễn Thị','Yến Nhi','nhi@ou.edu.vn','nhi123','25f9e794323b453885f5181f1b624d0b','Nữ','https://res.cloudinary.com/dkoppuet4/image/upload/v1642305315/nhi_ci9mud.png','0374561021',1,'KH'),(5,'Nguyễn','Thị Loan','loan@ou.edu.vn','loan123','e10adc3949ba59abbe56e057f20f883e','Nữ','https://res.cloudinary.com/dkoppuet4/image/upload/v1642305315/nhi_ci9mud.png	','076811289',1,'KH'),(6,'Lê','Xuân Long','xuanlong@ou.edu.vn','xuanlong123','e10adc3949ba59abbe56e057f20f883e','Nam','https://res.cloudinary.com/dkoppuet4/image/upload/v1642304813/cq72eumb8ppcmuc5t6l0.png','0937752035',1,'KH');
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
  `MieuTaLoaiSach` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
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
  `TuaSach` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `MoTaSach` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `GiaBia` float DEFAULT NULL,
  `HinhAnh` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
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
  `Ho` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `Ten` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `HinhAnh` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `TieuSu` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
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

-- Dump completed on 2022-01-16 13:00:44
