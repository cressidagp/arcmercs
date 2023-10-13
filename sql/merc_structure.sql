DROP DATABASE IF EXISTS `arc_mercs`;
CREATE DATABASE IF NOT EXISTS `arc_mercs` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `arc_mercs`;

CREATE TABLE `mercenaries` (
  `ownerGuid` int(6) unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `entry` int(6) unsigned NOT NULL DEFAULT '0',
  `ownerName` varchar(21) NOT NULL DEFAULT '',
  `type` varchar(21) NOT NULL DEFAULT '',
  PRIMARY KEY (`ownerguid`, `groupId`, `id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='MercSystem';