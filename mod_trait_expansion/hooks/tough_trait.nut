::ModTraitExpansion.HooksMod.hook("scripts/skills/traits/tough_trait", function ( q ) {
	q.create = @( __original) function ()
	{
		__original();
		this.m.Excluded.push("trait.leprosy");
	}
});
