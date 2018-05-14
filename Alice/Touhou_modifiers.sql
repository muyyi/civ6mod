-- Marisa
INSERT INTO Modifiers 
		(ModifierId, ModifierType, SubjectRequirementSetId)
VALUES	('SPY_CHOOSE_SKILL', 'MODIFIER_PLAYER_UNIT_GRANT_UNLIMITED_PROMOTION_CHOICES', NULL) ,
		('MARISA_ADD_TRADE_ROUTE_CAPACITY', 'EFFECT_ADJUST_TRADE_ROUTE_CAPACITY', 'PLAYER_DECLARED_FRIEND') ,
		('MARISA_GRANT_TRADER', 'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY', 'PLAYER_DECLARED_FRIEND');

INSERT INTO ModifierArguments
		(ModifierId, Name, Value)
VALUES	('SPY_CHOOSE_SKILL', 'UnitType', 'UNIT_SPY'),
		('MARISA_ADD_TRADE_ROUTE_CAPACITY', 'Amount', 1) ,
		('MARISA_GRANT_TRADER', 'UnitType', 'UNIT_TRADER') ,
		('MARISA_GRANT_TRADER', 'Amount', 1);


INSERT INTO UnitPromotionModifiers 
		(UnitPromotionType, ModifierId)
VALUES	('PROMOTION_MARISA_L1L', 'GUNBOATDIPLOMACY_OPENBORDERS') ,
		('PROMOTION_MARISA_L1L', 'GUNBOATDIPLOMACY_INFLUENCEPOINTS') ,
		('PROMOTION_MARISA_L2L', 'UNIQUE_LEADER_ADD_VISIBILITY') ,
		-- 被宣友时，获得一条免费的商路和贸易路线
		('PROMOTION_MARISA_L2L', 'MARISA_ADD_TRADE_ROUTE_CAPACITY') ,
		('PROMOTION_MARISA_L2L', 'MARISA_GRANT_TRADER') ,
		('PROMOTION_MARISA_L3L', 'POTALA_PALACE_DIPLOMATIC_GOVERNMENT_SLOT') ,
		('PROMOTION_MARISA_L1R', 'UNIQUE_LEADER_ADD_SPY_CAPACITY') ,
		('PROMOTION_MARISA_L1R', 'SPY_QUARTERMASTER') ,
		('PROMOTION_MARISA_L2R', 'UNIQUE_LEADER_SPIES_START_PROMOTED') ,
		('PROMOTION_MARISA_L2R', 'SPY_CHOOSE_SKILL') ,
		-- 暂时先将效果改为附赠一个间谍并提高一个间谍容量
		('PROMOTION_MARISA_L1R', 'UNIQUE_LEADER_ADD_SPY_CAPACITY') ,
		('PROMOTION_MARISA_L3R', 'UNIQUE_LEADER_ADD_SPY_UNIT') ,
		-- ('PROMOTION_MARISA_L3R', 'SPY_MARISA') ,
		-- ('PROMOTION_MARISA_L3R', 'SPY_MARISA_GREAT_WORK_HEIST') ,
		-- ('PROMOTION_MARISA_L3R', 'SPY_MARISA_SIPHON_FUND') ,
		-- 暂时先将效果改为从同盟时获得贸易路线，同时双方获得更多贸易加成(Arsenal of Democracy)
		('PROMOTION_MARISA_L4R', 'ALLIANCE_ADJUST_PLAYER_TRADE_ROUTE_CAPACITY') ,
		('PROMOTION_MARISA_L4R', 'ARSENALOFDEMOCRACY_TRADEROUTEFOODTOALLY') ,
		('PROMOTION_MARISA_L4R', 'ARSENALOFDEMOCRACY_TRADEROUTEPRODUCTIONTOALLY') ,
		('PROMOTION_MARISA_L4R', 'ARSENALOFDEMOCRACY_TRADEROUTEFOODFROMALLY') ,
		('PROMOTION_MARISA_L4R', 'ARSENALOFDEMOCRACY_TRADEROUTEPRODUCTIONFROMALLY') ,
		('PROMOTION_MARISA_L4R', 'ARSENALOFDEMOCRACY_ALLIANCEPOINTS') ;

-- Shinki
-- Can see any thing
CREATE TABLE IF NOT EXISTS HiddenStrategics AS 
	SELECT ResourceType FROM Resources 
	WHERE ResourceClassType="RESOURCECLASS_STRATEGIC" AND PrereqTech IS NOT NULL ;


INSERT INTO Modifiers 
	(ModifierId, 	ModifierType, 	RunOnce, Permanent, OwnerRequirementSetId, SubjectRequirementSetId)
SELECT	'ALICE_PLAYER_CAN_SEE' || HiddenStrategics.ResourceType, 	'MODIFIER_PLAYER_GRANT_FREE_RESOURCE_VISIBILITY', 1, 1, NULL, NULL
	FROM HiddenStrategics;


INSERT INTO ModifierArguments
	(ModifierId, Name, Value)
SELECT 'ALICE_PLAYER_CAN_SEE' || HiddenStrategics.ResourceType, 'ResourceType', HiddenStrategics.ResourceType	
	FROM HiddenStrategics;

INSERT INTO UnitPromotionModifiers
	(UnitPromotionType, ModifierId)
SELECT 'PROMOTION_SHINKI_L1', 'ALICE_PLAYER_CAN_SEE' || HiddenStrategics.ResourceType
	FROM HiddenStrategics;


-- Can build any improvement
INSERT INTO Modifiers 
		(ModifierId, ModifierType, RunOnce, Permanent, OwnerRequirementSetId, SubjectRequirementSetId)
SELECT 'ALICE_PLAYER_CAN_BUILD_' || ImprovementType, 'MODIFIER_PLAYER_ADJUST_VALID_IMPROVEMENT', 0, 0, NULL, NULL
FROM Improvements;

INSERT INTO ModifierArguments
		(ModifierId, Name, Value)
SELECT 'ALICE_PLAYER_CAN_BUILD_' || ImprovementType, 'ImprovementType', ImprovementType
FROM Improvements;

INSERT INTO UnitPromotionModifiers
		(UnitPromotionType, ModifierId)
SELECT 'PROMOTION_SHINKI_L2', 'ALICE_PLAYER_CAN_BUILD_' || ImprovementType
FROM Improvements;

-- Some wonder stronger
-- 先随便用2个技能代替试试
INSERT INTO UnitPromotionModifiers
	(UnitPromotionType, ModifierId)
VALUES	('PROMOTION_SHINKI_L3', 'PETRA_DESERT_FOOD') ,
		('PROMOTION_SHINKI_L4', 'PETRA_DESERT_GOLD') ;



