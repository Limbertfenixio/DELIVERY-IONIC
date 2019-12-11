-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-10-2019 a las 18:11:59
-- Versión del servidor: 10.1.38-MariaDB
-- Versión de PHP: 7.3.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbalmuline`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblclientes`
--

CREATE TABLE `tblclientes` (
  `idCliente` int(11) NOT NULL,
  `NombreCliente` varchar(65) NOT NULL,
  `Celular` int(12) NOT NULL,
  `Direccion` varchar(95) NOT NULL,
  `fotoDireccion` varchar(45) NOT NULL,
  `Latitud` double NOT NULL,
  `Longitud` double NOT NULL,
  `Referencia` varchar(65) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldelivery`
--

CREATE TABLE `tbldelivery` (
  `idDeliv` int(11) NOT NULL,
  `idPedidio` int(11) NOT NULL,
  `NombreCliente` varchar(65) NOT NULL,
  `Producto` varchar(65) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Direccion` varchar(75) NOT NULL,
  `Referencia` varchar(65) NOT NULL,
  `Latitud` double NOT NULL,
  `Longitud` double NOT NULL,
  `Estado` varchar(25) NOT NULL,
  `FechaHoraDespachado` datetime NOT NULL,
  `FechaHoraEntregado` datetime NOT NULL,
  `usuarioMoto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblempresas`
--

CREATE TABLE `tblempresas` (
  `idEmpresa` int(11) NOT NULL,
  `NombreRazonSocial` varchar(65) NOT NULL,
  `Direccion` varchar(85) NOT NULL,
  `Zona` varchar(65) NOT NULL,
  `Latitud` double NOT NULL,
  `Longitud` double NOT NULL,
  `Telefono` int(15) NOT NULL,
  `Estado` varchar(10) NOT NULL DEFAULT 'Abierto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblempresas`
--

INSERT INTO `tblempresas` (`idEmpresa`, `NombreRazonSocial`, `Direccion`, `Zona`, `Latitud`, `Longitud`, `Telefono`, `Estado`) VALUES
(1, 'prueba', 'av bolivia', 'bolivia', -12321, -12312, 74578962, 'Abierto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblfidelizacion`
--

CREATE TABLE `tblfidelizacion` (
  `idFideliza` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idPuntos` int(11) NOT NULL,
  `idPremio` int(11) NOT NULL,
  `Premio` varchar(65) NOT NULL,
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL,
  `Estado` varchar(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblhorarios`
--

CREATE TABLE `tblhorarios` (
  `id` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  `Dia` varchar(12) NOT NULL,
  `DeH` time NOT NULL,
  `HastaH` time NOT NULL,
  `Estado` varchar(2) NOT NULL DEFAULT 'AC'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblhorarios`
--

INSERT INTO `tblhorarios` (`id`, `idEmpresa`, `Dia`, `DeH`, `HastaH`, `Estado`) VALUES
(5, 1, 'Lunes', '08:00:00', '12:00:00', 'AC'),
(6, 1, 'Martes', '14:00:00', '19:30:00', 'AC'),
(7, 1, 'Miercoles', '13:00:00', '21:00:00', 'AC'),
(8, 1, 'Jueves', '09:00:00', '22:00:00', 'AC'),
(9, 1, 'Viernes', '10:00:00', '24:00:00', 'AC');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpedidos`
--

CREATE TABLE `tblpedidos` (
  `idPedido` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idProdMenu` int(11) NOT NULL,
  `Producto` varchar(45) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Costo` double NOT NULL,
  `SubTotal` double NOT NULL,
  `Estado` varchar(25) NOT NULL,
  `FechaPedido` date NOT NULL,
  `HoraPedido` time NOT NULL,
  `UsuAdd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblplatos`
--

CREATE TABLE `tblplatos` (
  `idPlatos` int(11) NOT NULL,
  `Nombre` varchar(65) NOT NULL,
  `Tipo` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblplatos`
--

INSERT INTO `tblplatos` (`idPlatos`, `Nombre`, `Tipo`) VALUES
(1, 'Sopa de Mani', 'Sopas'),
(2, 'Sopa Angelical', 'Sopas'),
(3, 'Chairo Paceño', 'Sopas'),
(4, 'Milanesa de Pollo', 'Segundos'),
(5, 'Saice Tarijeño', 'Segundos'),
(6, 'Ensalda de Primavera', 'Entrada'),
(7, 'Gelatina', 'Postre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpremios`
--

CREATE TABLE `tblpremios` (
  `idPremio` int(11) NOT NULL,
  `De` int(11) NOT NULL,
  `Hasta` int(11) NOT NULL,
  `Premio` varchar(65) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblprodmenu`
--

CREATE TABLE `tblprodmenu` (
  `idProdMen` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `NombreMenu` varchar(65) NOT NULL,
  `idPla_Entrada` int(11) DEFAULT NULL,
  `NombreEntrada` varchar(65) DEFAULT NULL,
  `idPla_Sopa` int(11) NOT NULL,
  `NombreSopa` varchar(45) NOT NULL,
  `idPla_Segundo` int(11) NOT NULL,
  `NombreSegundo` varchar(55) NOT NULL,
  `idPla_Postre` int(11) DEFAULT NULL,
  `NombrePostre` varchar(55) DEFAULT NULL,
  `fotoMenu` varchar(65) NOT NULL,
  `Fecha` date NOT NULL,
  `Cantidad` int(3) NOT NULL,
  `Precio` double NOT NULL,
  `estado` varchar(2) NOT NULL DEFAULT 'AC',
  `AddUss` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblproductos`
--

CREATE TABLE `tblproductos` (
  `idProducto` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  `DescripcionProd` varchar(65) NOT NULL,
  `UsuarioAdd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpuntoscliente`
--

CREATE TABLE `tblpuntoscliente` (
  `idPuntos` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idVenta` int(11) NOT NULL,
  `NombreCliente` varchar(75) NOT NULL,
  `Puntos` int(11) NOT NULL DEFAULT '1',
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblventas`
--

CREATE TABLE `tblventas` (
  `idVentas` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `idDelivery` int(11) NOT NULL,
  `Cantidad` int(11) NOT NULL,
  `Costo` double NOT NULL,
  `Subtotal` double NOT NULL,
  `Fecha` date NOT NULL,
  `Hora` time NOT NULL,
  `Estado` varchar(25) NOT NULL,
  `UssAdd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  `NombreApellidos` varchar(65) DEFAULT NULL,
  `Direccion` varchar(65) NOT NULL,
  `Telefono` int(11) NOT NULL,
  `rol` varchar(65) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tblclientes`
--
ALTER TABLE `tblclientes`
  ADD PRIMARY KEY (`idCliente`);

--
-- Indices de la tabla `tbldelivery`
--
ALTER TABLE `tbldelivery`
  ADD PRIMARY KEY (`idDeliv`),
  ADD KEY `idPedidio` (`idPedidio`),
  ADD KEY `usuarioMoto` (`usuarioMoto`);

--
-- Indices de la tabla `tblempresas`
--
ALTER TABLE `tblempresas`
  ADD PRIMARY KEY (`idEmpresa`);

--
-- Indices de la tabla `tblfidelizacion`
--
ALTER TABLE `tblfidelizacion`
  ADD PRIMARY KEY (`idFideliza`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idPuntos` (`idPuntos`),
  ADD KEY `idPremio` (`idPremio`);

--
-- Indices de la tabla `tblhorarios`
--
ALTER TABLE `tblhorarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idEmpresa` (`idEmpresa`);

--
-- Indices de la tabla `tblpedidos`
--
ALTER TABLE `tblpedidos`
  ADD PRIMARY KEY (`idPedido`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `UsuAdd` (`UsuAdd`),
  ADD KEY `idProducto` (`idProdMenu`) USING BTREE;

--
-- Indices de la tabla `tblplatos`
--
ALTER TABLE `tblplatos`
  ADD PRIMARY KEY (`idPlatos`);

--
-- Indices de la tabla `tblpremios`
--
ALTER TABLE `tblpremios`
  ADD PRIMARY KEY (`idPremio`);

--
-- Indices de la tabla `tblprodmenu`
--
ALTER TABLE `tblprodmenu`
  ADD PRIMARY KEY (`idProdMen`) USING BTREE,
  ADD KEY `idPlato` (`idPla_Entrada`),
  ADD KEY `idPla_Sopa` (`idPla_Sopa`),
  ADD KEY `idPla_Segundo` (`idPla_Segundo`),
  ADD KEY `idPla_Postre` (`idPla_Postre`),
  ADD KEY `idEmpresa` (`idEmpresa`),
  ADD KEY `idProducto` (`idProducto`);

--
-- Indices de la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `UsuarioAdd` (`UsuarioAdd`),
  ADD KEY `idEmpresa` (`idEmpresa`);

--
-- Indices de la tabla `tblpuntoscliente`
--
ALTER TABLE `tblpuntoscliente`
  ADD PRIMARY KEY (`idPuntos`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idVenta` (`idVenta`);

--
-- Indices de la tabla `tblventas`
--
ALTER TABLE `tblventas`
  ADD PRIMARY KEY (`idVentas`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idProducto` (`idProducto`),
  ADD KEY `idDelivery` (`idDelivery`),
  ADD KEY `UssAdd` (`UssAdd`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idEmpresa` (`idEmpresa`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tblclientes`
--
ALTER TABLE `tblclientes`
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbldelivery`
--
ALTER TABLE `tbldelivery`
  MODIFY `idDeliv` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblempresas`
--
ALTER TABLE `tblempresas`
  MODIFY `idEmpresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tblhorarios`
--
ALTER TABLE `tblhorarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tblpedidos`
--
ALTER TABLE `tblpedidos`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblplatos`
--
ALTER TABLE `tblplatos`
  MODIFY `idPlatos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tblpremios`
--
ALTER TABLE `tblpremios`
  MODIFY `idPremio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblprodmenu`
--
ALTER TABLE `tblprodmenu`
  MODIFY `idProdMen` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblpuntoscliente`
--
ALTER TABLE `tblpuntoscliente`
  MODIFY `idPuntos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblventas`
--
ALTER TABLE `tblventas`
  MODIFY `idVentas` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbldelivery`
--
ALTER TABLE `tbldelivery`
  ADD CONSTRAINT `tbldelivery_ibfk_1` FOREIGN KEY (`idPedidio`) REFERENCES `tblpedidos` (`idPedido`),
  ADD CONSTRAINT `tbldelivery_ibfk_2` FOREIGN KEY (`usuarioMoto`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tblfidelizacion`
--
ALTER TABLE `tblfidelizacion`
  ADD CONSTRAINT `tblfidelizacion_ibfk_1` FOREIGN KEY (`idPremio`) REFERENCES `tblpremios` (`idPremio`),
  ADD CONSTRAINT `tblfidelizacion_ibfk_2` FOREIGN KEY (`idPuntos`) REFERENCES `tblpuntoscliente` (`idPuntos`),
  ADD CONSTRAINT `tblfidelizacion_ibfk_3` FOREIGN KEY (`idCliente`) REFERENCES `tblclientes` (`idCliente`);

--
-- Filtros para la tabla `tblhorarios`
--
ALTER TABLE `tblhorarios`
  ADD CONSTRAINT `tblhorarios_ibfk_1` FOREIGN KEY (`idEmpresa`) REFERENCES `tblempresas` (`idEmpresa`);

--
-- Filtros para la tabla `tblpedidos`
--
ALTER TABLE `tblpedidos`
  ADD CONSTRAINT `tblpedidos_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `tblclientes` (`idCliente`),
  ADD CONSTRAINT `tblpedidos_ibfk_3` FOREIGN KEY (`UsuAdd`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tblpedidos_ibfk_4` FOREIGN KEY (`idProdMenu`) REFERENCES `tblprodmenu` (`idProdMen`);

--
-- Filtros para la tabla `tblprodmenu`
--
ALTER TABLE `tblprodmenu`
  ADD CONSTRAINT `tblprodmenu_ibfk_1` FOREIGN KEY (`idPla_Entrada`) REFERENCES `tblplatos` (`idPlatos`),
  ADD CONSTRAINT `tblprodmenu_ibfk_2` FOREIGN KEY (`idPla_Sopa`) REFERENCES `tblplatos` (`idPlatos`),
  ADD CONSTRAINT `tblprodmenu_ibfk_3` FOREIGN KEY (`idPla_Segundo`) REFERENCES `tblplatos` (`idPlatos`),
  ADD CONSTRAINT `tblprodmenu_ibfk_4` FOREIGN KEY (`idPla_Postre`) REFERENCES `tblplatos` (`idPlatos`),
  ADD CONSTRAINT `tblprodmenu_ibfk_5` FOREIGN KEY (`idEmpresa`) REFERENCES `tblempresas` (`idEmpresa`),
  ADD CONSTRAINT `tblprodmenu_ibfk_6` FOREIGN KEY (`idProducto`) REFERENCES `tblproductos` (`idProducto`);

--
-- Filtros para la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  ADD CONSTRAINT `tblproductos_ibfk_2` FOREIGN KEY (`UsuarioAdd`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tblpuntoscliente`
--
ALTER TABLE `tblpuntoscliente`
  ADD CONSTRAINT `tblpuntoscliente_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `tblclientes` (`idCliente`),
  ADD CONSTRAINT `tblpuntoscliente_ibfk_2` FOREIGN KEY (`idVenta`) REFERENCES `tblventas` (`idVentas`);

--
-- Filtros para la tabla `tblventas`
--
ALTER TABLE `tblventas`
  ADD CONSTRAINT `tblventas_ibfk_1` FOREIGN KEY (`idDelivery`) REFERENCES `tbldelivery` (`idDeliv`),
  ADD CONSTRAINT `tblventas_ibfk_2` FOREIGN KEY (`UssAdd`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`idEmpresa`) REFERENCES `tblempresas` (`idEmpresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
