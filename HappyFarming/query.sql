-- BASE_YIELD_CHANGE
SELECT * FROM DistrictModifiers AS dm
INNER JOIN Modifiers AS ms ON dm.ModifierId = ms.ModifierId
INNER JOIN ModifierArguments AS ma ON ms.ModifierId = ma.ModifierId
WHERE ms.ModifierType = 'MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE'; 

-- Industrial_building_add_production
SELECT * FROM BuildingModifiers
INNER JOIN Modifiers ON BuildingModifiers.ModifierId = Modifiers.ModifierId
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
INNER JOIN RequirementSets ON RequirementSets.RequirementSetId = Modifiers.SubjectRequirementSetId
INNER JOIN RequirementSetRequirements ON RequirementSetRequirements.RequirementSetId = RequirementSets.RequirementSetId
INNER JOIN Requirements ON Requirements.RequirementId = RequirementSetRequirements.RequirementId
INNER JOIN RequirementArguments ON RequirementArguments.RequirementId = Requirements.RequirementId
WHERE BuildingModifiers.BuildingType = 'BUILDING_WORKSHOP';

-- building_modifier(test with Monument)
SELECT bm.BuildingType,bm.ModifierId,ms.ModifierType,ma.Name,ma.Value,rs.RequirementSetId,rrs.RequirementId,r.RequirementType,ra.Name,ra.Value FROM BuildingModifiers AS bm
INNER JOIN Modifiers AS ms ON ms.ModifierId = bm.ModifierId
INNER JOIN ModifierArguments AS ma ON ma.ModifierId = ms.ModifierId
INNER JOIN RequirementSets AS rs ON rs.RequirementSetId = ms.SubjectRequirementSetId
INNER JOIN RequirementSetRequirements AS rrs ON rs.RequirementSetId = rrs.RequirementSetId
INNER JOIN Requirements AS r ON r.RequirementId = rrs.RequirementId
INNER JOIN RequirementArguments AS ra ON ra.RequirementId = r.RequirementId
WHERE bm.BuildingType LIKE '%Monument%'; 

SELECT * FROM BuildingModifiers
INNER JOIN Modifiers ON BuildingModifiers.ModifierId = Modifiers.ModifierId
INNER JOIN ModifierArguments ON ModifierArguments.ModifierId = Modifiers.ModifierId
INNER JOIN RequirementSets ON RequirementSets.RequirementSetId = Modifiers.SubjectRequirementSetId
INNER JOIN RequirementSetRequirements ON RequirementSetRequirements.RequirementSetId = RequirementSets.RequirementSetId
INNER JOIN Requirements ON RequirementSetRequirements.RequirementId = Requirements.RequirementId
INNER JOIN RequirementArguments ON RequirementArguments.RequirementId = Requirements.RequirementId
WHERE BuildingModifiers.BuildingType = 'BUILDING_HANGING_GARDENS';
