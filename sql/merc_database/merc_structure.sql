DROP DATABASE IF EXISTS `arcmercs`;
CREATE DATABASE IF NOT EXISTS `arcmercs` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `arcmercs`;

CREATE TABLE `mercenaries` (
  `ownerGuid` int(6) unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `entry` int(6) unsigned NOT NULL DEFAULT '0',
  `display` int(6) unsigned NOT NULL DEFAULT '0',
  `angle` float unsigned NOT NULL,
  `stance` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `mercGuid` varchar(21) NOT NULL DEFAULT '',
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

CREATE TABLE `spells` (
  `entry` int(6) unsigned NOT NULL DEFAULT '0',
  `stance` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `slot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spellId` int(6) unsigned NOT NULL DEFAULT '0',
  `rank` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `minlv` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `maxlv` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `target` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `spName` varchar(21) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`, `stance`, `slot`, `spellId`, `rank`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='MercSystem';

CREATE TABLE `weapons` (
  `entry` int(6) unsigned NOT NULL DEFAULT '0',
  `groupId` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `team` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `display` int(6) unsigned NOT NULL DEFAULT '0',
  `stance` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `slot1` int(6) unsigned NOT NULL DEFAULT '0',
  `slot2` int(6) unsigned NOT NULL DEFAULT '0',
  `slot3` int(6) unsigned NOT NULL DEFAULT '0',
  `teamName` varchar(21) NOT NULL DEFAULT '',
  `raceName` varchar(21) NOT NULL DEFAULT '',
  `type` varchar(21) NOT NULL DEFAULT '',
  PRIMARY KEY (`entry`, `groupId`, `team`, `display`, `stance`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='MercSystem';