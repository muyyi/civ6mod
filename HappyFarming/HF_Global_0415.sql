-- rep
-- I recomment you put this in the front
-- otherwise it maybe useless because foreign key constraint failed.
-- INSERT INTO Requirements
-- 		(RequirementId,RequirementType)
-- VALUES	('CITY_HAS_WORKSHOP','REQUIREMENT_CITY_HAS_BUILDING') ;

-- -- 暂时绑定纪念碑(测试)
-- INSERT INTO RequirementArguments 
-- 		(RequirementId,Name,Value)
-- VALUES 	('CITY_HAS_WORKSHOP','BuildingType','BUILDING_MONUMENT') ;

-- INSERT INTO RequirementSets 
-- 	(RequirementSetId,RequirementSetType)
-- VALUES 	('REQUIRES_CITY_HAS_WORKSHOP','REQUIREMENTSET_TEST_ALL');

-- INSERT INTO RequirementSetRequirements
-- 		(RequirementSetId,RequirementId)
-- VALUES	 ('REQUIRES_CITY_HAS_WORKSHOP','CITY_HAS_WORKSHOP')  ;

-- Distruct
-- 奇观为相邻剧院提供2点加成
INSERT INTO District_Adjacencies 
		 (DistrictType, YieldChangeId) 
VALUES   ('DISTRICT_THEATER', 'NaturalWonder_Culture') ,
		 ('DISTRICT_ACROPOLIS', 'NaturalWonder_Culture') ;
INSERT INTO Adjacency_YieldChanges 
		(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentNaturalWonder) 
VALUES  ('NaturalWonder_Culture', 'LOC_PLACEHOLDER', 'YIELD_CULTURE', 2 , 1 , 1) ;

-- 国家奇观为所在城市增加2点宜居度
UPDATE Buildings SET Entertainment=2 WHERE IsWonder=1;

-- 部分区域提升基础产出
-- DistrictModifiers
INSERT INTO DistrictModifiers(DistrictType,ModifierId)
VALUES ('DISTRICT_INDUSTRIAL_ZONE','DISTRICT_BASE_YIELD_PRODUCTION'),
('DISTRICT_THEATER','DISTRICT_BASE_YIELD_CULTURE'),
('DISTRICT_CAMPUS','DISTRICT_BASE_YIELD_SCIENCE'),
('DISTRICT_COMMERCIAL_HUB','DISTRICT_BASE_YIELD_GOLD'),
('DISTRICT_HARBOR','DISTRICT_BASE_YIELD_FAITH'),
('DISTRICT_HANSA','DISTRICT_BASE_YIELD_PRODUCTION'),
('DISTRICT_ACROPOLIS','DISTRICT_BASE_YIELD_CULTURE'),
('DISTRICT_SEOWON','DISTRICT_BASE_YIELD_SCIENCE'),
('DISTRICT_ROYAL_NAVY_DOCKYARD','DISTRICT_BASE_YIELD_GOLD'),
('DISTRICT_LAVRA','DISTRICT_BASE_YIELD_FAITH');

-- Modifiers
INSERT INTO Modifiers(ModifierId,ModifierType)
VALUES ('DISTRICT_BASE_YIELD_PRODUCTION','MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE'),
('DISTRICT_BASE_YIELD_CULTURE','MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE'),
('DISTRICT_BASE_YIELD_SCIENCE','MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE'),
('DISTRICT_BASE_YIELD_GOLD','MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE'),
('DISTRICT_BASE_YIELD_FAITH','MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE');

-- ModifierArguments
INSERT INTO ModifierArguments(ModifierId,Name,Value)
VALUES ('DISTRICT_BASE_YIELD_PRODUCTION','YieldType','YIELD_PRODUCTION'),
('DISTRICT_BASE_YIELD_PRODUCTION','Amount',2),
('DISTRICT_BASE_YIELD_CULTURE','YieldType','YIELD_CULTURE'),
('DISTRICT_BASE_YIELD_CULTURE','Amount',2),
('DISTRICT_BASE_YIELD_SCIENCE','YieldType','YIELD_SCIENCE'),
('DISTRICT_BASE_YIELD_SCIENCE','Amount',2),
('DISTRICT_BASE_YIELD_GOLD','YieldType','GOLD'),
('DISTRICT_BASE_YIELD_GOLD','Amount',2),
('DISTRICT_BASE_YIELD_FAITH','YieldType','YIELD_FAITH'),
('DISTRICT_BASE_YIELD_FAITH','Amount',2);

-- sql search
-- SELECT * FROM DistrictModifiers AS dm
-- INNER JOIN Modifiers AS ms ON dm.ModifierId = ms.ModifierId
-- INNER JOIN ModifierArguments AS ma ON ms.ModifierId = ma.ModifierId
-- WHERE ms.ModifierType = 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE'; 


-- 提升工业区建筑产能(由2/3/4提升至4/8/12)
UPDATE Building_YieldChanges
SET YieldChange = 4 
WHERE BuildingType="BUILDING_WORKSHOP" AND YieldType="YIELD_PRODUCTION";

UPDATE Building_YieldChanges
SET YieldChange = 8
WHERE BuildingType="BUILDING_FACTORY" AND YieldType="YIELD_PRODUCTION";

UPDATE Building_YieldChanges
SET YieldChange = 8
WHERE BuildingType="BUILDING_ELECTRONICS_FACTORY" AND YieldType="YIELD_PRODUCTION";

UPDATE Building_YieldChanges
SET YieldChange = 12
WHERE BuildingType="BUILDING_POWER_PLANT" AND YieldType="YIELD_PRODUCTION"; 

-- 每个工业区建筑为城市建造(包括区域/建筑/奇观)提供5%产能(建议一开始用纪念碑+100%，方便测试)
-- INSERT INTO BuildingModifiers(BuildingType,ModifierId)
-- VALUES ('BUILDING_MONUMENT','BUILDING_WORKSHOP_FASTER_BUILDTIME_DISTRICT'),
-- ('BUILDING_MONUMENT','BUILDING_WORKSHOP_FASTER_BUILDTIME_BUILDING'),
-- ('BUILDING_MONUMENT','BUILDING_WORKSHOP_FASTER_BUILDTIME_WONDER'),
-- ('BUILDING_WORKSHOP','BUILDING_WORKSHOP_FASTER_BUILDTIME_DISTRICT'),
-- ('BUILDING_WORKSHOP','BUILDING_WORKSHOP_FASTER_BUILDTIME_BUILDING'),
-- ('BUILDING_WORKSHOP','BUILDING_WORKSHOP_FASTER_BUILDTIME_WONDER'),
-- ('BUILDING_FACTORY','BUILDING_FACTORY_FASTER_BUILDTIME_DISTRICT'),
-- ('BUILDING_FACTORY','BUILDING_FACTORY_FASTER_BUILDTIME_BUILDING'),
-- ('BUILDING_FACTORY','BUILDING_FACTORY_FASTER_BUILDTIME_WONDER'),
-- ('BUILDING_ELECTRONICS_FACTORY','BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_DISTRICT'),
-- ('BUILDING_ELECTRONICS_FACTORY','BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_BUILDING'),
-- ('BUILDING_ELECTRONICS_FACTORY','BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_WONDER'),
-- ('BUILDING_POWER_PLANT','BUILDING_POWER_PLANT_FASTER_BUILDTIME_DISTRICT'),
-- ('BUILDING_POWER_PLANT','BUILDING_POWER_PLANT_FASTER_BUILDTIME_BUILDING'),
-- ('BUILDING_POWER_PLANT','BUILDING_POWER_PLANT_FASTER_BUILDTIME_WONDER');

-- INSERT INTO Modifiers(ModifierId,ModifierType,SubjectRequirementSetId)
-- VALUES ('BUILDING_WORKSHOP_FASTER_BUILDTIME_DISTRICT','MODIFIER_PLAYER_CITIES_ADJUST_ALL_DISTRICTS_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_WORKSHOP_FASTER_BUILDTIME_BUILDING','MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_WORKSHOP_FASTER_BUILDTIME_WONDER','MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_FACTORY_FASTER_BUILDTIME_DISTRICT','MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_FACTORY_FASTER_BUILDTIME_BUILDING','MODIFIER_PLAYER_CITY_ADJUST_BUILDING_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_FACTORY_FASTER_BUILDTIME_WONDER','MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_DISTRICT','MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_BUILDING','MODIFIER_PLAYER_CITY_ADJUST_BUILDING_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_WONDER','MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_POWER_PLANT_FASTER_BUILDTIME_DISTRICT','MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_POWER_PLANT_FASTER_BUILDTIME_BUILDING','MODIFIER_PLAYER_CITY_ADJUST_BUILDING_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP'),
-- ('BUILDING_POWER_PLANT_FASTER_BUILDTIME_WONDER','MODIFIER_PLAYER_CITIES_ADJUST_WONDER_PRODUCTION','REQUIRES_CITY_HAS_WORKSHOP');

-- INSERT INTO ModifierArguments(ModifierId,Name,Value)
-- VALUES ('BUILDING_WORKSHOP_FASTER_BUILDTIME_DISTRICT','Amount',100),
-- ('BUILDING_WORKSHOP_FASTER_BUILDTIME_BUILDING','Amount',100),
-- ('BUILDING_WORKSHOP_FASTER_BUILDTIME_WONDER','Amount',100),
-- ('BUILDING_FACTORY_FASTER_BUILDTIME_DISTRICT','Amount',100),
-- ('BUILDING_FACTORY_FASTER_BUILDTIME_BUILDING','Amount',100),
-- ('BUILDING_FACTORY_FASTER_BUILDTIME_WONDER','Amount',100),
-- ('BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_DISTRICT','Amount',100),
-- ('BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_BUILDING','Amount',100),
-- ('BUILDING_ELECTRONICS_FACTORY_FASTER_BUILDTIME_WONDER','Amount',100),
-- ('BUILDING_POWER_PLANT_FASTER_BUILDTIME_DISTRICT','Amount',100),
-- ('BUILDING_POWER_PLANT_FASTER_BUILDTIME_BUILDING','Amount',100),
-- ('BUILDING_POWER_PLANT_FASTER_BUILDTIME_WONDER','Amount',100);

-- sql search
-- SELECT bm.BuildingType,bm.ModifierId,ms.ModifierType,ma.Name,ma.Value,rs.RequirementSetId,rrs.RequirementId,r.RequirementType,ra.Name,ra.Value FROM BuildingModifiers AS bm
-- INNER JOIN Modifiers AS ms ON ms.ModifierId = bm.ModifierId
-- INNER JOIN ModifierArguments AS ma ON ma.ModifierId = ms.ModifierId
-- INNER JOIN RequirementSets AS rs ON rs.RequirementSetId = ms.SubjectRequirementSetId
-- INNER JOIN RequirementSetRequirements AS rrs ON rs.RequirementSetId = rrs.RequirementSetId
-- INNER JOIN Requirements AS r ON r.RequirementId = rrs.RequirementId
-- INNER JOIN RequirementArguments AS ra ON ra.RequirementId = r.RequirementId
-- WHERE bm.BuildingType LIKE '%Monument%'; 

-- 真正的专家
-- 每个城区专家产出提高(除商业中心提高到6金币外，剧院/学院/工坊的产出提升至3)
UPDATE "District_CitizenYieldChanges"
SET YieldChange = 3 
WHERE DistrictType != 'DISTRICT_COMMERCIAL_HUB';

UPDATE "District_CitizenYieldChanges"
SET YieldChange = 6
WHERE DistrictType = 'DISTRICT_COMMERCIAL_HUB'; 

-- 同时产出相应区域的伟人点数(固定为1)
-- INSERT INTO District_CitizenGreatPersonPoints
-- (DistrictType,GreatPersonClassType,PointsPerTurn)
-- VALUES 
-- ('DISTRICT_INDUSTRIAL_ZONE','GREAT_PERSON_CLASS_ENGINEER',1),
-- ('DISTRICT_HANSA','GREAT_PERSON_CLASS_ENGINEER',1),
-- ('DISTRICT_COMMERCIAL_HUB','GREAT_PERSON_CLASS_MERCHANT',1),
-- ('DISTRICT_CAMPUS','GREAT_PERSON_CLASS_SCIENTIST',1),
-- -- 在sqlite中会报错，游戏中不清楚，带测试，先注释
-- -- ('DISTRICT_SEOWON','GREAT_PERSON_CLASS_SCIENTIST',1),
-- ('DISTRICT_THEATER','GREAT_PERSON_CLASS_WRITER',1),
-- ('DISTRICT_ACROPOLIS','GREAT_PERSON_CLASS_SCIENTIST',1);

REPLACE INTO District_CitizenGreatPersonPoints
(DistrictType,GreatPersonClassType,PointsPerTurn)
VALUES 
('DISTRICT_INDUSTRIAL_ZONE','GREAT_PERSON_CLASS_ENGINEER',1),
('DISTRICT_HANSA','GREAT_PERSON_CLASS_ENGINEER',1),
('DISTRICT_COMMERCIAL_HUB','GREAT_PERSON_CLASS_MERCHANT',1),
('DISTRICT_CAMPUS','GREAT_PERSON_CLASS_SCIENTIST',1),
('DISTRICT_THEATER','GREAT_PERSON_CLASS_WRITER',1),
('DISTRICT_ACROPOLIS','GREAT_PERSON_CLASS_SCIENTIST',1);


-- 但是专家额外消耗1食物，同时学院还将额外消耗3金币（科研基金）
INSERT INTO "District_CitizenYieldChanges"
(DistrictType,YieldType,YieldChange)
VALUES ('DISTRICT_THEATER','YIELD_FOOD',-1),
('DISTRICT_ACROPOLIS','YIELD_FOOD',-1),
('DISTRICT_CAMPUS','YIELD_FOOD',-1),
('DISTRICT_CAMPUS','YIELD_GOLD',-3),
('DISTRICT_SEOWON','YIELD_FOOD',-1),
('DISTRICT_SEOWON','YIELD_GOLD',-3),
('DISTRICT_INDUSTRIAL_ZONE','YIELD_FOOD',-1),
('DISTRICT_HANSA','YIELD_FOOD',-1),
('DISTRICT_COMMERCIAL_HUB','YIELD_FOOD',-1);


-- SEWER
UPDATE Buildings
SET Entertainment = 2, Housing = 3
WHERE BuildingType = 'BUILDING_SEWER';

-- AQUEDUCT
UPDATE Districts
SET Appeal = 1
WHERE DistrictType = 'DISTRICT_AQUEDUCT';

-- wonder
UPDATE Building_YieldChanges
SET YieldChange = 5
WHERE BuildingType = 'BUILDING_STONEHENGE';

UPDATE Buildings
SET Housing = 4
WHERE BuildingType = 'BUILDING_HANGING_GARDENS';

INSERT INTO Building_GreatWorks
(BuildingType,GreatWorkSlotType,NumSlots)
VALUES ('BUILDING_ORACLE','GREATWORKSLOT_RELIC',1);

-- 小马哥的修改，暂时先放到这里了(收获资源的收益降低至33%)
UPDATE ModifierArguments
SET Value = 33
WHERE ModifierId = 'GROUNDBREAKER_BONUS_HARVEST_YIELDS';













