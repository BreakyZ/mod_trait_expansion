::ModTraitExpansion.HooksMod.hook("scripts/skills/traits/huge_trait", function ( q ) {
	q.create = @( __original) function ()
	{
		this.m.Description = "Being particularly huge and burly, this character\'s strikes hurt plenty, but they\'re also a bigger target than most. Certain weapons barely fit in their beefy hands.";
	}

	q.getTooltip = @(__original) function ()
	{
		local ret = __original();
		ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "The threshold to sustain injuries on getting hit is decreased by [color=" + this.Const.UI.Color.Negative + "]25%[/color]"
			});

		return ret;
	}

	q.onUpdate <- function( _properties )
	{
		__original( _properties);
		_properties.ThresholdToReceiveInjuryMult *= 0.75;
	}
});
