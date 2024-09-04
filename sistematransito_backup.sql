-- MariaDB dump 10.19  Distrib 10.11.6-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: sistematransito
-- ------------------------------------------------------
-- Server version	10.11.6-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `entrega_final`
--

DROP TABLE IF EXISTS `entrega_final`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrega_final` (
  `id` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `id_entregador` int(11) NOT NULL,
  `id_tramite` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_entregador` (`id_entregador`),
  KEY `id_tramite` (`id_tramite`),
  CONSTRAINT `entrega_final_ibfk_1` FOREIGN KEY (`id_entregador`) REFERENCES `entregador` (`id`),
  CONSTRAINT `entrega_final_ibfk_2` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega_final`
--

LOCK TABLES `entrega_final` WRITE;
/*!40000 ALTER TABLE `entrega_final` DISABLE KEYS */;
/*!40000 ALTER TABLE `entrega_final` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entregador`
--

DROP TABLE IF EXISTS `entregador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entregador` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `entregador_ibfk_1` FOREIGN KEY (`id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entregador`
--

LOCK TABLES `entregador` WRITE;
/*!40000 ALTER TABLE `entregador` DISABLE KEYS */;
/*!40000 ALTER TABLE `entregador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES
(1,'Inicio de proceso'),
(2,'Listo para pasar a revision'),
(3,'En revision'),
(4,'Listo para recoger');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gestor_tramite`
--

DROP TABLE IF EXISTS `gestor_tramite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gestor_tramite` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `gestor_tramite_ibfk_1` FOREIGN KEY (`id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gestor_tramite`
--

LOCK TABLES `gestor_tramite` WRITE;
/*!40000 ALTER TABLE `gestor_tramite` DISABLE KEYS */;
INSERT INTO `gestor_tramite` VALUES
(2);
/*!40000 ALTER TABLE `gestor_tramite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operador`
--

DROP TABLE IF EXISTS `operador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operador` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `operador_ibfk_1` FOREIGN KEY (`id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operador`
--

LOCK TABLES `operador` WRITE;
/*!40000 ALTER TABLE `operador` DISABLE KEYS */;
INSERT INTO `operador` VALUES
(4);
/*!40000 ALTER TABLE `operador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ci` varchar(15) DEFAULT NULL,
  `nombre` varchar(30) DEFAULT NULL,
  `ap_materno` varchar(30) DEFAULT NULL,
  `ap_paterno` varchar(30) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES
(1,NULL,'Prueba','Prueba','Prueba',NULL,NULL,NULL),
(2,'2143657','Juanito','Wara','Gonzales','11111111','Prueba',NULL),
(3,'1234567','Harla','Erlang','Costas','1222222','Prueba',NULL),
(4,'2134567','Levin','Zapata','Nuñes','1333333','Prueba',NULL),
(5,'1243567','Guisela','Gutierrez','Mangal','1444444','Prueba',NULL);
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `propietario`
--

DROP TABLE IF EXISTS `propietario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `propietario` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `propietario_ibfk_1` FOREIGN KEY (`id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `propietario`
--

LOCK TABLES `propietario` WRITE;
/*!40000 ALTER TABLE `propietario` DISABLE KEYS */;
INSERT INTO `propietario` VALUES
(2);
/*!40000 ALTER TABLE `propietario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisor`
--

DROP TABLE IF EXISTS `revisor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisor` (
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `revisor_ibfk_1` FOREIGN KEY (`id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisor`
--

LOCK TABLES `revisor` WRITE;
/*!40000 ALTER TABLE `revisor` DISABLE KEYS */;
/*!40000 ALTER TABLE `revisor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_tramite`
--

DROP TABLE IF EXISTS `tipo_tramite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_tramite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_tramite`
--

LOCK TABLES `tipo_tramite` WRITE;
/*!40000 ALTER TABLE `tipo_tramite` DISABLE KEYS */;
INSERT INTO `tipo_tramite` VALUES
(1,'OpcionEjemplo1'),
(2,'OpcionEjemplo2');
/*!40000 ALTER TABLE `tipo_tramite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tramite`
--

DROP TABLE IF EXISTS `tramite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tramite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date DEFAULT NULL,
  `descripcion_documentos` varchar(200) DEFAULT NULL,
  `fecha_fin_probable` date DEFAULT NULL,
  `nro_patente` varchar(20) DEFAULT NULL,
  `observacion` varchar(200) DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  `id_tipo_tramite` int(11) NOT NULL,
  `id_propietario` int(11) NOT NULL,
  `id_gestor_tramite` int(11) NOT NULL,
  `id_operador` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_estado` (`id_estado`),
  KEY `id_tipo_tramite` (`id_tipo_tramite`),
  KEY `id_propietario` (`id_propietario`),
  KEY `id_gestor_tramite` (`id_gestor_tramite`),
  KEY `id_operador` (`id_operador`),
  CONSTRAINT `tramite_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id`),
  CONSTRAINT `tramite_ibfk_2` FOREIGN KEY (`id_tipo_tramite`) REFERENCES `tipo_tramite` (`id`),
  CONSTRAINT `tramite_ibfk_3` FOREIGN KEY (`id_propietario`) REFERENCES `propietario` (`id`),
  CONSTRAINT `tramite_ibfk_4` FOREIGN KEY (`id_gestor_tramite`) REFERENCES `gestor_tramite` (`id`),
  CONSTRAINT `tramite_ibfk_5` FOREIGN KEY (`id_operador`) REFERENCES `operador` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramite`
--

LOCK TABLES `tramite` WRITE;
/*!40000 ALTER TABLE `tramite` DISABLE KEYS */;
INSERT INTO `tramite` VALUES
(4,'2024-09-02','211','2024-09-29','111','',1,1,2,2,4);
/*!40000 ALTER TABLE `tramite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tramite_bajada`
--

DROP TABLE IF EXISTS `tramite_bajada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tramite_bajada` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `id_revisor` int(11) NOT NULL,
  `id_entregador` int(11) NOT NULL,
  `id_tramite` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_revisor` (`id_revisor`),
  KEY `id_entregador` (`id_entregador`),
  KEY `id_tramite` (`id_tramite`),
  CONSTRAINT `tramite_bajada_ibfk_1` FOREIGN KEY (`id_revisor`) REFERENCES `revisor` (`id`),
  CONSTRAINT `tramite_bajada_ibfk_2` FOREIGN KEY (`id_entregador`) REFERENCES `entregador` (`id`),
  CONSTRAINT `tramite_bajada_ibfk_3` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramite_bajada`
--

LOCK TABLES `tramite_bajada` WRITE;
/*!40000 ALTER TABLE `tramite_bajada` DISABLE KEYS */;
/*!40000 ALTER TABLE `tramite_bajada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tramite_subida`
--

DROP TABLE IF EXISTS `tramite_subida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tramite_subida` (
  `id` int(11) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `id_revisor` int(11) NOT NULL,
  `id_tramite` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_revisor` (`id_revisor`),
  KEY `id_tramite` (`id_tramite`),
  CONSTRAINT `tramite_subida_ibfk_1` FOREIGN KEY (`id_revisor`) REFERENCES `revisor` (`id`),
  CONSTRAINT `tramite_subida_ibfk_2` FOREIGN KEY (`id_tramite`) REFERENCES `tramite` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tramite_subida`
--

LOCK TABLES `tramite_subida` WRITE;
/*!40000 ALTER TABLE `tramite_subida` DISABLE KEYS */;
/*!40000 ALTER TABLE `tramite_subida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES
(1,'UsuarioPrueba','12345678');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-04  0:43:32
