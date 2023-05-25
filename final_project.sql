-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2023 at 02:17 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `up` (IN `bill_no` INTEGER)   BEGIN
UPDATE bill set price = compute_price(bill_no) where bill_id = bill_no;
end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `compute_price` (`bill_no` INTEGER) RETURNS INT(11)  BEGIN 
DECLARE meal_no INTEGER;
DECLARE cost INTEGER;
DECLARE meal_quantity INTEGER;
DECLARE meal_price INTEGER;
DECLARE finished INTEGER DEFAULT 0;
DECLARE c CURSOR for SELECT meal_id,quantity FROM orders WHERE bill_id = bill_no;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
SET cost = 0;
OPEN c;

get_values: LOOP
FETCH FROM c INTO meal_no,meal_quantity;

IF finished = 1 THEN
LEAVE get_values;
END IF;

SELECT price into meal_price FROM meal WHERE meal_id = meal_no;
SET cost = cost + meal_price * meal_quantity;
END LOOP get_values;


CLOSE c;
RETURN cost;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bill`
--

CREATE TABLE `bill` (
  `bill_id` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bill`
--

INSERT INTO `bill` (`bill_id`, `price`) VALUES
(1234, NULL),
(1235, 300),
(1236, 1050),
(1237, 700),
(1238, 1080);

-- --------------------------------------------------------

--
-- Table structure for table `chef`
--

CREATE TABLE `chef` (
  `chef_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `salary` bigint(20) DEFAULT NULL,
  `cuisine` varchar(45) DEFAULT NULL,
  `experience` int(11) DEFAULT NULL,
  `sex` varchar(7) DEFAULT NULL,
  `phno` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chef`
--

INSERT INTO `chef` (`chef_id`, `name`, `salary`, `cuisine`, `experience`, `sex`, `phno`) VALUES
(101, 'Sunil', 45000, 'chinese', 3, 'male', 7895672341),
(102, 'Rahul', 30000, 'south indian', 2, 'male', 6783458761),
(103, 'Sonali', 60000, 'italian', 5, 'female', 4672874671),
(104, 'Ratan', 50000, 'northindian', 4, 'male', 7491089563),
(105, 'Reshma', 45000, 'lebanese', 4, 'female', 9284820818),
(106, 'priya', 45000, 'chinese', 4, 'female', 6284673829),
(107, 'prakash', 80000, 'italian', 6, 'male', 7295728472),
(108, 'tom', 60000, 'american', 3, 'male', 8629852983),
(109, 'divya', 80000, 'desserts', 4, 'female', 7436372366);

-- --------------------------------------------------------

--
-- Table structure for table `consists_of`
--

CREATE TABLE `consists_of` (
  `meal_id` int(11) DEFAULT NULL,
  `ing_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `consists_of`
--

INSERT INTO `consists_of` (`meal_id`, `ing_id`) VALUES
(601, 201),
(601, 201),
(601, 206),
(601, 207),
(601, 204),
(601, 210),
(602, 201),
(602, 219),
(602, 202),
(602, 204),
(602, 210),
(602, 207),
(602, 206),
(602, 208),
(602, 211),
(603, 217),
(603, 220),
(603, 212),
(603, 209),
(604, 203),
(604, 204),
(604, 210),
(604, 214),
(604, 216),
(605, 201),
(605, 211),
(606, 204),
(606, 210),
(606, 213),
(606, 216),
(607, 203),
(607, 215),
(608, 203),
(608, 215),
(609, 202),
(609, 204),
(609, 210),
(609, 216),
(609, 206),
(610, 204),
(610, 206),
(610, 210),
(611, 202),
(611, 207),
(611, 210),
(611, 216),
(611, 206),
(612, 208),
(612, 205),
(612, 218),
(613, 219),
(613, 206),
(613, 211),
(613, 204),
(614, 201),
(614, 217),
(614, 219),
(614, 209),
(615, 201),
(615, 208),
(615, 209),
(615, 218);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `phno` bigint(20) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `name`, `phno`, `address`) VALUES
(3001, 'harsha', 8296444590, '31/2 RT road Bangalore'),
(3002, 'chandan', 2345287492, '21/34 MR road Bangalore'),
(3003, 'atharv', 5573948930, '39/21 CT road Bangalore '),
(3004, 'puneeth', 8757294759, '21/32 MM road Mysore'),
(3005, 'ishaan', 8583957602, '90/11 KR road Tumkur'),
(3006, 'isha', 7391257295, '21//33 LT road Davangere'),
(3007, 'ram', 7382957482, '43/22 RR road Bangalore'),
(3008, 'geetha', 8147483028, '56/5 MK road Bangalore'),
(3009, 'suresh', 8472857692, '2/2 ML street Dharwad'),
(3010, 'tarun', 74138074102, '20/11 KR road Bangalore'),
(3011, 'vishak', 9843213478, '56/32 MP street mumbai'),
(3012, 'roopa', 8731492812, '32/45 TN street Chennai'),
(3013, 'dcd', 7689, 'dfrg'),
(3014, 'Yogitha', 7259392738, '12/uiop');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `ingredients_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `shelf_life` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ingredients`
--

INSERT INTO `ingredients` (`ingredients_id`, `name`, `shelf_life`) VALUES
(201, 'flour', '1 year'),
(202, 'noodles', '1 year'),
(203, 'rice', '2 years'),
(204, 'vegetables', '1 week'),
(205, 'fruits', '1 week'),
(206, 'sauces', '10 months'),
(207, 'cheese', '2 months'),
(208, 'milk', '1 week'),
(209, 'sugar', '1 year'),
(210, 'spices', '2 years'),
(211, 'butter', '1 month'),
(212, 'ice cream', '1 month'),
(213, 'chicken', '1 week'),
(214, 'mutton', '1 week'),
(215, 'lentils', '2 years'),
(216, 'greens', '4 days'),
(217, 'chocholates', '5 months'),
(218, 'eggs', '2 weeks'),
(219, 'bread', '3 days'),
(220, 'biscuits ', '1 month');

-- --------------------------------------------------------

--
-- Table structure for table `meal`
--

CREATE TABLE `meal` (
  `meal_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `preference` varchar(45) DEFAULT NULL,
  `chef_id` int(11) DEFAULT NULL,
  `cuisine` varchar(45) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meal`
--

INSERT INTO `meal` (`meal_id`, `name`, `preference`, `chef_id`, `cuisine`, `price`) VALUES
(601, 'pizza', 'veg', 103, 'italian', 450),
(602, 'pasta', 'veg', 107, 'italian', 350),
(603, 'chocolate milkshake', 'veg', 109, 'desserts', 200),
(604, 'biryani', 'non veg', 104, 'north indian', 400),
(605, 'roti', 'veg', 104, 'north indian', 100),
(606, 'curry', 'non veg', 104, 'north indian', 200),
(607, 'idly', 'veg', 102, 'south indian', 100),
(608, 'dosa', 'veg', 102, 'south indian', 150),
(609, 'noodles', 'veg', 101, 'chinese', 300),
(610, 'manchurian', 'veg', 106, 'chinese', 280),
(611, 'mac and cheese', 'veg', 108, 'american', 370),
(612, 'panna cota', 'veg', 107, 'italian', 260),
(613, 'sandwich ', 'veg', 103, 'american', 250),
(614, 'brownies', 'egg', 109, 'desserts', 180),
(615, 'cake', 'egg', 109, 'desserts', 180);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `customer_id` int(11) DEFAULT NULL,
  `meal_id` int(11) DEFAULT NULL,
  `bill_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`customer_id`, `meal_id`, `bill_id`, `quantity`) VALUES
(3003, 604, 1235, 1),
(3002, 614, 1234, 1),
(3001, 602, 1236, 1),
(3001, 602, 1236, 2),
(3001, 602, 1237, 2),
(3014, 614, 1238, 3),
(3014, 615, 1238, 3);

-- --------------------------------------------------------

--
-- Table structure for table `provides`
--

CREATE TABLE `provides` (
  `supplier_id` int(11) DEFAULT NULL,
  `ingredients_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `provides`
--

INSERT INTO `provides` (`supplier_id`, `ingredients_id`) VALUES
(402, 202),
(401, 201),
(402, 202),
(401, 203),
(402, 202),
(403, 204),
(402, 205),
(411, 206),
(430, 207),
(404, 208),
(406, 209),
(409, 210),
(407, 211),
(404, 212),
(408, 213),
(407, 214),
(412, 215),
(411, 216),
(411, 218),
(416, 219),
(415, 220),
(420, 202),
(423, 204),
(424, 207),
(426, 208),
(427, 209),
(427, 210),
(430, 211),
(421, 212),
(411, 213),
(421, 214),
(412, 215),
(406, 216),
(409, 217),
(410, 218),
(411, 219),
(412, 220),
(413, 212),
(414, 201),
(415, 220),
(416, 211),
(417, 213),
(421, 203),
(422, 211),
(405, 206),
(402, 209);

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE `supplier` (
  `supplier_id` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `chef_id` int(11) DEFAULT NULL,
  `phno` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplier_id`, `name`, `city`, `chef_id`, `phno`) VALUES
(401, 'yashas', 'bangalore', 102, 7258492854),
(402, 'manas', 'chennai', 101, 6928648382),
(403, 'vineeth', 'delhi', 104, 9887243873),
(404, 'pankaj', 'mumbai', 106, 9827842729),
(405, 'ankit', 'pune', 107, 4242488952),
(406, 'prajwal', 'hyderabad', 103, 4298635928),
(407, 'raghu', 'bangalore', 104, 9273649272),
(408, 'bhuvan', 'vizag', 105, 8237842703),
(409, 'bushan', 'mysore', 108, 837401740),
(410, 'barath', 'mysore', 109, 3413435351),
(411, 'bhanu', 'delhi', 101, 2455243453),
(412, 'bushan', 'bangalore', 103, 5325252354),
(413, 'prateek', 'delhi', 102, 3525523524),
(414, 'pavan', 'chennai', 105, 2352543364),
(415, 'ritviz', 'pune', 104, 3523523525),
(416, 'ganesh', 'bangalore', 103, 4234232354),
(417, 'jhon', 'mumbai', 106, 5252523543),
(418, 'bhasker', 'delhi', 107, 9274818246),
(419, 'vijay', 'delhi', 108, 9374836669),
(420, 'surya', 'pune', 109, 9779349718),
(421, 'karthik', 'bangalore', 101, 8712647916),
(422, 'kiran', 'mysore', 104, 7624791274),
(423, 'indira', 'pune', 102, 7824791649),
(424, 'sonia', 'hyderabad', 105, 7461746917),
(425, 'mahesh', 'chennai', 103, 3796491799),
(426, 'manasa', 'chennai', 107, 982918792),
(427, 'vishnu', 'delhi', 106, 7691468198),
(428, 'chaitra', 'bangalore', 109, 7364719714),
(429, 'pranav', 'mumbai', 108, 98649128918),
(430, 'pruthvik', 'pune', 108, 83419864918);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bill`
--
ALTER TABLE `bill`
  ADD PRIMARY KEY (`bill_id`);

--
-- Indexes for table `chef`
--
ALTER TABLE `chef`
  ADD PRIMARY KEY (`chef_id`);

--
-- Indexes for table `consists_of`
--
ALTER TABLE `consists_of`
  ADD KEY `meal_idx` (`meal_id`),
  ADD KEY `ing_idx` (`ing_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`ingredients_id`);

--
-- Indexes for table `meal`
--
ALTER TABLE `meal`
  ADD PRIMARY KEY (`meal_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD KEY `cust_idx` (`customer_id`),
  ADD KEY `bill_idx` (`bill_id`),
  ADD KEY `meal_idx` (`meal_id`);

--
-- Indexes for table `provides`
--
ALTER TABLE `provides`
  ADD KEY `supp_idx` (`supplier_id`),
  ADD KEY `ing_idx` (`ingredients_id`);

--
-- Indexes for table `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`supplier_id`),
  ADD KEY `chef_id_idx` (`chef_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `consists_of`
--
ALTER TABLE `consists_of`
  ADD CONSTRAINT `ing` FOREIGN KEY (`ing_id`) REFERENCES `ingredients` (`ingredients_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `meal` FOREIGN KEY (`meal_id`) REFERENCES `meal` (`meal_id`) ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `bill` FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`),
  ADD CONSTRAINT `cust` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `meals` FOREIGN KEY (`meal_id`) REFERENCES `meal` (`meal_id`);

--
-- Constraints for table `provides`
--
ALTER TABLE `provides`
  ADD CONSTRAINT `ings` FOREIGN KEY (`ingredients_id`) REFERENCES `ingredients` (`ingredients_id`),
  ADD CONSTRAINT `supp` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`);

--
-- Constraints for table `supplier`
--
ALTER TABLE `supplier`
  ADD CONSTRAINT `chef_supplier` FOREIGN KEY (`chef_id`) REFERENCES `chef` (`chef_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
