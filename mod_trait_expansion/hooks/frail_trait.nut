::ModTraitExpansion.HooksMod.hook("scripts/skills/traits/frail_trait", function ( q ) {
	q.create = @( __original) function ()
	{
		this.m.Description = "Weak and loose. Has to work hard to become a real warrior. Will receive injuries more often.";
	}

	q.getTooltip = @(__original) function ()
	{
		local ret = __original();
		ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "The threshold to sustain injuries on getting hit is decreased by [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color]"
			});

		return ret;
	}

	q.onUpdate <- function( _properties )
	{
		__original( _properties);
		_properties.ThresholdToReceiveInjuryMult *= 0.75;
	}
});
