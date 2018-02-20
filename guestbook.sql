-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 20, 2018 at 08:18 AM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `guestbook`
--

-- --------------------------------------------------------

--
-- Table structure for table `guestbook`
--

CREATE TABLE `guestbook` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `website` text,
  `message` text NOT NULL,
  `ip` text NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `guestbook`
--

INSERT INTO `guestbook` (`id`, `first_name`, `last_name`, `email`, `website`, `message`, `ip`, `date`) VALUES
(1, 'Duncan', 'Sterken', 'duncan@leeks.life', NULL, 'hello', '', '2018-02-20 08:16:12'),
(2, 'Duncan', 'Sterken', 'duncan@leeks.life', NULL, 'hello', '127.0.0.1', '2018-02-20 08:16:12'),
(3, 'Duncan', 'Sterken', 'duncan@leeks.life', 'https://duncte123.me/', 'Hellotherewhatanicewebsite', '127.0.0.1', '2018-02-20 08:16:12'),
(4, 'Duncan', 'Sterken', 'duncan@leeks.life', 'https://duncte123.me/', 'Hello there', '127.0.0.1', '2018-02-20 08:16:12'),
(6, 'Duncan', 'Sterken', 'duncan@leeks.life', NULL, 'jhkllkjhgdf dshdfs dflghklfdohg', '127.0.0.1', '2018-02-20 08:16:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `guestbook`
--
ALTER TABLE `guestbook`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `guestbook`
--
ALTER TABLE `guestbook`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
