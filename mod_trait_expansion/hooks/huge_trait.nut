::ModTraitExpansion.HooksMod.hook("scripts/skills/traits/huge_trait", function ( q ) {
	q.create = @( __original) function ()
	{
		this.m.Description = "Being particularly huge and burly, this character\'s strikes hurt plenty, but they\'re also a bigger target than most. Certain weapons barely fit in their beefy hands.";
	}

	q.getTooltip = @(__original) function ()
	{
		local ret = __original();
		ret.extend(
		[
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "Orc weapons confer no penalties."
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "This character is too big and cannot use goblin weapons and [color=#731f39]Double Grip[/color] one handed weapons."
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Receives an additional [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] Melee Damage when wielding "
			}
		]);

		return ret;
	}

	q.onAdded <- function()
	{
		local items = this.getContainer().getActor().getItems();

		if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) && items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isGoblinWeapon)
		{
			local item = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
			//item.unequip();
			item.drop();
		}

		items.getData()[this.Const.ItemSlot.Offhand][0] = -1;
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null || !weapon.isOrcWeapon)
		{
			local skills = weapon.getSkills();
			if (skills.len() == 0)
			{
				this.m.Skills.clear();
				return;
			}
			if (weapon.m.FatigueOnSkillUse > 0)
			{
				foreach (skill in skills)
				{
					if (this.m.Skills.find(skill.getID()) == null)
					{
						this.m.Skills.push(skill.getID());
						skill.m.FatigueCost -= ::Math.min(5, weapon.m.FatigueOnSkillUse);
					}
				}
			}
		}
	}

	q.onRemoved = @(__original) function()
	{
		local equippedItem = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);
		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}
	}
});
