# 单城区域/奇观/建筑建造加速的实现和自定义ModifierType
问题：我想要实现以下效果
建造区域/建筑/奇观时，若本城市拥有工业区，加速10%。

起初，我使用了类似MODIFIER_PLAYER_CITIES_ADJUST_DISTRICT_PRODUCTION这样的ModifierType,并将它们绑定到工业区上。
代码如图所示：


但在游戏里实际测试的时候，却发现该效果会重复触发。假设我们有10个工业区城市，每个城市吃到的加成不是10%，而是100%！

仔细思考和研究后，我发现了问题所在：无论是努比亚金字塔，还是布鲁塞尔的宗主国效果，他们本身是和文明（城邦本身也属于一种特殊文明）绑定的。因此，该效果只会触发一次。

而当我们将这个modifier绑定到建筑上（我们假设是纪念碑）的时候，由于我们会多次在不同的城市建立纪念碑的原因，所以这个效果也会触发多次。哪怕你在req里限制了只对拥有的纪念碑城市生效，也仅仅只会让某些没有纪念碑的城市不受影响而已，对于拥有该建筑的城市来说，该效果一样会叠加多次。

那么解决这个问题的办法就很简单了，并不是modifier本身有问题，而是我们取的对象不合理。以下我构思出来的三种办法，我相信对这个问题应该都可以起到效果。更重要的是，如果你会举一反三，我相信它同样适用于更多令你困惑的场合。

1. 将效果绑定到文明而非建筑上(不推荐)。
我可以将这些区域加速的效果绑定到每个文明上，这样一来，不管你生产多少纪念碑，效果始终是“有纪念碑的城市建造加速”，只触发一次。这样的效果我们可以在游戏里找到原型，比如前面提到的努比亚的区域加速，和布鲁塞尔的宗主国效果。当然，我本身不推荐这样的方法，因为这实际上相当于每个文明凭空多出了一个技能。而且这个的工作量并不见得小，如果你实在要写，我推荐你用sql来一次性搞定它。

2. 将这个效果改写为只对本城市生效
如果你希望某个效果只对某个城市（区域/建筑/单位等）生效，最好的办法就是使用MODIFIER_SINGLE_CITY_XXX类的ModifierType.
但目前为止，上面的单城效果，我们找不到游戏里有这样的代码供我们参考。但是受群里小伙伴的启发，我们发现Modifier本身定义的CollectionType和EffectType，我们也是可以拿来自由使用的。

举个简单的例子，假设我现在想要一条首都地块加魅力的Modifier,但是我们发现游戏里本身并没有这样的ModifierType，只有针对目标城市的ModifierType（MODIFIER_PLAYER_CITIES_ADJUST_CITY_APPEAL）和针对单个城市ModifierType（MODIFIER_SINGLE_CITY_ADJUST_CITY_APPEAL）。
当然，我们有其它的办法，利用上面现有的ModifierType来实现该效果(提示：想想首都里一定会有的建筑是什么？)。但我们这里要自己创造一个ModifierType来实现我们的效果。
打开Modifier.xml,我们可以学会如何声明一个新的ModifierType——首先，我们需要先在Type表里声明这个Modifier，然后再声明这个ModifierType的几个属性就好。其中ModifierType是你为这个Type取的名字，而剩下的2个属性:CollectionType决定了这个效果的目标类型，而EffectType决定了这个效果的作用类型。这2个属性的取值只能取一些已经固定好的值，我们学会照葫芦画瓢就好了。

我的代码如下：
<Types>
	<Row Type="MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_APPEAL" Kind="KIND_MODIFIER"/>
<Types>

<Row>
	<ModifierType>MODIFIER_PLAYER_CAPITAL_CITY_ADJUST_CITY_APPEAL</ModifierType>
	<CollectionType>COLLECTION_PLAYER_CAPITAL_CITY</CollectionType>
	<EffectType>EFFECT_ADJUST_CITY_APPEAL</EffectType>
</Row>

那么，这个CollectionType和这个EffectType是从哪来的呢？
很简单，如图：
这里2个modifier分别对应调整首都产出和调整单城宜居度2个效果。我们只是把这里的参数拿出来，组合到一起而已。

接下来，就是常规工作了。这里我就略过了，最终代码如下：

我尝试将这个代码绑定到老秦身上，进行测试，一次成功！

那么区域加速这里的代码要如何组合，这里也不做过多说明了，晚上回去尝试再说。


3. 寻找已有的Modifier
其实当你熟悉了方法2以后，你就会发现上述代码并不是不存在，而是隐藏的比较深。
用上述特定的条件去数据库里找可以说一找一个准，我只能叹息之前看名字来寻找Modifier的方法真的low...顺带吐槽一下这程序员的命名规则真鸡儿科学，一个相同效果我就是要写很多个Type，而且命名也不走寻常路...

单城区域加速的代码可以参考(注意不要直接抄Modifier，里面是有条件的)：
格式  ModifierId(ModifierType)

CITY_PATRON_GODDESS_DISTRICT_PRODUCTION_MODIFIER(MODIFIER_SINGLE_CITY_ADJUST_DISTRICT_PRODUCTION_MODIFIER)
信条城镇守护女神的效果

KILWA_SINGLE_ADDPRODUCTIONDISTRICTS(MODIFIER_SINGLE_CITY_ADJUST_DISTRICT_PRODUCTION_MODIFIER)
奇观基卢瓦基西瓦尼的效果，尽管wiki上写的是所有产出，但数据库里的结果包含了所有区域/建筑/单位的加速(没想到吧)。

ZONING_COMMISSIONER_FASTER_DISTRICT_CONSTRUCTION(MODIFIER_CITY_INCREASE_DISTRICT_PRODUCTION_RATE)
梁总督的区域加速效果。


单城建筑加速的代码可以参考：
KILWA_SINGLE_ADDPRODUCTIONBUILDINGS(MODIFIER_SINGLE_CITY_ADJUST_BUILDING_PRODUCTION_MODIFIER)

暂时没有单城奇观的加速效果，为什么呢？很简单，因为奇观是包含在建筑里的啊，开心的去使用万能的基卢瓦基西瓦尼吧。


