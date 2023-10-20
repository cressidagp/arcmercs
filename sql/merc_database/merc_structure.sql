DROP DATABASE IF EXISTS `arcmercs`;
CREATE DATABASE IF NOT EXISTS `arcmercs` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `arcmercs`;

CREATE TABLE `mercenaries` (
  `ownerGuid` int(6) unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `entry` int(6) unsigned NOT NULL DEFAULT '0',
  `display` int(6) unsigned NOT NULL DEFAULT '0',
  `ownerName` varchar(21) NOT NULL DEFAULT '',
  `type` varchar(21) NOT NULL DEFAULT '',
  PRIMARY KEY (`ownerguid`, `groupId`, `id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='MercSystem';

CREATE TABLE `gossip_display` (
  `entry` int(6) unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `team` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `optionName` varchar(21) NOT NULL DEFAULT '',
  `optionId` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `display` int(6) unsigned NOT NULL DEFAULT '0',
  `teamName` varchar(21) NOT NULL DEFAULT '',
  `type` varchar(21) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`, `groupId`, `team`, `optionId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='MercSystem';