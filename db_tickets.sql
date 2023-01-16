/*
 Navicat Premium Data Transfer

 Source Server         : prt
 Source Server Type    : MySQL
 Source Server Version : 100427
 Source Host           : localhost:3306
 Source Schema         : db_tickets

 Target Server Type    : MySQL
 Target Server Version : 100427
 File Encoding         : 65001

 Date: 16/01/2023 14:55:48
*/

CREATE DATABASE db_tickets;
use db_tickets;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for comentarios
-- ----------------------------
DROP TABLE IF EXISTS `comentarios`;
CREATE TABLE `comentarios`  (
  `idcomentarios` int NOT NULL AUTO_INCREMENT,
  `descripcionComentarios` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idcomentarios`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comentarios
-- ----------------------------
INSERT INTO `comentarios` VALUES (1, '.', 'A');
INSERT INTO `comentarios` VALUES (2, '', 'A');
INSERT INTO `comentarios` VALUES (3, '', 'A');

-- ----------------------------
-- Table structure for comentariostickets
-- ----------------------------
DROP TABLE IF EXISTS `comentariostickets`;
CREATE TABLE `comentariostickets`  (
  `idcomentariosTickets` int NOT NULL AUTO_INCREMENT,
  `comentarios_idcomentarios` int NOT NULL,
  `tickets_idTickets` int NOT NULL,
  PRIMARY KEY (`idcomentariosTickets`) USING BTREE,
  INDEX `fk_comentariosTickets_comentarios1_idx`(`comentarios_idcomentarios`) USING BTREE,
  INDEX `fk_comentariosTickets_tickets1_idx`(`tickets_idTickets`) USING BTREE,
  CONSTRAINT `fk_comentariosTickets_comentarios1` FOREIGN KEY (`comentarios_idcomentarios`) REFERENCES `comentarios` (`idcomentarios`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_comentariosTickets_tickets1` FOREIGN KEY (`tickets_idTickets`) REFERENCES `tickets` (`idTickets`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comentariostickets
-- ----------------------------
INSERT INTO `comentariostickets` VALUES (1, 1, 3);
INSERT INTO `comentariostickets` VALUES (2, 2, 12);
INSERT INTO `comentariostickets` VALUES (3, 3, 13);

-- ----------------------------
-- Table structure for empresa
-- ----------------------------
DROP TABLE IF EXISTS `empresa`;
CREATE TABLE `empresa`  (
  `idEmpresa` int NOT NULL AUTO_INCREMENT,
  `nombreEmpresa` varchar(35) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telefono` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idEmpresa`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empresa
-- ----------------------------
INSERT INTO `empresa` VALUES (1, 'Empresa Default', '12345678', 'default@gmail.com', 'A');
INSERT INTO `empresa` VALUES (5, 'Binbo', '554433213', 'Binbo@gmail.com ', 'A');
INSERT INTO `empresa` VALUES (6, 'Bodega', '5564272826', 'Bodega@gmail.com ', 'A');
INSERT INTO `empresa` VALUES (7, 'Continental', '5567882229', 'Continental.mex@gmail.com', 'I');
INSERT INTO `empresa` VALUES (8, 'Coppel', '5546377382', 'Coopel@outlook.com ', 'I');
INSERT INTO `empresa` VALUES (9, 'Santander', '554622211', 'Santander1@yahoo.com ', 'A');
INSERT INTO `empresa` VALUES (10, 'Sabritas', '557372822', 'Sabritas@gmail.com ', 'A');
INSERT INTO `empresa` VALUES (11, 'Liverpool ', '667838292', 'Liverpool@gmail.com ', 'I');

-- ----------------------------
-- Table structure for formadepago
-- ----------------------------
DROP TABLE IF EXISTS `formadepago`;
CREATE TABLE `formadepago`  (
  `idFormadePago` int NOT NULL AUTO_INCREMENT,
  `claveTarjeta` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `monto` double NOT NULL,
  `descripcion` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idFormadePago`) USING BTREE,
  INDEX `fk_formadePago_usuario1_idx`(`idUsuario`) USING BTREE,
  CONSTRAINT `fk_formadePago_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of formadepago
-- ----------------------------

-- ----------------------------
-- Table structure for gettickets
-- ----------------------------
DROP TABLE IF EXISTS `gettickets`;
CREATE TABLE `gettickets`  (
  `idGetTickets` int NOT NULL AUTO_INCREMENT,
  `idUsuarioProyecto` int NOT NULL,
  `idTickets` int NOT NULL,
  PRIMARY KEY (`idGetTickets`) USING BTREE,
  INDEX `fk_getTickets_usuarioProyecto1_idx`(`idUsuarioProyecto`) USING BTREE,
  INDEX `fk_getTickets_tickets1_idx`(`idTickets`) USING BTREE,
  CONSTRAINT `fk_getTickets_tickets1` FOREIGN KEY (`idTickets`) REFERENCES `tickets` (`idTickets`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_getTickets_usuarioProyecto1` FOREIGN KEY (`idUsuarioProyecto`) REFERENCES `usuarioproyecto` (`idUsuarioProyecto`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gettickets
-- ----------------------------
INSERT INTO `gettickets` VALUES (3, 2, 3);
INSERT INTO `gettickets` VALUES (12, 3, 12);
INSERT INTO `gettickets` VALUES (13, 3, 13);

-- ----------------------------
-- Table structure for incidentes
-- ----------------------------
DROP TABLE IF EXISTS `incidentes`;
CREATE TABLE `incidentes`  (
  `idIncidentes` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tickets_idTickets` int NOT NULL,
  PRIMARY KEY (`idIncidentes`) USING BTREE,
  INDEX `fk_incidentes_tickets1_idx`(`tickets_idTickets`) USING BTREE,
  CONSTRAINT `fk_incidentes_tickets1` FOREIGN KEY (`tickets_idTickets`) REFERENCES `tickets` (`idTickets`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of incidentes
-- ----------------------------
INSERT INTO `incidentes` VALUES (1, 'No se ejecuta correctamente la app en el movil', 'A', 1);
INSERT INTO `incidentes` VALUES (2, 'No se ejecuta correctamente la app en el movil', 'A', 2);
INSERT INTO `incidentes` VALUES (3, 'No funciona la app en el movil', 'A', 3);
INSERT INTO `incidentes` VALUES (4, 'Error al cargar archivos', 'A', 4);
INSERT INTO `incidentes` VALUES (5, 'Error al cargar archivos', 'A', 5);
INSERT INTO `incidentes` VALUES (6, 'Error al cargar archivos', 'A', 6);
INSERT INTO `incidentes` VALUES (7, 'Error al cargar archivos', 'A', 7);
INSERT INTO `incidentes` VALUES (8, 'Error al cargar archivos', 'A', 8);
INSERT INTO `incidentes` VALUES (9, 'Error al cargar archivos', 'A', 9);
INSERT INTO `incidentes` VALUES (10, 'Error al cargar archivos', 'A', 10);
INSERT INTO `incidentes` VALUES (11, 'Error al cargar archivos', 'A', 11);
INSERT INTO `incidentes` VALUES (12, 'No carga', 'A', 12);
INSERT INTO `incidentes` VALUES (13, 'Se congela la pantalla', 'A', 13);

-- ----------------------------
-- Table structure for permisos
-- ----------------------------
DROP TABLE IF EXISTS `permisos`;
CREATE TABLE `permisos`  (
  `idPermisos` int NOT NULL AUTO_INCREMENT,
  `nombrePermiso` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descripcionPermiso` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idPermisos`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permisos
-- ----------------------------
INSERT INTO `permisos` VALUES (1, 'HOME_USUARIO', '_', 'A');
INSERT INTO `permisos` VALUES (2, 'PERFIL_USUARIO', '_', 'A');
INSERT INTO `permisos` VALUES (3, 'HOME_ADMINISTRADOR', '_', 'A');
INSERT INTO `permisos` VALUES (4, 'LIST_EMPRESAS_ADMIN', '_', 'A');
INSERT INTO `permisos` VALUES (5, 'LIST_PROYECTOS_ADMIN', '_', 'A');
INSERT INTO `permisos` VALUES (6, 'LIST_USUARIOS_ADMIN', '_', 'A');
INSERT INTO `permisos` VALUES (7, 'FORM_USUARIO_ADMIN', '_', 'A');
INSERT INTO `permisos` VALUES (8, 'FORM_EMPRESA_ADMIN', '_', 'A');
INSERT INTO `permisos` VALUES (9, 'FORM_PROYECTO_ADMIN', '_', 'A');
INSERT INTO `permisos` VALUES (10, 'FORM_PROYECTO_USUARIO_ADMIN', '_', 'A');

-- ----------------------------
-- Table structure for proyectos
-- ----------------------------
DROP TABLE IF EXISTS `proyectos`;
CREATE TABLE `proyectos`  (
  `idProyectos` int NOT NULL AUTO_INCREMENT,
  `nombreProyecto` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descripcion` varchar(400) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idProyectos`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of proyectos
-- ----------------------------
INSERT INTO `proyectos` VALUES (1, 'App ticket', 'Permite al usuario reportar cualquier\n incidente con si tikets ', 'A');
INSERT INTO `proyectos` VALUES (2, 'App comida rap', 'Permite al usuario tener contacto \ncon las cocinas más cercanas \npara que no se arregle a salir', 'A');
INSERT INTO `proyectos` VALUES (3, 'App movil', 'Permite encontrar automóviles \nsin perdida de datos.', 'I');
INSERT INTO `proyectos` VALUES (4, 'App radio', 'No te pierdas tus estaciones \nfavoritas encuentra las frecuencias aquí.', 'A');
INSERT INTO `proyectos` VALUES (5, 'Uber', 'Aplicación para viajar \nSeguro', 'A');
INSERT INTO `proyectos` VALUES (6, 'Tvmovi', 'Ve películas gratis', 'I');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `idRoles` int NOT NULL AUTO_INCREMENT,
  `roles` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idRoles`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'USUARIO', 'A');
INSERT INTO `roles` VALUES (2, 'ADMINISTRADOR', 'A');
INSERT INTO `roles` VALUES (3, 'GERENTE', 'A');

-- ----------------------------
-- Table structure for rolespermisos
-- ----------------------------
DROP TABLE IF EXISTS `rolespermisos`;
CREATE TABLE `rolespermisos`  (
  `idrolesPermisos` int NOT NULL AUTO_INCREMENT,
  `roles_idRoles` int NOT NULL,
  `permisos_idPermisos` int NOT NULL,
  PRIMARY KEY (`idrolesPermisos`) USING BTREE,
  INDEX `fk_rolesPermisos_roles_idx`(`roles_idRoles`) USING BTREE,
  INDEX `fk_rolesPermisos_permisos1_idx`(`permisos_idPermisos`) USING BTREE,
  CONSTRAINT `fk_rolesPermisos_permisos1` FOREIGN KEY (`permisos_idPermisos`) REFERENCES `permisos` (`idPermisos`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_rolesPermisos_roles` FOREIGN KEY (`roles_idRoles`) REFERENCES `roles` (`idRoles`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rolespermisos
-- ----------------------------
INSERT INTO `rolespermisos` VALUES (1, 1, 1);
INSERT INTO `rolespermisos` VALUES (3, 2, 3);
INSERT INTO `rolespermisos` VALUES (4, 2, 4);
INSERT INTO `rolespermisos` VALUES (5, 2, 5);
INSERT INTO `rolespermisos` VALUES (6, 2, 6);
INSERT INTO `rolespermisos` VALUES (7, 2, 7);
INSERT INTO `rolespermisos` VALUES (8, 2, 8);
INSERT INTO `rolespermisos` VALUES (9, 2, 9);
INSERT INTO `rolespermisos` VALUES (10, 3, 3);
INSERT INTO `rolespermisos` VALUES (11, 3, 4);
INSERT INTO `rolespermisos` VALUES (12, 3, 5);
INSERT INTO `rolespermisos` VALUES (13, 3, 6);
INSERT INTO `rolespermisos` VALUES (14, 3, 7);
INSERT INTO `rolespermisos` VALUES (15, 3, 8);
INSERT INTO `rolespermisos` VALUES (16, 3, 9);
INSERT INTO `rolespermisos` VALUES (17, 2, 10);
INSERT INTO `rolespermisos` VALUES (18, 3, 10);
INSERT INTO `rolespermisos` VALUES (19, 1, 2);

-- ----------------------------
-- Table structure for tickets
-- ----------------------------
DROP TABLE IF EXISTS `tickets`;
CREATE TABLE `tickets`  (
  `idTickets` int NOT NULL AUTO_INCREMENT,
  `ticketsFolio` int NOT NULL,
  `fechaCreacion` date NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`idTickets`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tickets
-- ----------------------------
INSERT INTO `tickets` VALUES (1, 2147483647, '2012-02-23', 'A');
INSERT INTO `tickets` VALUES (2, 2147483647, '2012-02-23', 'A');
INSERT INTO `tickets` VALUES (3, 1233467, '2012-02-22', 'A');
INSERT INTO `tickets` VALUES (4, 2147483647, '2021-12-22', 'A');
INSERT INTO `tickets` VALUES (5, 472829282, '2021-12-22', 'A');
INSERT INTO `tickets` VALUES (6, 472829282, '0000-00-00', 'A');
INSERT INTO `tickets` VALUES (7, 472829282, '0000-00-00', 'A');
INSERT INTO `tickets` VALUES (8, 472829282, '2022-11-01', 'A');
INSERT INTO `tickets` VALUES (9, 12234667, '2021-12-11', 'A');
INSERT INTO `tickets` VALUES (10, 12234667, '0000-00-00', 'A');
INSERT INTO `tickets` VALUES (11, 12234667, '0000-00-00', 'A');
INSERT INTO `tickets` VALUES (12, 1234476, '0000-00-00', 'A');
INSERT INTO `tickets` VALUES (13, 2147483647, '0000-00-00', 'A');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apellidoMaterno` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `apellidoPaterno` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telefono` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idEmpresa` int NOT NULL,
  PRIMARY KEY (`idUsuario`) USING BTREE,
  UNIQUE INDEX `username_UNIQUE`(`username`) USING BTREE,
  INDEX `fk_usuario_empresa1_idx`(`idEmpresa`) USING BTREE,
  CONSTRAINT `fk_usuario_empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuario
-- ----------------------------
INSERT INTO `usuario` VALUES (1, 'Default', 'Dminguez', 'Sants', '12345678', 'admin', 'admin', 'A', 1);
INSERT INTO `usuario` VALUES (2, 'Yolotzin ', 'Santos', 'Dominguez ', '5512346732', 'Yolotzin', '1235', 'A', 6);
INSERT INTO `usuario` VALUES (3, 'Carlos', 'Espegel', 'Rodriguez', '5544332211', 'Carlos', '2320', 'A', 5);
INSERT INTO `usuario` VALUES (4, 'Angel ', 'Perez', 'Barrientos', '553327282', 'Angel', '1233456', 'A', 6);
INSERT INTO `usuario` VALUES (5, 'Luis ', 'Gutierrez', 'Tolentino ', '55426262', 'Luis', '123456l', 'I', 6);
INSERT INTO `usuario` VALUES (6, 'Yolanda', 'Cruz', 'Carteres', '554222727', 'Yolanda', '12345', 'I', 9);
INSERT INTO `usuario` VALUES (7, 'Teresa ', 'Perez', 'Castro', '556778822', 'Teresa', '1234', 'A', 6);

-- ----------------------------
-- Table structure for usuarioproyecto
-- ----------------------------
DROP TABLE IF EXISTS `usuarioproyecto`;
CREATE TABLE `usuarioproyecto`  (
  `idUsuarioProyecto` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `idProyectos` int NOT NULL,
  PRIMARY KEY (`idUsuarioProyecto`) USING BTREE,
  INDEX `fk_usuarioProyecto_usuario1_idx`(`idUsuario`) USING BTREE,
  INDEX `fk_usuarioProyecto_proyectos1_idx`(`idProyectos`) USING BTREE,
  CONSTRAINT `fk_usuarioProyecto_proyectos1` FOREIGN KEY (`idProyectos`) REFERENCES `proyectos` (`idProyectos`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_usuarioProyecto_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuarioproyecto
-- ----------------------------
INSERT INTO `usuarioproyecto` VALUES (1, 1, 1);
INSERT INTO `usuarioproyecto` VALUES (2, 2, 1);
INSERT INTO `usuarioproyecto` VALUES (3, 3, 2);
INSERT INTO `usuarioproyecto` VALUES (4, 4, 3);
INSERT INTO `usuarioproyecto` VALUES (5, 6, 5);
INSERT INTO `usuarioproyecto` VALUES (6, 6, 2);

-- ----------------------------
-- Table structure for usuarioroles
-- ----------------------------
DROP TABLE IF EXISTS `usuarioroles`;
CREATE TABLE `usuarioroles`  (
  `idusuarioRoles` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `idRoles` int NOT NULL,
  PRIMARY KEY (`idusuarioRoles`) USING BTREE,
  INDEX `fk_usuarioRoles_usuario1_idx`(`idUsuario`) USING BTREE,
  INDEX `fk_usuarioRoles_roles1_idx`(`idRoles`) USING BTREE,
  CONSTRAINT `fk_usuarioRoles_roles1` FOREIGN KEY (`idRoles`) REFERENCES `roles` (`idRoles`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_usuarioRoles_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuarioroles
-- ----------------------------
INSERT INTO `usuarioroles` VALUES (1, 1, 2);
INSERT INTO `usuarioroles` VALUES (2, 2, 2);
INSERT INTO `usuarioroles` VALUES (3, 3, 1);
INSERT INTO `usuarioroles` VALUES (4, 4, 1);
INSERT INTO `usuarioroles` VALUES (5, 5, 3);
INSERT INTO `usuarioroles` VALUES (6, 6, 1);
INSERT INTO `usuarioroles` VALUES (7, 7, 3);

-- ----------------------------
-- Procedure structure for SP_EMPRESA_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_EMPRESA_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_EMPRESA_ADD`(IN `pidEmpresa` INT, IN `pnombreEmpresa` VARCHAR(35), IN `ptelefono` VARCHAR(25), IN `pemail` VARCHAR(45), IN `pstatus` VARCHAR(1))
BEGIN
	INSERT INTO EMPRESA (
		nombreEmpresa,
        telefono,
        email,
        status
    )
    VALUES(
		pnombreEmpresa,
        ptelefono,
        pemail,
        pstatus
    );
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_EMPRESA_DELETE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_EMPRESA_DELETE`;
delimiter ;;
CREATE PROCEDURE `SP_EMPRESA_DELETE`(IN `pidEmpresa` INT)
BEGIN
	UPDATE EMPRESA SET status = 'I' WHERE idEmpresa = pidEmpresa;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_EMPRESA_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_EMPRESA_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_EMPRESA_EDIT`(IN `pidEmpresa` INT, IN `pnombreEmpresa` VARCHAR(35), IN `ptelefono` VARCHAR(25), IN `pemail` VARCHAR(45), IN `pstatus` VARCHAR(1))
BEGIN
	UPDATE EMPRESA SET 
		nombreEmpresa = pnombreEmpresa,
        telefono = ptelefono,
        email = pemail,
        status = pstatus
	WHERE idEmpresa = pidEmpresa;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_EMPRESA_FIND
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_EMPRESA_FIND`;
delimiter ;;
CREATE PROCEDURE `SP_EMPRESA_FIND`(IN `pid` INT)
BEGIN
	SELECT * FROM empresa WHERE idEmpresa = pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_EMPRESA_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_EMPRESA_LIST`;
delimiter ;;
CREATE PROCEDURE `SP_EMPRESA_LIST`()
BEGIN
	SELECT * FROM empresa;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_EMPRESA_LISTACTIVE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_EMPRESA_LISTACTIVE`;
delimiter ;;
CREATE PROCEDURE `SP_EMPRESA_LISTACTIVE`()
BEGIN
	SELECT * FROM empresa WHERE status = 'A';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_INCIDENTE_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_INCIDENTE_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_INCIDENTE_ADD`(IN `pidUsuario` INT, IN `pidProyecto` INT, IN `pticketsFolio` INT, IN `pfechaCreacion` DATE, IN `pdescripcionIncidente` VARCHAR(60), IN `pdescripcionComentario` VARCHAR(200))
BEGIN
	DECLARE pidTickets INT;
    DECLARE pidComentarios INT;
    
    INSERT INTO TICKETS(ticketsFolio, fechaCreacion, status) VALUES(pticketsFolio, pfechaCreacion, 'A');
    
    SET pidTickets = LAST_INSERT_ID();
    INSERT INTO INCIDENTES(descripcion, status, tickets_idTickets) VALUES(pdescripcionIncidente, 'A', pidTickets);
    INSERT INTO GETTICKETS (idUsuarioProyecto, idTickets) VALUES(pidUsuario, pidTickets);
    INSERT INTO COMENTARIOS (descripcionComentarios, status)VALUES(pdescripcionComentario, 'A');
    SET pidComentarios = LAST_INSERT_ID();
    INSERT INTO COMENTARIOSTICKETS(comentarios_idcomentarios, tickets_idTickets)VALUES(pidComentarios, pidTickets);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PERMISOS_FIND
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PERMISOS_FIND`;
delimiter ;;
CREATE PROCEDURE `SP_PERMISOS_FIND`(IN `pidPermisos` INT)
BEGIN
	SELECT * 
    FROM permisos 
    WHERE idPermisos = pidPermisos;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PERMISOS_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PERMISOS_LIST`;
delimiter ;;
CREATE PROCEDURE `SP_PERMISOS_LIST`()
BEGIN
	SELECT * 
    FROM permisos ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PROYECTO_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PROYECTO_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_PROYECTO_ADD`(IN `pidProyecto` INT, IN `pnombreProyecto` VARCHAR(60), IN `pdescripcion` VARCHAR(400), IN `pstatus` VARCHAR(1))
BEGIN
	INSERT INTO PROYECTOS (
		nombreProyecto, 
        descripcion, 
        status
	) VALUES (
		pnombreProyecto, 
        pdescripcion, 
        pstatus
	);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PROYECTO_DELETE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PROYECTO_DELETE`;
delimiter ;;
CREATE PROCEDURE `SP_PROYECTO_DELETE`(IN `pidProyecto` INT)
BEGIN
	UPDATE PROYECTOS SET
        status = 'I'
	WHERE idProyectos = pidProyecto;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PROYECTO_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PROYECTO_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_PROYECTO_EDIT`(IN `pidProyecto` INT, IN `pnombreProyecto` VARCHAR(60), IN `pdescripcion` VARCHAR(400), IN `pstatus` VARCHAR(1))
BEGIN
	UPDATE PROYECTOS SET
        nombreProyecto = pnombreProyecto ,
        descripcion = pdescripcion, 
        status = pstatus
	WHERE idProyectos = pidProyecto;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PROYECTO_FIND
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PROYECTO_FIND`;
delimiter ;;
CREATE PROCEDURE `SP_PROYECTO_FIND`(IN `pidProyecto` INT)
BEGIN
	SELECT * FROM PROYECTOS 
	WHERE idProyectos = pidProyecto;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PROYECTO_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PROYECTO_LIST`;
delimiter ;;
CREATE PROCEDURE `SP_PROYECTO_LIST`()
BEGIN
	SELECT * FROM PROYECTOS ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_PROYECTO_LISTACTIVE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_PROYECTO_LISTACTIVE`;
delimiter ;;
CREATE PROCEDURE `SP_PROYECTO_LISTACTIVE`()
BEGIN
	SELECT * FROM PROYECTOS WHERE status = 'A';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ROLESPERMISOS_LISTBYROL
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ROLESPERMISOS_LISTBYROL`;
delimiter ;;
CREATE PROCEDURE `SP_ROLESPERMISOS_LISTBYROL`(IN `pidRoles` INT)
BEGIN
	SELECT * 
    FROM rolespermisos 
    WHERE roles_idRoles = pidRoles;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ROLES_FIND
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ROLES_FIND`;
delimiter ;;
CREATE PROCEDURE `SP_ROLES_FIND`(IN `pidRoles` INT)
BEGIN
	SELECT * 
    FROM roles 
    WHERE idRoles = pidRoles;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ROLES_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ROLES_LIST`;
delimiter ;;
CREATE PROCEDURE `SP_ROLES_LIST`()
BEGIN
	SELECT * 
    FROM roles ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_ROLES_LISTACTIVE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_ROLES_LISTACTIVE`;
delimiter ;;
CREATE PROCEDURE `SP_ROLES_LISTACTIVE`()
BEGIN
	SELECT * FROM roles WHERE status = 'A';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIOPROYECTO_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIOPROYECTO_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIOPROYECTO_ADD`(IN `pidUsuarioProyecto` INT, IN `pidUsuario` INT, IN `pidProyecto` INT)
BEGIN
	INSERT INTO usuarioproyecto (
		idUsuario,
        idProyectos
    )VALUES(
		pidUsuario,
        pidProyecto
    );
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIOPROYECTO_FIND
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIOPROYECTO_FIND`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIOPROYECTO_FIND`(IN `pidUsuario` INT, IN `pidProyecto` INT)
BEGIN
	SELECT * FROM usuarioproyecto WHERE idUsuario = pidUsuario AND idProyectos = pidProyecto;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIOPROYECTO_LISTBYUSUARIO
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIOPROYECTO_LISTBYUSUARIO`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIOPROYECTO_LISTBYUSUARIO`(IN `pidUsuario` INT)
BEGIN
	SELECT * FROM usuarioproyecto WHERE idUsuario = pidUsuario;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIOROLES_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIOROLES_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIOROLES_ADD`(IN `pidusuarioRoles` INT, IN `pidUsuario` INT, IN `pidRoles` INT)
BEGIN
	INSERT INTO usuarioroles (
		idUsuario,
        idRoles
    )
    VALUES(
		pidUsuario,
        pidRoles
    );
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIOROLES_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIOROLES_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIOROLES_EDIT`(IN `pidusuarioRoles` INT, IN `pidUsuario` INT, IN `pidRoles` INT)
BEGIN
	UPDATE usuarioroles SET
		idRoles = pidRoles
    WHERE idUsuario = pidUsuario;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIOROLES_FINDBYUSER
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIOROLES_FINDBYUSER`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIOROLES_FINDBYUSER`(IN `pidUsuario` INT)
BEGIN
	SELECT * FROM usuarioroles WHERE idUsuario = pidUsuario;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIOROLES_LISTBYUSER
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIOROLES_LISTBYUSER`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIOROLES_LISTBYUSER`(IN `pidUsuario` INT)
BEGIN
	SELECT * 
    FROM usuarioroles 
    WHERE idUsuario = pidUsuario;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIO_ADD
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIO_ADD`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIO_ADD`(IN `pidUsuario` INT, IN `pnombre` VARCHAR(45), IN `papellidopaterno` VARCHAR(45), IN `papellidomaterno` VARCHAR(45), IN `ptelefono` CHAR(10), IN `pusername` VARCHAR(45), IN `ppassword` VARCHAR(10), IN `pstatus` VARCHAR(1), IN `pidEmpresa` INT)
BEGIN
	INSERT INTO USUARIO (
		nombre,
        apellidopaterno,
        apellidomaterno,
        telefono,
        username,
        password,
        status,
        idEmpresa
    )
    VALUES(
		pnombre,
        papellidopaterno,
        papellidomaterno,
        ptelefono,
        pusername,
        ppassword,
        pstatus,
        pidEmpresa
    );
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIO_DELETE
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIO_DELETE`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIO_DELETE`(IN `pidUsuario` INT)
BEGIN
	UPDATE USUARIO SET status = 'I' WHERE idUsuario = pidUsuario;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIO_EDIT
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIO_EDIT`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIO_EDIT`(IN `pidUsuario` INT, IN `pnombre` VARCHAR(45), IN `papellidopaterno` VARCHAR(45), IN `papellidomaterno` VARCHAR(45), IN `ptelefono` CHAR(10), IN `pusername` VARCHAR(45), IN `ppassword` VARCHAR(10), IN `pstatus` VARCHAR(1), IN `pidEmpresa` INT)
BEGIN
	UPDATE USUARIO SET
        nombre = pnombre,
        apellidopaterno = papellidopaterno,
        apellidomaterno = papellidomaterno,
        telefono = ptelefono,
        username = pusername,
        password = ppassword,
        status = pstatus,
        idEmpresa = pidEmpresa
	WHERE idUsuario = pidUsuario;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIO_FIND
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIO_FIND`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIO_FIND`(IN `pid` INT)
BEGIN
	SELECT * FROM usuario WHERE idUsuario = pid;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIO_FINDBYUSERNAME
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIO_FINDBYUSERNAME`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIO_FINDBYUSERNAME`(IN `pusername` VARCHAR(45))
BEGIN
	SELECT * 
    FROM usuario 
    WHERE username = pusername;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIO_LIST
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIO_LIST`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIO_LIST`()
BEGIN
	SELECT * FROM usuario;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for SP_USUARIO_LOGIN
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_USUARIO_LOGIN`;
delimiter ;;
CREATE PROCEDURE `SP_USUARIO_LOGIN`(IN `pusername` VARCHAR(45), IN `ppassword` VARCHAR(10))
BEGIN
	SELECT * FROM usuario WHERE username = pusername AND password = ppassword;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
