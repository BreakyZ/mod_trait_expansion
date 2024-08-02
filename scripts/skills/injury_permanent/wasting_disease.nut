this.wasting_trait <- this.inherit("scripts/skills/injury/injury", {
	m = 
	{
		dayAdded = 0;
	},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.wasting";
		this.m.Name = "Leprosy";
		this.m.Icon = "ui/traits/rotting_flesh_trait.png";
		this.m.Description = "This character has contacted a deadly disease and his body is failing them. Enemies will instinctivly avoid this character lest they contract a disease themselves.";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect | this.Const.SkillType.SemiInjury;
		this.m.HealingTimeMin = 99999;
		this.m.HealingTimeMax = 99999;
		this.m.IsAlwaysInEffect = true;
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
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Damage"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Hitpoints"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Max Fatigue"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-2[/color] Vision"
			},
			{
				id = 6,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Makes enemies less likely to attack you instead of an ally."
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		this.m.timeAdded = this.Time.getVirtualTimeF();
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_scarred");
		if (this.getContainer().getActor().getEthnicity() == 1)
		{
			sprite.setBrush("permanent_injury_scarred_southern");
		}
		else
		{
			sprite.setBrush("permanent_injury_scarred");
		}

		sprite.Visible = true;
	}

	function calculateMult()
	{
		local dc = 0;
		if (actor.isPlayerControlled())
		{
			dc = this.getContainer().getActor().getDaysWithCompany();
		}
	
		dc = this.Math.floor(dc / 7);
		dc = 1.00 - 0.01 * this.Math.min(5 * (dc + 1), 100);
	}

	function onUpdate( _properties )
	{

		this.injury.onUpdate(_properties);

		local dc = calculateMult();
		_properties.HitpointsMult *= dc;
		_properties.BraveryMult *= dc;
		_properties.InitiativeMult *= dc;
		_properties.StaminaMult *= dc;
		_properties.MeleeSkill *= dc;
		_properties.RangedSkill *= dc;
		_properties.MeleeDefense *= dc;
		_properties.RangedDefense *= dc;

		_properties.Vision += -1;
	}

});
