if not(GetLocale() == "deDE") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Templates
	L[" (Channeling)"] = "(Kanalisiert)"
	L[" (Healing received increase)"] = " (erhaltene Heilung erhöht)"
	L["- Any"] = "- Irgendein(e)"
	L["- Holy Word: Chastise"] = "- Segenswort: Züchtigung"
	L["- Holy Word: Sanctify"] = "- Segenswort: Heiligung"
	L["- Holy Word: Serenity"] = "- Segenswort: Epiphanie"
	L["(Pet)"] = "(Begleiter)"
	L["(Water Elemental)"] = "(Wasserelementar)"
	L["Ability Charges"] = "Aufladungen der Fähigkeit"
	L["Absorb Shield"] = "Absorbschild"
	L["Add Triggers"] = "Auslöser hinzufügen"
	L["Always Active"] = "Immer aktiv"
	L["Back"] = "Zurück"
	L["Bleed"] = "Blutung"
	L["Bloodlust/Heroism"] = "Kampfrausch/Heldentum"
	L["Buff"] = "Buff"
	L["buff"] = "buff"
	L["Buffs"] = "Buffs"
	L["Cancel"] = "Abbrechen"
	L["Cast"] = "Zauberwirken"
	L["Concordance of the Legionfall"] = "Einigkeit der Legionsrichter"
	L["cooldown"] = "Abklingzeit"
	L["Cooldowns"] = "Abklingzeiten"
	L["Crimson Vial Item Count"] = "Gegenstandsanzahl Blutrote Phiole "
	L["Damage Trinkets"] = "Schadensverursacher-Schmuckstücke"
	--[[Translation missing --]]
	L["Death Knight 2P Bonus - "] = "Death Knight 2P Bonus - "
	--[[Translation missing --]]
	L["Death Knight Unholy 4P Bonus - "] = "Death Knight Unholy 4P Bonus - "
	L["debuff"] = "debuff"
	L["Debuffs"] = "Debuffs"
	--[[Translation missing --]]
	L["Discipline Priest"] = "Discipline Priest"
	--[[Translation missing --]]
	L["Druid"] = "Druid"
	--[[Translation missing --]]
	L["Effuse"] = "Effuse"
	L["Enchants"] = "Verzauberungen"
	--[[Translation missing --]]
	L["Enveloping Mist"] = "Enveloping Mist"
	--[[Translation missing --]]
	L["Essence Font"] = "Essence Font"
	L["General"] = "Allgemein"
	L["Healer Trinkets"] = "Heiler-Schmuckstücke"
	L["Health"] = "Gesundheit"
	--[[Translation missing --]]
	L["Holy Priest"] = "Holy Priest"
	L["Keeps existing triggers intact"] = "Verändert existierende Auslöser nicht"
	L["Legendaries"] = "Legendäre Ggst."
	--[[Translation missing --]]
	L["Monk"] = "Monk"
	--[[Translation missing --]]
	L["Monk Windwalker 4P Bonus - "] = "Monk Windwalker 4P Bonus - "
	--[[Translation missing --]]
	L["Netherlight Crucible"] = "Netherlight Crucible"
	L["Nimble Brew Item Count"] = "Gegenstandsanzahl Schlüpfriges Gebräu"
	--[[Translation missing --]]
	L["Paladin"] = "Paladin"
	--[[Translation missing --]]
	L["Paladin Protection 2P Bonus - "] = "Paladin Protection 2P Bonus - "
	--[[Translation missing --]]
	L["Paladin Retribution 2P Bonus - "] = "Paladin Retribution 2P Bonus - "
	--[[Translation missing --]]
	L["Pantheon Trinkets"] = "Pantheon Trinkets"
	L["Pet alive"] = "Begleiter am Leben"
	L["Pet Behavior"] = "Begleiterverhalten"
	L["PVP Set"] = "PvP-Set"
	L["PvP Talents"] = "PvP-Talente"
	L["PVP Trinkets"] = "PvP-Schmuckstücke"
	--[[Translation missing --]]
	L["Renewing Mist"] = "Renewing Mist"
	L["Replace all existing triggers"] = "Ersetzt alle vorhandenen Auslöser "
	L["Replace Triggers"] = "Auslöser ersetzen"
	L["Resources"] = "Ressourcen"
	L["Resources and Shapeshift Form"] = "Ressourcen und Gestaltwandlungsform"
	--[[Translation missing --]]
	L["Rogue Assassination/Outlaw 4P Bonus - "] = "Rogue Assassination/Outlaw 4P Bonus - "
	--[[Translation missing --]]
	L["Rogue Subtlety 4P Bonus - "] = "Rogue Subtlety 4P Bonus - "
	L["Rooted"] = "Bewegungsunfähig"
	L["Runes"] = "Runen"
	--[[Translation missing --]]
	L["Secondary Effect"] = "Secondary Effect"
	--[[Translation missing --]]
	L["Set Bonus"] = "Set Bonus"
	--[[Translation missing --]]
	L["Shaman"] = "Shaman"
	--[[Translation missing --]]
	L["Shaman Elemental 4P Bonus - "] = "Shaman Elemental 4P Bonus - "
	--[[Translation missing --]]
	L["Shaman Enhancement 2P Bonus - "] = "Shaman Enhancement 2P Bonus - "
	L["Shapeshift Form"] = "Gestaltwandlungsform"
	L["Slowed"] = "Verlangsamt"
	--[[Translation missing --]]
	L["Stagger"] = "Stagger"
	--[[Translation missing --]]
	L["Stun"] = "Stun"
	--[[Translation missing --]]
	L["T19 2P Bonus - "] = "T19 2P Bonus - "
	--[[Translation missing --]]
	L["T19 4P Bonus - "] = "T19 4P Bonus - "
	--[[Translation missing --]]
	L["T20 2P Bonus - "] = "T20 2P Bonus - "
	--[[Translation missing --]]
	L["T20 4P Bonus - "] = "T20 4P Bonus - "
	--[[Translation missing --]]
	L["T21 2P Bonus - "] = "T21 2P Bonus - "
	--[[Translation missing --]]
	L["T21 4P Bonus - "] = "T21 4P Bonus - "
	L["Tank Trinkets"] = "Tank-Schmuckstücke"
	L["Totem"] = "Totem"
	L["Totems"] = "Totems"
	L["Unknown Item"] = "Unbekannter Gegenstand"
	L["Unknown Spell"] = "Unbekannter Zauber"
	--[[Translation missing --]]
	L["Vivify"] = "Vivify"
	--[[Translation missing --]]
	L["Warlock Affliction 4P/Demonology 2P Bonus - "] = "Warlock Affliction 4P/Demonology 2P Bonus - "
	--[[Translation missing --]]
	L["Warrior 2P Bonus - "] = "Warrior 2P Bonus - "

