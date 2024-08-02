::ModTraitExpansion.HooksMod.hook("scripts/skills/traits/tiny_trait", function ( q ) {
	q.create = @( __original) function ()
	{
		this.m.Description = "Being very short of height, this character is used to slipping through. Normal weapons feel like they\'re not meant for their hands.";
		this.m.Titles = [
			"the Dwarf",
			"the Halfman",
			"the Short",
			"the Gremlin"
		];
	}

	q.getTooltip = @(__original) function ()
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] (multiplicative) Damage"
			}
		];
		ret.extend(
		[
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "Goblin weapons\'s abilities have their Action Point cost reduced by [color=" + ::Const.UI.Color.NegativeValue + "]1[/color]."
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "This character is too small and cannot use orc weapons and cannot [color=#731f39]Double Grip[/color] one handed weapons."
			}
		]);

		return ret;
	}

	q.onUpdate = @(__original) <- function( _properties )
	{
		_properties.DamageTotalMult *= 0.75;
		_properties.MeleeDefense += 5;
		_properties.RangedDefense += 5;
	}

	q.onAdded <- function()
	{
		local items = this.getContainer().getActor().getItems();

		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) && items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isOrcWeapon)
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			//item.unequip();
			item.drop();
		}

		items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
	}

	q.onAfterUpdate <- function( _properties )
	{
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null)
			return;
		if (!weapon.isGoblinWeapon)
			return;
		foreach (s in skills)
		{
			if (s.isAttack())
			{
				s.m.ActionPointCost -= 1;
			}		
		}
	}
});
