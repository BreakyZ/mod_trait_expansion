::ModTraitExpansion.HooksMod.hook("scripts/skills/traits/fat_trait", function ( q ) {

	q.getTooltip = @(__original) function ()
	{
		local ret = __original();
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Builds up [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] more fatigue for each tile travelled"
		});

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original();
		_properties.MovementFatigueCostAdditional += 1;
	}
});
