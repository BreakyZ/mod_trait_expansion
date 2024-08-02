this.perfectionist_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.perfectionist";
		this.m.Name = "Perfectionist";
		this.m.Icon = "ui/traits/pugilist_trait.png";
		this.m.Description = "This character will always choose excellence over mediocrity. They will always take their time to do above and beyond.";
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
		return [
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
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Chance to hit head"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "Increases Armor Penetration by [color=" + this.Const.UI.Color.Positive + "]10%[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]+1[/color] Action Point cost on every skill"
			}
		];
	}

	function onUpdate( _properties )
	{
		foreach (s in skills)
		{
			s.m.ActionPointCost += 1;
			s.m.FatigueCost += this.Math.ceil(0.04 * bodyHealth);
		}
		_properties.DamageDirectMult *= 1.1;
		_properties.HitChance[this.Const.BodyPart.Head] += 15;
	}

});
