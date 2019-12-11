-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 21-10-2019 a las 21:28:02
-- Versión del servidor: 10.1.24-MariaDB
-- Versión de PHP: 7.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `dbalmuonline`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(55) NOT NULL,
  `nivelacceso` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_user`
--

CREATE TABLE `role_user` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `Dia` varchar(12) NOT NULL,
  `DeH` time NOT NULL,
  `HastaH` time NOT NULL,
  `Estado` varchar(2) NOT NULL DEFAULT 'AC'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmenu`
--

CREATE TABLE `tblmenu` (
  `idMenu` int(11) NOT NULL,
  `NombreMenu` varchar(65) NOT NULL,
  `idPlato` int(11) NOT NULL,
  `Tipo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpedidos`
--

CREATE TABLE `tblpedidos` (
  `idPedido` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
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
  `Tipo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Estructura de tabla para la tabla `tblproductos`
--

CREATE TABLE `tblproductos` (
  `idProducto` int(11) NOT NULL,
  `DescripcionProd` varchar(65) NOT NULL,
  `CantidadStock` int(11) NOT NULL,
  `Precio` double NOT NULL,
  `IdMenu` int(11) NOT NULL,
  `FechaMenu` date NOT NULL,
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
  `NombreApellidos` varchar(65) DEFAULT NULL,
  `Direccion` varchar(65) NOT NULL,
  `Telefono` int(11) NOT NULL,
  `rol` varchar(65) DEFAULT NULL,
  `email` varchar(35) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `role_user`
--
ALTER TABLE `role_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `user_id` (`user_id`);

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
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tblmenu`
--
ALTER TABLE `tblmenu`
  ADD PRIMARY KEY (`idMenu`),
  ADD KEY `idPlato` (`idPlato`);

--
-- Indices de la tabla `tblpedidos`
--
ALTER TABLE `tblpedidos`
  ADD PRIMARY KEY (`idPedido`),
  ADD KEY `idCliente` (`idCliente`),
  ADD KEY `idProducto` (`idProducto`),
  ADD KEY `UsuAdd` (`UsuAdd`);

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
-- Indices de la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  ADD PRIMARY KEY (`idProducto`),
  ADD KEY `IdMenu` (`IdMenu`),
  ADD KEY `UsuarioAdd` (`UsuarioAdd`);

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
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `role_user`
--
ALTER TABLE `role_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT de la tabla `tblhorarios`
--
ALTER TABLE `tblhorarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblmenu`
--
ALTER TABLE `tblmenu`
  MODIFY `idMenu` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblpedidos`
--
ALTER TABLE `tblpedidos`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblplatos`
--
ALTER TABLE `tblplatos`
  MODIFY `idPlatos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblpremios`
--
ALTER TABLE `tblpremios`
  MODIFY `idPremio` int(11) NOT NULL AUTO_INCREMENT;

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
-- Filtros para la tabla `role_user`
--
ALTER TABLE `role_user`
  ADD CONSTRAINT `role_user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `role_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

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
-- Filtros para la tabla `tblmenu`
--
ALTER TABLE `tblmenu`
  ADD CONSTRAINT `tblmenu_ibfk_1` FOREIGN KEY (`idPlato`) REFERENCES `tblplatos` (`idPlatos`);

--
-- Filtros para la tabla `tblpedidos`
--
ALTER TABLE `tblpedidos`
  ADD CONSTRAINT `tblpedidos_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `tblclientes` (`idCliente`),
  ADD CONSTRAINT `tblpedidos_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `tblproductos` (`idProducto`),
  ADD CONSTRAINT `tblpedidos_ibfk_3` FOREIGN KEY (`UsuAdd`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  ADD CONSTRAINT `tblproductos_ibfk_1` FOREIGN KEY (`IdMenu`) REFERENCES `tblmenu` (`idMenu`),
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
