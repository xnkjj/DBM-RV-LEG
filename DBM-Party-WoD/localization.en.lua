local L

if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

-- Auto-generated Special Warning Localizations
L.AUTO_SPEC_WARN_OPTIONS = {
	spell 								= "Show special announce for $spell:%s",
	ends 								= "Show special announce when $spell:%s has ended",
	fades 								= "Show special announce when $spell:%s has faded",
	soon 								= "Show pre-special announce for $spell:%s",
	sooncount							= "Show pre-special announce (with count) for $spell:%s",
	bait								= "Show pre-special announce (to bait) for $spell:%s",
	prewarn 							= "Show pre-special announce %s seconds before $spell:%s",
	dispel 								= "Show special announce to dispel $spell:%s",
	interrupt							= "Show special announce to interrupt $spell:%s",
	interruptcount						= "Show special announce (with count) to interrupt $spell:%s",
	you 								= "Show special announce when you are affected by $spell:%s",
	youcount							= "Show special announce (with count) when you are affected by $spell:%s",
	youpos								= "Show special announce (with position) when you are affected by $spell:%s",
	youposcount							= "Show special announce (with position and count) when you are affected by $spell:%s",
	soakpos								= "Show special announce (with position) to help soak others affected by $spell:%s",
	target 								= "Show special announce when someone is affected by $spell:%s",
	targetcount 						= "Show special announce (with count) when someone is affected by $spell:%s",
	link								= "Show special announce when you are linked to another player by $spell:%s",
	defensive 							= "Show special announce to use defensive abilites for $spell:%s",
	taunt 								= "Show special announce to taunt when other tank affected by $spell:%s",
	close 								= "Show special announce when someone close to you is affected by $spell:%s",
	move 								= "Show special announce to move out from $spell:%s",
	keepmove 							= "Show special announce to keep moving for $spell:%s",
	stopmove 							= "Show special announce to stop moving for $spell:%s",
	dodge 								= "Show special announce to dodge $spell:%s",
	dodgecount							= "Show special announce (with count) to dodge $spell:%s",
	dodgeloc							= "Show special announce (with location) to dodge $spell:%s",
	moveaway							= "Show special announce to move away from others for $spell:%s",
	moveawaycount						= "Show special announce (with count) to move away from others for $spell:%s",
	moveawaytarget						= "Show special announce (with target) to move away from others for $spell:%s",
	moveto								= "Show special announce to move to someone or some place for $spell:%s",
	soak								= "Show special announce to soak for $spell:%s",
	soakcount							= "Show special announce (with count) to soak for $spell:%s",
	jump								= "Show special announce to move to jump for $spell:%s",
	run 								= "Show special announce to run away from $spell:%s",
	runcount							= "Show special announce (with count) to run away from $spell:%s",
	cast 								= "Show special announce to stop casting for $spell:%s",--Spell Interrupt
	lookaway							= "Show special announce to look away for $spell:%s",
	reflect 							= "Show special announce to stop attacking $spell:%s",--Spell Reflect
	count 								= "Show special announce (with count) for $spell:%s",
	stack 								= "Show special announce when you are affected by >=%d stacks of $spell:%s",
	switch								= "Show special announce to switch targets for $spell:%s",
	switchcount							= "Show special announce (with count) to switch targets for $spell:%s",
	switchcustom						= "Show special announce (with info) to switch targets for $spell:%s",
	gtfo 								= "Show special announce to move out of bad stuff on ground",
	adds								= "Show special announce to switch targets for incoming adds",
	addscount							= "Show special announce (with count) to switch targets for incoming adds",
	addscustom							= "Show special announce for incoming adds",
	targetchange						= "Show special announce for priority target changes"
}

-- Auto-generated Warning Localizations
L.AUTO_ANNOUNCE_TEXTS = {
	you									= "%s on YOU",
	target								= "%s on >%%s<",
	targetsource						= ">%%s< cast %s on >%%s<",
	targetcount							= "%s (%%s) on >%%s<",
	spell								= "%s", -- OPTIONAL
	spellsource							= ">%%s< cast %s",
	incoming							= "%s incoming debuff",
	incomingcount						= "%s incoming debuff (%%s)",
	ends 								= "%s ended",
	endtarget							= "%s ended: >%%s<",
	fades								= "%s faded",
	addsleft							= "%s remaining: %%d",
	cast								= "Casting %s: %.1f sec",
	soon								= "%s soon",
	sooncount							= "%s (%%s) soon",
	countdown							= "%s in %%ds",
	prewarn								= "%s in %s",
	bait								= "%s soon - bait now",
	stage								= "Stage %s",
	prestage							= "Stage %s soon",
	count								= "%s (%%s)", -- OPTIONAL
	stack								= "%s on >%%s< (%%d)",
	moveto								= "%s - move to >%%s<"
}

L.AUTO_SPEC_WARN_TEXTS = {
	spell								= "%s!", -- OPTIONAL
	ends								= "%s ended",
	fades								= "%s faded",
	soon								= "%s soon",
	sooncount							= "%s (%%s) soon",
	bait								= "%s soon - bait now",
	prewarn								= "%s in %s",
	dispel								= "%s on >%%s< - dispel now",
	interrupt							= "%s - interrupt >%%s<!",
	interruptcount						= "%s - interrupt >%%s<! (%%d)",
	you									= "%s on you",
	youcount							= "%s (%%s) on you",
	youpos								= "%s (Position: %%s) on you",
	youposcount							= "%s (%%s) (Position: %%s) on you",
	soakpos								= "%s (Soak Position: %%s)",
	target								= "%s on >%%s<",
	targetcount							= "%s (%%s) on >%%s< ",
	link								= "%s linked with >%%s<",
	defensive							= "%s - defensive",
	taunt								= "%s on >%%s< - taunt now",
	close								= "%s on >%%s< near you",
	move								= "%s - move away",
	keepmove							= "%s - keep moving",
	stopmove							= "%s - stop moving",
	dodge								= "%s - dodge attack",
	dodgecount							= "%s (%%s) - dodge attack",
	dodgeloc							= "%s - dodge from %%s",
	moveaway							= "%s - move away from others",
	moveawaycount						= "%s (%%s) - move away from others",
	moveawaytarget						= "%s - move away from %%s",
	moveto								= "%s - move to >%%s<",
	soak								= "%s - soak it",
	soakcount							= "%s - soak (%%s)",
	jump								= "%s - jump",
	run									= "%s - run away",
	runcount							= "%s - run away (%%s)",
	cast								= "%s - stop casting",
	lookaway							= "%s on %%s - look away",
	reflect								= "%s on >%%s< - stop attacking",
	count								= "%s! (%%s)", -- OPTIONAL
	stack								= "%%d stacks of %s on you",
	switch								= "%s - switch targets",
	switchcount							= "%s - switch targets (%%s)",
	switchcustom						= "%s - switch targets (%%s)",
	gtfo								= "%%s damage - move away",
	adds								= "Incoming Adds - switch targets",--Basically a generic of switch
	addscount							= "Incoming Adds - switch targets (%%s)",--Basically a generic of switch
	addscustom							= "Incoming Adds - %%s",--Same as above, but more info, pretty much made for like 3 boss mods, such as akama
	targetchange						= "Target Change - switch to %%s"
}

-----------------------
-- <<<Auchindoun>>> --
-----------------------
-----------------------
-- Protector of Auchindoun --
-----------------------
L= DBM:GetModLocalization(1185)

-----------------------
-- Soulbinder Nyami --
-----------------------
L= DBM:GetModLocalization(1186)

-----------------------
-- Azzakel, Vanguard of the Legion --
-----------------------
L= DBM:GetModLocalization(1216)

-----------------------
-- Teron'gor --
-----------------------
L= DBM:GetModLocalization(1225)

-------------
--  Auch Trash  --
-------------
L = DBM:GetModLocalization("AuchTrash")

L:SetGeneralLocalization({
	name =	"Auchindoun Trash"
})

-----------------------
-- <<<Bloodmaul Slag Mines>>> --
-----------------------
-----------------------
-- Magmolatus --
-----------------------
L= DBM:GetModLocalization(893)

-----------------------
-- Slave Watcher Crushto --
-----------------------
L= DBM:GetModLocalization(888)

-----------------------
-- Roltall --
-----------------------
L= DBM:GetModLocalization(887)

-----------------------
-- Gug'rokk --
-----------------------
L= DBM:GetModLocalization(889)

-------------
--  BSM Trash  --
-------------
L = DBM:GetModLocalization("BSMTrash")

L:SetGeneralLocalization({
	name =	"BSM Trash"
})

-----------------------
-- <<<Grimrail Depot>>> --
-----------------------
-----------------------
-- Railmaster Rocketspark and Borka the Brute --
-----------------------
L= DBM:GetModLocalization(1138)

-----------------------
-- Blackrock Assault Commander --
-----------------------
L= DBM:GetModLocalization(1163)

L:SetWarningLocalization({
	warnGrenadeDown			= "%s dropped",
	warnMortarDown			= "%s dropped"
})

-----------------------
-- Thunderlord General --
-----------------------
L= DBM:GetModLocalization(1133)

L:SetMiscLocalization({
	Rakun	= "Rakun"
})

-------------
--  GRD Trash  --
-------------
L = DBM:GetModLocalization("GRDTrash")

L:SetGeneralLocalization({
	name =	"GRD Trash"
})

-----------------------
-- <<<Iron Docks>>> --
-----------------------
---------------------
-- Fleshrender Nok'gar --
---------------------
L= DBM:GetModLocalization(1235)

-------------
-- Grimrail Enforcers --
-------------
L= DBM:GetModLocalization(1236)

-----------------------
-- Oshir --
-----------------------
L= DBM:GetModLocalization(1237)

-----------------------------
-- Skulloc, Son of Gruul --
-----------------------------
L= DBM:GetModLocalization(1238)

-----------------------
-- <<<EverBloom>>> --
-----------------------
-----------------------
-- Witherbark --
-----------------------
L= DBM:GetModLocalization(1214)

-----------------------
-- Ancient Protectors --
-----------------------
L= DBM:GetModLocalization(1207)

-----------------------
-- Archmage Sol --
-----------------------
L= DBM:GetModLocalization(1208)

-----------------------
-- Xeri'tac --
-----------------------
L= DBM:GetModLocalization(1209)

L:SetMiscLocalization({
	Pull	= "Xeri'tac begins unleashing Toxic Spiderlings down on you!"
})

-----------------------
-- Yalnu --
-----------------------
L= DBM:GetModLocalization(1210)

L:SetMiscLocalization({
	YalnuRP	= "The portal is lost! We must stop this beast before it can escape!"
})

-----------------------
-- Trash --
-----------------------
L = DBM:GetModLocalization("EverBloomTrash")

L:SetGeneralLocalization({
	name =	"EverBloom Trash"
})

-----------------------
-- <<<Shadowmoon Buriel Grounds>>> --
-----------------------
-----------------------
-- Sadana Bloodfury --
-----------------------
L= DBM:GetModLocalization(1139)

-----------------------
-- Nhallish, Feaster of Souls --
-----------------------
L= DBM:GetModLocalization(1168)

-----------------------
-- Bonemaw --
-----------------------
L= DBM:GetModLocalization(1140)

-----------------------
-- Ner'zhul --
-----------------------
L= DBM:GetModLocalization(1160)

-------------
--  SMBG Trash  --
-------------
L = DBM:GetModLocalization("SMBGTrash")

L:SetGeneralLocalization({
	name =	"SMBG Trash"
})

-----------------------
-- <<<Skyreach>>> --
-----------------------
-----------------------
-- Ranjit, Master of the Four Winds --
-----------------------
L= DBM:GetModLocalization(965)

-----------------------
-- Araknath --
-----------------------
L= DBM:GetModLocalization(966)

-----------------------
-- Rukhran --
-----------------------
L= DBM:GetModLocalization(967)

-----------------------
-- High Sage Viryx --
-----------------------
L= DBM:GetModLocalization(968)

L:SetWarningLocalization({
	warnAdd			= DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.spell:format("Skyreach Shield Construct"),
	specWarnAdd		= DBM_CORE_L.AUTO_SPEC_WARN_TEXTS.switch:format("Skyreach Shield Construct")
})

L:SetOptionLocalization({
	warnAdd			= "Show warning for Skyreach Shield Construct",
	specWarnAdd		= "Show special warning to switch targets for Skyreach Shield Construct"
})

-------------
--  Skyreach Trash  --
-------------
L = DBM:GetModLocalization("SkyreachTrash")

L:SetGeneralLocalization({
	name =	"Skyreach Trash"
})

-----------------------
-- <<<Upper Blackrock Spire>>> --
-----------------------
-----------------------
-- Orebender Gor'ashan --
-----------------------
L= DBM:GetModLocalization(1226)

-----------------------
-- Kyrak --
-----------------------
L= DBM:GetModLocalization(1227)

-----------------------
-- Commander Tharbek --
-----------------------
L= DBM:GetModLocalization(1228)

-----------------------
-- Ragewind the Untamed --
-----------------------
L= DBM:GetModLocalization(1229)

-----------------------
-- Warlord Zaela --
-----------------------
L= DBM:GetModLocalization(1234)

L:SetTimerLocalization({
	timerZaelaReturns	= "Zaela Returns"
})

L:SetOptionLocalization({
	timerZaelaReturns	= "Show timer for when Zaela returns"
})

-------------
--  UBRS Trash  --
-------------
L = DBM:GetModLocalization("UBRSTrash")

L:SetGeneralLocalization({
	name =	"UBRS Trash"
})
