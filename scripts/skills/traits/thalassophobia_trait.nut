this.thalassophobia_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		isNearWater = false,
		nearWaterDescription = "This character is scared out of his mind and will behave uncoordinated and erratic."
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.thalassophobia";
		this.m.Name = "Thalassophobia";
		this.m.Icon = "ui/traits/peaceful_trait.png";
		this.m.Description = "This character is deathly scared from any bodies of water and will avoid them at all cost.";
		this.m.Titles = [
			"the Unwashed",
			"the Smelly",
		];
		this.m.Excluded = [
			"trait.fearless"
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
			}
		];

		if (this.m.isNearWater)
		{
			ret.extend(
			[
				{
					id = 7,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Resolve"
				},
				{
					id = 7,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Initiative"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Ranged Skill"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Melee Skill"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]+10[/color] Melee Defense"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]+10[/color] Melee Defense"
				}
			]);
		}
	}

	function getDescription()
	{
		if (this.m.isNearWater)
		{
			return this.m.nearWaterDescription;
		}
		return this.getDescription();
	}

	function onCombatStarted()
	{
		local size = this.Tactical.getMapSize();
		for ( local x = 0; x < size.X; x = ++x )
		{
			for( local y = 0; y < size.Y; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);
				switch (true)
				{
					case _tile.Type == this.Const.Tactical.TerrainType.DeepWater:
					case _tile.Type == this.Const.Tactical.TerrainType.ShallowWater:
					case _tile.Type == this.Const.Tactical.TerrainType.MurkyWater:
					case _tile.getEntity().getType() == this.Const.EntityType.Kraken):
						this.m.isNearWater = true;
						return;					
				}
			}
		}
	}

	function onUpdate()
	{
		if (this.m.isNearWater)
		{
			_properties.BraveryMult *= 0.8;
			_properties.InitiativeMult *= 0.8;
			_properties.MeleeSkill -= 10;
			_properties.RangedSkill -= 10;
			_properties.MeleeDefense += 10;
			_properties.RangedDefense += 10;
		}
	}
});
