this.perfectionist_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		totalMissCounter = 0,
		battleMissCounter = 0,
		},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.perfectionist";
		this.m.Name = "Perfectionist";
		this.m.Icon = "ui/traits/pugilist_trait.png";
		this.m.Description = "This character will always choose excellence over mediocrity and will always take %their% time to do above and beyond. Failing will be a big hit to their morale.";
		this.m.Titles = [
			"the Flawless",
			"the Perfect",
			"the Infallible",
			"the Impeccable"
		];
		this.m.Excluded = [
			"trait.slack"
		];
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] Ranged skill"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] Melee skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.Positive + "]10%[/color] extra damage on any attack"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Action Point cost on every skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] Extra Fatigue cost for every skill"
			}
		];
		if (this.m.battleMissCounter > 0)
		{
			ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.pow(5, this.m.battleMissCounter) + "%[/color] to have a meltdown the next attack missed"
			});
		}
	}

	function onUpdate( _properties )
	{
		foreach (s in skills)
		{
			s.m.ActionPointCost += 1;
			s.m.FatigueCost += this.Math.ceil(0.2 * s.m.FatigueCost);
		}
		_properties.DamageTotalMult *= 1.1;
		_properties.RangedSkill *= 1.1;
		_properties.MeleeSkill *= 1.1;
	}

	function onTargetMissed( _skill, _targetEntity )
	{	
		this.m.totalMissCounter += 1;
		this.m.battleMissCounter += 1;
		if (this.m.battleMissCounter > 0 && this.Math.rand(1, 100) < this.Math.pow(5, this.m.battleMissCounter))
		{
			this.getContainer().getActor().checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
			this.getContainer().getActor().checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
			this.getContainer().getActor().worsenMood(1.0, "Failed in combat and had a meltdown");
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.battleMissCounter = 0;
	}

	function onCombatStarted()
	{
		this.m.battleMissCounter = 0;
	}

	function onCombatFinished()
	{
		this.m.battleMissCounter = 0;
	}

});
