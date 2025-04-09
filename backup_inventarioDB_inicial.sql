-- MySQL dump 10.13  Distrib 8.0.39, for macos14.4 (arm64)
--
-- Host: localhost    Database: InventarioDB
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text,
  `precio` decimal(10,2) NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `ubicacion_id` int NOT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `ubicacion_id` (`ubicacion_id`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`ubicacion_id`) REFERENCES `ubicaciones` (`id_ubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=502 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'P-0001','Producto 1','Descripción 1',70.61,20,5),(2,'P-0002','Producto 2','Descripción 2',54.55,28,4),(3,'P-0003','Producto 3','Descripción 3',57.51,90,3),(4,'P-0004','Producto 4','Descripción 4',27.73,67,3),(5,'P-0005','Producto 5','Descripción 5',65.84,68,3),(6,'P-0006','Producto 6','Descripción 6',18.70,59,2),(7,'P-0007','Producto 7','Descripción 7',17.88,72,1),(8,'P-0008','Producto 8','Descripción 8',25.90,3,2),(9,'P-0009','Producto 9','Descripción 9',88.89,24,3),(10,'P-00010','Producto 10','Descripción 10',11.77,87,1),(11,'P-00011','Producto 11','Descripción 11',41.47,5,1),(12,'P-00012','Producto 12','Descripción 12',99.88,89,3),(13,'P-00013','Producto 13','Descripción 13',70.35,8,2),(14,'P-00014','Producto 14','Descripción 14',31.68,64,2),(15,'P-00015','Producto 15','Descripción 15',34.77,97,5),(16,'P-00016','Producto 16','Descripción 16',26.24,79,1),(17,'P-00017','Producto 17','Descripción 17',60.12,41,2),(18,'P-00018','Producto 18','Descripción 18',1.19,31,3),(19,'P-00019','Producto 19','Descripción 19',71.95,0,5),(20,'P-00020','Producto 20','Descripción 20',23.82,64,3),(21,'P-00021','Producto 21','Descripción 21',63.29,62,2),(22,'P-00022','Producto 22','Descripción 22',19.73,34,1),(23,'P-00023','Producto 23','Descripción 23',69.89,4,1),(24,'P-00024','Producto 24','Descripción 24',58.60,49,4),(25,'P-00025','Producto 25','Descripción 25',1.12,96,4),(26,'P-00026','Producto 26','Descripción 26',7.29,98,4),(27,'P-00027','Producto 27','Descripción 27',53.07,56,2),(28,'P-00028','Producto 28','Descripción 28',49.05,73,2),(29,'P-00029','Producto 29','Descripción 29',91.21,88,4),(30,'P-00030','Producto 30','Descripción 30',72.02,58,4),(31,'P-00031','Producto 31','Descripción 31',98.84,70,3),(32,'P-00032','Producto 32','Descripción 32',62.43,48,3),(33,'P-00033','Producto 33','Descripción 33',26.15,68,4),(34,'P-00034','Producto 34','Descripción 34',6.53,46,1),(35,'P-00035','Producto 35','Descripción 35',16.22,48,5),(36,'P-00036','Producto 36','Descripción 36',21.48,27,4),(37,'P-00037','Producto 37','Descripción 37',80.40,84,5),(38,'P-00038','Producto 38','Descripción 38',52.05,17,2),(39,'P-00039','Producto 39','Descripción 39',93.27,79,1),(40,'P-00040','Producto 40','Descripción 40',55.95,22,3),(41,'P-00041','Producto 41','Descripción 41',57.78,53,5),(42,'P-00042','Producto 42','Descripción 42',11.42,73,2),(43,'P-00043','Producto 43','Descripción 43',53.93,64,3),(44,'P-00044','Producto 44','Descripción 44',6.27,51,3),(45,'P-00045','Producto 45','Descripción 45',45.53,7,5),(46,'P-00046','Producto 46','Descripción 46',72.98,68,2),(47,'P-00047','Producto 47','Descripción 47',9.44,78,4),(48,'P-00048','Producto 48','Descripción 48',84.55,30,1),(49,'P-00049','Producto 49','Descripción 49',9.13,44,5),(50,'P-00050','Producto 50','Descripción 50',47.60,48,1),(51,'P-00051','Producto 51','Descripción 51',61.29,1,2),(52,'P-00052','Producto 52','Descripción 52',17.67,14,2),(53,'P-00053','Producto 53','Descripción 53',58.91,32,5),(54,'P-00054','Producto 54','Descripción 54',35.86,18,5),(55,'P-00055','Producto 55','Descripción 55',78.08,29,1),(56,'P-00056','Producto 56','Descripción 56',78.51,52,2),(57,'P-00057','Producto 57','Descripción 57',72.45,84,1),(58,'P-00058','Producto 58','Descripción 58',76.57,64,5),(59,'P-00059','Producto 59','Descripción 59',69.29,68,2),(60,'P-00060','Producto 60','Descripción 60',75.77,69,1),(61,'P-00061','Producto 61','Descripción 61',90.74,94,5),(62,'P-00062','Producto 62','Descripción 62',13.06,67,5),(63,'P-00063','Producto 63','Descripción 63',94.84,75,5),(64,'P-00064','Producto 64','Descripción 64',34.67,96,5),(65,'P-00065','Producto 65','Descripción 65',13.12,23,4),(66,'P-00066','Producto 66','Descripción 66',13.76,38,3),(67,'P-00067','Producto 67','Descripción 67',46.50,74,2),(68,'P-00068','Producto 68','Descripción 68',48.81,40,3),(69,'P-00069','Producto 69','Descripción 69',49.50,85,4),(70,'P-00070','Producto 70','Descripción 70',42.21,71,2),(71,'P-00071','Producto 71','Descripción 71',39.87,6,1),(72,'P-00072','Producto 72','Descripción 72',50.35,9,5),(73,'P-00073','Producto 73','Descripción 73',51.03,67,5),(74,'P-00074','Producto 74','Descripción 74',23.33,60,2),(75,'P-00075','Producto 75','Descripción 75',88.90,41,3),(76,'P-00076','Producto 76','Descripción 76',81.98,85,5),(77,'P-00077','Producto 77','Descripción 77',58.44,42,2),(78,'P-00078','Producto 78','Descripción 78',61.66,94,5),(79,'P-00079','Producto 79','Descripción 79',54.69,10,5),(80,'P-00080','Producto 80','Descripción 80',10.62,87,1),(81,'P-00081','Producto 81','Descripción 81',73.30,44,1),(82,'P-00082','Producto 82','Descripción 82',77.51,81,4),(83,'P-00083','Producto 83','Descripción 83',21.86,90,5),(84,'P-00084','Producto 84','Descripción 84',55.96,23,3),(85,'P-00085','Producto 85','Descripción 85',86.81,78,2),(86,'P-00086','Producto 86','Descripción 86',33.84,66,2),(87,'P-00087','Producto 87','Descripción 87',63.69,19,1),(88,'P-00088','Producto 88','Descripción 88',81.08,81,4),(89,'P-00089','Producto 89','Descripción 89',66.70,47,2),(90,'P-00090','Producto 90','Descripción 90',46.95,20,4),(91,'P-00091','Producto 91','Descripción 91',55.08,84,3),(92,'P-00092','Producto 92','Descripción 92',38.78,18,4),(93,'P-00093','Producto 93','Descripción 93',15.58,56,2),(94,'P-00094','Producto 94','Descripción 94',99.05,94,4),(95,'P-00095','Producto 95','Descripción 95',3.26,83,1),(96,'P-00096','Producto 96','Descripción 96',86.76,11,5),(97,'P-00097','Producto 97','Descripción 97',52.59,70,5),(98,'P-00098','Producto 98','Descripción 98',64.71,37,5),(99,'P-00099','Producto 99','Descripción 99',56.61,1,2),(100,'P-000100','Producto 100','Descripción 100',81.66,96,2),(101,'P-000101','Producto 101','Descripción 101',4.24,4,1),(102,'P-000102','Producto 102','Descripción 102',34.78,44,2),(103,'P-000103','Producto 103','Descripción 103',67.88,77,5),(104,'P-000104','Producto 104','Descripción 104',91.16,1,2),(105,'P-000105','Producto 105','Descripción 105',60.41,3,2),(106,'P-000106','Producto 106','Descripción 106',71.22,47,2),(107,'P-000107','Producto 107','Descripción 107',66.93,69,3),(108,'P-000108','Producto 108','Descripción 108',31.14,11,4),(109,'P-000109','Producto 109','Descripción 109',83.86,28,5),(110,'P-000110','Producto 110','Descripción 110',68.43,69,3),(111,'P-000111','Producto 111','Descripción 111',10.10,18,4),(112,'P-000112','Producto 112','Descripción 112',60.41,12,4),(113,'P-000113','Producto 113','Descripción 113',60.46,64,2),(114,'P-000114','Producto 114','Descripción 114',5.42,8,2),(115,'P-000115','Producto 115','Descripción 115',1.55,31,3),(116,'P-000116','Producto 116','Descripción 116',77.30,22,5),(117,'P-000117','Producto 117','Descripción 117',41.97,63,5),(118,'P-000118','Producto 118','Descripción 118',70.40,75,4),(119,'P-000119','Producto 119','Descripción 119',98.77,99,5),(120,'P-000120','Producto 120','Descripción 120',0.83,5,2),(121,'P-000121','Producto 121','Descripción 121',99.97,30,3),(122,'P-000122','Producto 122','Descripción 122',74.80,13,3),(123,'P-000123','Producto 123','Descripción 123',84.78,87,5),(124,'P-000124','Producto 124','Descripción 124',62.91,58,1),(125,'P-000125','Producto 125','Descripción 125',43.98,8,1),(126,'P-000126','Producto 126','Descripción 126',19.73,72,1),(127,'P-000127','Producto 127','Descripción 127',90.89,50,4),(128,'P-000128','Producto 128','Descripción 128',38.63,59,5),(129,'P-000129','Producto 129','Descripción 129',36.04,30,3),(130,'P-000130','Producto 130','Descripción 130',40.46,62,5),(131,'P-000131','Producto 131','Descripción 131',63.31,46,3),(132,'P-000132','Producto 132','Descripción 132',72.25,34,3),(133,'P-000133','Producto 133','Descripción 133',70.72,89,2),(134,'P-000134','Producto 134','Descripción 134',6.48,27,1),(135,'P-000135','Producto 135','Descripción 135',9.31,91,2),(136,'P-000136','Producto 136','Descripción 136',70.06,63,1),(137,'P-000137','Producto 137','Descripción 137',53.66,41,3),(138,'P-000138','Producto 138','Descripción 138',0.79,69,3),(139,'P-000139','Producto 139','Descripción 139',14.27,37,3),(140,'P-000140','Producto 140','Descripción 140',20.15,60,3),(141,'P-000141','Producto 141','Descripción 141',26.44,7,3),(142,'P-000142','Producto 142','Descripción 142',71.59,81,5),(143,'P-000143','Producto 143','Descripción 143',12.84,90,1),(144,'P-000144','Producto 144','Descripción 144',94.56,33,5),(145,'P-000145','Producto 145','Descripción 145',18.12,39,3),(146,'P-000146','Producto 146','Descripción 146',96.12,51,4),(147,'P-000147','Producto 147','Descripción 147',0.86,90,3),(148,'P-000148','Producto 148','Descripción 148',73.79,22,5),(149,'P-000149','Producto 149','Descripción 149',80.00,32,2),(150,'P-000150','Producto 150','Descripción 150',7.91,76,4),(151,'P-000151','Producto 151','Descripción 151',72.79,81,5),(152,'P-000152','Producto 152','Descripción 152',9.34,73,3),(153,'P-000153','Producto 153','Descripción 153',82.02,88,5),(154,'P-000154','Producto 154','Descripción 154',9.07,61,4),(155,'P-000155','Producto 155','Descripción 155',11.33,19,4),(156,'P-000156','Producto 156','Descripción 156',61.09,13,5),(157,'P-000157','Producto 157','Descripción 157',81.77,55,2),(158,'P-000158','Producto 158','Descripción 158',91.86,64,3),(159,'P-000159','Producto 159','Descripción 159',41.12,64,1),(160,'P-000160','Producto 160','Descripción 160',9.43,44,5),(161,'P-000161','Producto 161','Descripción 161',43.99,32,2),(162,'P-000162','Producto 162','Descripción 162',64.98,26,2),(163,'P-000163','Producto 163','Descripción 163',10.58,38,4),(164,'P-000164','Producto 164','Descripción 164',91.77,74,5),(165,'P-000165','Producto 165','Descripción 165',55.99,92,5),(166,'P-000166','Producto 166','Descripción 166',1.63,20,5),(167,'P-000167','Producto 167','Descripción 167',18.56,5,4),(168,'P-000168','Producto 168','Descripción 168',40.49,88,2),(169,'P-000169','Producto 169','Descripción 169',38.41,29,2),(170,'P-000170','Producto 170','Descripción 170',79.57,96,3),(171,'P-000171','Producto 171','Descripción 171',28.25,10,4),(172,'P-000172','Producto 172','Descripción 172',11.32,50,1),(173,'P-000173','Producto 173','Descripción 173',43.23,59,4),(174,'P-000174','Producto 174','Descripción 174',52.99,66,4),(175,'P-000175','Producto 175','Descripción 175',71.80,35,4),(176,'P-000176','Producto 176','Descripción 176',13.56,74,2),(177,'P-000177','Producto 177','Descripción 177',45.99,27,5),(178,'P-000178','Producto 178','Descripción 178',13.45,69,1),(179,'P-000179','Producto 179','Descripción 179',34.45,45,2),(180,'P-000180','Producto 180','Descripción 180',92.50,84,3),(181,'P-000181','Producto 181','Descripción 181',70.21,16,4),(182,'P-000182','Producto 182','Descripción 182',19.58,75,1),(183,'P-000183','Producto 183','Descripción 183',70.50,94,3),(184,'P-000184','Producto 184','Descripción 184',11.12,79,4),(185,'P-000185','Producto 185','Descripción 185',86.30,36,2),(186,'P-000186','Producto 186','Descripción 186',3.75,51,3),(187,'P-000187','Producto 187','Descripción 187',69.98,15,4),(188,'P-000188','Producto 188','Descripción 188',97.30,79,1),(189,'P-000189','Producto 189','Descripción 189',94.43,52,4),(190,'P-000190','Producto 190','Descripción 190',27.68,8,3),(191,'P-000191','Producto 191','Descripción 191',64.95,51,4),(192,'P-000192','Producto 192','Descripción 192',48.87,63,4),(193,'P-000193','Producto 193','Descripción 193',55.46,70,5),(194,'P-000194','Producto 194','Descripción 194',17.56,30,5),(195,'P-000195','Producto 195','Descripción 195',7.24,36,4),(196,'P-000196','Producto 196','Descripción 196',5.07,35,4),(197,'P-000197','Producto 197','Descripción 197',9.96,59,4),(198,'P-000198','Producto 198','Descripción 198',59.65,95,5),(199,'P-000199','Producto 199','Descripción 199',2.89,21,5),(200,'P-000200','Producto 200','Descripción 200',20.48,12,5),(201,'P-000201','Producto 201','Descripción 201',60.79,5,3),(202,'P-000202','Producto 202','Descripción 202',10.10,14,3),(203,'P-000203','Producto 203','Descripción 203',66.39,6,2),(204,'P-000204','Producto 204','Descripción 204',38.56,98,4),(205,'P-000205','Producto 205','Descripción 205',92.35,28,4),(206,'P-000206','Producto 206','Descripción 206',47.16,35,2),(207,'P-000207','Producto 207','Descripción 207',79.17,83,5),(208,'P-000208','Producto 208','Descripción 208',60.09,53,5),(209,'P-000209','Producto 209','Descripción 209',69.69,90,3),(210,'P-000210','Producto 210','Descripción 210',52.91,29,5),(211,'P-000211','Producto 211','Descripción 211',51.18,92,1),(212,'P-000212','Producto 212','Descripción 212',65.81,3,1),(213,'P-000213','Producto 213','Descripción 213',83.00,59,3),(214,'P-000214','Producto 214','Descripción 214',62.95,69,4),(215,'P-000215','Producto 215','Descripción 215',94.79,91,4),(216,'P-000216','Producto 216','Descripción 216',83.44,3,4),(217,'P-000217','Producto 217','Descripción 217',16.23,85,5),(218,'P-000218','Producto 218','Descripción 218',45.64,86,5),(219,'P-000219','Producto 219','Descripción 219',12.65,80,4),(220,'P-000220','Producto 220','Descripción 220',79.67,5,5),(221,'P-000221','Producto 221','Descripción 221',32.14,90,3),(222,'P-000222','Producto 222','Descripción 222',19.73,23,3),(223,'P-000223','Producto 223','Descripción 223',10.47,84,5),(224,'P-000224','Producto 224','Descripción 224',5.15,50,2),(225,'P-000225','Producto 225','Descripción 225',29.14,37,1),(226,'P-000226','Producto 226','Descripción 226',91.97,56,1),(227,'P-000227','Producto 227','Descripción 227',70.90,29,2),(228,'P-000228','Producto 228','Descripción 228',88.42,35,1),(229,'P-000229','Producto 229','Descripción 229',59.20,56,1),(230,'P-000230','Producto 230','Descripción 230',48.55,32,1),(231,'P-000231','Producto 231','Descripción 231',85.83,79,2),(232,'P-000232','Producto 232','Descripción 232',55.28,60,2),(233,'P-000233','Producto 233','Descripción 233',5.02,12,3),(234,'P-000234','Producto 234','Descripción 234',8.67,94,3),(235,'P-000235','Producto 235','Descripción 235',58.03,44,3),(236,'P-000236','Producto 236','Descripción 236',8.27,96,3),(237,'P-000237','Producto 237','Descripción 237',94.42,2,2),(238,'P-000238','Producto 238','Descripción 238',30.78,71,4),(239,'P-000239','Producto 239','Descripción 239',13.30,69,1),(240,'P-000240','Producto 240','Descripción 240',33.07,40,1),(241,'P-000241','Producto 241','Descripción 241',86.81,29,5),(242,'P-000242','Producto 242','Descripción 242',52.01,95,2),(243,'P-000243','Producto 243','Descripción 243',16.82,22,4),(244,'P-000244','Producto 244','Descripción 244',40.97,19,4),(245,'P-000245','Producto 245','Descripción 245',23.75,88,4),(246,'P-000246','Producto 246','Descripción 246',93.52,51,4),(247,'P-000247','Producto 247','Descripción 247',40.04,62,5),(248,'P-000248','Producto 248','Descripción 248',78.38,12,2),(249,'P-000249','Producto 249','Descripción 249',89.38,71,5),(250,'P-000250','Producto 250','Descripción 250',34.31,2,1),(251,'P-000251','Producto 251','Descripción 251',31.22,33,4),(252,'P-000252','Producto 252','Descripción 252',70.94,31,3),(253,'P-000253','Producto 253','Descripción 253',32.38,25,2),(254,'P-000254','Producto 254','Descripción 254',74.80,83,5),(255,'P-000255','Producto 255','Descripción 255',9.63,72,2),(256,'P-000256','Producto 256','Descripción 256',50.87,53,1),(257,'P-000257','Producto 257','Descripción 257',9.21,4,5),(258,'P-000258','Producto 258','Descripción 258',63.20,29,3),(259,'P-000259','Producto 259','Descripción 259',7.54,59,4),(260,'P-000260','Producto 260','Descripción 260',97.15,60,1),(261,'P-000261','Producto 261','Descripción 261',68.17,11,3),(262,'P-000262','Producto 262','Descripción 262',30.76,94,5),(263,'P-000263','Producto 263','Descripción 263',20.21,58,2),(264,'P-000264','Producto 264','Descripción 264',86.20,33,1),(265,'P-000265','Producto 265','Descripción 265',50.43,21,3),(266,'P-000266','Producto 266','Descripción 266',7.35,74,3),(267,'P-000267','Producto 267','Descripción 267',25.92,80,2),(268,'P-000268','Producto 268','Descripción 268',75.53,7,1),(269,'P-000269','Producto 269','Descripción 269',42.52,72,2),(270,'P-000270','Producto 270','Descripción 270',62.09,2,2),(271,'P-000271','Producto 271','Descripción 271',18.93,19,2),(272,'P-000272','Producto 272','Descripción 272',37.80,71,3),(273,'P-000273','Producto 273','Descripción 273',13.29,29,1),(274,'P-000274','Producto 274','Descripción 274',42.17,93,2),(275,'P-000275','Producto 275','Descripción 275',14.99,58,3),(276,'P-000276','Producto 276','Descripción 276',60.27,60,1),(277,'P-000277','Producto 277','Descripción 277',17.24,27,5),(278,'P-000278','Producto 278','Descripción 278',51.55,96,2),(279,'P-000279','Producto 279','Descripción 279',58.79,4,3),(280,'P-000280','Producto 280','Descripción 280',11.65,23,5),(281,'P-000281','Producto 281','Descripción 281',44.63,73,2),(282,'P-000282','Producto 282','Descripción 282',55.72,72,5),(283,'P-000283','Producto 283','Descripción 283',52.37,80,3),(284,'P-000284','Producto 284','Descripción 284',85.15,89,5),(285,'P-000285','Producto 285','Descripción 285',98.41,11,4),(286,'P-000286','Producto 286','Descripción 286',73.52,83,5),(287,'P-000287','Producto 287','Descripción 287',24.52,38,1),(288,'P-000288','Producto 288','Descripción 288',76.81,28,1),(289,'P-000289','Producto 289','Descripción 289',82.87,72,1),(290,'P-000290','Producto 290','Descripción 290',55.78,34,1),(291,'P-000291','Producto 291','Descripción 291',24.97,7,4),(292,'P-000292','Producto 292','Descripción 292',91.11,67,4),(293,'P-000293','Producto 293','Descripción 293',14.68,83,4),(294,'P-000294','Producto 294','Descripción 294',14.37,53,2),(295,'P-000295','Producto 295','Descripción 295',53.19,98,2),(296,'P-000296','Producto 296','Descripción 296',66.88,37,5),(297,'P-000297','Producto 297','Descripción 297',14.47,16,3),(298,'P-000298','Producto 298','Descripción 298',52.00,38,2),(299,'P-000299','Producto 299','Descripción 299',68.94,33,4),(300,'P-000300','Producto 300','Descripción 300',11.34,68,1),(301,'P-000301','Producto 301','Descripción 301',45.56,96,3),(302,'P-000302','Producto 302','Descripción 302',38.34,55,4),(303,'P-000303','Producto 303','Descripción 303',36.82,2,1),(304,'P-000304','Producto 304','Descripción 304',10.68,41,4),(305,'P-000305','Producto 305','Descripción 305',59.86,68,4),(306,'P-000306','Producto 306','Descripción 306',0.65,20,5),(307,'P-000307','Producto 307','Descripción 307',35.78,80,5),(308,'P-000308','Producto 308','Descripción 308',45.02,32,2),(309,'P-000309','Producto 309','Descripción 309',35.50,98,5),(310,'P-000310','Producto 310','Descripción 310',24.37,70,5),(311,'P-000311','Producto 311','Descripción 311',90.83,12,5),(312,'P-000312','Producto 312','Descripción 312',8.24,74,3),(313,'P-000313','Producto 313','Descripción 313',7.08,97,4),(314,'P-000314','Producto 314','Descripción 314',43.93,17,3),(315,'P-000315','Producto 315','Descripción 315',23.61,52,5),(316,'P-000316','Producto 316','Descripción 316',2.64,36,4),(317,'P-000317','Producto 317','Descripción 317',73.93,38,4),(318,'P-000318','Producto 318','Descripción 318',43.05,99,4),(319,'P-000319','Producto 319','Descripción 319',48.15,32,1),(320,'P-000320','Producto 320','Descripción 320',89.77,96,1),(321,'P-000321','Producto 321','Descripción 321',81.54,64,4),(322,'P-000322','Producto 322','Descripción 322',99.58,61,1),(323,'P-000323','Producto 323','Descripción 323',64.45,92,4),(324,'P-000324','Producto 324','Descripción 324',67.73,31,3),(325,'P-000325','Producto 325','Descripción 325',78.22,27,1),(326,'P-000326','Producto 326','Descripción 326',28.85,37,1),(327,'P-000327','Producto 327','Descripción 327',96.34,76,5),(328,'P-000328','Producto 328','Descripción 328',28.26,67,3),(329,'P-000329','Producto 329','Descripción 329',59.56,40,2),(330,'P-000330','Producto 330','Descripción 330',1.64,33,4),(331,'P-000331','Producto 331','Descripción 331',22.97,19,2),(332,'P-000332','Producto 332','Descripción 332',93.30,74,5),(333,'P-000333','Producto 333','Descripción 333',43.76,38,3),(334,'P-000334','Producto 334','Descripción 334',81.88,31,1),(335,'P-000335','Producto 335','Descripción 335',68.52,4,1),(336,'P-000336','Producto 336','Descripción 336',71.14,4,1),(337,'P-000337','Producto 337','Descripción 337',41.20,72,2),(338,'P-000338','Producto 338','Descripción 338',75.06,59,4),(339,'P-000339','Producto 339','Descripción 339',92.27,38,1),(340,'P-000340','Producto 340','Descripción 340',54.80,32,5),(341,'P-000341','Producto 341','Descripción 341',93.09,71,4),(342,'P-000342','Producto 342','Descripción 342',67.55,9,3),(343,'P-000343','Producto 343','Descripción 343',90.18,20,2),(344,'P-000344','Producto 344','Descripción 344',90.37,61,2),(345,'P-000345','Producto 345','Descripción 345',94.91,67,3),(346,'P-000346','Producto 346','Descripción 346',52.40,9,5),(347,'P-000347','Producto 347','Descripción 347',29.91,73,4),(348,'P-000348','Producto 348','Descripción 348',78.13,50,1),(349,'P-000349','Producto 349','Descripción 349',43.03,58,4),(350,'P-000350','Producto 350','Descripción 350',32.88,80,1),(351,'P-000351','Producto 351','Descripción 351',68.91,39,5),(352,'P-000352','Producto 352','Descripción 352',25.15,60,2),(353,'P-000353','Producto 353','Descripción 353',51.51,77,2),(354,'P-000354','Producto 354','Descripción 354',41.76,3,5),(355,'P-000355','Producto 355','Descripción 355',49.92,73,1),(356,'P-000356','Producto 356','Descripción 356',65.87,77,5),(357,'P-000357','Producto 357','Descripción 357',21.91,36,1),(358,'P-000358','Producto 358','Descripción 358',74.28,21,5),(359,'P-000359','Producto 359','Descripción 359',50.78,5,4),(360,'P-000360','Producto 360','Descripción 360',56.73,59,2),(361,'P-000361','Producto 361','Descripción 361',67.38,48,3),(362,'P-000362','Producto 362','Descripción 362',58.65,70,4),(363,'P-000363','Producto 363','Descripción 363',72.55,32,3),(364,'P-000364','Producto 364','Descripción 364',20.59,72,1),(365,'P-000365','Producto 365','Descripción 365',88.42,38,2),(366,'P-000366','Producto 366','Descripción 366',17.90,9,5),(367,'P-000367','Producto 367','Descripción 367',44.82,39,4),(368,'P-000368','Producto 368','Descripción 368',2.09,17,5),(369,'P-000369','Producto 369','Descripción 369',57.14,39,2),(370,'P-000370','Producto 370','Descripción 370',14.66,93,2),(371,'P-000371','Producto 371','Descripción 371',29.98,84,2),(372,'P-000372','Producto 372','Descripción 372',2.70,20,5),(373,'P-000373','Producto 373','Descripción 373',6.38,51,2),(374,'P-000374','Producto 374','Descripción 374',37.70,73,3),(375,'P-000375','Producto 375','Descripción 375',43.49,59,4),(376,'P-000376','Producto 376','Descripción 376',61.25,2,2),(377,'P-000377','Producto 377','Descripción 377',26.00,50,4),(378,'P-000378','Producto 378','Descripción 378',26.04,3,2),(379,'P-000379','Producto 379','Descripción 379',81.58,93,2),(380,'P-000380','Producto 380','Descripción 380',22.88,53,5),(381,'P-000381','Producto 381','Descripción 381',28.11,47,3),(382,'P-000382','Producto 382','Descripción 382',30.76,89,3),(383,'P-000383','Producto 383','Descripción 383',1.85,47,2),(384,'P-000384','Producto 384','Descripción 384',17.45,91,1),(385,'P-000385','Producto 385','Descripción 385',45.77,17,3),(386,'P-000386','Producto 386','Descripción 386',90.27,6,4),(387,'P-000387','Producto 387','Descripción 387',85.89,46,4),(388,'P-000388','Producto 388','Descripción 388',33.55,43,1),(389,'P-000389','Producto 389','Descripción 389',64.79,65,2),(390,'P-000390','Producto 390','Descripción 390',77.62,82,5),(391,'P-000391','Producto 391','Descripción 391',60.29,55,5),(392,'P-000392','Producto 392','Descripción 392',27.07,38,1),(393,'P-000393','Producto 393','Descripción 393',37.77,57,4),(394,'P-000394','Producto 394','Descripción 394',90.61,35,1),(395,'P-000395','Producto 395','Descripción 395',28.78,22,2),(396,'P-000396','Producto 396','Descripción 396',56.14,7,4),(397,'P-000397','Producto 397','Descripción 397',14.46,70,1),(398,'P-000398','Producto 398','Descripción 398',41.20,73,3),(399,'P-000399','Producto 399','Descripción 399',5.12,89,2),(400,'P-000400','Producto 400','Descripción 400',97.43,87,3),(401,'P-000401','Producto 401','Descripción 401',55.80,48,4),(402,'P-000402','Producto 402','Descripción 402',33.19,38,5),(403,'P-000403','Producto 403','Descripción 403',49.09,66,5),(404,'P-000404','Producto 404','Descripción 404',30.68,94,5),(405,'P-000405','Producto 405','Descripción 405',29.01,96,5),(406,'P-000406','Producto 406','Descripción 406',92.50,72,5),(407,'P-000407','Producto 407','Descripción 407',17.11,23,4),(408,'P-000408','Producto 408','Descripción 408',71.03,49,2),(409,'P-000409','Producto 409','Descripción 409',20.79,2,3),(410,'P-000410','Producto 410','Descripción 410',45.54,75,3),(411,'P-000411','Producto 411','Descripción 411',81.58,82,4),(412,'P-000412','Producto 412','Descripción 412',96.77,76,5),(413,'P-000413','Producto 413','Descripción 413',38.85,12,3),(414,'P-000414','Producto 414','Descripción 414',95.47,37,1),(415,'P-000415','Producto 415','Descripción 415',88.33,41,3),(416,'P-000416','Producto 416','Descripción 416',89.08,17,1),(417,'P-000417','Producto 417','Descripción 417',41.52,51,2),(418,'P-000418','Producto 418','Descripción 418',16.53,79,3),(419,'P-000419','Producto 419','Descripción 419',1.51,63,1),(420,'P-000420','Producto 420','Descripción 420',74.13,31,2),(421,'P-000421','Producto 421','Descripción 421',89.72,37,1),(422,'P-000422','Producto 422','Descripción 422',75.70,25,1),(423,'P-000423','Producto 423','Descripción 423',33.58,61,1),(424,'P-000424','Producto 424','Descripción 424',42.47,96,3),(425,'P-000425','Producto 425','Descripción 425',90.76,85,3),(426,'P-000426','Producto 426','Descripción 426',14.31,9,1),(427,'P-000427','Producto 427','Descripción 427',94.45,58,1),(428,'P-000428','Producto 428','Descripción 428',69.71,21,5),(429,'P-000429','Producto 429','Descripción 429',26.36,37,1),(430,'P-000430','Producto 430','Descripción 430',26.39,8,4),(431,'P-000431','Producto 431','Descripción 431',99.93,3,1),(432,'P-000432','Producto 432','Descripción 432',82.12,54,2),(433,'P-000433','Producto 433','Descripción 433',71.12,74,3),(434,'P-000434','Producto 434','Descripción 434',72.11,83,5),(435,'P-000435','Producto 435','Descripción 435',48.45,43,4),(436,'P-000436','Producto 436','Descripción 436',28.83,28,3),(437,'P-000437','Producto 437','Descripción 437',98.52,21,1),(438,'P-000438','Producto 438','Descripción 438',3.06,74,4),(439,'P-000439','Producto 439','Descripción 439',84.55,38,2),(440,'P-000440','Producto 440','Descripción 440',81.67,89,1),(441,'P-000441','Producto 441','Descripción 441',50.29,39,3),(442,'P-000442','Producto 442','Descripción 442',18.54,50,5),(443,'P-000443','Producto 443','Descripción 443',25.20,40,2),(444,'P-000444','Producto 444','Descripción 444',15.31,94,2),(445,'P-000445','Producto 445','Descripción 445',44.06,44,5),(446,'P-000446','Producto 446','Descripción 446',11.87,92,2),(447,'P-000447','Producto 447','Descripción 447',59.90,16,1),(448,'P-000448','Producto 448','Descripción 448',71.80,45,1),(449,'P-000449','Producto 449','Descripción 449',26.36,93,5),(450,'P-000450','Producto 450','Descripción 450',70.31,80,5),(451,'P-000451','Producto 451','Descripción 451',13.46,94,2),(452,'P-000452','Producto 452','Descripción 452',78.29,94,2),(453,'P-000453','Producto 453','Descripción 453',99.97,90,3),(454,'P-000454','Producto 454','Descripción 454',83.43,64,4),(455,'P-000455','Producto 455','Descripción 455',75.31,54,3),(456,'P-000456','Producto 456','Descripción 456',72.41,20,5),(457,'P-000457','Producto 457','Descripción 457',59.75,46,3),(458,'P-000458','Producto 458','Descripción 458',25.02,66,3),(459,'P-000459','Producto 459','Descripción 459',88.16,68,4),(460,'P-000460','Producto 460','Descripción 460',77.59,58,4),(461,'P-000461','Producto 461','Descripción 461',26.76,52,5),(462,'P-000462','Producto 462','Descripción 462',45.57,86,5),(463,'P-000463','Producto 463','Descripción 463',23.30,26,4),(464,'P-000464','Producto 464','Descripción 464',33.89,81,1),(465,'P-000465','Producto 465','Descripción 465',82.28,95,2),(466,'P-000466','Producto 466','Descripción 466',67.13,43,1),(467,'P-000467','Producto 467','Descripción 467',48.56,95,2),(468,'P-000468','Producto 468','Descripción 468',72.30,66,1),(469,'P-000469','Producto 469','Descripción 469',72.54,19,5),(470,'P-000470','Producto 470','Descripción 470',50.97,8,5),(471,'P-000471','Producto 471','Descripción 471',19.22,29,5),(472,'P-000472','Producto 472','Descripción 472',61.40,37,1),(473,'P-000473','Producto 473','Descripción 473',93.25,63,2),(474,'P-000474','Producto 474','Descripción 474',2.15,94,4),(475,'P-000475','Producto 475','Descripción 475',53.87,66,4),(476,'P-000476','Producto 476','Descripción 476',51.65,47,5),(477,'P-000477','Producto 477','Descripción 477',77.27,33,2),(478,'P-000478','Producto 478','Descripción 478',86.97,21,3),(479,'P-000479','Producto 479','Descripción 479',71.26,14,3),(480,'P-000480','Producto 480','Descripción 480',52.98,86,4),(481,'P-000481','Producto 481','Descripción 481',14.65,48,5),(482,'P-000482','Producto 482','Descripción 482',41.02,13,3),(483,'P-000483','Producto 483','Descripción 483',86.28,94,1),(484,'P-000484','Producto 484','Descripción 484',94.57,25,3),(485,'P-000485','Producto 485','Descripción 485',35.89,52,3),(486,'P-000486','Producto 486','Descripción 486',17.98,24,4),(487,'P-000487','Producto 487','Descripción 487',69.16,40,5),(488,'P-000488','Producto 488','Descripción 488',47.19,55,2),(489,'P-000489','Producto 489','Descripción 489',7.90,35,3),(490,'P-000490','Producto 490','Descripción 490',57.99,31,5),(491,'P-000491','Producto 491','Descripción 491',26.07,77,1),(492,'P-000492','Producto 492','Descripción 492',19.68,66,4),(493,'P-000493','Producto 493','Descripción 493',70.58,30,3),(494,'P-000494','Producto 494','Descripción 494',15.22,51,1),(495,'P-000495','Producto 495','Descripción 495',11.61,17,3),(496,'P-000496','Producto 496','Descripción 496',17.82,26,4),(497,'P-000497','Producto 497','Descripción 497',12.35,26,5),(498,'P-000498','Producto 498','Descripción 498',6.43,39,5),(499,'P-000499','Producto 499','Descripción 499',81.31,65,5),(500,'P-000500','Producto 500','Descripción 500',31.17,98,5),(501,'P-0501','Producto 501','Descripción para el producto 501',34.99,34,1);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `reporteinventariogeneral`
--

DROP TABLE IF EXISTS `reporteinventariogeneral`;
/*!50001 DROP VIEW IF EXISTS `reporteinventariogeneral`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reporteinventariogeneral` AS SELECT 
 1 AS `id_producto`,
 1 AS `codigo`,
 1 AS `nombre`,
 1 AS `stock`,
 1 AS `precio`,
 1 AS `valor_total`,
 1 AS `ubicacion`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin'),(2,'almacen'),(3,'vendedor');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos_transaccion`
--

DROP TABLE IF EXISTS `tipos_transaccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos_transaccion` (
  `id_tipo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  PRIMARY KEY (`id_tipo`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos_transaccion`
--

LOCK TABLES `tipos_transaccion` WRITE;
/*!40000 ALTER TABLE `tipos_transaccion` DISABLE KEYS */;
INSERT INTO `tipos_transaccion` VALUES (1,'entrada'),(2,'salida');
/*!40000 ALTER TABLE `tipos_transaccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacciones`
--

DROP TABLE IF EXISTS `transacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacciones` (
  `id_transaccion` int NOT NULL AUTO_INCREMENT,
  `producto_id` int NOT NULL,
  `cambio_stock` int NOT NULL,
  `tipo_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_transaccion`),
  KEY `producto_id` (`producto_id`),
  KEY `tipo_id` (`tipo_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id_producto`),
  CONSTRAINT `transacciones_ibfk_2` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_transaccion` (`id_tipo`),
  CONSTRAINT `transacciones_ibfk_3` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacciones`
--

LOCK TABLES `transacciones` WRITE;
/*!40000 ALTER TABLE `transacciones` DISABLE KEYS */;
INSERT INTO `transacciones` VALUES (1,1,2,1,1,'2025-04-08 03:04:44'),(2,1,2,2,1,'2025-04-08 03:04:52');
/*!40000 ALTER TABLE `transacciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacciones_reportes_historia`
--

DROP TABLE IF EXISTS `transacciones_reportes_historia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transacciones_reportes_historia` (
  `id_transaccion` int NOT NULL,
  `producto_id` int NOT NULL,
  `cambio_stock` int NOT NULL,
  `tipo_id` int NOT NULL,
  `usuario_id` int NOT NULL,
  `fecha` date NOT NULL,
  PRIMARY KEY (`id_transaccion`,`fecha`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY RANGE (year(`fecha`))
(PARTITION p2021 VALUES LESS THAN (2022) ENGINE = InnoDB,
 PARTITION p2022 VALUES LESS THAN (2023) ENGINE = InnoDB,
 PARTITION p2023 VALUES LESS THAN (2024) ENGINE = InnoDB,
 PARTITION p2024 VALUES LESS THAN (2025) ENGINE = InnoDB,
 PARTITION p2025 VALUES LESS THAN (2026) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacciones_reportes_historia`
--

LOCK TABLES `transacciones_reportes_historia` WRITE;
/*!40000 ALTER TABLE `transacciones_reportes_historia` DISABLE KEYS */;
INSERT INTO `transacciones_reportes_historia` VALUES (1,1,2,1,1,'2025-04-07'),(2,1,2,2,1,'2025-04-07');
/*!40000 ALTER TABLE `transacciones_reportes_historia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicaciones`
--

DROP TABLE IF EXISTS `ubicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubicaciones` (
  `id_ubicacion` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id_ubicacion`),
  UNIQUE KEY `descripcion` (`descripcion`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicaciones`
--

LOCK TABLES `ubicaciones` WRITE;
/*!40000 ALTER TABLE `ubicaciones` DISABLE KEYS */;
INSERT INTO `ubicaciones` VALUES (1,'Almacén 1'),(2,'Almacén 2'),(3,'Almacén 3'),(4,'Almacén 4'),(5,'Almacén 5');
/*!40000 ALTER TABLE `ubicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(120) NOT NULL,
  `apellidos` varchar(120) NOT NULL,
  `correo` varchar(120) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `rol_id` int NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `correo` (`correo`),
  KEY `rol_id` (`rol_id`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Pablo Alfonso','Vargas Melgar','20034951@galileo.edu','11b817f3f351629c31ad47bffd97839d46d0d4c82708c417b9eade655ae7077c',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `reporteinventariogeneral`
--

/*!50001 DROP VIEW IF EXISTS `reporteinventariogeneral`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reporteinventariogeneral` AS select `p`.`id_producto` AS `id_producto`,`p`.`codigo` AS `codigo`,`p`.`nombre` AS `nombre`,`p`.`stock` AS `stock`,`p`.`precio` AS `precio`,(`p`.`stock` * `p`.`precio`) AS `valor_total`,`u`.`descripcion` AS `ubicacion` from (`productos` `p` left join `ubicaciones` `u` on((`p`.`ubicacion_id` = `u`.`id_ubicacion`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-08 21:55:08
