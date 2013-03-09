-- phpMyAdmin SQL Dump
-- version 3.3.7deb7
-- http://www.phpmyadmin.net
--
-- ホスト: localhost
-- 生成時間: 2012 年 7 月 24 日 07:02
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
-- テーブルの構造 `tadoku03`
--

CREATE TABLE IF NOT EXISTS `tadoku03` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `participant` varchar(20) NOT NULL,
  `book` double NOT NULL,
  `manga` double NOT NULL,
  `net` double NOT NULL,
  `fullgame` int(11) NOT NULL,
  `game` int(11) NOT NULL,
  `lyric` int(11) NOT NULL,
  `subs` double NOT NULL,
  `news` double NOT NULL,
  `sentences` int(11) NOT NULL,
  `nico` double NOT NULL,
  `pagecount` double NOT NULL,
  `lang1` varchar(2) NOT NULL,
  `lang2` varchar(2) NOT NULL,
  `lang3` varchar(2) NOT NULL,
  KEY `id` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=156 ;

--
-- テーブルのデータをダンプしています `tadoku03`
--

INSERT INTO `tadoku03` (`id`, `participant`, `book`, `manga`, `net`, `fullgame`, `game`, `lyric`, `subs`, `news`, `sentences`, `nico`, `pagecount`, `lang1`, `lang2`, `lang3`) VALUES
(1, 'lordsilent', 311, 14346, 8.9, 0, 6920, 0, 1320, 0.57, 287, 0, 4099.64326203209, 'jp', '', ''),
(2, 'japaneseme', 989.12, 359.4, 163, 0, 0, 0, 140, 24, 0, 0, 1276, 'jp', '', ''),
(3, 'starsandsea', 0, 307, 0, 0, 0, 0, 0, 0, 0, 0, 61.4, 'jp', '', ''),
(4, 'teango', 114, 0, 0, 0, 0, 0, 0, 0, 0, 0, 114, 'ru', '', ''),
(5, 'Junesun', 560.5, 0, 0, 0, 0, 0, 40, 11, 632, 0, 616.676470588235, 'zh', 'it', 'ru'),
(6, 'jimjamjeniko', 592, 1256, 0, 0, 432, 0, 118, 0, 0, 0, 906.072727272727, 'jp', '', ''),
(7, 'mullr', 43, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43, 'jp', '', ''),
(8, 'sloppier_r', 4330, 1670, 60, 0, 0, 8, 0, 0, 0, 0, 4732, 'en', 'fr', ''),
(9, 'Zetsubou_Robert', 586, 641, 0, 0, 6138, 0, 0, 0, 1854, 0, 1381.25882352941, 'jp', '', ''),
(10, 'aiorral', 1.48, 1847, 0, 0, 0, 0, 0, 0, 0, 0, 370.88, 'jp', '', ''),
(11, 'o7400', 0, 1474, 0, 0, 0, 0, 0, 0, 250, 0, 309.505882352941, 'jp', '', ''),
(12, 'coffeeonimal', 0, 4059, 0, 0, 0, 152, 365, 0, 195, 0, 1048.27058823529, 'jp', '', ''),
(13, 'jsj2003', 0, 548, 0, 0, 0, 1, 0, 0, 0, 0, 110.6, 'jp', '', ''),
(14, 'gsbod', 205, 0, 0, 0, 0, 0, 0, 10, 40, 0, 217.352941176471, 'jp', '', ''),
(15, 'chovenge', 427, 1121, 8, 0, 0, 0, 897, 0, 0, 0, 838.6, 'jp', '', ''),
(16, 'kalek573', 36, 45, 11, 0, 966, 7, 136, 16, 39, 0, 196.312299465241, 'jp', '', ''),
(17, 'taispy', 21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 21, 'zh', '', ''),
(18, 'aerielle', 8, 77, 0, 0, 0, 0, 48, 7, 694, 0, 78.5555555555555, 'kr', '', ''),
(19, 'bri_tyan', 136, 79, 51, 0, 0, 0, 60, 0, 0, 0, 214.8, 'jp', 'de', 'es'),
(20, 'KSaiydT', 518.5, 1055, 189, 6, 12475, 14, 0, 1, 1598, 0, 2162.59090909091, 'jp', '', ''),
(21, 'burritolingus', 283, 0, 0, 170, 29231, 0, 817, 0, 0, 0, 3132.09696969697, 'jp', '', ''),
(22, 'BlackDragonHunt', 0, 3121, 21, 0, 90005, 1, 1879, 0, 1200, 0, 9274.86096256684, 'jp', '', ''),
(23, 'JapanNewbie', 283, 0, 0, 0, 0, 0, 0, 1, 0, 0, 284, 'jp', '', ''),
(24, 'e_dub_kendo', 1034, 195, 13.5, 0, 3760, 0, 1832, 0, 209, 0, 1807.01229946524, 'jp', '', ''),
(25, 'Landorien', 64.49, 2764.5, 0, 0, 0, 1, 0, 0, 0, 0, 618.39, 'jp', '', ''),
(26, 'qqkachoojp', 1229, 4342, 0, 0, 45634, 0, 0, 0, 0, 0, 6245.94545454546, 'jp', '', ''),
(27, 'Little_strokes', 3412, 10042, 654, 29, 12326, 0, 208, 51, 536, 0, 7315.68313570487, 'jp', 'zh', 'en'),
(28, 'momonigiri', 165.2, 61, 0, 0, 12177, 0, 1161, 15, 4418, 0, 1791.48235, 'jp', '', ''),
(29, 'Cheftom123', 33.5, 181, 0, 0, 236, 0, 629, 14, 4, 0, 231.204545454545, 'fr', '', ''),
(30, 'bakunin3', 970, 0, 0, 0, 0, 0, 0, 36, 0, 0, 1006, 'th', '', ''),
(51, 'Cush1979', 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 'jp', '', ''),
(31, 'KonyaHurricane', 0, 207, 0, 0, 0, 0, 136, 0, 0, 0, 68.6, 'jp', '', ''),
(32, 'ihan1127', 771, 0, 4, 0, 0, 0, 0, 25, 0, 0, 800, 'de', 'en', ''),
(33, 'tummai', 376, 757, 7, 0, 0, 3, 0, 0, 1057, 0, 599.576470588235, 'jp', 'sv', 'es'),
(34, 'tonesvenn', 336, 11, 4, 0, 0, 0, 0, 0, 232, 0, 355.847058823529, 'jp', '', ''),
(35, 'emilyrct', 0, 1378, 0, 0, 0, 0, 315, 11, 23, 0, 350.952941176471, 'jp', '', ''),
(36, 'mikankun', 0, 2076, 0, 0, 1246, 4, 143, 0, 146, 0, 569.660962566845, 'jp', '', ''),
(37, 'chmijo', 18, 2007, 0, 0, 0, 45, 0, 0, 0, 0, 464.4, 'jp', '', ''),
(38, 'maryag', 40, 105, 29, 0, 0, 0, 134, 0, 76, 0, 121.270588235294, 'jp', '', ''),
(39, 'lianaleslie', 3040, 0, 0, 0, 5186, 0, 0, 0, 0, 0, 3511.45454545455, 'jp', '', ''),
(40, 'glitteringloke', 3, 542, 0, 0, 0, 0, 0, 0, 0, 0, 111.4, 'jp', '', ''),
(41, 'HanaYanaa', 61, 0, 0, 0, 0, 19, 196, 0, 4067, 0, 358.435294117647, 'jp', '', ''),
(42, 'funshinefirefly', 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 'jp', '', ''),
(43, 'peterjcarroll', 34, 0, 0, 0, 167, 0, 114, 0, 15, 0, 72.7712918660287, 'es', 'eo', ''),
(45, 'crystalcampbell', 18, 5, 0, 0, 0, 0, 0, 0, 0, 0, 19, 'jp', 'fr', ''),
(46, 'Kanjiwarrior', 855, 353, 6, 0, 0, 1, 419, 0, 0, 0, 1016.4, 'jp', '', ''),
(47, 'TMJake', 0, 501, 3, 0, 46897, 0, 0, 0, 651, 0, 4404.85775401069, 'jp', '', ''),
(48, 'entreview', 0, 0, 0, 0, 0, 0, 0, 0, 30, 0, 1.76470588235294, 'jp', 'eo', ''),
(49, 'melitu', 544.5, 1360, 12, 0, 0, 0, 0, 0, 419, 0, 853.147058823529, 'jp', 'zh', ''),
(50, 'xatlasm', 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 4, 'jp', '', ''),
(52, 'zhongruige', 231, 0, 0, 0, 0, 0, 0, 0, 0, 0, 231, 'zh', '', ''),
(53, 'mochidzuki', 235, 1833, 8, 0, 3612, 7, 24, 2, 662, 0, 990.704812834225, 'jp', '', ''),
(54, 'Pharamp', 196, 0, 0, 0, 0, 0, 0, 0, 363, 0, 223.923076923077, 'de', 'en', 'es'),
(56, 'jyemenai', 0, 78, 0, 1402, 15, 0, 98, 0, 20, 0, 271.406773618538, 'jp', '', ''),
(57, 'pbadger', 48, 93, 0, 0, 0, 0, 0, 0, 0, 0, 66.6, 'jp', '', ''),
(58, 'diogovk', 69, 1722, 0, 0, 0, 0, 0, 0, 0, 0, 413.4, 'jp', 'en', ''),
(59, 'MrsMalone_emmie', 2401, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2401, 'en', '', ''),
(60, 'Moniiku', 0, 126, 0, 0, 0, 0, 0, 0, 0, 0, 25.2, 'jp', '', ''),
(61, 'Nekesu', 720, 10312, 102, 0, 2854, 5, 575, 4, 2543, 0, 3417.44278074866, 'jp', '', ''),
(62, 'Mirohan', 0, 440, 0, 0, 0, 0, 0, 0, 87, 0, 93.1176470588235, 'jp', '', ''),
(63, 'revenantkioku', 604, 3274, 313, 698, 8622, 10, 135, 0, 2478, 0, 2654.71622103387, 'jp', '', ''),
(65, 'luna_moonsilver', 80, 91, 0, 0, 0, 8, 0, 0, 0, 0, 106.2, 'de', 'es', ''),
(66, 'TakehikoKoizumi', 52, 30, 0, 0, 23, 0, 0, 0, 980, 0, 117.737967914439, 'jp', '', ''),
(67, 'shyxormz', 17, 0, 0, 0, 0, 0, 0, 15, 0, 0, 32, 'jp', '', ''),
(68, 'mikotoneko', 166, 148, 0, 0, 0, 0, 0, 0, 0, 0, 195.6, 'jp', '', ''),
(69, 'nowasforjason', 31, 0, 0, 0, 0, 0, 0, 0, 0, 0, 31, 'jp', '', ''),
(70, 'LawlCarl', 852, 0, 0, 0, 81, 0, 0, 3, 0, 0, 862.363636363636, 'fr', 'sv', 'eo'),
(71, 'Zyaga', 0, 512, 0, 0, 0, 0, 0, 0, 0, 0, 102.4, 'jp', '', ''),
(72, 'curryisyummy', 652, 181, 767, 0, 1097, 0, 225, 2, 3000, 0, 1778.39786096257, 'jp', '', ''),
(73, 'sandkatt', 664, 0, 0, 0, 0, 0, 0, 0, 0, 0, 664, 'jp', '', ''),
(75, 'tekcopocket', 69, 5976, 57, 0, 0, 0, 185, 10, 231, 0, 1381.78823529412, 'jp', '', ''),
(76, 'Lorata', 32, 647, 11, 0, 0, 0, 0, 0, 0, 0, 172.4, 'jp', '', ''),
(77, 'gboschen', 220.5, 422, 5, 0, 0, 0, 0, 0, 428, 0, 335.076470588235, 'jp', '', ''),
(78, 'veeontour', 0, 0, 0, 0, 0, 0, 4416, 0, 0, 0, 883.2, 'jp', '', ''),
(80, 'NoraBahasa', 350, 0, 0, 0, 0, 0, 0, 0, 345, 0, 371.5625, 'fr', '', ''),
(81, 'spinnningcat', 1230, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1230, 'jp', '', ''),
(82, 'JPP4', 4191, 0, 96, 0, 0, 0, 0, 0, 0, 0, 4287, 'pt', 'nl', 'ru'),
(83, 'f_splendor', 774, 0, 0, 0, 0, 0, 0, 0, 0, 0, 774, 'en', '', ''),
(84, 'SheepyAU', 16, 455, 0, 0, 0, 0, 0, 0, 5, 0, 107.294117647059, 'jp', '', ''),
(85, 'Jairzinho19', 0, 428, 0, 0, 0, 0, 0, 0, 0, 0, 85.6, 'jp', '', ''),
(86, 'Kissemizz', 62, 0, 0, 0, 0, 0, 0, 0, 0, 0, 62, 'fr', 'sv', ''),
(87, 'Yakkoe', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 'jp', '', ''),
(88, 'takkie3', 526, 0, 0, 0, 0, 0, 0, 0, 0, 0, 526, 'en', '', ''),
(89, 'amy_burr', 17, 0, 0, 0, 0, 0, 0, 0, 60, 0, 19.6086956521739, 'he', '', ''),
(90, 'ember_seed', 93.4, 0, 0, 0, 0, 0, 90, 0, 70, 0, 115.517647058824, 'jp', '', ''),
(92, 'RaquelLuvBooks', 10367, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10367, 'en', '', ''),
(93, 'firearnok', 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 3.88235294117647, 'jp', '', ''),
(95, 'AnyaPop', 2507.56, 0, 44, 0, 0, 0, 0, 5, 866, 0, 2623.17538461538, 'de', 'jp', 'it'),
(96, 'loolnashi', 25, 13187, 0, 150, 6850, 0, 555, 0, 0, 0, 3421.12727272727, 'jp', '', ''),
(97, 'mletterlejp', 0, 35, 25, 0, 0, 0, 0, 0, 0, 0, 32, 'jp', '', ''),
(99, 'languageez', 0, 0, 0, 0, 0, 0, 0, 0, 36, 0, 2.11764705882353, 'zh', 'jp', ''),
(100, 'IvanMeredith', 0, 10, 0, 0, 90, 0, 0, 0, 69, 0, 14.2406417112299, 'jp', '', ''),
(101, 'Seizar86', 1040, 9433, 187, 147, 6014, 6, 300, 201, 455, 0, 3978.59197860963, 'jp', 'kr', ''),
(102, 'Reveriekun', 0, 450, 0, 0, 0, 1, 120, 0, 40, 0, 117.352941176471, 'jp', '', ''),
(103, 'EliOmans', 121, 200, 3, 0, 0, 4, 0, 1, 57, 0, 172.352941176471, 'jp', 'zh', ''),
(104, 'hjordisa', 0, 98, 0, 0, 0, 0, 0, 0, 0, 0, 19.6, 'jp', '', ''),
(105, 'AjarnPasa', 88, 206, 0, 0, 0, 0, 0, 0, 246, 0, 139.895652173913, 'th', '', ''),
(106, 'nerxs', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 'fr', 'zh', ''),
(107, 'lavinia_dinu', 5183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5183, 'de', 'en', ''),
(108, 'Hussien_Liban', 137, 0, 0, 0, 165, 0, 0, 31, 233, 0, 192.734117647059, 'en', 'jp', 'zh'),
(109, 'Pandakittynya', 146, 483, 0, 0, 0, 0, 0, 0, 1713, 0, 343.364705882353, 'jp', '', ''),
(110, 'Rachael_nl', 138, 0, 85, 0, 0, 0, 123, 418, 156, 0, 670.8, 'nl', '', ''),
(111, 'Amasugiya', 33, 528, 0, 0, 0, 0, 78, 0, 0, 0, 154.2, 'de', 'jp', 'en'),
(112, 'hippaforalkus', 379, 0, 0, 0, 0, 0, 0, 0, 0, 0, 379, 'jp', 'en', ''),
(113, 'Yuffie89', 184, 0, 349, 0, 0, 0, 0, 2, 0, 0, 535, 'jp', '', ''),
(114, 'WelcomeGhosts', 0, 27, 0, 0, 0, 0, 0, 0, 82, 0, 10.2235294117647, 'jp', '', ''),
(115, 'Bbvoncrumb', 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 'jp', '', ''),
(116, 'michimarzo', 0, 134, 0, 0, 0, 0, 0, 0, 0, 0, 26.8, 'jp', 'de', ''),
(117, 'RichardMedh', 2425, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2425, 'jp', '', ''),
(118, 'ChuckSmith', 113, 0, 0, 0, 0, 0, 0, 0, 0, 0, 113, 'de', 'eo', ''),
(119, 'ltcooper', 48, 0, 0, 0, 0, 0, 0, 0, 26, 0, 49.5294117647059, 'jp', '', ''),
(120, 'modis151', 25, 0, 134, 0, 638, 0, 949, 0, 20, 0, 407.976470588235, 'fr', '', ''),
(121, 'tricours', 925.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 925.5, 'ru', 'de', ''),
(122, 'ALxPlaying', 0, 219, 8, 0, 5287, 0, 0, 0, 982, 0, 590.201069518717, 'jp', '', ''),
(123, 'Sakuyan', 342.5, 2055, 0, 0, 0, 0, 0, 0, 0, 0, 753.5, 'jp', 'kr', 'fr'),
(124, 'tzck', 1767, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1867, 'es', 'en', ''),
(125, 'Fujiwara23', 3808, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3808, 'jp', '', ''),
(126, 'yoshi1225us', 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 'en', '', ''),
(127, 'samhy', 491.5, 4, 0, 0, 0, 0, 0, 0, 91, 0, 497.652941176471, 'jp', '', ''),
(128, 'CultureQuirk', 0, 4976.5, 0, 0, 0, 12, 601, 0, 400, 0, 1151.02941176471, 'jp', '', ''),
(129, '_flyver', 170, 0, 5, 0, 0, 3, 0, 0, 41, 0, 179.782608695652, 'eo', 'fr', 'en'),
(130, 'relet', 205, 0, 0, 0, 0, 0, 0, 0, 0, 0, 205, 'eo', 'nb', 'nn'),
(131, 'dmaddock1', 161, 0, 0, 0, 0, 0, 0, 0, 0, 0, 161, 'eo', 'el', ''),
(132, 'tubatime1010', 402, 113, 0, 0, 0, 0, 458, 0, 623, 0, 552.847058823529, 'jp', 'fr', 'kr'),
(134, 'missingno15', 0, 798, 61, 0, 0, 16, 0, 0, 297, 0, 254.070588235294, 'jp', '', ''),
(133, 'hanikamiya', 786, 8880, 0, 0, 0, 10, 0, 0, 700, 0, 2593.21212121212, 'ru', 'sv', 'jp'),
(135, 'Calamarain4', 0, 399, 0, 0, 0, 0, 0, 0, 67, 0, 83.7411764705882, 'jp', '', ''),
(136, 'KanmuriAramaki', 40.68, 328, 0, 0, 1299, 0, 72, 0, 0, 431, 281.870909090909, 'jp', '', ''),
(139, 'jikkenkekka', 0, 0, 0, 0, 0, 1, 199, 0, 62, 0, 44.4470588235294, 'jp', '', ''),
(137, 'BuyYamsNow', 365, 0, 0, 0, 275, 0, 0, 0, 0, 0, 390, 'jp', 'fr', 'de'),
(154, 'kanjidaily', 13, 2178, 3, 0, 0, 0, 114, 5, 1330, 0, 557.635294117647, 'jp', '', ''),
(141, 'Ally_kk', 7056, 0, 33, 0, 0, 0, 0, 18, 0, 0, 7107, 'es', '', ''),
(142, 'lorxraposa', 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0.8, 'jp', '', ''),
(143, 'ALet75', 179.6, 210, 0, 0, 0, 0, 568, 0, 217, 0, 347.964705882353, 'jp', '', ''),
(144, 'domokun1134', 57.4, 5, 0, 0, 0, 0, 0, 0, 0, 0, 58.4, 'jp', '', ''),
(146, 'SimHuman', 640, 943, 3, 0, 0, 0, 0, 0, 1245, 446, 949.435294117647, 'jp', '', ''),
(148, 'kassvea', 3829, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3829, 'fr', '', ''),
(155, 'Final__Heaven', 0, 373, 4, 0, 0, 2, 0, 0, 0, 0, 80.6, 'jp', '', ''),
(149, 'hyrulehippie', 266, 0, 349, 0, 23450, 0, 0, 9, 0, 0, 2755.81818181818, 'jp', '', ''),
(150, 'sinisterscribe', 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 'jp', '', ''),
(151, 'r_b_n_w_n', 179, 2153, 0, 0, 0, 0, 535, 0, 55, 0, 719.835294117647, 'jp', '', ''),
(153, 'Hyperglot', 7, 0, 0, 0, 0, 0, 0, 5, 0, 0, 12, 'eo', 'fr', 'es');
