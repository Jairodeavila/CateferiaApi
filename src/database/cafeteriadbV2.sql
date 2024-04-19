/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - cafeteriadb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`cafeteriadb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `cafeteriadb`;

/*Table structure for table `categorias` */

DROP TABLE IF EXISTS `categorias`;

CREATE TABLE `categorias` (
  `Id_Cat` int(11) NOT NULL AUTO_INCREMENT,
  `Nom_Cat` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime NOT NULL,
  `activo` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`Id_Cat`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `categorias` */

insert  into `categorias`(`Id_Cat`,`Nom_Cat`,`createdAt`,`updatedAt`,`activo`) values 
(1,'Circuitos 1',NULL,'2024-04-18 23:11:23',1),
(2,'programacion','2024-03-21 01:48:47','2024-03-21 01:48:47',1),
(9,'destornilladores','2024-04-04 15:02:12','2024-04-04 15:02:12',1),
(10,'desarrollo web','2024-04-18 22:37:38','2024-04-18 22:37:38',1),
(11,'IA','2024-04-19 01:27:37','2024-04-19 01:28:57',1);

/*Table structure for table `detalle_compra` */

DROP TABLE IF EXISTS `detalle_compra`;

CREATE TABLE `detalle_compra` (
  `Id_Detalle` varchar(100) NOT NULL,
  `Id_Enc_FK` varchar(100) DEFAULT NULL,
  `Id_Prod_Fk` varchar(100) DEFAULT NULL,
  `cantidad` int(100) DEFAULT NULL,
  `Precio_U` decimal(10,2) DEFAULT NULL,
  `Prov_Id_FK` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id_Detalle`),
  KEY `Id_Compra` (`Id_Enc_FK`),
  KEY `Id_Prod_Fk` (`Id_Prod_Fk`),
  KEY `Prov_Id_FK` (`Prov_Id_FK`),
  CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`Id_Enc_FK`) REFERENCES `encabezado` (`ENC_ID`),
  CONSTRAINT `detalle_compra_ibfk_2` FOREIGN KEY (`Id_Prod_Fk`) REFERENCES `productos` (`PROD_ID`),
  CONSTRAINT `detalle_compra_ibfk_3` FOREIGN KEY (`Prov_Id_FK`) REFERENCES `proveedors` (`PROV_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalle_compra` */

/*Table structure for table `detalle_venta` */

DROP TABLE IF EXISTS `detalle_venta`;

CREATE TABLE `detalle_venta` (
  `Id_Det_Vent` varchar(100) NOT NULL,
  `Id_Enc_FK` varchar(100) DEFAULT NULL,
  `Id_Prod_Fk` varchar(100) DEFAULT NULL,
  `cantidad` int(100) DEFAULT NULL,
  `Precio_U` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Id_Det_Vent`),
  KEY `Id_Enc_FK` (`Id_Enc_FK`),
  KEY `Id_Prod_Fk` (`Id_Prod_Fk`),
  CONSTRAINT `detalle_venta_ibfk_1` FOREIGN KEY (`Id_Enc_FK`) REFERENCES `encabezado` (`ENC_ID`),
  CONSTRAINT `detalle_venta_ibfk_2` FOREIGN KEY (`Id_Prod_Fk`) REFERENCES `productos` (`PROD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalle_venta` */

/*Table structure for table `encabezado` */

DROP TABLE IF EXISTS `encabezado`;

CREATE TABLE `encabezado` (
  `ENC_ID` varchar(100) NOT NULL,
  `FECH_ENC` date DEFAULT NULL,
  `MET_PAGO` char(1) DEFAULT NULL,
  `TOTAL` decimal(10,2) DEFAULT NULL,
  `ID_USER_FK` varchar(100) DEFAULT NULL,
  `TIPO_ENCABE` char(1) DEFAULT NULL,
  PRIMARY KEY (`ENC_ID`),
  KEY `Id_User_FK` (`ID_USER_FK`),
  CONSTRAINT `encabezado_ibfk_2` FOREIGN KEY (`ID_USER_FK`) REFERENCES `usuarios` (`Id_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `encabezado` */

/*Table structure for table `factura` */

DROP TABLE IF EXISTS `factura`;

CREATE TABLE `factura` (
  `FACT_ID` varchar(100) NOT NULL,
  `ENC_ID_FK` varchar(100) NOT NULL,
  `TOTAL_COM` int(11) NOT NULL,
  `FACT_FECH` date NOT NULL,
  PRIMARY KEY (`FACT_ID`),
  KEY `id_VentaFK` (`ENC_ID_FK`),
  CONSTRAINT `factura_ibfk_3` FOREIGN KEY (`ENC_ID_FK`) REFERENCES `encabezado` (`ENC_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `factura` */

/*Table structure for table `inventarios` */

DROP TABLE IF EXISTS `inventarios`;

CREATE TABLE `inventarios` (
  `INV_ID` varchar(100) NOT NULL,
  `PROD_ID_FK` varchar(100) DEFAULT NULL,
  `PROD_CANT` int(11) DEFAULT NULL,
  `INV_EST` char(1) DEFAULT NULL COMMENT '1:STOK, 2:AGOTADO, 3:RESERVADO',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `activo` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`INV_ID`),
  KEY `producto_idFK` (`PROD_ID_FK`),
  CONSTRAINT `inventarios_ibfk_1` FOREIGN KEY (`PROD_ID_FK`) REFERENCES `productos` (`PROD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `inventarios` */

insert  into `inventarios`(`INV_ID`,`PROD_ID_FK`,`PROD_CANT`,`INV_EST`,`createdAt`,`updatedAt`,`activo`) values 
('9p6bgwklu1dgwqx','4343',4242,'A','2024-03-21 15:13:26','2024-03-21 15:19:14',NULL),
('9p6bgwklu1dh8vq','4343',10,'A','2024-03-21 15:13:41','2024-03-21 15:13:41',NULL),
('9p6bgwklu1dhaz9','4343',10,'A','2024-03-21 15:13:44','2024-03-21 15:13:44',NULL);

/*Table structure for table `localizacions` */

DROP TABLE IF EXISTS `localizacions`;

CREATE TABLE `localizacions` (
  `Id_Loc` int(11) NOT NULL AUTO_INCREMENT,
  `Dir_Ip` varchar(255) DEFAULT NULL,
  `Id_User_FK` varchar(100) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  `activo` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`Id_Loc`),
  KEY `Id_User_FK` (`Id_User_FK`),
  CONSTRAINT `localizacions_ibfk_1` FOREIGN KEY (`Id_User_FK`) REFERENCES `usuarios` (`Id_User`)
) ENGINE=InnoDB AUTO_INCREMENT=441 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `localizacions` */

insert  into `localizacions`(`Id_Loc`,`Dir_Ip`,`Id_User_FK`,`createdAt`,`updatedAt`,`activo`) values 
(50,'192.168.0.1','hle1ffcmolul8uo6n','2024-04-04 12:59:33','2024-04-04 16:06:24',1),
(434,'1111','hle1ffcmolul8uo6n','2024-04-04 11:02:49','2024-04-04 16:09:19',0),
(435,'192.168.0.1','erxyjd1aclv5t60t8','2024-04-18 22:23:39','2024-04-18 22:23:39',NULL),
(437,'192.168.0.1','erxyjd7a4lv603r9h','2024-04-19 01:37:50','2024-04-19 01:37:50',NULL),
(438,'192.168.0.5','erxyjd7a4lv603r9h','2024-04-19 01:51:07','2024-04-19 01:51:07',NULL),
(439,'192.168.9.1','erxyjd7a4lv603r9h','2024-04-19 17:48:04','2024-04-19 17:48:04',NULL),
(440,'8.8.8.4','erxyjd7a4lv603r9h','2024-04-19 17:50:49','2024-04-19 17:50:49',NULL);

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `PROD_ID` varchar(100) NOT NULL,
  `PROD_COD` varchar(100) DEFAULT NULL,
  `PROD_NOM` varchar(100) DEFAULT NULL,
  `PROD_DESC` text DEFAULT NULL,
  `PROD_PREC` decimal(10,2) DEFAULT NULL,
  `CAT_ID_FK` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`PROD_ID`),
  KEY `categoria_idFK` (`CAT_ID_FK`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`CAT_ID_FK`) REFERENCES `categorias` (`Id_Cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `productos` */

insert  into `productos`(`PROD_ID`,`PROD_COD`,`PROD_NOM`,`PROD_DESC`,`PROD_PREC`,`CAT_ID_FK`,`createdAt`,`updatedAt`) values 
('4343','4324','NEVERA','1134380338',12322222.00,1,'2024-03-20 22:01:13','2024-03-21 03:23:35'),
('ahyvadclu0nwpaz','0022','tv','full hd 4k',1502300.00,1,'2024-03-21 03:17:53','2024-03-21 03:17:53'),
('erxyjd154lv6xxawz','34432','tv','full hd 4k samsung',1502300.00,1,'2024-04-19 17:24:36','2024-04-19 17:24:36'),
('erxyjd3molv6xyonw','34324','tv','full hd 4k OLIMPO',1502300.00,1,'2024-04-19 17:25:41','2024-04-19 17:30:26');

/*Table structure for table `proveedors` */

DROP TABLE IF EXISTS `proveedors`;

CREATE TABLE `proveedors` (
  `PROV_ID` varchar(100) NOT NULL,
  `PROV_NOM` varchar(30) DEFAULT NULL,
  `PROV_CONTACTO` varchar(100) DEFAULT NULL,
  `PROV_EST` char(1) DEFAULT NULL COMMENT '1:ACTIVO, 2 INACTIVO, 3:SUSPENDIDO',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`PROV_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `proveedors` */

insert  into `proveedors`(`PROV_ID`,`PROV_NOM`,`PROV_CONTACTO`,`PROV_EST`,`createdAt`,`updatedAt`) values 
('9p6b9dolu1f5b9z','Proveedor32323231',NULL,'A','2024-03-21 16:00:24','2024-03-21 16:11:48'),
('9p6bfhglu1cd6tl','Proveedor 1',NULL,'A','2024-03-21 14:42:33','2024-03-21 14:42:33'),
('erxyjd4x0lv6wybq7','POSTOBON','postobon@gmail.com','A','2024-04-19 16:57:24','2024-04-19 17:36:38');

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `Id_Rol` int(11) NOT NULL AUTO_INCREMENT,
  `Nom_Rol` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `roles` */

insert  into `roles`(`Id_Rol`,`Nom_Rol`,`createdAt`,`updatedAt`) values 
(1,'Admin',NULL,NULL),
(2,'Empleado',NULL,NULL),
(3,'Cliente',NULL,'2024-03-21 00:34:44'),
(9,'mamaweb0','2024-04-19 02:55:47','2024-04-19 02:56:59');

/*Table structure for table `tokens` */

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `Id_Token` int(255) NOT NULL AUTO_INCREMENT,
  `Token` varchar(255) DEFAULT NULL,
  `Fec_Caducidad` varchar(100) DEFAULT NULL,
  `User_Id_FK` varchar(100) DEFAULT NULL,
  `Tipo_token` char(1) DEFAULT NULL COMMENT '1: inicio Sesion, 2: verificacion Email, 3: recuperacion de contraseña, 4: Verificar IP',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_Token`),
  KEY `Usuario_Id` (`User_Id_FK`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`User_Id_FK`) REFERENCES `usuarios` (`Id_User`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tokens` */

insert  into `tokens`(`Id_Token`,`Token`,`Fec_Caducidad`,`User_Id_FK`,`Tipo_token`,`createdAt`,`updatedAt`) values 
(11,'576627','1712236173','hle1ffcmolul8uo6n','1','2024-04-04 12:59:33','2024-04-04 12:59:33'),
(12,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJobGUxZmZjbW9sdWw4dW82biIsIk5vbV9Vc2VyIjoicGV0cm8iLCJBcGVfVXNlciI6InBlcmV6IiwiRW1hX1VzZXIiOiJ5b2luZXJwZXJ0dXpAZ21haWwuY29tIiwiSWRfUm9sX0ZLIjoxfSwiaWF0IjoxNzEyMjM1NTgzLCJleHAiOjE3MTIzMjE5ODN9.N','1712321983','hle1ffcmolul8uo6n','2','2024-04-04 12:59:43','2024-04-04 12:59:43'),
(13,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJobGUxZmZjbW9sdWw4dW82biIsIk5vbV9Vc2VyIjoicGV0cm8iLCJBcGVfVXNlciI6InBlcmV6IiwiRW1hX1VzZXIiOiJ5b2luZXJwZXJ0dXpAZ21haWwuY29tIiwiSWRfUm9sX0ZLIjoxfSwiaWF0IjoxNzEyMjM1NjMzLCJleHAiOjE3MTIzMjIwMzN9.5','1712322033','hle1ffcmolul8uo6n','2','2024-04-04 13:00:33','2024-04-04 13:00:33'),
(14,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJobGUxZmZjbW9sdWw4dW82biIsIk5vbV9Vc2VyIjoicGV0cm8iLCJBcGVfVXNlciI6InBlcmV6IiwiRW1hX1VzZXIiOiJ5b2luZXJwZXJ0dXpAZ21haWwuY29tIiwiSWRfUm9sX0ZLIjoxfSwiaWF0IjoxNzEzNDc2MDIxLCJleHAiOjE3MTM1NjI0MjF9._','1713562421','hle1ffcmolul8uo6n','2','2024-04-18 21:33:41','2024-04-18 21:33:41'),
(20,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJobGUxZmZjbW9sdWw4dW82biIsIk5vbV9Vc2VyIjoicGV0cm8iLCJBcGVfVXNlciI6InBlcmV6IiwiRW1hX1VzZXIiOiJ5b2luZXJwZXJ0dXpAZ21haWwuY29tIiwiSWRfUm9sX0ZLIjoxfSwiaWF0IjoxNzEzNDc5NjU2LCJleHAiOjE3MTM1NjYwNTZ9.W','1713566056','hle1ffcmolul8uo6n','2','2024-04-18 22:34:16','2024-04-18 22:34:16'),
(21,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJobGUxZmZjbW9sdWw4dW82biIsIk5vbV9Vc2VyIjoicGV0cm8iLCJBcGVfVXNlciI6InBlcmV6IiwiRW1hX1VzZXIiOiJ5b2luZXJwZXJ0dXpAZ21haWwuY29tIiwiSWRfUm9sX0ZLIjoxfSwiaWF0IjoxNzEzNDc5NzM0LCJleHAiOjE3MTM1NjYxMzR9.-','1713566134','hle1ffcmolul8uo6n','2','2024-04-18 22:35:34','2024-04-18 22:35:34'),
(23,'049548','1713491270','erxyjd7a4lv603r9h','1','2024-04-19 01:37:50','2024-04-19 01:37:50'),
(24,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJobGUxZmZjbW9sdWw4dW82biIsIk5vbV9Vc2VyIjoicGV0cm8iLCJBcGVfVXNlciI6InBlcmV6IiwiRW1hX1VzZXIiOiJ5b2luZXJwZXJ0dXpAZ21haWwuY29tIiwiSWRfUm9sX0ZLIjoxfSwiaWF0IjoxNzEzNDkxMTA2LCJleHAiOjE3MTM1Nzc1MDZ9.Q','1713577506','hle1ffcmolul8uo6n','2','2024-04-19 01:45:06','2024-04-19 01:45:06'),
(25,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJlcnh5amQ3YTRsdjYwM3I5aCIsIk5vbV9Vc2VyIjoiSmFpcm8iLCJBcGVfVXNlciI6IkRlIGF2aWxhIiwiRW1hX1VzZXIiOiJqb3NlY29ydGVzYW5kcmFkZTQxQGdtYWlsLmNvbSIsIklkX1JvbF9GSyI6M30sImlhdCI6MTcxMzQ5MTEzMSwiZXhwIjoxNz','1713577531','erxyjd7a4lv603r9h','2','2024-04-19 01:45:31','2024-04-19 01:45:31'),
(26,'387626','1713491848','erxyjd7a4lv603r9h','3','2024-04-19 01:47:28','2024-04-19 01:47:28'),
(27,'841339','1713493342','hle1ffcmolul8uo6n','3','2024-04-19 02:12:22','2024-04-19 02:12:22'),
(28,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJobGUxZmZjbW9sdWw4dW82biIsIk5vbV9Vc2VyIjoicGV0cm8iLCJBcGVfVXNlciI6InBlcmV6IiwiRW1hX1VzZXIiOiJ5b2luZXJwZXJ0dXpAZ21haWwuY29tIiwiSWRfUm9sX0ZLIjoxfSwiaWF0IjoxNzEzNDkyNzQ2LCJleHAiOjE3MTM1NzkxNDZ9.g','1713579146','hle1ffcmolul8uo6n','2','2024-04-19 02:12:26','2024-04-19 02:12:26'),
(29,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJlcnh5amQxYWNsdjV0NjB0OCIsIk5vbV9Vc2VyIjoiQW5kcmVhIiwiQXBlX1VzZXIiOiJwZXJleiIsIkVtYV9Vc2VyIjoid2lyb0BnbWFpbC5jb20iLCJJZF9Sb2xfRksiOjN9LCJpYXQiOjE3MTM0OTQ0NTcsImV4cCI6MTcxMzU4MDg1N30.E1RCKkFm0l','1713580857','erxyjd1aclv5t60t8','1','2024-04-19 02:40:57','2024-04-19 02:40:57'),
(30,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7IklkX1VzZXIiOiJlcnh5amQxYWNsdjV0NjB0OCIsIk5vbV9Vc2VyIjoiQW5kcmVhIiwiQXBlX1VzZXIiOiJwZXJleiIsIkVtYV9Vc2VyIjoid2lyb0BnbWFpbC5jb20iLCJJZF9Sb2xfRksiOjN9LCJpYXQiOjE3MTM0OTQ0ODcsImV4cCI6MTcxMzU4MDg4N30.DThE5pj_2P','1713580887','erxyjd1aclv5t60t8','1','2024-04-19 02:41:27','2024-04-19 02:41:27'),
(31,'227611','1713495098','hle1ffcmolul8uo6n','1','2024-04-19 02:41:38','2024-04-19 02:45:31');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `Id_User` varchar(100) NOT NULL,
  `Nom_User` varchar(255) DEFAULT NULL,
  `Ape_User` varchar(255) DEFAULT NULL,
  `Tel_User` varchar(20) DEFAULT NULL,
  `Ema_User` varchar(255) DEFAULT NULL,
  `Pass_User` varchar(255) DEFAULT NULL,
  `Id_Rol_FK` int(11) DEFAULT NULL,
  `Fot_User` varchar(255) DEFAULT NULL,
  `Est_Email_User` int(1) DEFAULT 0 COMMENT '0: No verificado, 1: verificado',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`Id_User`),
  KEY `Id_Rol_FK` (`Id_Rol_FK`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`Id_Rol_FK`) REFERENCES `roles` (`Id_Rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `usuarios` */

insert  into `usuarios`(`Id_User`,`Nom_User`,`Ape_User`,`Tel_User`,`Ema_User`,`Pass_User`,`Id_Rol_FK`,`Fot_User`,`Est_Email_User`,`createdAt`,`updatedAt`) values 
('erxyjd1aclv5t60t8','Andrea','perez','3004445577','wiro@gmail.com','$2b$10$06bglGa1ntkEdgsp9UV4Gejkc72Wm.XLZ9qWGAD3ZrtfXq3irIN0q',3,'3004445577',0,'2024-04-18 22:23:39','2024-04-19 02:06:28'),
('erxyjd7a4lv603r9h','Jairo','De avila',NULL,'josecortesandrade41@gmail.com','$2b$10$B18zG/zCfjMjEjM.bGgzhur2y.AKNiUHjnW02Q6q4gRN9yN.37JFy',3,NULL,1,'2024-04-19 01:37:50','2024-04-19 01:43:58'),
('hle1ffcmolul8uo6n','petro','perez',NULL,'yoinerpertuz@gmail.com','$2b$10$vK83JCqzwie8eda4lwaxw.cL2TNsAdWzR9mbfnOlZ/z9vkv3/OhV6',1,NULL,0,'2024-04-04 12:59:33','2024-04-04 12:59:33');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;