/*
	INSTRUCTIONS

	Update the Values below to customize your gameplay experience. 
	Be sure to change only the number that appears after the Value and nothing else in the code.
*/
 
-- LOGS
-- Do not edit this section. It is used for bug tracking purposes.

CREATE TABLE HF_Options 
(
   OptionID text PRIMARY KEY,
   Value text,
   OptionClass text
);

INSERT INTO HF_Options
   (OptionID,        Value,   OptionClass)
VALUES   ('HF_OPTION_BORDER_SPEED_AMOUNT',  '-99', 'HF'),
   ('HF_OPTION_MAX_BARB_CAMPS_PER_PLAYER',  '-99', 'HF');


UPDATE GlobalParameters
SET Value = 30
WHERE Name = 'Ma_bonus';

UPDATE Eras SET GreatPersonBaseCost = GreatPersonBaseCost*1 
WHERE EraType = 'ERA_ANCIENT' AND 
(SELECT tblquoOptions.Value FROM tblQuoOptions WHERE tblQuoOptions.OptionID='QUO_OPTION_SLOW_GREAT_PEOPLE') >0 ;

UPDATE ModifierArguments
   SET Value = (
           SELECT tblQuoOptions.Value
             FROM tblQuoOptions
            WHERE tblQuoOptions.OptionID = 'QUO_OPTION_BORDER_SPEED_AMOUNT'
       )
 WHERE ModifierId = 'QUO_CULTURE_BORDER_DISCOUNT_OPTION' AND 
       Name = 'Amount';


-- 请教一个关于数据库的问题
-- 我现在有一个config表，里面两个字段，id和value
-- 我在sql文件里，想通过这2个字段来控制某些代码是否执行（0为关闭，1为执行），逻辑如下

-- if((SELECT config.value WHERE config.id = 'xxx') == 1){
-- 要执行的sql代码
-- }

-- 这个的操作应该是怎么样的？
-- 谢谢

-- 补充：
-- 指的不是简单的where和case语句，这种或许可以用在一些简单的查询里
-- 但我现在想要的是控制一段sql代码是否执行
-- 举个例子
-- 如果我只是要根据config的id和value修改另一个表，那么我在UPDATE后面增加
-- WHERE (SELECT config.value WHERE config.id = 'xxx') = 1
-- 这样的代码是可以的

-- 但假设我要插入一行新数据呢？显然就不能用WHERE了

-- 没法搞…… 这个一定要在 sql 里写的话就死存储过程了
-- 这种逻辑放在应用层吧，没啥关系
-- 就是存储过程了


 




-- ====== START YOUR EDITING HERE BY ADJUSTING THE NUMBERS THAT APPEAR AFTER THE VALUE FIELD
-- ======================================================================================
-- ==                              HF MOD OPTIONS                          ==
-- ======================================================================================





-- ================
-- USE OLD HARDCORE RULES FOR TECH AND CULTURE
/* Set Value to enable or disable the old Hardcore rules for science and culture. 1= Enable, 0=Disable. In this mode, you receive no free culture or science from population.
The AI receives a bonus to each district it builds, rising as it progresses through the eras.  This mode was originally created for the Vanilla version of the game, and
is no longer as needed with the Rise and Fall expansion. Recommended setting is 0 (off).*/

UPDATE HF_Options
   SET Value = 0
 WHERE OptionID = 'HF_OPTION_ENABLE_HARDCORE_SCIENCE_RULES' ;
 
UPDATE tblHFDebug SET x_Close='1' WHERE DebugID='MyOptions';
