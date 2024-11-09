if GetLocale() ~= "zhTW" then return end
local L

if not DBM_CORE_L then DBM_CORE_L = {} end

local L = DBM_CORE_L

L.AUTO_SPEC_WARN_OPTIONS = {}
L.AUTO_SPEC_WARN_OPTIONS.spell				= "特別提示：$spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.ends				= "特別提示：$spell:%s結束"
L.AUTO_SPEC_WARN_OPTIONS.fades				= "特別提示：$spell:%s消退"
L.AUTO_SPEC_WARN_OPTIONS.soon				= "特別提示：$spell:%s即將到來"
L.AUTO_SPEC_WARN_OPTIONS.sooncount			= "特別提示：$spell:%s (包含計數)即將到來"
L.AUTO_SPEC_WARN_OPTIONS.bait				= "特別提示：$spell:%s(當誘餌)預先顯示"
L.AUTO_SPEC_WARN_OPTIONS.prewarn 			= "特別提示：$spell:%s在%d秒前預先顯示"
L.AUTO_SPEC_WARN_OPTIONS.dispel				= "特別提示：需要驅散$spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interrupt			= "特別提示：需要中斷$spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.interruptcount		= "特別提示：需要中斷$spell:%s (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.you				= "特別提示：當你中了$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.youcount			= "特別提示：當你中了$spell:%s時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.youpos				= "特別提示：當你中了$spell:%s時 (包含站位)"
L.AUTO_SPEC_WARN_OPTIONS.youposcount	    = "特別提示：當你中了$spell:%s時 (包含站位和計數)"
L.AUTO_SPEC_WARN_OPTIONS.soakpos			= "特別提示：當需要為$spell:%s分傷時(包含站位)"
L.AUTO_SPEC_WARN_OPTIONS.target				= "特別提示：當他人中了$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.targetcount 		= "特別提示：當他人中了$spell:%s時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.link				= "特別提示：當你中了$spell:%s與其他玩家連結時"
L.AUTO_SPEC_WARN_OPTIONS.defensive 			= "特別提示：當需要使用$spell:%s技能來減傷時"
L.AUTO_SPEC_WARN_OPTIONS.taunt 				= "特別提示：當另外一個坦中了$spell:%s並需要你嘲諷時"
L.AUTO_SPEC_WARN_OPTIONS.close				= "特別提示：當你附近有人中了$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.move				= "特別提示：當你中了$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.keepmove 			= "特別提示：當你中了$spell:%s需要保持移動時"
L.AUTO_SPEC_WARN_OPTIONS.stopmove 			= "特別提示：當你中了$spell:%s需要停止移動時"
L.AUTO_SPEC_WARN_OPTIONS.dodge				= "特別提示：當你中了$spell:%s並需要躲開攻擊"
L.AUTO_SPEC_WARN_OPTIONS.dodgecount			= "特別提示：當你中了$spell:%s並需要躲開攻擊 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.dodgeloc			= "特別提示：當你需要閃避$spell:%s技能時(包含站位)"
L.AUTO_SPEC_WARN_OPTIONS.moveaway			= "特別提示：當你中了$spell:%s並需要跑開人群時"
L.AUTO_SPEC_WARN_OPTIONS.moveawaycount		= "特別提示：當你中了$spell:%s並需要跑開人群時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.moveto				= "特別提示：當中了$spell:%s並需要你去靠近某人或某地點時"
L.AUTO_SPEC_WARN_OPTIONS.soak				= "特別提示：當需要你去踩圈分擔$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.soakcount			= "特別提示：當需要你去踩圈分擔$spell:%s時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.jump				= "特別提示：當你中了$spell:%s需要跳起來時"
L.AUTO_SPEC_WARN_OPTIONS.run				= "特別提示：當你中了$spell:%s需要跑開時"
L.AUTO_SPEC_WARN_OPTIONS.runcount			= "特別提示：當你中了$spell:%s需要跑開時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.cast				= "特別提示：$spell:%s的施放（停止施法）"
L.AUTO_SPEC_WARN_OPTIONS.lookaway			= "特別提示：當需要為$spell:%s轉頭時"
L.AUTO_SPEC_WARN_OPTIONS.reflect 			= "特別提示：$spell:%s需要停止攻擊"
L.AUTO_SPEC_WARN_OPTIONS.count 				= "特別提示：$spell:%s"
L.AUTO_SPEC_WARN_OPTIONS.stack				= "特別提示：當疊加了>=%d層$spell:%s時"
L.AUTO_SPEC_WARN_OPTIONS.switch 			= "特別提示：針對$spell:%s需要轉換目標"
L.AUTO_SPEC_WARN_OPTIONS.switchcount		= "特別提示：針對$spell:%s需要轉換目標 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.gtfo 				= "特別提示：當地板出現危險的東西需要躲開時"
L.AUTO_SPEC_WARN_OPTIONS.adds				= "特別提示：當小怪出現需要更換目標時"
L.AUTO_SPEC_WARN_OPTIONS.addscount			= "特別提示：當小怪出現需要更換目標時 (包含計數)"
L.AUTO_SPEC_WARN_OPTIONS.addscustom			= "特別提示：即將到來的小怪"
L.AUTO_SPEC_WARN_OPTIONS.targetchange		= "特別提示：當需要更換主要目標時"

L.AUTO_ANNOUNCE_TEXTS = {}
L.AUTO_ANNOUNCE_TEXTS.you					= "你中了%s"
L.AUTO_ANNOUNCE_TEXTS.target				= "%s:>%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetsource			= ">%%s< 施放 %s 在 >%%s<"
L.AUTO_ANNOUNCE_TEXTS.targetcount			= "%s (%%s):>%%s<"
L.AUTO_ANNOUNCE_TEXTS.spell					= "%s"
L.AUTO_ANNOUNCE_TEXTS.incoming				= "%s 即將到來的減益"
L.AUTO_ANNOUNCE_TEXTS.incomingcount			= "%s 即將到來的減益 (%%s)"
L.AUTO_ANNOUNCE_TEXTS.ends 					= "%s結束"
L.AUTO_ANNOUNCE_TEXTS.endtarget				= "%s結束:>%%s<"
L.AUTO_ANNOUNCE_TEXTS.fades					= "%s消退"
L.AUTO_ANNOUNCE_TEXTS.addsleft				= "%s還剩下:%%d"
L.AUTO_ANNOUNCE_TEXTS.cast					= "施放%s:%.1f秒"
L.AUTO_ANNOUNCE_TEXTS.soon					= "%s即將到來"
L.AUTO_ANNOUNCE_TEXTS.sooncount				= "%s (%%s)即將到來"
L.AUTO_ANNOUNCE_TEXTS.countdown				= "%s還有%%ds"
L.AUTO_ANNOUNCE_TEXTS.prewarn				= "%s在%s"
L.AUTO_ANNOUNCE_TEXTS.bait					= "%s即將到來 - 快引誘"
L.AUTO_ANNOUNCE_TEXTS.stage					= "第%s階段"
L.AUTO_ANNOUNCE_TEXTS.prestage				= "第%s階段即將到來"
L.AUTO_ANNOUNCE_TEXTS.count					= "%s (%%s)"
L.AUTO_ANNOUNCE_TEXTS.stack					=">%%s<中了%s (%%d)"
L.AUTO_ANNOUNCE_TEXTS.moveto				= "%s - 移動到>%%s<"

L.AUTO_SPEC_WARN_TEXTS = {}
L.AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
L.AUTO_SPEC_WARN_TEXTS.ends 				= "%s結束"
L.AUTO_SPEC_WARN_TEXTS.fades				= "%s消退"
L.AUTO_SPEC_WARN_TEXTS.soon					= "%s即將到來"
L.AUTO_SPEC_WARN_TEXTS.sooncount			= "%s (%%s)即將到來"
L.AUTO_SPEC_WARN_TEXTS.bait					= "%s即將到來 - 快引誘"
L.AUTO_SPEC_WARN_TEXTS.prewarn				= "%s在%s"
L.AUTO_SPEC_WARN_TEXTS.dispel				= ">%%s<中了%s - 現在驅散"
L.AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - 快中斷>%%s< !"
L.AUTO_SPEC_WARN_TEXTS.interruptcount		= "%s - 快中斷>%%s< !(%%d)"
L.AUTO_SPEC_WARN_TEXTS.you					= "你中了%s"
L.AUTO_SPEC_WARN_TEXTS.youcount				= "你中了%s (%%s)"
L.AUTO_SPEC_WARN_TEXTS.youpos				= "你中了%s (位置：%%s)"
L.AUTO_SPEC_WARN_TEXTS.youposcount		    = "你中了%s (%%s) (位置: %%s)"
L.AUTO_SPEC_WARN_TEXTS.soakpos				= "%s - 快到%%s分傷"
L.AUTO_SPEC_WARN_TEXTS.target				= ">%%s<中了%s"
L.AUTO_SPEC_WARN_TEXTS.targetcount			= ">%%2$s<中了%s (%%1$s) "
L.AUTO_SPEC_WARN_TEXTS.link					= "%s 與 >%%s< 連結"
L.AUTO_SPEC_WARN_TEXTS.defensive			= "%s - 使用防禦技能"
L.AUTO_SPEC_WARN_TEXTS.taunt				= ">%%s<中了%s - 快嘲諷"
L.AUTO_SPEC_WARN_TEXTS.close				= "你附近的>%%s<中了%s"
L.AUTO_SPEC_WARN_TEXTS.move					= "%s - 快移動"
L.AUTO_SPEC_WARN_TEXTS.keepmove				= "%s - 保持移動"
L.AUTO_SPEC_WARN_TEXTS.stopmove				= "%s - 停止移動"
L.AUTO_SPEC_WARN_TEXTS.dodge				= "%s - 閃避攻擊"
L.AUTO_SPEC_WARN_TEXTS.dodgecount			= "%s (%%s) - 閃避攻擊"
L.AUTO_SPEC_WARN_TEXTS.dodgeloc				= "%s - 閃避技能 %%s"
L.AUTO_SPEC_WARN_TEXTS.moveaway				= "%s - 快離開其他人"
L.AUTO_SPEC_WARN_TEXTS.moveawaycount		= "%s (%%s) - 快離開其他人"
L.AUTO_SPEC_WARN_TEXTS.moveto				= "%s - 快跑向>%%s<"
L.AUTO_SPEC_WARN_TEXTS.soak					= "%s - 踩圈分擔"
L.AUTO_SPEC_WARN_TEXTS.soakcount			= "%s - 踩圈分擔 (%%s)"
L.AUTO_SPEC_WARN_TEXTS.jump					= "%s - 快跳躍"
L.AUTO_SPEC_WARN_TEXTS.run					= "%s - 快跑開"
L.AUTO_SPEC_WARN_TEXTS.runcount				= "%s - 快跑開 (%%s)"
L.AUTO_SPEC_WARN_TEXTS.cast					= "%s - 停止施法"
L.AUTO_SPEC_WARN_TEXTS.lookaway				= "%s 點名 %%s - 快轉頭"
L.AUTO_SPEC_WARN_TEXTS.reflect				= ">%%s<中了%s - 停止攻擊"
L.AUTO_SPEC_WARN_TEXTS.count				= "%s!(%%s)"
L.AUTO_SPEC_WARN_TEXTS.stack				= "你中了%%d層%s"
L.AUTO_SPEC_WARN_TEXTS.switch				= "%s - 快更換目標!"
L.AUTO_SPEC_WARN_TEXTS.switchcount			= "%s - 快更換目標！(%%s)"
L.AUTO_SPEC_WARN_TEXTS.gtfo					= "%%s 傷害 - 快移動"
L.AUTO_SPEC_WARN_TEXTS.adds					= "小怪出現 - 快更換目標！"
L.AUTO_SPEC_WARN_TEXTS.addscount			= "小怪出現 - 快更換目標！(%%s)"
L.AUTO_SPEC_WARN_TEXTS.addscustom			= "小怪來了 - %%s"
L.AUTO_SPEC_WARN_TEXTS.targetchange			= "更換目標 - 轉火 %%s"

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
	name =	"奧齊頓小怪"
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
	name =	"血槌熔渣礦場小怪"
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
	warnGrenadeDown			= "%s掉落了",
	warnMortarDown			= "%s掉落了"
})

-----------------------
-- Thunderlord General --
-----------------------
L= DBM:GetModLocalization(1133)

-------------
--  GRD Trash  --
-------------
L = DBM:GetModLocalization("GRDTrash")

L:SetGeneralLocalization({
	name =	"恐軌車站小怪"
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
-- <<<Overgrown Outpost>>> --
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
	Pull	= "榭里塔克開始放出劇毒幼蛛攻擊你！"
})

-----------------------
-- Yalnu --
-----------------------
L= DBM:GetModLocalization(1210)

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
	warnAdd			= DBM_CORE_L.AUTO_ANNOUNCE_TEXTS.spell:format("擎天護盾傀儡"),
	specWarnAdd		= DBM_CORE_L.AUTO_SPEC_WARN_TEXTS.switch:format("擎天護盾傀儡")
})

L:SetOptionLocalization({
	warnAdd			= "為擎天護盾傀儡顯示警告",
	specWarnAdd		= "為轉換攻擊目標至擎天護盾傀儡顯示特別警告"
})

-------------
--  Skyreach Trash  --
-------------
L = DBM:GetModLocalization("SkyreachTrash")

L:SetGeneralLocalization({
	name =	"擎天峰小怪"
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
	timerZaelaReturns	= "札伊拉回場地"
})

L:SetOptionLocalization({
	timerZaelaReturns	= "為札伊拉回場地顯示計時器"
})

-------------
--  UBRS Trash  --
-------------
L = DBM:GetModLocalization("UBRSTrash")

L:SetGeneralLocalization({
	name =	"黑石塔上層小怪"
})
