DROP TABLE IF EXISTS `merc`;

CREATE TABLE `merc` (
  `guid` int(6) unsigned NOT NULL DEFAULT '0',
  `name` varchar(21) NOT NULL DEFAULT '',
  `slot1entry` int(10) unsigned NOT NULL DEFAULT '0',
  `slot2entry` int(10) unsigned NOT NULL DEFAULT '0',
  `slot3entry` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='MercSystem';