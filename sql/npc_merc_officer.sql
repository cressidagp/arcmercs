SET @ID4 := 43286;
SET @ID5 := 43287;

DELETE FROM creature_names WHERE entry IN ( @ID4, @ID5);
DELETE FROM creature_proto WHERE entry IN ( @ID4, @ID5);

INSERT INTO creature_names (`entry`, `name`, `subname`, `info_str`, `flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`, `questitem1`, `questitem2`, `questitem3`, `questitem4`, `questitem5`, `questitem6`, `waypointid`) 
VALUES (@ID4, 'Mercenary Officer', '', '', 0, 7, 0, 0, 0, 0, 21308, 21310, 21309, 21311, 1.5, 1, 0, 0, 0, 0, 0, 0, 0, 144);

INSERT INTO creature_proto (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `spell_flags`, `modImmunities`, `isTrainingDummy`, `guardtype`, `summonguard`, `spelldataid`, `vehicleid`, `rooted`) 
VALUES (@ID4, 75, 75, 11, 15952, 15952, 0, 1, 1, 2000, 0, 342, 485, 0, 1500, 0, 0, 25000000, 8219, 0, 0, 0, 0, 0, 0, 1.5, 0.306, '', 0, 0, 0, 2.5, 8, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

INSERT INTO creature_names (`entry`, `name`, `subname`, `info_str`, `flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`, `questitem1`, `questitem2`, `questitem3`, `questitem4`, `questitem5`, `questitem6`, `waypointid`) 
VALUES (@ID5, 'Mercenary Officer', '', '', 0, 7, 0, 0, 0, 0, 21312, 21313, 21314, 21315, 1.5, 1, 0, 0, 0, 0, 0, 0, 0, 144);

INSERT INTO creature_proto (`entry`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `spell_flags`, `modImmunities`, `isTrainingDummy`, `guardtype`, `summonguard`, `spelldataid`, `vehicleid`, `rooted`) 
VALUES (@ID5, 75, 75, 85, 15952, 15952, 0, 1, 1, 2000, 0, 342, 485, 0, 1500, 0, 0, 25000000, 8219, 0, 0, 0, 0, 0, 0, 1.5, 0.306, '', 0, 0, 0, 2.5, 8, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);