-- SELECT 
-- 获取Modifier的详细信息
SELECT DynamicModifiers.*,Modifiers.ModifierId,Modifiers.SubjectRequirementSetId,ModifierArguments.Name,ModifierArguments.Value FROM DynamicModifiers
INNER JOIN Modifiers ON Modifiers.ModifierType = DynamicModifiers.ModifierType
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
WHERE Modifiers.ModifierType LIKE '%MODIFIER_PLAYER_CORPS_ARMY_MODIFIED_STRENGTH%';


-- 获取modifier所绑定的对象(注意，不一定有结果，需要优化)
SELECT * FROM Modifiers
INNER JOIN TraitModifiers ON TraitModifiers.ModifierId = Modifiers.ModifierId
WHERE Modifiers.ModifierType LIKE '%MODIFIER_PLAYER_CITIES_ADJUST_ALL_DISTRICTS_PRODUCTION%';

-- 特定条件的ModifierType
SELECT * FROM DynamicModifiers
WHERE ModifierType LIKE '%BUILDING%PRODUCTION%' AND CollectionType = 'COLLECTION_OWNER';


SELECT DynamicModifiers.*,Modifiers.ModifierId,Modifiers.SubjectRequirementSetId,ModifierArguments.Name,ModifierArguments.Value FROM DynamicModifiers
INNER JOIN Modifiers ON Modifiers.ModifierType = DynamicModifiers.ModifierType
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
WHERE DynamicModifiers.ModifierType LIKE '%BUILDING%PRODUCTION%' AND DynamicModifiers.CollectionType = 'COLLECTION_OWNER';

SELECT * FROM Modifiers
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
WHERE Modifiers.ModifierId LIKE '%TEST_CITY_BUILDING_FASTER%' OR Modifiers.ModifierId IS 'MINOR_CIV_PRODUCTION_WALLS';

-- 某个国家关联的modifier详情
SELECT Modifiers.ModifierId,Modifiers.SubjectRequirementSetId,ModifierArguments.Name,ModifierArguments.Value FROM Civilizations
INNER JOIN CivilizationTraits ON Civilizations.CivilizationType = CivilizationTraits.CivilizationType
INNER JOIN Traits ON Traits.TraitType = CivilizationTraits.TraitType
INNER JOIN TraitModifiers ON TraitModifiers.TraitType = Traits.TraitType
INNER JOIN Modifiers ON Modifiers.ModifierId = TraitModifiers.ModifierId
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
WHERE Civilizations.CivilizationType LIKE '%Georgia%';

-- 某个领袖关联的modifier详情
SELECT Modifiers.ModifierId,Modifiers.SubjectRequirementSetId,ModifierArguments.Name,ModifierArguments.Value FROM Leaders
INNER JOIN LeaderTraits ON LeaderTraits.LeaderType = Leaders.LeaderType
INNER JOIN Traits ON Traits.TraitType = LeaderTraits.TraitType
INNER JOIN TraitModifiers ON TraitModifiers.TraitType = Traits.TraitType
INNER JOIN Modifiers ON Modifiers.ModifierId = TraitModifiers.ModifierId
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
WHERE Leaders.LeaderType LIKE '%QIN%';

-- 查找某个人文/科技
SELECT * FROM Civics
WHERE CivicType LIKE '%Training%'

SELECT * FROM Technologies
WHERE TechnologyType LIKE '%Training%'

-- 根据某个条件查找完整条件集
SELECT * FROM RequirementSets
INNER JOIN RequirementSetRequirements ON RequirementSetRequirements.RequirementSetId = RequirementSets.RequirementSetId
INNER JOIN Requirements ON Requirements.RequirementId = RequirementSetRequirements.RequirementId
INNER JOIN RequirementArguments ON RequirementArguments.RequirementId = Requirements.RequirementId
WHERE RequirementSets.RequirementSetId LIKE '%HOPLITE_PLOT_IS_HOPLITE_REQUIREMENTS%';

SELECT Modifiers.ModifierId,Modifiers.SubjectRequirementSetId,ModifierArguments.Name,ModifierArguments.Value FROM TraitModifiers
INNER JOIN Modifiers ON Modifiers.ModifierId = TraitModifiers.ModifierId
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
WHERE TraitModifiers.TraitType LIKE '%QIN%';

