SET @ID1 := 43283;

DELETE FROM creature_proto WHERE entry = @ID1;

INSERT INTO `creature_proto` (`entry`, `name`, `subname`, `info_str`, `flags1`, `type`, `family`, `rank`, `killcredit1`, `killcredit2`, `male_displayid`, `female_displayid`, `male_displayid2`, `female_displayid2`, `unknown_float1`, `unknown_float2`, `leader`, `questitem1`, `questitem2`, `questitem3`, `questitem4`, `questitem5`, `questitem6`, `waypointid`, `minlevel`, `maxlevel`, `faction`, `minhealth`, `maxhealth`, `mana`, `scale`, `npcflags`, `attacktime`, `attacktype`, `mindamage`, `maxdamage`, `can_ranged`, `rangedattacktime`, `rangedmindamage`, `rangedmaxdamage`, `respawntime`, `armor`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `combat_reach`, `bounding_radius`, `auras`, `boss`, `money`, `invisibility_type`, `walk_speed`, `run_speed`, `fly_speed`, `extra_a9_flags`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `spell_flags`, `modImmunities`, `isTrainingDummy`, `guardtype`, `summonguard`, `spelldataid`, `vehicleid`, `rooted`) 
VALUES (43283, 'Mercenary Master', 'ArcMercs', 'Buy', 0, 7, 0, 0, 0, 0, 3167, 5446, 0, 0, 1.5, 1, 0, 0, 0, 0, 0, 0, 0, 144, 75, 75, 35, 15952, 15952, 0, 1, 1, 2000, 0, 342, 485, 0, 1500, 0, 0, 25000000, 8219, 0, 0, 0, 0, 0, 0, 1.5, 0.306, '', 0, 0, 0, 2.5, 8, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);