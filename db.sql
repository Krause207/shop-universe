-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Апр 28 2023 г., 08:57
-- Версия сервера: 10.1.31-MariaDB
-- Версия PHP: 5.6.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `shop`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `descr` text,
  `parent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`, `descr`, `parent`) VALUES
(0, ' не выбрано', '', 0),
(8, 'Wi-fi роутеры', '', 0),
(12, 'Кабельное ТВ', 'Оборудование для предоставления доступа к сети Кабельного ТВ', 0),
(16, 'Для TV', 'Оборудование для предоставления доступа к медиапорталу', 0),
(17, 'Ноутбуки', 'Ноутбуки и нетбуки', 0),
(18, 'Планшеты', '', 0),
(19, 'Настольные компьютеры', '', 0),
(20, 'Материнские платы', '', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `discounts`
--

CREATE TABLE `discounts` (
  `id` int(11) NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `start` date NOT NULL,
  `stop` date NOT NULL,
  `name` varchar(200) NOT NULL COMMENT 'название акции/скидки'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='скидки и акции';

--
-- Дамп данных таблицы `discounts`
--

INSERT INTO `discounts` (`id`, `value`, `start`, `stop`, `name`) VALUES
(1, '5.00', '2010-06-01', '2025-12-31', 'подарочная'),
(2, '10.00', '2023-04-01', '2023-12-31', 'Скидка'),
(5, '1.00', '2023-10-01', '2023-10-31', 'новая');

-- --------------------------------------------------------

--
-- Структура таблицы `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `ord_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `items`
--

INSERT INTO `items` (`id`, `ord_id`, `product_id`, `amount`, `price`, `user_id`) VALUES
(17, 5, 27, '1.00', '451.00', 1),
(18, 5, 25, '2.00', '285.00', 1),
(20, 5, 24, '2.00', '105.00', 1),
(22, 5, 28, '1.00', '2100.00', 1),
(25, 8, 27, '3.00', '270.00', 1),
(28, 7, 28, '1.00', '2100.00', 20),
(29, 7, 25, '1.00', '769.50', 20),
(30, 0, 24, '8.00', '2700.00', 1),
(31, 0, 28, '1.00', '4200.00', 1),
(32, 9, 28, '1.00', '4200.00', 20),
(33, 9, 25, '1.00', '3000.00', 20),
(34, 9, 27, '1.00', '4800.00', 20),
(35, 10, 36, '1.00', '1542.00', 20),
(36, 10, 34, '1.00', '1182.75', 20);

-- --------------------------------------------------------

--
-- Структура таблицы `levels`
--

CREATE TABLE `levels` (
  `id` int(11) NOT NULL,
  `descr` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `levels`
--

INSERT INTO `levels` (`id`, `descr`) VALUES
(1, 'пользователь'),
(2, 'менеджер'),
(10, 'администратор');

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `dt` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `dt`, `user_id`, `status`) VALUES
(1, '2023-02-01 09:48:00', 1, 1),
(2, '2023-03-02 09:48:00', 19, 0),
(3, '2023-04-03 04:16:00', 20, 0),
(5, '2023-02-07 09:48:00', 1, 0),
(6, '2023-04-10 09:48:00', 1, 0),
(7, '2023-04-28 03:20:00', 20, 0),
(8, '2023-04-14 08:30:39', 1, 0),
(9, '2023-04-14 13:53:48', 20, 0),
(10, '2023-04-28 08:53:18', 20, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `descr` text,
  `cat_id` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `discount_id` int(11) NOT NULL COMMENT 'id акции или скидки',
  `date_add` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `weight` int(11) NOT NULL COMMENT 'масса',
  `length` int(11) NOT NULL COMMENT 'длина',
  `width` int(11) NOT NULL COMMENT 'ширина',
  `height` int(11) NOT NULL COMMENT 'высота',
  `amount` int(11) NOT NULL COMMENT 'количество'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `name`, `descr`, `cat_id`, `price`, `discount_id`, `date_add`, `weight`, `length`, `width`, `height`, `amount`) VALUES
(24, 'КАМ-модуль', 'Оборудование, которое достаточно вставить в телевизор для получения доступа к сети вещания каналов ТВ-пакетов \"Стандартный\" и \"Эксклюзивный\", а также премиальных пакетов в SD-, HD- и UltraHD-качестве.', 12, '2700.00', 0, '2022-10-05 11:35:20', 98, 0, 0, 0, 10),
(25, 'Wi-fi роутер Стандарт', 'Классический роутер для самого распространённого диапазона частот 2,4 ГГц.\r\n\r\nМаксимальная пропускная способность роутера в лабораторных условиях: до 50-70 Мбит/с.', 8, '3000.00', 0, '2022-10-13 08:37:16', 670, 0, 0, 0, 36),
(26, 'Медиацентр Премиум', '200руб/мес', 16, '5400.00', 0, '2022-11-11 11:37:58', 780, 0, 0, 0, 16),
(27, 'Медиацентр Стандарт', 'Аренда 150руб/мес', 16, '4800.00', 0, '2022-09-07 08:23:28', 260, 0, 0, 0, 50),
(28, 'Wi-fi роутер Премиум', 'Двухдиапазонный роутер с частотами 2,4 ГГц и 5 ГГц. Частота 5 ГГц позволяет снизить помехи и передавать данные на максимальной скорости в часы пик.\r\n\r\nМаксимальная пропускная способность роутера в лабораторных условиях: до 80-90 Мбит/с.', 12, '4200.00', 0, '2022-10-13 11:42:33', 870, 0, 0, 0, 47),
(32, 'Wi-fi роутер Профи', 'Двухдиапазонный роутер с частотами 2,4 ГГц и 5 ГГц. Подходит для тарифов от 100 Мбит/с и выше.\r\n\r\nМаксимальная пропускная способность роутера в лабораторных условиях с использованием оборудования с возможностью приёма больших пакетов данных: до 600 Мбит/с.', 8, '5400.00', 0, '2023-04-14 09:30:14', 1400, 0, 0, 0, 3),
(33, 'Ноутбук Tecno Megabook T1', '15.6\" 1920 x 1080, IPS, 60 Гц, Intel Core i3 1005G1, 12 ГБ LPDDR4X, SSD 256 ГБ, видеокарта встроенная, Linux, цвет крышки серебристый', 17, '600.00', 1, '2023-04-28 09:01:48', 1500, 0, 0, 0, 6),
(34, 'Игровой ноутбук MSI Pulse GL76', '17.3\" 1920 x 1080, IPS, 144 Гц, Intel Core i5 12500H, 16 ГБ DDR4, SSD 512 ГБ', 17, '1245.00', 1, '2023-04-28 09:02:41', 1850, 0, 0, 0, 8),
(35, 'Планшет Apple iPad 10.2\" 2021 64GB', '10.2\" IPS, 60 Гц (2160x1620), iPadOS, Apple A13 Bionic, ОЗУ 3 ГБ, флэш-память 64 ГБ', 18, '333.00', 0, '2023-04-28 09:03:43', 444, 0, 0, 0, 7),
(36, 'Компьютер Jet Gamer 5i10400FD', 'игровой (геймерский), CPU Intel Core i5 10400F 2900 МГц, RAM DDR4 16 ГБ, SSD 240 ГБ', 19, '1542.00', 0, '2023-04-28 09:09:23', 5780, 0, 0, 0, 6),
(37, 'Компьютер MultiGame 9C139K', 'CPU Intel Core i9 13900KF 2200 МГц, RAM DDR5 64 ГБ, SSD 2000 ГБ', 19, '1450.00', 0, '2023-04-28 09:10:12', 7245, 0, 0, 0, 1),
(38, 'Микро-ПК Chuwi Larkbox Pro', 'CPU Intel Celeron J4125 2000 МГц, RAM LPDDR4 6 ГБ, eMMC 128 ГБ', 19, '190.00', 0, '2023-04-28 09:12:44', 540, 0, 0, 0, 6);

-- --------------------------------------------------------

--
-- Структура таблицы `statuses`
--

CREATE TABLE `statuses` (
  `id` int(11) NOT NULL,
  `descr` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `statuses`
--

INSERT INTO `statuses` (`id`, `descr`) VALUES
(0, 'открыт'),
(1, 'закрыт'),
(2, 'удален'),
(4, 'отменен'),
(5, 'ожидает доставку');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `surname` varchar(100) DEFAULT NULL COMMENT 'фамилия',
  `name` varchar(100) NOT NULL,
  `middlename` varchar(100) NOT NULL,
  `rank` varchar(200) DEFAULT NULL COMMENT 'должность',
  `phone` varchar(15) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `login` varchar(20) DEFAULT NULL,
  `date_reg` datetime DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `surname`, `name`, `middlename`, `rank`, `phone`, `address`, `password`, `login`, `date_reg`, `email`, `level`) VALUES
(1, 'Чистяков', 'Михаил', 'Петрович', 'администратор', '7946134984', 'ул. солнцева, 44-234', 'admin', 'admin', NULL, NULL, 10),
(11, 'Парак', 'Олег', '', '', '79416316544', 'ул.Замова, 59-263', 'par', 'par', NULL, NULL, 1),
(12, '2234', '', '', '', '2234', '2234', '2234', '2234', NULL, NULL, 0),
(14, 'Живняк', 'Игорь', '', '', '', '', 'giv', 'giv', NULL, NULL, 2),
(19, 'Левина', 'Ольга', 'Аркадьевна', '', '', '', 'lev', 'lev', NULL, NULL, 1),
(20, 'test100', 'test100', 'test100', '', 'test100', 'test100', 'test100', 'test100', NULL, NULL, 1),
(21, 'Ковальчук', 'Илья', 'Ильич', '', '', '', 'kov', 'kov', NULL, NULL, 2),
(22, 'Субботин', 'Андрей', '', '', '', '', 'sub', 'sub', NULL, NULL, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `statuses`
--
ALTER TABLE `statuses`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT для таблицы `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
