::Const.Items.addNewWeaponType("Goblin");
::Const.Items.addNewWeaponType("Orc");

local gobboWeapons = 
[
	"greenskins/legend_bone_carver",
	"greenskins/legend_bough",
	"greenskins/legend_limb_lopper",
	"greenskins/legend_meat_hacker",
	"greenskins/legend_skin_flayer",
	"greenskins/legend_skullbreaker",
	"greenskins/legend_skullsmasher"
	"greenskins/orc_axe",
	"greenskins/orc_axe_2h",
	"greenskins/orc_cleaver",
	"greenskins/orc_flail_2h",
	"greenskins/orc_javelin",
	"greenskins/orc_metal_club",
	"greenskins/orc_wooden_club"
	"named/named_orc_axe",
	"named/named_orc_axe_2h",
	"named/named_orc_cleaver",
	"named/named_orc_flail_2h"
];
if (Is_SSU_Exist)
{
	orcWeapons.extend([
		"greenskins/cr_orc_mace",
		"greenskins/cr_orc_spear",
		"greenskins/cr_orc_staff",
		"named/cr_named_orc_axe_infantry"
		"named/cr_named_orc_cleaver_2h",
		"named/cr_named_orc_hammer_2h",
		"named/cr_named_orc_mace_2h",
		"named/cr_named_orc_sword_2h"]);
}
foreach (weapon in gobboWeapons)
{
	::ModTraitExpansion.HooksMod.hook("scripts/items/weapons/" + weapon, function ( q ) {
		q.create = @( __original) function ()
		{
			this.m.GoblinWeapon = true;
		}
	});
}
local gobboWeapons = 
[
	"greenskins/goblin_bow",
	"greenskins/goblin_crossbow",
	"greenskins/goblin_falchion",
	"greenskins/goblin_heavy_bow",
	"greenskins/goblin_notched_blade",
	"greenskins/goblin_pike",
	"greenskins/goblin_staff",
	"greenskins/goblin_spiked_balls"
	"greenskins/orc_axe_2h",
	"greenskins/orc_cleaver",
	"greenskins/orc_flail_2h",
	"greenskins/orc_javelin",
	"greenskins/orc_metal_club",
	"greenskins/orc_wooden_club",
	"named/named_goblin_falchion",
	"named/named_goblin_heavy_bow",
	"named/named_goblin_pike",
	"named/named_goblin_spear"
];
if (Is_SSU_Exist)
{
	gobboWeapons.extend(["greenskins/cr_goblin_axe"]);
}
foreach (weapon in orcWeapons)
{
	::ModTraitExpansion.HooksMod.hook("scripts/items/weapons/" + weapon, function ( q ) {
		q.create = @( __original) function ()
		{
			this.m.OrcWeapon = true;
		}
	});
}
