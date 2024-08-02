::ModTraitExpansion.HooksMod.hook("scripts/skills/special/double_grip", function ( q ) {
	q.canDoubleGrip = @(__original) function()
	{	
		local ret = __original();
		if (!ret)
			return;

		local actor = this.getContainer().getActor();
		local mainHand = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (actor.getSkills().hasSkill("trait.tiny") && !mainhand.isGoblinWeapon)
			return false;
		if (actor.getSkills().hasSkill("trait.huge") && !mainhand.isOrcWeapon)
			return false;
		return true;
	}
});
