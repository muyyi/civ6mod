-- SELECT 
-- 获取Modifier的详细信息
SELECT DynamicModifiers.*,Modifiers.ModifierId,Modifiers.SubjectRequirementSetId,ModifierArguments.Name,ModifierArguments.Value FROM DynamicModifiers
INNER JOIN Modifiers ON Modifiers.ModifierType = DynamicModifiers.ModifierType
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
WHERE DynamicModifiers.ModifierType LIKE '%DISTRICT%PRODUCTION%';

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