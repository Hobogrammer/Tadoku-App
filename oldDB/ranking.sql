-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
--
-- ホスト: localhost
-- 生成時間: 2012 年 7 月 24 日 07:03
-- サーバのバージョン: 5.1.61
-- PHP のバージョン: 5.3.3-7+squeeze13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- データベース: `silent`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `ranking`
--

CREATE TABLE IF NOT EXISTS `ranking` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `participant` varchar(20) NOT NULL,
  `pagenum` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=51 ;

--
-- テーブルのデータをダンプしています `ranking`
--

INSERT INTO `ranking` (`id`, `participant`, `pagenum`) VALUES
(1, 'lordsilent', 623),
(2, 'pbadger', 30.6),
(3, 'e_dub_kendo', 251),
(4, 'Landorien', 204),
(5, 'qqkachoo24', 302),
(6, 'burritolingus', 46),
(7, 'loafyi', 285),
(8, 'LizLearns', 290),
(45, 'nac_est', 1019),
(10, 'Moniiku', 13.5),
(11, 'Mirohan', 4.5),
(12, 'momonigiri', 530),
(13, 'don_rivers', 18),
(14, 'c_nak', 220),
(16, 'nickdesuyo', 1047),
(18, 'wiwocola', 260),
(19, 'mletterle', 12),
(20, 'kiriyama_s', 45),
(21, 'mullr', 40),
(22, 'BlackDragonHunt', 2224),
(23, 'Brokenvai', 44.9),
(24, 'ShiiraShiira', 53),
(49, 'Tibul', 10),
(26, 'Infernatotely', 29),
(27, 'languageez', 52.7),
(28, 'Squintox', 345),
(29, 'distefam', 33),
(30, 'Juniperarrow', 1116.2),
(31, 'Nekesu', 730),
(32, 'mikotoneko', 160),
(33, 'Seizar86', 2186),
(34, 'Little_strokes', 500),
(35, 'Kanjiwarrior', 1230),
(36, 'Lorata', 129),
(37, 'tonesvenn', 157),
(40, 'tummai', 57),
(41, 'peterjcarroll', 84),
(42, 'Sakatsu', 655),
(43, 'TheoOliveira', 7),
(47, 'YouAintNoNerd', 26),
(48, 'hotsw4p', 69);
