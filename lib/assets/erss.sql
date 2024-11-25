CREATE TABLE IF NOT EXISTS `allotnum` (
  `nextid` int(4) NOT NULL,
  `yearAllot` int(4) NOT NULL DEFAULT '2024',
  `dtcreated` datetime DEFAULT CURRENT_TIMESTAMP
)

INSERT INTO `allotnum` (`nextid`, `yearAllot`, `dtcreated`) VALUES
	(34, 2024, '2024-09-19 17:02:36');

CREATE TABLE IF NOT EXISTS `tblcategory` (
  `id` int(3) NOT NULL DEFAULT '0',
  `category` varchar(50) NOT NULL DEFAULT '0'
) 

INSERT INTO `tblcategory` (`id`, `category`) VALUES
	(1, 'ipfiling'),
	(2, 'ipsearch'),
	(3, 'tmclass'),
	(4, 'temujanji'),
	(5, 'visitor');

CREATE TABLE IF NOT EXISTS `tblclock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(50) NOT NULL,
  `timeclockout` time DEFAULT NULL,
  `timeclockin` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtclockin` date NOT NULL,
  `dtclockout` date DEFAULT NULL,
  PRIMARY KEY (`id`)
)

INSERT INTO `tblclock` (`id`, `userid`, `timeclockout`, `timeclockin`, `dtclockin`, `dtclockout`) VALUES
	(57, 'shuhrah', '14:40:04', '2024-09-11 14:39:32', '2024-09-11', '2024-09-11'),
	(58, 'shuhrah', NULL, '2024-09-11 14:44:31', '2024-09-11', NULL),
	(59, 'shuhrah', '16:07:33', '2024-09-11 16:02:53', '2024-09-11', '2024-09-11'),
	(60, 'shuhrah', '17:01:29', '2024-09-11 16:59:04', '2024-09-11', '2024-09-11'),
	(61, 'shuhrah', '17:02:13', '2024-09-11 17:01:30', '2024-09-11', '2024-09-11'),
	(62, 'shuhrah', NULL, '2024-09-12 09:37:56', '2024-09-12', NULL),
	(63, 'shuhrah', NULL, '2024-09-12 10:22:34', '2024-09-12', NULL),
	(64, 'shuhrah', NULL, '2024-09-12 11:37:22', '2024-09-12', NULL),
	(65, 'shuhrah', NULL, '2024-09-12 14:14:18', '2024-09-12', NULL),
	(66, 'shuhrah', NULL, '2024-09-12 14:14:28', '2024-09-12', NULL),
	(67, 'shuhrah', NULL, '2024-09-12 14:14:52', '2024-09-12', NULL),
	(68, 'shuhrah', NULL, '2024-09-12 14:14:56', '2024-09-12', NULL),
	(69, 'shuhrah', NULL, '2024-09-12 14:15:00', '2024-09-12', NULL),
	(70, 'shuhrah', NULL, '2024-09-12 14:16:04', '2024-09-12', NULL),
	(71, 'shuhrah', NULL, '2024-09-12 14:16:41', '2024-09-12', NULL),
	(72, 'shuhrah', NULL, '2024-09-12 14:16:53', '2024-09-12', NULL),
	(73, 'shuhrah', NULL, '2024-09-12 14:17:08', '2024-09-12', NULL),
	(74, 'shuhrah', NULL, '2024-09-12 14:17:13', '2024-09-12', NULL),
	(75, 'shuhrah', NULL, '2024-09-12 14:17:37', '2024-09-12', NULL),
	(76, 'shuhrah', '14:18:42', '2024-09-12 14:17:42', '2024-09-12', '2024-09-12'),
	(77, 'shuhrah', NULL, '2024-09-12 14:18:43', '2024-09-12', NULL),
	(78, 'shuhrah', '14:20:12', '2024-09-12 14:18:50', '2024-09-12', '2024-09-12'),
	(79, 'shuhrah', '14:22:53', '2024-09-12 14:20:13', '2024-09-12', '2024-09-12'),
	(80, 'shuhrah', NULL, '2024-09-12 14:24:21', '2024-09-12', NULL),
	(81, 'shuhrah', '14:44:13', '2024-09-12 14:44:07', '2024-09-12', '2024-09-12'),
	(82, 'shuhrah', '14:52:01', '2024-09-12 14:44:35', '2024-09-12', '2024-09-12'),
	(83, 'shuhrah', '14:53:20', '2024-09-12 14:52:02', '2024-09-12', '2024-09-12'),
	(84, 'shuhrah', '14:56:43', '2024-09-12 14:53:22', '2024-09-12', '2024-09-12'),
	(85, 'shuhrah', '14:57:35', '2024-09-12 14:56:45', '2024-09-12', '2024-09-12'),
	(86, 'shuhrah', '15:07:04', '2024-09-12 15:05:44', '2024-09-12', '2024-09-12'),
	(87, 'shuhrah', '15:08:21', '2024-09-12 15:07:05', '2024-09-12', '2024-09-12'),
	(88, 'shuhrah', NULL, '2024-09-12 15:09:27', '2024-09-12', NULL),
	(89, 'shuhrah', NULL, '2024-09-12 15:41:57', '2024-09-12', NULL),
	(90, 'shuhrah', NULL, '2024-09-13 11:34:16', '2024-09-13', NULL),
	(91, 'shuhrah', NULL, '2024-09-17 08:43:24', '2024-09-17', NULL),
	(92, 'shuhrah', '11:39:25', '2024-09-18 11:39:22', '2024-09-18', '2024-09-18'),
	(93, 'shuhrah', NULL, '2024-09-18 16:51:28', '2024-09-18', NULL),
	(94, 'shuhrah', NULL, '2024-09-19 17:02:29', '2024-09-19', NULL),
	(95, 'shuhrah', '14:33:56', '2024-09-23 14:33:52', '2024-09-23', '2024-09-23'),
	(96, 'shuhrah', '16:21:52', '2024-09-23 14:33:57', '2024-09-23', '2024-09-25'),
	(97, 'shuhrah', NULL, '2024-09-25 16:21:51', '2024-09-25', NULL),
	(98, 'shuhrah', '16:22:04', '2024-09-25 16:21:53', '2024-09-25', '2024-09-25');

CREATE TABLE IF NOT EXISTS `tblhistory` (
  `remark` varchar(100) NOT NULL,
  `to1` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from1` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userid` varchar(50) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nextid` int(4) NOT NULL,
  PRIMARY KEY (`id`)
) 

INSERT INTO `tblhistory` (`remark`, `to1`, `from1`, `userid`, `id`, `nextid`) VALUES
	('sign out', '2024-09-11 14:39:32', '2024-09-11 14:40:04', 'shuhrah', 57, 0),
	('sign in', '2024-09-11 14:44:31', '2024-09-01 00:00:00', 'shuhrah', 58, 0),
	('sign out', '2024-09-11 16:02:53', '2024-09-11 16:07:33', 'shuhrah', 59, 0),
	('sign out', '2024-09-11 16:59:04', '2024-09-11 17:01:29', 'shuhrah', 60, 0),
	('sign out', '2024-09-11 17:01:30', '2024-09-11 17:02:13', 'shuhrah', 61, 0),
	('sign in', '2024-09-12 09:37:56', '2024-09-01 00:00:00', 'shuhrah', 62, 0),
	('sign in', '2024-09-12 10:22:34', '2024-09-01 00:00:00', 'shuhrah', 63, 0),
	('sign in', '2024-09-12 11:37:22', '2024-09-01 00:00:00', 'shuhrah', 64, 0),
	('Bareskinlab', '2024-09-12 12:33:11', '2024-09-12 12:33:11', 'visitor', 65, 22),
	('Bareskinlab1', '2024-09-12 12:38:02', '2024-09-12 12:38:02', 'visitor', 66, 22),
	('Bareskinlab2', '2024-09-12 12:38:39', '2024-09-12 12:38:39', 'visitor', 67, 22),
	('Bareskinlab2', '2024-09-12 12:39:59', '2024-09-12 12:39:59', 'visitor', 68, 22),
	('Bareskinlab2', '2024-09-12 12:46:00', '2024-09-12 12:46:00', 'visitor', 69, 22),
	('test remark', '2024-09-12 12:48:52', '2024-09-12 12:48:52', 'visitor', 70, 22),
	('test remark', '2024-09-12 12:51:40', '2024-09-12 12:51:40', 'visitor', 71, 22),
	('test remark', '2024-09-12 12:53:28', '2024-09-12 12:53:28', 'visitor', 72, 22),
	('test remark', '2024-09-12 12:54:12', '2024-09-12 12:54:12', 'visitor', 73, 22),
	('Bareskinlab4', '2024-09-12 13:00:03', '2024-09-12 13:00:03', 'visitor', 74, 26),
	('Bareskinlab4', '2024-09-12 13:01:13', '2024-09-12 13:01:13', 'visitor', 75, 26),
	('sign out', '2024-09-12 14:17:42', '2024-09-12 14:18:42', 'shuhrah', 76, 0),
	('sign in', '2024-09-12 14:18:43', '2024-09-01 00:00:00', 'shuhrah', 77, 0),
	('sign out', '2024-09-12 14:18:50', '2024-09-12 14:20:12', 'shuhrah', 78, 0),
	('sign out', '2024-09-12 14:20:13', '2024-09-12 14:22:53', 'shuhrah', 79, 0),
	('sign in', '2024-09-12 14:24:21', '2024-09-01 00:00:00', 'shuhrah', 80, 0),
	('sign out', '2024-09-12 14:44:07', '2024-09-12 14:44:13', 'shuhrah', 81, 0),
	('sign out', '2024-09-12 14:44:35', '2024-09-12 14:52:01', 'shuhrah', 82, 0),
	('sign out', '2024-09-12 14:52:02', '2024-09-12 14:53:20', 'shuhrah', 83, 0),
	('sign out', '2024-09-12 14:53:22', '2024-09-12 14:56:43', 'shuhrah', 84, 0),
	('sign out', '2024-09-12 14:56:45', '2024-09-12 14:57:35', 'shuhrah', 85, 0),
	('sign out', '2024-09-12 15:05:44', '2024-09-12 15:07:04', 'shuhrah', 86, 0),
	('sign out', '2024-09-12 15:07:05', '2024-09-12 15:08:22', 'shuhrah', 87, 0),
	('sign in', '2024-09-12 15:09:27', '2024-09-01 00:00:00', 'shuhrah', 88, 0),
	('sign in', '2024-09-12 15:41:57', '2024-09-01 00:00:00', 'shuhrah', 89, 0),
	('sign in', '2024-09-13 11:34:16', '2024-09-01 00:00:00', 'shuhrah', 90, 0),
	('sign in', '2024-09-17 08:43:24', '2024-09-01 00:00:00', 'shuhrah', 91, 0),
	('sign out', '2024-09-18 11:39:22', '2024-09-18 11:39:25', 'shuhrah', 92, 0),
	('sign in', '2024-09-18 16:51:28', '2024-09-01 00:00:00', 'shuhrah', 93, 0),
	('sign in', '2024-09-19 17:02:29', '2024-09-01 00:00:00', 'shuhrah', 94, 0),
	('sign out', '2024-09-23 14:33:52', '2024-09-23 14:33:56', 'shuhrah', 95, 0),
	('sign out', '2024-09-23 14:33:57', '2024-09-25 16:21:52', 'shuhrah', 96, 0),
	('sign in', '2024-09-25 16:21:51', '2024-09-01 00:00:00', 'shuhrah', 97, 0),
	('sign out', '2024-09-25 16:21:54', '2024-09-25 16:22:04', 'shuhrah', 98, 0);

CREATE TABLE IF NOT EXISTS `tbllevel` (
  `id` int(11) NOT NULL,
  `accesslevelID` int(11) DEFAULT NULL,
  `roles` varchar(50) DEFAULT NULL
) 


INSERT INTO `tbllevel` (`id`, `accesslevelID`, `roles`) VALUES
	(1, 1, 'satelit'),
	(2, 2, 'admin'),
	(3, 3, 'not exist');


CREATE TABLE IF NOT EXISTS `tblregister` (
  `userid` varchar(50) DEFAULT '',
  `name` varchar(50) NOT NULL DEFAULT '',
  `dtregister` date NOT NULL,
  `nextid` int(4) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `telefon` varchar(10) DEFAULT NULL,
  `emel` varchar(50) DEFAULT NULL,
  `timeregister` time NOT NULL,
  `postcode` int(11) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL
) 


INSERT INTO `tblregister` (`userid`, `name`, `dtregister`, `nextid`, `address`, `telefon`, `emel`, `timeregister`, `postcode`, `state`) VALUES
	('shuhrah', 'shuhrah', '2024-08-16', 7, 'test', '0133941007', 'shuhrah@gmail.com', '12:09:00', 21300, 'Terengganu'),
	('s', 's', '2024-08-21', 0, 'test1', '74960010', 'rshuhrah@gmail.com', '11:41:24', 25100, 'Pahang');


CREATE TABLE IF NOT EXISTS `tblstate` (
  `id` int(11) NOT NULL,
  `state` varchar(50) NOT NULL
) 


INSERT INTO `tblstate` (`id`, `state`) VALUES
	(1, 'Pahang'),
	(2, 'Terengganu'),
	(3, 'Kelantan');

CREATE TABLE IF NOT EXISTS `tbltemujanji` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nota` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) 


CREATE TABLE IF NOT EXISTS `tbluser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `emel` varchar(255) NOT NULL,
  `pswd` varchar(50) NOT NULL,
  `userlevel_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) 


INSERT INTO `tbluser` (`id`, `userid`, `name`, `emel`, `pswd`, `userlevel_id`) VALUES
	(1, 'shuhrah', 'shuhrah', 'shuhrah@gmail.com', 's', 1);


CREATE TABLE IF NOT EXISTS `tblusrlog` (
  `userid` varchar(50) NOT NULL DEFAULT '',
  `activity` varchar(50) NOT NULL DEFAULT '0',
  `datetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `idx_userid` (`userid`)
) 

INSERT INTO `tblusrlog` (`userid`, `activity`, `datetime`) VALUES
	('shuhrah', 'sign in', '2024-09-11 14:39:32'),
	('shuhrah', 'sign out', '2024-09-11 14:40:04'),
	('shuhrah', 'sign in', '2024-09-11 14:44:31'),
	('shuhrah', 'sign out', '2024-09-11 16:01:02'),
	('shuhrah', 'sign in', '2024-09-11 16:02:53'),
	('shuhrah', 'sign out', '2024-09-11 16:02:54'),
	('shuhrah', 'sign out', '2024-09-11 16:07:33'),
	('shuhrah', 'sign in', '2024-09-11 16:59:04'),
	('shuhrah', 'sign out', '2024-09-11 17:01:29'),
	('shuhrah', 'sign in', '2024-09-11 17:01:30'),
	('shuhrah', 'sign out', '2024-09-11 17:02:13'),
	('shuhrah', 'sign in', '2024-09-12 09:37:56'),
	('shuhrah', 'sign in', '2024-09-12 10:22:34'),
	('shuhrah', 'sign in', '2024-09-12 11:37:22'),
	('shuhrah', 'sign in', '2024-09-12 14:14:18'),
	('shuhrah', 'sign in', '2024-09-12 14:14:28'),
	('shuhrah', 'sign in', '2024-09-12 14:14:52'),
	('shuhrah', 'sign in', '2024-09-12 14:14:56'),
	('shuhrah', 'sign in', '2024-09-12 14:15:00'),
	('shuhrah', 'sign in', '2024-09-12 14:16:04'),
	('shuhrah', 'sign in', '2024-09-12 14:16:41'),
	('shuhrah', 'sign in', '2024-09-12 14:16:53'),
	('shuhrah', 'sign in', '2024-09-12 14:17:08'),
	('shuhrah', 'sign in', '2024-09-12 14:17:13'),
	('shuhrah', 'sign in', '2024-09-12 14:17:37'),
	('shuhrah', 'sign in', '2024-09-12 14:17:42'),
	('shuhrah', 'sign out', '2024-09-12 14:18:42'),
	('shuhrah', 'sign in', '2024-09-12 14:18:43'),
	('shuhrah', 'sign in', '2024-09-12 14:18:50'),
	('shuhrah', 'sign out', '2024-09-12 14:20:12'),
	('shuhrah', 'sign in', '2024-09-12 14:20:13'),
	('shuhrah', 'sign out', '2024-09-12 14:22:53'),
	('shuhrah', 'sign in', '2024-09-12 14:24:21'),
	('shuhrah', 'sign in', '2024-09-12 14:44:07'),
	('shuhrah', 'sign out', '2024-09-12 14:44:13'),
	('shuhrah', 'sign in', '2024-09-12 14:44:35'),
	('shuhrah', 'sign out', '2024-09-12 14:52:01'),
	('shuhrah', 'sign in', '2024-09-12 14:52:02'),
	('shuhrah', 'sign out', '2024-09-12 14:53:20'),
	('shuhrah', 'sign in', '2024-09-12 14:53:22'),
	('shuhrah', 'sign out', '2024-09-12 14:56:43'),
	('shuhrah', 'sign in', '2024-09-12 14:56:45'),
	('shuhrah', 'sign out', '2024-09-12 14:57:35'),
	('shuhrah', 'sign in', '2024-09-12 15:05:44'),
	('shuhrah', 'sign out', '2024-09-12 15:07:04'),
	('shuhrah', 'sign in', '2024-09-12 15:07:05'),
	('shuhrah', 'sign out', '2024-09-12 15:08:22'),
	('shuhrah', 'sign in', '2024-09-12 15:09:27'),
	('shuhrah', 'sign in', '2024-09-12 15:41:57'),
	('shuhrah', 'sign in', '2024-09-13 11:34:16'),
	('shuhrah', 'sign in', '2024-09-17 08:43:24'),
	('shuhrah', 'sign in', '2024-09-18 11:39:22'),
	('shuhrah', 'sign out', '2024-09-18 11:39:25'),
	('shuhrah', 'sign in', '2024-09-18 16:51:28'),
	('shuhrah', 'sign in', '2024-09-19 17:02:29'),
	('shuhrah', 'sign in', '2024-09-23 14:33:52'),
	('shuhrah', 'sign out', '2024-09-23 14:33:56'),
	('shuhrah', 'sign in', '2024-09-23 14:33:57'),
	('shuhrah', 'sign in', '2024-09-25 16:21:51'),
	('shuhrah', 'sign out', '2024-09-25 16:21:52'),
	('shuhrah', 'sign in', '2024-09-25 16:21:53'),
	('shuhrah', 'sign out', '2024-09-25 16:22:04');


CREATE TABLE IF NOT EXISTS `tblvisitor` (
  `nextid` int(4) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `dtvisit` date NOT NULL,
  `remark` varchar(100) NOT NULL DEFAULT '',
  `telefon` varchar(10) NOT NULL,
  `emel` varchar(50) DEFAULT NULL,
  `address` varchar(150) DEFAULT NULL,
  `postcode` int(5) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `category` int(11) NOT NULL DEFAULT '0',
  `timevisit` time NOT NULL
) 

INSERT INTO `tblvisitor` (`nextid`, `userid`, `name`, `dtvisit`, `remark`, `telefon`, `emel`, `address`, `postcode`, `state`, `category`, `timevisit`) VALUES
	(7, 's', 's', '2024-08-22', 'test', '0133941007', 'shuhrah@gmail.com', 'test', 43000, 'Terengganu', 4, '09:00:00'),
	(22, 'visitor', 'BARESKINLAB2', '2024-09-12', 'Bareskinlab2', '0133941007', 'bareskinlab@gmail.com', 'Bareskinlab2', 43000, 'Terengganu', 5, '12:46:00'),
	(22, 'visitor', 'BARESKINLAB3', '2024-09-12', 'test remark', '0133941007', 'bareskinlab@gmail.com', 'Bareskinlab3', 43000, 'Terengganu', 5, '12:48:52'),
	(22, 'visitor', 'BARESKINLAB3', '2024-09-12', 'test remark', '0133941007', 'bareskinlab@gmail.com', 'Bareskinlab3', 43000, 'Terengganu', 5, '12:51:40'),
	(22, 'visitor', 'BARESKINLAB3', '2024-09-12', 'test remark', '0133941007', 'bareskinlab@gmail.com', 'Bareskinlab3', 43000, 'Terengganu', 5, '12:53:28'),
	(22, 'visitor', 'BARESKINLAB3', '2024-09-12', 'test remark', '0133941007', 'bareskinlab@gmail.com', 'Bareskinlab3', 43000, 'Terengganu', 5, '12:54:12'),
	(26, 'visitor', 'BARESKINLAB4', '2024-09-12', 'Bareskinlab4', '0133941007', 'bareskinlab@gmail.com', 'Bareskinlab4', 43000, 'Terengganu', 5, '13:00:03'),
	(26, 'visitor', 'BARESKINLAB4', '2024-09-12', 'Bareskinlab4', '0133941007', 'bareskinlab@gmail.com', 'Bareskinlab4', 43000, 'Terengganu', 5, '13:01:13');
/


CREATE TABLE IF NOT EXISTS `waktu` (
  `timeclockin` time DEFAULT NULL,
  `timeclockout` time DEFAULT NULL
)

INSERT INTO `waktu` (`timeclockin`, `timeclockout`) VALUES
	('08:00:00', '17:00:00');

