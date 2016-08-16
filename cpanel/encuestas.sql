/*
Navicat MySQL Data Transfer

Source Server         : Mysql
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : encuestas

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2016-08-16 13:58:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for encuestas
-- ----------------------------
DROP TABLE IF EXISTS `encuestas`;
CREATE TABLE `encuestas` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(8) NOT NULL,
  `encuesta` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `usuario_encuesta` (`id_usuario`),
  CONSTRAINT `usuario_encuesta` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for preguntas
-- ----------------------------
DROP TABLE IF EXISTS `preguntas`;
CREATE TABLE `preguntas` (
  `id` int(24) NOT NULL AUTO_INCREMENT,
  `id_encuesta` int(8) NOT NULL,
  `id_tipo_respuesta` int(4) NOT NULL,
  `pregunta` varchar(255) NOT NULL,
  `estado` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `encuesta_pregunta` (`id_encuesta`),
  KEY `tipo_respuesta` (`id_tipo_respuesta`),
  CONSTRAINT `encuesta_pregunta` FOREIGN KEY (`id_encuesta`) REFERENCES `encuestas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tipo_respuesta` FOREIGN KEY (`id_tipo_respuesta`) REFERENCES `tipo_respuesta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for respuestas
-- ----------------------------
DROP TABLE IF EXISTS `respuestas`;
CREATE TABLE `respuestas` (
  `id` int(24) NOT NULL AUTO_INCREMENT,
  `id_pregunta` int(24) NOT NULL,
  `respuesta` varchar(255) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `pregunta_respuesta` (`id_pregunta`),
  CONSTRAINT `pregunta_respuesta` FOREIGN KEY (`id_pregunta`) REFERENCES `preguntas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sesiones
-- ----------------------------
DROP TABLE IF EXISTS `sesiones`;
CREATE TABLE `sesiones` (
  `id` int(24) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(8) NOT NULL,
  `codigo` varchar(128) NOT NULL,
  `ip` varchar(64) NOT NULL,
  `estado` int(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sesion_usuario` (`id_usuario`),
  CONSTRAINT `sesion_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tipo_respuesta
-- ----------------------------
DROP TABLE IF EXISTS `tipo_respuesta`;
CREATE TABLE `tipo_respuesta` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(8) NOT NULL,
  `nombre` varchar(64) NOT NULL,
  `slug` varchar(255) NOT NULL COMMENT 'texto a mostrar (Formato: Json, configurable por el usuario)',
  PRIMARY KEY (`id`),
  KEY `tipo_respuesta_usuario` (`id_usuario`),
  CONSTRAINT `tipo_respuesta_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Por ejemplo 1- Rate, 2- Abierta, 3- 1 a 5\r\nLos registros del usuario 0 o el usuario administrador se muestra por default. Pero se agregan los registros del usuario que haya consultado.\r\nEstá tabla se nutre por la personalización de respuestas';

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(64) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `correo` varchar(64) NOT NULL,
  `contrasena` varchar(128) NOT NULL,
  `token` varchar(128) NOT NULL COMMENT 'Para loger desde web al servidor, es decir, doble verficación ',
  `tipo_usuario` int(4) NOT NULL,
  `estado` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
