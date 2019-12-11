-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-11-2019 a las 21:32:18
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
  `Latitud` double NOT NULL,
  `Longitud` double NOT NULL,
  `Referencia` varchar(65) NOT NULL DEFAULT 'Ninguna'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblclientes`
--

INSERT INTO `tblclientes` (`idCliente`, `NombreCliente`, `Celular`, `Direccion`, `Latitud`, `Longitud`, `Referencia`) VALUES
(4, 'Limbert Canqui Tambo', 79676381, 'av. pensilvania', -16.5047387, -68.1550537, 'Ninguna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldelivery`
--

CREATE TABLE `tbldelivery` (
  `idDeliv` int(11) NOT NULL,
  `idPedido` int(11) NOT NULL,
  `DireccionEntrega` varchar(75) NOT NULL,
  `LatitudEntrega` double NOT NULL,
  `LongitudEntrega` double NOT NULL,
  `Estado` varchar(25) NOT NULL,
  `FechaHoraRecogido` datetime NOT NULL,
  `FechaHoraEnviado` datetime NOT NULL,
  `FechaHoraEntregado` datetime NOT NULL,
  `CIRepartidor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tbldelivery`
--

INSERT INTO `tbldelivery` (`idDeliv`, `idPedido`, `DireccionEntrega`, `LatitudEntrega`, `LongitudEntrega`, `Estado`, `FechaHoraRecogido`, `FechaHoraEnviado`, `FechaHoraEntregado`, `CIRepartidor`) VALUES
(1, 174027, '16 de Julio', -16.5047387, -16.5047387, 'enviado', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1489235);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbldeliveryubicacion`
--

CREATE TABLE `tbldeliveryubicacion` (
  `idDevUbica` int(11) NOT NULL,
  `idDeliv` int(11) NOT NULL,
  `latitud` double NOT NULL,
  `longitud` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tbldeliveryubicacion`
--

INSERT INTO `tbldeliveryubicacion` (`idDevUbica`, `idDeliv`, `latitud`, `longitud`) VALUES
(1, 1, -16.495964, -68.148987);

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
  `Estado` varchar(10) NOT NULL DEFAULT 'Abierto',
  `ServicioEmpresa` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblempresas`
--

INSERT INTO `tblempresas` (`idEmpresa`, `NombreRazonSocial`, `Direccion`, `Zona`, `Latitud`, `Longitud`, `Telefono`, `Estado`, `ServicioEmpresa`) VALUES
(1, 'RESTAURANT PRIMAVERA', 'Av. Sanchez Lima N° 3467 Esq. 20 de Octubre', 'Sopocachi', -16.495844, -68.149025, 77523456, 'Abierto', 'Almuerzo Tradicional'),
(2, 'RESTAURANT EL VEGETE', 'Av. Busch Nro 3467 Esq. Samuel Garcia', 'Miraflores', 0, 0, 77345679, 'Abierto', 'Almuerzo Vegetariano'),
(3, 'CHICHARRONERIA LA RIEL', 'Av. Busch N°4567 Esq. Miguel Gutierrez', 'Calacoto', 0, 0, 77456987, 'Abierto', 'Especial');

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
(1, 1, 'Lunes', '07:00:00', '23:00:00', 'AC'),
(2, 1, 'Martes', '00:00:00', '22:00:00', 'AC'),
(3, 1, 'Miercoles', '07:00:00', '20:00:00', 'AC'),
(4, 1, 'Jueves', '07:00:00', '23:59:00', 'AC'),
(5, 1, 'Viernes', '00:00:00', '23:27:00', 'AC'),
(6, 2, 'viernes', '09:00:00', '18:00:00', 'AC'),
(7, 2, 'sabado', '07:00:00', '18:00:00', 'AC'),
(8, 2, 'jueves', '09:00:00', '11:00:00', 'AC'),
(9, 2, 'miercoles', '09:30:00', '12:00:00', 'AC'),
(10, 2, 'martes', '08:00:00', '12:00:00', 'AC'),
(11, 2, 'domingo', '10:00:00', '18:00:00', 'AC');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmenu`
--

CREATE TABLE `tblmenu` (
  `idProdMen` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  `idProducto` int(11) NOT NULL,
  `NombreMenu` varchar(65) NOT NULL,
  `fotoMenu` varchar(65) NOT NULL,
  `Fecha` date NOT NULL,
  `Cantidad` int(3) NOT NULL,
  `Precio` double NOT NULL,
  `estado` varchar(2) NOT NULL DEFAULT 'AC',
  `AddUss` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblmenu`
--

INSERT INTO `tblmenu` (`idProdMen`, `idEmpresa`, `idProducto`, `NombreMenu`, `fotoMenu`, `Fecha`, `Cantidad`, `Precio`, `estado`, `AddUss`) VALUES
(5, 1, 1, 'ALMUERZO FAMILIAR VIERNES', '1MT20191101', '2019-11-15', 29, 20, 'AC', 1),
(8, 1, 2, 'ALMUERZO FAMILIAR VIERNES', '2MV20191101', '2019-11-08', 11, 25, 'AC', 1),
(9, 3, 3, 'CHICHARRON DE CERDEO DE CABANA', '', '2019-11-01', 50, 30, 'AC', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblmenudetalle`
--

CREATE TABLE `tblmenudetalle` (
  `idMendet` int(11) NOT NULL,
  `idProdMen` int(11) NOT NULL,
  `idplato` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblmenudetalle`
--

INSERT INTO `tblmenudetalle` (`idMendet`, `idProdMen`, `idplato`) VALUES
(1, 5, 10),
(2, 5, 12),
(3, 5, 15),
(4, 5, 19),
(5, 8, 9),
(6, 8, 11),
(7, 8, 17),
(8, 8, 18),
(9, 8, 24),
(10, 9, 8),
(13, 5, 18);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpedidodetalle`
--

CREATE TABLE `tblpedidodetalle` (
  `idPedDet` int(11) NOT NULL,
  `idPedido` int(11) NOT NULL,
  `Producto` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `Cantidad` int(4) NOT NULL,
  `PrecioVenta` double NOT NULL,
  `Descripcion` varchar(65) COLLATE utf8_spanish_ci NOT NULL,
  `Subtotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tblpedidodetalle`
--

INSERT INTO `tblpedidodetalle` (`idPedDet`, `idPedido`, `Producto`, `Cantidad`, `PrecioVenta`, `Descripcion`, `Subtotal`) VALUES
(4, 110914, 'ALMUERZO TRADICIONAL', 1, 20, '1 bolsa', 20),
(5, 174027, 'ALMUERZO TRADICIONAL', 2, 20, '1 solo segundo con una soda extra', 40),
(6, 170619, 'ALMUERZO TRADICIONAL', 3, 20, '1 sopa sin fideo', 60);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblpedidos`
--

CREATE TABLE `tblpedidos` (
  `idPedido` int(11) NOT NULL,
  `idCliente` int(11) NOT NULL,
  `idProdMenu` int(11) NOT NULL,
  `Estado` varchar(25) NOT NULL DEFAULT 'preparacion',
  `FechaPedido` date NOT NULL,
  `HoraPedido` time NOT NULL,
  `UsuAdd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblpedidos`
--

INSERT INTO `tblpedidos` (`idPedido`, `idCliente`, `idProdMenu`, `Estado`, `FechaPedido`, `HoraPedido`, `UsuAdd`) VALUES
(110644, 4, 5, 'preparacion', '2019-11-15', '19:14:02', 3),
(110914, 4, 5, 'preparacion', '2019-11-15', '19:17:47', 3),
(170619, 4, 5, 'preparacion', '2019-11-15', '20:06:52', 3),
(174027, 4, 5, 'preparacion', '2019-11-15', '20:03:48', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tblplatos`
--

CREATE TABLE `tblplatos` (
  `idPlatos` int(11) NOT NULL,
  `Nombre` varchar(65) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `Tipo` varchar(15) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `grupoProducto` varchar(65) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblplatos`
--

INSERT INTO `tblplatos` (`idPlatos`, `Nombre`, `Tipo`, `grupoProducto`) VALUES
(8, 'CHICHARON DE CERDO', 'Segundos', 'PLATO ESPECIAL'),
(9, 'ENSALDA DE ESPARRAGOS', 'Entrada', 'ALMUERZO VEGETARIANO'),
(10, 'ENSALDA DE SARDINA', 'Entrada', 'ALMUERZO TRADICIONAL'),
(11, 'SOPA DE VERDURAS', 'Sopas', 'ALMUERZO VEGETARIANO'),
(12, 'SOPA ANGELICAL', 'Sopas', 'ALMUERZO TRADICIONAL'),
(13, 'SOPA DE ESPARRAGOS', 'Sopas', 'ALMUERZO VEGETARIANO'),
(14, 'SOPA DE SEMOLA CON PAPAS', 'Sopas', 'ALMUERZO TRADICIONAL'),
(15, 'MILANESA DE POLLO', 'Segundos', 'ALMUERZO TRADICIONAL'),
(16, 'REVUELTO', 'Segundos', 'ALMUERZO TRADICIONAL'),
(17, 'CUPIS DE TRIGO', 'Segundos', 'ALMUERZO VEGETARIANO'),
(18, 'ALBONDIGAS VEGANAS', 'Segundos', 'ALMUERZO VEGETARIANO'),
(19, 'GELATINA', 'Postre', 'ALMUERZO TRADICIONAL'),
(20, 'COMPOTA DE PINA', 'Postre', 'ALMUERZO TRADICIONAL'),
(21, 'FLAN DE CHOCOLATE', 'Postre', 'ALMUERZO TRADICIONAL'),
(22, 'FLAN DE CHOCOLATE', 'Postre', 'ALMUERZO VEGETARIANO'),
(23, 'EMPANADA DE QUESO', 'Postre', 'ALMUERZO VEGETARIANO'),
(24, 'GELATINA DE PATA', 'Postre', 'ALMUERZO VEGETARIANO'),
(25, 'ENSALDA DE FRIAMBRE', 'Entrada', 'ALMUERZO TRADICIONAL');

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
  `idEmpresa` int(11) NOT NULL,
  `DescripcionProd` varchar(65) NOT NULL,
  `UsuarioAdd` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tblproductos`
--

INSERT INTO `tblproductos` (`idProducto`, `idEmpresa`, `DescripcionProd`, `UsuarioAdd`) VALUES
(1, 1, 'ALMUERZO TRADICIONAL', 1),
(2, 2, 'ALMUERZO VEGETARIANO', 1),
(3, 3, 'CHICHARON DE CERDO', 1);

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
-- Estructura de tabla para la tabla `tblrepartidor`
--

CREATE TABLE `tblrepartidor` (
  `CI` int(11) NOT NULL,
  `NombreApellidos` varchar(65) COLLATE utf8_spanish_ci NOT NULL,
  `Domicilio` varchar(65) COLLATE utf8_spanish_ci NOT NULL,
  `Email` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Password` varchar(85) COLLATE utf8_spanish_ci NOT NULL,
  `TipoVehiculo` varchar(35) COLLATE utf8_spanish_ci NOT NULL,
  `Placa` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `Ruat` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `Licencia` varchar(25) COLLATE utf8_spanish_ci NOT NULL,
  `Soat` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `FotoRepartidor` varchar(45) COLLATE utf8_spanish_ci NOT NULL,
  `Seguro` varchar(10) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tblrepartidor`
--

INSERT INTO `tblrepartidor` (`CI`, `NombreApellidos`, `Domicilio`, `Email`, `Password`, `TipoVehiculo`, `Placa`, `Ruat`, `Licencia`, `Soat`, `FotoRepartidor`, `Seguro`) VALUES
(1489235, 'Mauricio Gomezz', 'centro', 'mauricio@gmail.com', '12345678', 'Motocicleta', '3454XYS', '324234JU', '23423J4', '3443GG', 'wefwe434', 'si');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbltoken`
--

CREATE TABLE `tbltoken` (
  `id` int(11) NOT NULL,
  `celular` int(12) NOT NULL,
  `token` int(4) NOT NULL,
  `estado` varchar(3) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'ENV'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

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
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `idEmpresa`, `NombreApellidos`, `Direccion`, `Telefono`, `rol`, `email`, `password`) VALUES
(1, 1, 'Gustavo Peredo', 'CALLE 16 DE JULIO', 77550147, 'AdminSis', 'gusgus@gmail.com', '$2y$10$BOKnpUKHed65TvcwVdnvRu0Xu2DMRMbPZ.zPPbFyZTKJArptkpHd2'),
(2, 1, 'Limbert', 'Av. Santiago segundo N°23', 77423416, 'AdminSis', 'limbert@gmail.com', '$2y$10$zWgTl.VnjeBeDIwYRA4to.nrXMp2TFGwY73QKOkZqDFBfQYc0pWou');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tblclientes`
--
ALTER TABLE `tblclientes`
  ADD PRIMARY KEY (`idCliente`) USING BTREE;

--
-- Indices de la tabla `tbldelivery`
--
ALTER TABLE `tbldelivery`
  ADD PRIMARY KEY (`idDeliv`),
  ADD KEY `usuarioMoto` (`CIRepartidor`),
  ADD KEY `idPedido` (`idPedido`) USING BTREE;

--
-- Indices de la tabla `tbldeliveryubicacion`
--
ALTER TABLE `tbldeliveryubicacion`
  ADD PRIMARY KEY (`idDevUbica`),
  ADD KEY `idDeliv` (`idDeliv`);

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
-- Indices de la tabla `tblmenu`
--
ALTER TABLE `tblmenu`
  ADD PRIMARY KEY (`idProdMen`) USING BTREE,
  ADD KEY `Fecha` (`Fecha`) USING BTREE,
  ADD KEY `idEmpresa` (`idEmpresa`) USING BTREE,
  ADD KEY `idProducto` (`idProducto`) USING BTREE;

--
-- Indices de la tabla `tblmenudetalle`
--
ALTER TABLE `tblmenudetalle`
  ADD PRIMARY KEY (`idMendet`),
  ADD KEY `idProdMen` (`idProdMen`),
  ADD KEY `idplato` (`idplato`);

--
-- Indices de la tabla `tblpedidodetalle`
--
ALTER TABLE `tblpedidodetalle`
  ADD PRIMARY KEY (`idPedDet`),
  ADD KEY `idPedido` (`idPedido`);

--
-- Indices de la tabla `tblpedidos`
--
ALTER TABLE `tblpedidos`
  ADD PRIMARY KEY (`idPedido`) USING BTREE,
  ADD KEY `UsuAdd` (`UsuAdd`),
  ADD KEY `idProducto` (`idProdMenu`) USING BTREE,
  ADD KEY `idCliente` (`idCliente`) USING BTREE;

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
-- Indices de la tabla `tblrepartidor`
--
ALTER TABLE `tblrepartidor`
  ADD PRIMARY KEY (`CI`);

--
-- Indices de la tabla `tbltoken`
--
ALTER TABLE `tbltoken`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `idCliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tbldelivery`
--
ALTER TABLE `tbldelivery`
  MODIFY `idDeliv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tbldeliveryubicacion`
--
ALTER TABLE `tbldeliveryubicacion`
  MODIFY `idDevUbica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tblempresas`
--
ALTER TABLE `tblempresas`
  MODIFY `idEmpresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tblhorarios`
--
ALTER TABLE `tblhorarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tblmenu`
--
ALTER TABLE `tblmenu`
  MODIFY `idProdMen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tblmenudetalle`
--
ALTER TABLE `tblmenudetalle`
  MODIFY `idMendet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `tblpedidodetalle`
--
ALTER TABLE `tblpedidodetalle`
  MODIFY `idPedDet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `tblplatos`
--
ALTER TABLE `tblplatos`
  MODIFY `idPlatos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `tblpremios`
--
ALTER TABLE `tblpremios`
  MODIFY `idPremio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tblpuntoscliente`
--
ALTER TABLE `tblpuntoscliente`
  MODIFY `idPuntos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tbltoken`
--
ALTER TABLE `tbltoken`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tblventas`
--
ALTER TABLE `tblventas`
  MODIFY `idVentas` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbldelivery`
--
ALTER TABLE `tbldelivery`
  ADD CONSTRAINT `tbldelivery_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `tblpedidos` (`idPedido`),
  ADD CONSTRAINT `tbldelivery_ibfk_2` FOREIGN KEY (`CIRepartidor`) REFERENCES `tblrepartidor` (`CI`);

--
-- Filtros para la tabla `tbldeliveryubicacion`
--
ALTER TABLE `tbldeliveryubicacion`
  ADD CONSTRAINT `tbldeliveryubicacion_ibfk_1` FOREIGN KEY (`idDeliv`) REFERENCES `tbldelivery` (`idDeliv`);

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
-- Filtros para la tabla `tblmenu`
--
ALTER TABLE `tblmenu`
  ADD CONSTRAINT `tblmenu_ibfk_5` FOREIGN KEY (`idEmpresa`) REFERENCES `tblempresas` (`idEmpresa`),
  ADD CONSTRAINT `tblmenu_ibfk_6` FOREIGN KEY (`idProducto`) REFERENCES `tblproductos` (`idProducto`);

--
-- Filtros para la tabla `tblmenudetalle`
--
ALTER TABLE `tblmenudetalle`
  ADD CONSTRAINT `tblmenudetalle_ibfk_1` FOREIGN KEY (`idProdMen`) REFERENCES `tblmenu` (`idProdMen`),
  ADD CONSTRAINT `tblmenudetalle_ibfk_2` FOREIGN KEY (`idplato`) REFERENCES `tblplatos` (`idPlatos`);

--
-- Filtros para la tabla `tblpedidodetalle`
--
ALTER TABLE `tblpedidodetalle`
  ADD CONSTRAINT `tblpedidodetalle_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `tblpedidos` (`idPedido`);

--
-- Filtros para la tabla `tblpedidos`
--
ALTER TABLE `tblpedidos`
  ADD CONSTRAINT `tblpedidos_ibfk_2` FOREIGN KEY (`idProdMenu`) REFERENCES `tblmenu` (`idProdMen`),
  ADD CONSTRAINT `tblpedidos_ibfk_3` FOREIGN KEY (`idCliente`) REFERENCES `tblclientes` (`idCliente`);

--
-- Filtros para la tabla `tblproductos`
--
ALTER TABLE `tblproductos`
  ADD CONSTRAINT `tblproductos_ibfk_1` FOREIGN KEY (`idEmpresa`) REFERENCES `tblempresas` (`idEmpresa`),
  ADD CONSTRAINT `tblproductos_ibfk_2` FOREIGN KEY (`UsuarioAdd`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tblpuntoscliente`
--
ALTER TABLE `tblpuntoscliente`
  ADD CONSTRAINT `tblpuntoscliente_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `tblclientes` (`idCliente`);

--
-- Filtros para la tabla `tblventas`
--
ALTER TABLE `tblventas`
  ADD CONSTRAINT `tblventas_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `tblclientes` (`idCliente`);

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`idEmpresa`) REFERENCES `tblempresas` (`idEmpresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
