
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `bluebirdhotel`
-- User: `bluebird_user`
-- Password:   `password`
--
DROP DATABASE IF EXISTS bluebirdhotel;
CREATE DATABASE IF NOT EXISTS bluebirdhotel;

DROP USER IF EXISTS'bluebird_user'@'%';
CREATE USER IF NOT EXISTS 'bluebird_user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON bluebirdhotel.* TO 'bluebird_user'@'%';
USE bluebirdhotel;

-- --------------------------------------------------------

--
-- Table structure for table `emp_login`
--

CREATE TABLE `emp_login` (
  `empid` int(100) NOT NULL,
  `Emp_Email` varchar(50) NOT NULL,
  `Emp_Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `emp_login`
--

INSERT INTO `emp_login` (`empid`, `Emp_Email`, `Emp_Password`) VALUES
(1, 'Admin@gmail.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `id` int(30) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `RoomType` varchar(30) NOT NULL,
  `Bed` varchar(30) NOT NULL,
  `NoofRoom` int(30) NOT NULL,
  `cin` date NOT NULL,
  `cout` date NOT NULL,
  `noofdays` int(30) NOT NULL,
  `roomtotal` double(8,2) NOT NULL,
  `bedtotal` double(8,2) NOT NULL,
  `meal` varchar(30) NOT NULL,
  `mealtotal` double(8,2) NOT NULL,
  `finaltotal` double(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--
INSERT INTO `payment` 
(`id`, `Name`, `Email`, `RoomType`, `Bed`, `NoofRoom`, `cin`, `cout`, `noofdays`, `roomtotal`, `bedtotal`, `meal`, `mealtotal`, `finaltotal`) 
VALUES
(1, 'Harshil Finava', 'harshilfinava@gmail.com', 'Single Room', 'Single', 1, '2022-11-09', '2022-11-10', 1, 1000.00, 10.00, 'Room only', 0.00, 1010.00),
(2, 'Raj Patel', 'rajpatel@example.com', 'Deluxe Room', 'Double', 1, '2022-12-01', '2022-12-03', 2, 2000.00, 20.00, 'Breakfast', 300.00, 2320.00),
(3, 'Aarav Mehta', 'aaravmehta@example.com', 'Superior Room', 'Triple', 2, '2022-12-10', '2022-12-13', 3, 4500.00, 30.00, 'Full Board', 900.00, 5430.00),
(4, 'Krisha Shah', 'krishashah@example.com', 'Guest House', 'Single', 1, '2023-01-05', '2023-01-07', 2, 1600.00, 10.00, 'Half Board', 400.00, 2010.00);

-- --------------------------------------------------------

--
-- Table structure for table `room`
--

CREATE TABLE `room` (
  `id` int(30) NOT NULL,
  `type` varchar(50) NOT NULL,
  `bedding` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room`
--

INSERT INTO `room` (`id`, `type`, `bedding`) VALUES
(1,  'Superior Room', 'Single'),
(2,  'Superior Room', 'Double'),
(3,  'Superior Room', 'Triple'),
(4,  'Superior Room', 'Quad'),

(5,  'Deluxe Room', 'Single'),
(6,  'Deluxe Room', 'Double'),
(7,  'Deluxe Room', 'Triple'),
(8,  'Deluxe Room', 'Quad'),

(9,  'Guest House', 'Single'),
(10, 'Guest House', 'Double'),
(11, 'Guest House', 'Triple'),
(12, 'Guest House', 'Quad'),

(13, 'Single Room', 'Single'),
(14, 'Single Room', 'Double'),
(15, 'Single Room', 'Triple'),
(16, 'Single Room', 'Quad');


-- --------------------------------------------------------

--
-- Table structure for table `roombook`
--

CREATE TABLE `roombook` (
  `id` int(10) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Country` varchar(30) NOT NULL,
  `Phone` varchar(30) NOT NULL,
  `RoomType` varchar(30) NOT NULL,
  `Bed` varchar(30) NOT NULL,
  `Meal` varchar(30) NOT NULL,
  `NoofRoom` varchar(30) NOT NULL,
  `cin` date NOT NULL,
  `cout` date NOT NULL,
  `nodays` int(50) NOT NULL,
  `stat` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `roombook`
--

INSERT INTO `roombook` 
(`id`, `Name`, `Email`, `Country`, `Phone`, `RoomType`, `Bed`, `Meal`, `NoofRoom`, `cin`, `cout`, `nodays`, `stat`) 
VALUES
(1, 'Harshil Finava', 'harshilfinava@gmail.com', 'India', '9313346569', 'Single Room', 'Single', 'Room only', '1', '2022-11-09', '2022-11-10', 1, 'Confirm'),

(2, 'Raj Patel', 'rajpatel@example.com', 'India', '9876543210', 'Deluxe Room', 'Double', 'Breakfast', '2', '2022-12-01', '2022-12-03', 2, 'Confirm'),

(3, 'Aarav Mehta', 'aaravmehta@example.com', 'USA', '2025550199', 'Superior Room', 'Triple', 'Full Board', '1', '2023-01-05', '2023-01-08', 3, 'Confirm'),

(4, 'Krisha Shah', 'krisha.shah@example.com', 'UK', '447911123456', 'Guest House', 'Single', 'Half Board', '1', '2023-02-10', '2023-02-12', 2, 'Confirm');

-- --------------------------------------------------------

--
-- Table structure for table `signup`
--

CREATE TABLE `signup` (
  `UserID` int(100) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `signup`
--
INSERT INTO `signup` (`UserID`, `Username`, `Email`, `Password`) VALUES
(1, 'Harshil Finava', 'harshilfinava@gmail.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  `work` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff`
--

 INSERT INTO `staff` (`id`, `name`, `work`) VALUES
(1,  'Harshil Finava',       'Manager'),
(2,  'Rohit Patel',          'Head Cook'),
(3,  'Dipak Mevada',         'Assistant Cook'),
(4,  'Tirth Parmar',         'Helper'),
(5,  'Mohan Solanki',        'Helper'),
(6,  'Shyam Bhandari',       'Cleaner'),
(7,  'Rohan Desai',          'Waiter'),
(8,  'Hiren Chauhan',        'Waiter'),
(9,  'Nikunj Prajapati',     'Waiter'),
(10, 'Rekha Shrimali',       'Senior Cook');


--
-- Indexes for dumped tables
--

--
-- Indexes for table `emp_login`
--
ALTER TABLE `emp_login`
  ADD PRIMARY KEY (`empid`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roombook`
--
ALTER TABLE `roombook`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `signup`
--
ALTER TABLE `signup`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `emp_login`
--
ALTER TABLE `emp_login`
  MODIFY `empid` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `room`
--
ALTER TABLE `room`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `roombook`
--
ALTER TABLE `roombook`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `signup`
--
ALTER TABLE `signup`
  MODIFY `UserID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(30) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
