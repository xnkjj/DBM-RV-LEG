-- Lua APIs
local tinsert, tremove, wipe = table.insert, table.remove, wipe
local fmt, tostring = string.format, tostring
local pairs, type, unpack = pairs, type, unpack
local loadstring, error = loadstring, error
local coroutine = coroutine
local _G = _G

-- WoW APIs
local InCombatLockdown = InCombatLockdown
local GetSpellInfo, GetItemInfo, GetItemIcon, UnitName = GetSpellInfo, GetItemInfo, GetItemIcon, UnitName
local GetScreenWidth, GetScreenHeight, GetBuildInfo, GetLocale, GetTime, PlaySoundFile, PlaySound, CreateFrame, IsAddOnLoaded, LoadAddOn
  = GetScreenWidth, GetScreenHeight, GetBuildInfo, GetLocale, GetTime, PlaySoundFile, PlaySound, CreateFrame, IsAddOnLoaded, LoadAddOn

local AceGUI = LibStub("AceGUI-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local WeakAuras = WeakAuras
local L = WeakAuras.L
local ADDON_NAME = "WeakAurasOptions";
local prettyPrint = WeakAuras.prettyPrint

local font_close,yellow_font,red_font = FONT_COLOR_CODE_CLOSE,YELLOW_FONT_COLOR_CODE,RED_FONT_COLOR_CODE
local ValidateNumeric = function(info,val)
  if not tonumber(val) then
    return false;
  end
  return true
end
WeakAuras.ValidateNumeric = ValidateNumeric;

local dynFrame = WeakAuras.dynFrame;
WeakAuras.transmitCache = {};

local regionOptions = WeakAuras.regionOptions;
local displayButtons = {};
WeakAuras.displayButtons = displayButtons;
local optionReloads = {};
local optionTriggerChoices = {};
WeakAuras.optionTriggerChoices = optionTriggerChoices;
WeakAuras.thumbnails = {};
local thumbnails = WeakAuras.thumbnails;
local displayOptions = {};
WeakAuras.displayOptions = displayOptions;
local loaded = WeakAuras.loaded;
local spellCache = WeakAuras.spellCache;
local savedVars = {};
WeakAuras.savedVars = savedVars;

local tempGroup = {
  id = {"tempGroup"},
  regionType = "group",
  controlledChildren = {},
  load = {},
  trigger = {},
  anchorPoint = "CENTER",
  anchorFrameType = "SCREEN",
  xOffset = 0,
  yOffset = 0
};
WeakAuras.tempGroup = tempGroup;

function WeakAuras.MultipleDisplayTooltipDesc()
  local desc = {{L["Multiple Displays"], L["Temporary Group"]}};
  for index, id in pairs(tempGroup.controlledChildren) do
    desc[index + 1] = {" ", id};
  end
  desc[2][1] = L["Children:"]
  tinsert(desc, " ");
  tinsert(desc, {" ", "|cFF00FFFF"..L["Right-click for more options"]});
  return desc;
end

function WeakAuras.DuplicateAura(data)
  local base_id = data.id .. " ";
  local num = 2;

  -- if the old id ends with a number increment the number
  local matchName, matchNumber = string.match(data.id, "^(.-)(%d*)$")
  matchNumber = tonumber(matchNumber)
  if (matchName ~= "" and matchNumber ~= nil) then
    base_id = matchName;
    num = matchNumber + 1
  end

  local new_id = base_id .. num;
  while(WeakAuras.GetData(new_id)) do
    new_id = base_id .. num;
    num = num + 1;
  end

  local newData = {};
  WeakAuras.DeepCopy(data, newData);
  newData.id = new_id;
  newData.parent = nil;
  WeakAuras.Add(newData);
  WeakAuras.NewDisplayButton(newData);
  if(data.parent) then
    local parentData = WeakAuras.GetData(data.parent);
    local index;
    for i, childId in pairs(parentData.controlledChildren) do
      if(childId == data.id) then
        index = i;
        break;
      end
    end
    if(index) then
      local newIndex = index + 1;
      if(newIndex > #parentData.controlledChildren) then
        tinsert(parentData.controlledChildren, newData.id);
      else
        tinsert(parentData.controlledChildren, index + 1, newData.id);
      end
      newData.parent = data.parent;
      WeakAuras.Add(parentData);
      WeakAuras.Add(newData);

      for index, id in pairs(parentData.controlledChildren) do
        local childButton = WeakAuras.GetDisplayButton(id);
        childButton:SetGroup(parentData.id, parentData.regionType == "dynamicgroup");
        childButton:SetGroupOrder(index, #parentData.controlledChildren);
      end

      local button = WeakAuras.GetDisplayButton(parentData.id);
      button.callbacks.UpdateExpandButton();
      WeakAuras.UpdateDisplayButton(parentData);
      WeakAuras.ReloadGroupRegionOptions(parentData);
    end
  end
  return newData.id;
end

function WeakAuras.MultipleDisplayTooltipMenu()
  local menu = {
    {
      text = L["Add to new Group"],
      notCheckable = 1,
      func = function()
        local new_id = tempGroup.controlledChildren[1].." Group";
        local num = 2;
        while(WeakAuras.GetData(new_id)) do
          new_id = "New "..num;
          num = num + 1;
        end

        local data = {
          id = new_id,
          regionType = "group",
          trigger = {},
          load = {}
        };
        WeakAuras.Add(data);
        WeakAuras.NewDisplayButton(data);

        for index, childId in pairs(tempGroup.controlledChildren) do
          local childData = WeakAuras.GetData(childId);
          tinsert(data.controlledChildren, childId);
          childData.parent = data.id;
          WeakAuras.Add(data);
          WeakAuras.Add(childData);
        end

        for index, id in pairs(data.controlledChildren) do
          local childButton = WeakAuras.GetDisplayButton(id);
          childButton:SetGroup(data.id, data.regionType == "dynamicgroup");
          childButton:SetGroupOrder(index, #data.controlledChildren);
        end

        local button = WeakAuras.GetDisplayButton(data.id);
        button.callbacks.UpdateExpandButton();
        WeakAuras.UpdateDisplayButton(data);
        WeakAuras.ReloadGroupRegionOptions(data);
        WeakAuras.SortDisplayButtons();
        button:Expand();
      end
    },
    {
      text = L["Add to new Dynamic Group"],
      notCheckable = 1,
      func = function()
        local new_id = tempGroup.controlledChildren[1].." Group";
        local num = 2;
        while(WeakAuras.GetData(new_id)) do
          new_id = "New "..num;
          num = num + 1;
        end

        local data = {
          id = new_id,
          regionType = "dynamicgroup",
          trigger = {},
          load = {}
        };

        WeakAuras.Add(data);
        WeakAuras.NewDisplayButton(data);

        for index, childId in pairs(tempGroup.controlledChildren) do
          local childData = WeakAuras.GetData(childId);
          tinsert(data.controlledChildren, childId);
          childData.parent = data.id;
          childData.xOffset = 0;
          childData.yOffset = 0;
          WeakAuras.Add(data);
          WeakAuras.Add(childData);
        end

        for index, id in pairs(data.controlledChildren) do
          local childButton = WeakAuras.GetDisplayButton(id);
          childButton:SetGroup(data.id, data.regionType == "dynamicgroup");
          childButton:SetGroupOrder(index, #data.controlledChildren);
        end

        local button = WeakAuras.GetDisplayButton(data.id);
        button.callbacks.UpdateExpandButton();
        WeakAuras.UpdateDisplayButton(data);
        WeakAuras.ReloadGroupRegionOptions(data);
        WeakAuras.SortDisplayButtons();
        button:Expand();
        WeakAuras.PickDisplay(new_id);
      end
    },
    {
      text = L["Duplicate All"],
      notCheckable = 1,
      func = function()
        local toDuplicate = {};
        for index, id in pairs(tempGroup.controlledChildren) do
          toDuplicate[index] = id;
        end

        local duplicated = {};

        for index, id in ipairs(toDuplicate) do
          local childData = WeakAuras.GetData(id);
          duplicated[index] = WeakAuras.DuplicateAura(childData);
        end

        WeakAuras.ClearPicks();
        for index, id in ipairs(duplicated) do
          WeakAuras.PickDisplayMultiple(id);
        end
      end
    },
    {
      text = " ",
      notCheckable = 1,
      notClickable = 1
    },
    {
      text = L["Delete all"],
      notCheckable = 1,
      func = function()
        for index, id in pairs(tempGroup.controlledChildren) do
          local toDelete = {};
          local parents = {};
          for index, id in pairs(tempGroup.controlledChildren) do
            local childData = WeakAuras.GetData(id);
            toDelete[index] = childData;
            if(childData.parent) then
              parents[childData.parent] = true;
            end
          end
          for index, childData in pairs(toDelete) do
            WeakAuras.DeleteOption(childData);
          end
          for id, _ in pairs(parents) do
            local parentData = WeakAuras.GetData(id);
            local parentButton = WeakAuras.GetDisplayButton(id);
            WeakAuras.UpdateGroupOrders(parentData);
            if(#parentData.controlledChildren == 0) then
              parentButton:DisableExpand();
            else
              parentButton:EnableExpand();
            end
            parentButton:SetNormalTooltip();
          end
        end
        WeakAuras.SortDisplayButtons();
      end
    },
    {
      text = " ",
      notClickable = 1,
      notCheckable = 1,
    },
    {
      text = L["Close"],
      notCheckable = 1,
      func = function() WeakAuras_DropDownMenu:Hide() end
    }
  };
  local anyGrouped = false;
  for index, id in pairs(tempGroup.controlledChildren) do
    local childData = WeakAuras.GetData(id);
    if(childData and childData.parent) then
      anyGrouped = true;
      break;
    end
  end
  if(anyGrouped) then
    menu[1].notClickable = 1;
    menu[1].text = "|cFF777777"..menu[1].text;
    menu[2].notClickable = 1;
    menu[2].text = "|cFF777777"..menu[2].text;
  end
  return menu;
end

local trigger_types = WeakAuras.trigger_types;
local point_types = WeakAuras.point_types;
local operator_types = WeakAuras.operator_types;
local operator_types_without_equal = WeakAuras.operator_types_without_equal;
local string_operator_types = WeakAuras.string_operator_types;
local eventend_types = WeakAuras.eventend_types;
local autoeventend_types = WeakAuras.autoeventend_types;
local subevent_actual_prefix_types = WeakAuras.subevent_actual_prefix_types;


local function union(table1, table2)
  local meta = {};
  for i,v in pairs(table1) do
    meta[i] = v;
  end
  for i,v in pairs(table2) do
    meta[i] = v;
  end
  return meta;
end

AceGUI:RegisterLayout("AbsoluteList", function(content, children)
  local yOffset = 0;
  for i = 1, #children do
    local child = children[i]

    local frame = child.frame;
    frame:ClearAllPoints();
    frame:Show();

    frame:SetPoint("LEFT", content);
    frame:SetPoint("RIGHT", content);
    frame:SetPoint("TOP", content, "TOP", 0, yOffset)

    if child.DoLayout then
      child:DoLayout()
    end

    yOffset = yOffset - ((frame.height or frame:GetHeight() or 0) + 2);
  end
  if(content.obj.LayoutFinished) then
    content.obj:LayoutFinished(nil, yOffset * -1);
  end
end);

AceGUI:RegisterLayout("ButtonsScrollLayout", function(content, children)
  local yOffset = 0
  local scrollTop, scrollBottom = content.obj:GetScrollPos()
  for i = 1, #children do
    local child = children[i]
    local frame = child.frame;

    if not child.dragging then
      local frameHeight = (frame.height or frame:GetHeight() or 0);
      frame:ClearAllPoints();
      if (-yOffset + frameHeight > scrollTop and -yOffset - frameHeight < scrollBottom) then
        frame:Show();
        frame:SetPoint("LEFT", content);
        frame:SetPoint("RIGHT", content);
        frame:SetPoint("TOP", content, "TOP", 0, yOffset)
      else
        frame:Hide();
        frame.yOffset = yOffset
      end
      yOffset = yOffset - (frameHeight + 2);
    end

    if child.DoLayout then
      child:DoLayout()
    end

  end
  if(content.obj.LayoutFinished) then
    content.obj:LayoutFinished(nil, yOffset * -1)
  end
end)

function WeakAuras.ConstructOptions(prototype, data, startorder, subPrefix, subSuffix, triggernum, triggertype, unevent)
  local trigger, untrigger;
  if(data.controlledChildren) then
    trigger, untrigger = {}, {};
  elseif(triggertype == "load") then
    trigger = data.load;
  else
    if(triggernum == 0) then
      data.untrigger = data.untrigger or {};
      if(triggertype == "untrigger") then
        trigger = data.untrigger;
      else
        trigger = data.trigger;
        untrigger = data.untrigger;
      end
    elseif(triggernum >= 1) then
      data.additional_triggers[triggernum].untrigger = data.additional_triggers[triggernum].untrigger or {};
      if(triggertype == "untrigger") then
        trigger = data.additional_triggers[triggernum].untrigger;
      else
        trigger = data.additional_triggers[triggernum].trigger;
        untrigger = data.additional_triggers[triggernum].untrigger;
      end
    else
      error("Improper argument to WeakAuras.ConstructOptions - trigger number not in range");
    end
  end
  unevent = unevent or trigger.unevent;
  local options = {};
  local order = startorder or 10;
  for index, arg in pairs(prototype.args) do
    local hidden = nil;
    if(type(arg.enable) == "function") then
      hidden = function() return not arg.enable(trigger) end;
    end
    local name = arg.name;
    local reloadOptions = arg.reloadOptions;
    if(name and not arg.hidden) then
      local realname = name;
      if(triggertype == "untrigger") then
        name = "untrigger_"..name;
      end
      if (arg.type == "multiselect") then
        -- Ensure new line for non-toggle options
        options["spacer_"..name] = {
          type = "description",
          name = "",
          order = order,
          hidden = hidden,
        }
        order = order + 1;
      end
      if(arg.type == "tristate") then
        options["use_"..name] = {
          type = "toggle",
          name = function(input)
            local value = trigger["use_"..realname];
            if(value == nil) then return arg.display;
            elseif(value == false) then return "|cFFFF0000 "..L["Negator"].." "..arg.display;
            else return "|cFF00FF00"..arg.display; end
          end,
          get = function()
            local value = trigger["use_"..realname];
            if(value == nil) then return false;
            elseif(value == false) then return "false";
            else return "true"; end
          end,
          set = function(info, v)
            if(v) then
              trigger["use_"..realname] = true;
            else
              local value = trigger["use_"..realname];
              if(value == false) then trigger["use_"..realname] = nil;
              else trigger["use_"..realname] = false end
            end
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end,
          hidden = hidden,
          order = order
        };
      elseif(arg.type == "multiselect") then
        options["use_"..name] = {
          type = "toggle",
          name = arg.display,
          desc = function()
            local v = trigger["use_"..realname];
            if(v == true) then
              return L["Multiselect single tooltip"];
            elseif(v == false) then
              return L["Multiselect multiple tooltip"];
            else
              return L["Multiselect ignored tooltip"];
            end
          end,
          get = function()
            local value = trigger["use_"..realname];
            if(value == nil) then return false;
            elseif(value == false) then return "false";
            else return "true"; end
          end,
          set = function(info, v)
            if(v) then
              trigger["use_"..realname] = true;
            else
              local value = trigger["use_"..realname];
              if(value == false) then trigger["use_"..realname] = nil;
              else
                trigger["use_"..realname] = false
                if(trigger[realname].single) then
                  trigger[realname].multi[trigger[realname].single] = true;
                end
              end
            end
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end,
          hidden = hidden,
          order = order
        };
      elseif (arg.type == "description") then
        options["description_space_"..name] = {
          type = "description",
          name = "",
          order = order,
          hidden = hidden,
        }
        options["description_title_"..name] = {
          type = "description",
          name = arg.display,
          order = order,
          hidden = hidden,
          fontSize = "large",
        }
        order = order + 1;
        options["description_"..name] = {
          type = "description",
          name = arg.text,
          order = order,
          hidden = hidden,
        }
        order = order + 1;
      else
        options["use_"..name] = {
          type = "toggle",
          name = arg.display,
          order = order,
          hidden = hidden,
          desc = arg.desc,
          get = function() return trigger["use_"..realname]; end,
          set = function(info, v)
            trigger["use_"..realname] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
      end
      if(arg.type == "toggle" or arg.type == "tristate") then
        options["use_"..name].width = arg.width or "double";
      end
      if(arg.required) then
        trigger["use_"..realname] = true;
        if not(triggertype) then
          options["use_"..name].disabled = true;
        else
          options["use_"..name] = nil;
          order = order - 1;
        end
      end
      order = order + 1;
      if(arg.type == "number") then
        if (not arg.noOperator) then
          options[name.."_operator"] = {
            type = "select",
            name = L["Operator"],
            width = "half",
            order = order,
            hidden = hidden,
            values = arg.operator_types_without_equal and operator_types_without_equal or operator_types,
            disabled = function() return not trigger["use_"..realname]; end,
            get = function() return trigger["use_"..realname] and trigger[realname.."_operator"] or nil; end,
            set = function(info, v)
              trigger[realname.."_operator"] = v;
              WeakAuras.Add(data);
              if (reloadOptions) then
                WeakAuras.ScheduleReloadOptions(data);
              end
              WeakAuras.ScanForLoads();
              WeakAuras.SetThumbnail(data);
              WeakAuras.SetIconNames(data);
              WeakAuras.UpdateDisplayButton(data);
              WeakAuras.SortDisplayButtons();
            end
          };
          if(arg.required and not triggertype) then
            options[name.."_operator"].set = function(info, v)
              trigger[realname.."_operator"] = v;
              untrigger[realname.."_operator"] = v;
              WeakAuras.Add(data);
              if (reloadOptions) then
                WeakAuras.ScheduleReloadOptions(data);
              end
              WeakAuras.ScanForLoads();
              WeakAuras.SortDisplayButtons();
            end
          elseif(arg.required and triggertype == "untrigger") then
            options[name.."_operator"] = nil;
            order = order - 1;
          end
          order = order + 1;
        end
        options[name] = {
          type = "input",
          validate = ValidateNumeric,
          name = arg.display,
          width = arg.noOperator and "normal" or "half",
          order = order,
          hidden = hidden,
          disabled = function() return not trigger["use_"..realname]; end,
          get = function() return trigger["use_"..realname] and trigger[realname] or nil; end,
          set = function(info, v)
            trigger[realname] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
        if(arg.required and not triggertype) then
          options[name].set = function(info, v)
            trigger[realname] = v;
            untrigger[realname] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SortDisplayButtons();
          end
        elseif(arg.required and triggertype == "untrigger") then
          options[name] = nil;
          order = order - 1;
        end
        order = order + 1;
      elseif(arg.type == "string") then
        options[name] = {
          type = "input",
          name = arg.display,
          order = order,
          hidden = hidden,
          desc = arg.desc,
          disabled = function() return not trigger["use_"..realname]; end,
          get = function() return trigger["use_"..realname] and trigger[realname] or nil; end,
          set = function(info, v)
            trigger[realname] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
        if(arg.required and not triggertype) then
          options[name].set = function(info, v)
            trigger[realname] = v;
            untrigger[realname] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SortDisplayButtons();
          end
        elseif(arg.required and triggertype == "untrigger") then
          options[name] = nil;
          order = order - 1;
        end
        order = order + 1;
      elseif(arg.type == "longstring") then
        options[name.."_operator"] = {
          type = "select",
          name = L["Operator"],
          order = order,
          hidden = hidden,
          values = string_operator_types,
          disabled = function() return not trigger["use_"..realname]; end,
          get = function() return trigger["use_"..realname] and trigger[realname.."_operator"] or nil; end,
          set = function(info, v)
            trigger[realname.."_operator"] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
        if(arg.required and not triggertype) then
          options[name.."_operator"].set = function(info, v)
            trigger[realname.."_operator"] = v;
            untrigger[realname.."_operator"] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SortDisplayButtons();
          end
        elseif(arg.required and triggertype == "untrigger") then
          options[name.."_operator"] = nil;
          order = order - 1;
        end
        order = order + 1;
        options[name] = {
          type = "input",
          name = arg.display,
          width = "double",
          order = order,
          hidden = hidden,
          disabled = function() return not trigger["use_"..realname]; end,
          get = function() return trigger["use_"..realname] and trigger[realname] or nil; end,
          set = function(info, v)
            trigger[realname] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
        if(arg.required and not triggertype) then
          options[name].set = function(info, v)
            trigger[realname] = v;
            untrigger[realname] = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SortDisplayButtons();
          end
        elseif(arg.required and triggertype == "untrigger") then
          options[name] = nil;
          order = order - 1;
        end
        order = order + 1;
      elseif(arg.type == "spell" or arg.type == "aura" or arg.type == "item") then
        options["icon"..name] = {
          type = "execute",
          name = "",
          order = order,
          hidden = hidden,
          width = "normal",
          image = function()
            if(trigger["use_"..realname] and trigger[realname]) then
              if(arg.type == "aura") then
                local icon = spellCache.GetIcon(trigger[realname]);
                return icon and tostring(icon) or "", 18, 18;
              elseif(arg.type == "spell") then
                local _, _, icon = GetSpellInfo(trigger[realname]);
                return icon and tostring(icon) or "", 18, 18;
              elseif(arg.type == "item") then
                local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(trigger[realname]);
                return icon and tostring(icon) or "", 18, 18;
              end
            else
              return "", 18, 18;
            end
          end,
          disabled = function() return not ((arg.type == "aura" and trigger[realname] and spellCache.GetIcon(trigger[realname])) or (arg.type == "spell" and trigger[realname] and GetSpellInfo(trigger[realname])) or (arg.type == "item" and trigger[realname] and GetItemIcon(trigger[realname]))) end
        };
        order = order + 1;
        options[name] = {
          type = "input",
          name = arg.display,
          order = order,
          hidden = hidden,
          width = "double",
          disabled = function() return not trigger["use_"..realname]; end,
          get = function()
            if(arg.type == "item") then
              if(trigger["use_"..realname] and trigger[realname] and trigger[realname] ~= "") then
                local name = GetItemInfo(trigger[realname]);
                if(name) then
                  return name;
                else
                  return "Invalid Item Name/ID/Link";
                end
              else
                return nil;
              end
            elseif(arg.type == "spell") then
              if(trigger["use_"..realname] and trigger[realname] and trigger[realname] ~= "") then
                local name = GetSpellInfo(trigger[realname]);
                if(name) then
                  return name;
                else
                  return "Invalid Spell Name/ID/Link";
                end
              else
                return nil;
              end
            else
              return trigger["use_"..realname] and trigger[realname] or nil;
            end
          end,
          set = function(info, v)
            local fixedInput = v;
            if(arg.type == "aura") then
              fixedInput = WeakAuras.spellCache.CorrectAuraName(v);
            elseif(arg.type == "spell") then
              fixedInput = WeakAuras.CorrectSpellName(v);
            elseif(arg.type == "item") then
              fixedInput = WeakAuras.CorrectItemName(v);
            end
            trigger[realname] = fixedInput;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
        if(arg.required and not triggertype) then
          options[name].set = function(info, v)
            local fixedInput = v;
            if(arg.type == "aura") then
              fixedInput = WeakAuras.spellCache.CorrectAuraName(v);
            elseif(arg.type == "spell") then
              fixedInput = WeakAuras.CorrectSpellName(v);
            elseif(arg.type == "item") then
              fixedInput = WeakAuras.CorrectItemName(v);
            end
            trigger[realname] = fixedInput;
            untrigger[realname] = fixedInput;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        elseif(arg.required and triggertype == "untrigger") then
          options["icon"..name] = nil;
          options[name] = nil;
          order = order - 2;
        end
        order = order + 1;
      elseif(arg.type == "select" or arg.type == "unit") then
        local values;
        if(type(arg.values) == "function") then
          values = arg.values(trigger);
        else
          values = WeakAuras[arg.values];
        end
        options[name] = {
          type = "select",
          name = arg.display,
          order = order,
          hidden = hidden,
          values = values,
          disabled = function() return not trigger["use_"..realname]; end,
          get = function()
            if(arg.type == "unit" and trigger["use_specific_"..realname]) then
              return "member";
            end

            if (not trigger["use_"..realname]) then
              return nil;
            end

            if (arg.default and (not trigger[realname] or not values[trigger[realname]])) then
              trigger[realname] = arg.default;
              return arg.default;
            end

            return trigger[realname] or nil;
          end,
          set = function(info, v)
            trigger[realname] = v;
            if(arg.type == "unit" and v == "member") then
              trigger["use_specific_"..realname] = true;
              trigger[realname] = UnitName("player");
            else
              trigger["use_specific_"..realname] = nil;
            end
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
        if(arg.required and not triggertype) then
          options[name].set = function(info, v)
            trigger[realname] = v;
            if(arg.type == "unit" and v == "member") then
              trigger["use_specific_"..realname] = true;
            else
              trigger["use_specific_"..realname] = nil;
            end
            untrigger[realname] = v;
            if(arg.type == "unit" and v == "member") then
              untrigger["use_specific_"..realname] = true;
            else
              untrigger["use_specific_"..realname] = nil;
            end
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        elseif(arg.required and triggertype == "untrigger") then
          options[name] = nil;
          order = order - 1;
        end
        if (arg.control) then
          options[name].control = arg.control;
        end
        order = order + 1;
        if(arg.type == "unit" and not (arg.required and triggertype == "untrigger")) then
          options["use_specific_"..name] = {
            type = "toggle",
            name = L["Specific Unit"],
            order = order,
            hidden = function() return (not trigger["use_specific_"..realname]) or (type(hidden) == "function" and hidden(trigger)) or (type(hidden) ~= "function" and hidden) end,
            get = function() return true end,
            set = function(info, v)
              trigger["use_specific_"..realname] = nil;
              options[name].set(info, "player");
            end
          }
          order = order + 1;
          options["specific_"..name] = {
            type = "input",
            name = L["Specific Unit"],
            desc = L["Can be a name or a UID (e.g., party1). A name only works on friendly players in your group."],
            order = order,
            hidden = function() return (not trigger["use_specific_"..realname]) or (type(hidden) == "function" and hidden(trigger)) or (type(hidden) ~= "function" and hidden) end,
            get = function() return trigger[realname] end,
            set = function(info, v)
              trigger[realname] = v;
              if(arg.required and not triggertype) then
                untrigger[realname] = v;
              end
              WeakAuras.Add(data);
              if (reloadOptions) then
                WeakAuras.ScheduleReloadOptions(data);
              end
            end
          };
          order = order + 1;
        end
      elseif(arg.type == "multiselect") then
        local values;
        if(type(arg.values) == "function") then
          values = arg.values(trigger);
        else
          values = WeakAuras[arg.values];
        end
        options[name] = {
          type = "select",
          name = arg.display,
          order = order,
          values = values,
          hidden = function()
            return (type(hidden) == "function" and hidden(trigger)) or (type(hidden) ~= "function" and hidden) or trigger["use_"..realname] == false;
          end,
          disabled = function() return not trigger["use_"..realname]; end,
          get = function() return trigger["use_"..realname] and trigger[realname] and trigger[realname].single or nil; end,
          set = function(info, v)
            trigger[realname].single = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
        if(arg.required and not triggertype) then
          options[name].set = function(info, v)
            trigger[realname].single = v;
            untrigger[realname].single = v;
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        end

        options["multiselect_"..name] = {
          type = "multiselect",
          name = arg.display,
          order = order,
          hidden = function() return (type(hidden) == "function" and hidden(trigger)) or (type(hidden) ~= "function" and hidden) or trigger["use_"..realname] ~= false; end,
          values = values,
          -- width = "half",
          get = function(info, v)
            if(trigger["use_"..realname] == false and trigger[realname] and trigger[realname].multi) then
              return trigger[realname].multi[v];
            end
          end,
          set = function(info, v, calledFromSetAll)
            if (calledFromSetAll) then
              trigger[realname].multi[v] = calledFromSetAll;
            elseif(trigger[realname].multi[v]) then
              trigger[realname].multi[v] = nil;
            else
              trigger[realname].multi[v] = true;
            end
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        };
        options["multiselectspace_"..name] = {
          type = "execute",
          name = "",
          order = (order - 0.5),
          hidden = function() return (type(hidden) == "function" and hidden(trigger)) or (type(hidden) ~= "function" and hidden) or trigger["use_"..realname] ~= false; end,
          disabled = true,
          image = function() return "", 52, 52 end
        };
        if(arg.required and not triggertype) then
          options[name].set = function(info, v)
            if(trigger[realname].multi[v]) then
              trigger[realname].multi[v] = nil;
            else
              trigger[realname].multi[v] = true;
            end
            if(untrigger[realname].multi[v]) then
              untrigger[realname].multi[v] = nil;
            else
              untrigger[realname].multi[v] = true;
            end
            WeakAuras.Add(data);
            if (reloadOptions) then
              WeakAuras.ScheduleReloadOptions(data);
            end
            WeakAuras.ScanForLoads();
            WeakAuras.SetThumbnail(data);
            WeakAuras.SetIconNames(data);
            WeakAuras.UpdateDisplayButton(data);
            WeakAuras.SortDisplayButtons();
          end
        end

        if(arg.required and triggertype == "untrigger") then
          options[name] = nil;
          options["multiselect_"..name] = nil;
        else
          order = order + 1;
        end
      end
    end
  end

  if not(triggertype or prototype.automaticrequired) then
    options.unevent = {
      type = "select",
      name = L["Hide"],
      width = "double",
      order = order
    };
    order = order + 1;
    if(unevent == "timed") then
      options.unevent.width = "normal";
      options.duration = {
        type = "input",
        name = L["Duration (s)"],
        order = order
      }
      order = order + 1;
    else
      options.unevent.width = "double";
    end
    if(unevent == "custom") then
      local unevent_options = WeakAuras.ConstructOptions(prototype, data, order, subPrefix, subSuffix, triggernum, "untrigger");
      options = union(options, unevent_options);
    end
    if(prototype.automatic) then
      options.unevent.values = autoeventend_types;
    else
      options.unevent.values = eventend_types;
    end
  end

  WeakAuras.option = options;
  return options;
end

local frame;
local db;
local odb;
local options;
local newOptions;
local loadedOptions;
local unloadedOptions;
local reopenAfterCombat = false;
local loadedFrame = CreateFrame("FRAME");
loadedFrame:RegisterEvent("ADDON_LOADED");
loadedFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
loadedFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
loadedFrame:SetScript("OnEvent", function(self, event, addon)
  if (event == "ADDON_LOADED") then
    if(addon == ADDON_NAME) then
      db = WeakAurasSaved;
      WeakAurasOptionsSaved = WeakAurasOptionsSaved or {};

      odb = WeakAurasOptionsSaved;

      -- Remove icon and id cache (replaced with spellCache)
      if (odb.iconCache) then
        odb.iconCache = nil;
      end
      if (odb.idCache) then
        odb.idCache = nil;
      end
      odb.spellCache = odb.spellCache or {};
      spellCache.Load(odb.spellCache);

      local _, build = GetBuildInfo();
      local locale = GetLocale();
      local version = WeakAuras.versionString

      local num = 0;

      for i,v in pairs(odb.spellCache) do
        num = num + 1;
      end

      if(num < 39000 or odb.locale ~= locale or odb.build ~= build or odb.version ~= version) then
        spellCache.Build();

        odb.build = build;
        odb.locale = locale;
        odb.version = version;
      end

      -- Updates the icon cache with whatever icons WeakAuras core has actually used.
      -- This helps keep name<->icon matches relevant.
      for name, icons in pairs(db.dynamicIconCache) do
        if db.dynamicIconCache[name] then
          for spellId, icon in pairs(db.dynamicIconCache[name]) do
            spellCache.AddIcon(name, spellId, icon)
          end
        end
      end
      savedVars.db = db;
      savedVars.odb = odb;
    end
  elseif (event == "PLAYER_REGEN_DISABLED") then
    if(frame and frame:IsVisible()) then
      reopenAfterCombat = true;
      WeakAuras.HideOptions();
    end
  elseif (event == "PLAYER_REGEN_ENABLED") then
    if (reopenAfterCombat) then
      reopenAfterCombat = nil;
      WeakAuras.ShowOptions()
    end
  end
end);

function WeakAuras.DeleteOption(data)
  local id = data.id;
  local parentData;
  if(data.parent) then
    parentData = db.displays[data.parent];
  end

  if(data.controlledChildren) then
    for index, childId in pairs(data.controlledChildren) do
      local childButton = displayButtons[childId];
      if(childButton) then
        childButton:SetGroup();
      end
      local childData = db.displays[childId];
      if(childData) then
        childData.parent = nil;
      end
    end
  end

  WeakAuras.CollapseAllClones(id);

  WeakAuras.Delete(data);
  frame:ClearPicks();
  frame.buttonsScroll:DeleteChild(displayButtons[id]);
  thumbnails[id].region:Hide();
  thumbnails[id] = nil;
  displayButtons[id] = nil;

  if(parentData and parentData.controlledChildren) then
    for index, childId in pairs(parentData.controlledChildren) do
      local childButton = displayButtons[childId];
      if(childButton) then
        childButton:SetGroupOrder(index, #parentData.controlledChildren);
      end
    end
    WeakAuras.Add(parentData);
    WeakAuras.ReloadGroupRegionOptions(parentData);
    WeakAuras.UpdateDisplayButton(parentData);
  end
end

function WeakAuras.OptionsFrame()
  if(frame) then
    return frame;
  else
    return nil;
  end
end

function WeakAuras.ToggleOptions(msg)
  if(frame and frame:IsVisible()) then
    WeakAuras.HideOptions();
  elseif (InCombatLockdown()) then
    prettyPrint(L["Options will open after combat ends."])
    reopenAfterCombat = true;
  else
    WeakAuras.ShowOptions(msg);
  end
end

function WeakAuras.UpdateCloneConfig(data)
  if(WeakAuras.CanHaveClones(data)) then
    local cloneRegion = WeakAuras.EnsureClone(data.id, 1);
    cloneRegion:Expand();

    cloneRegion = WeakAuras.EnsureClone(data.id, 2);
    cloneRegion:Expand();

    --if(data.parent and WeakAuras.regions[data.parent]) then
    if(data.parent and WeakAuras.regions[data.parent] and
      WeakAuras.regions[data.parent].region and
      WeakAuras.regions[data.parent].region.ControlChildren) then
      WeakAuras.regions[data.parent].region:ControlChildren();
    end

    WeakAuras.SetIconNames(data);
  end
end

function WeakAuras.ShowOptions(msg)
  local firstLoad = not(frame);
  WeakAuras.Pause();

  if (firstLoad) then
    frame = WeakAuras.CreateFrame();
    frame.buttonsScroll.frame:Show();
    WeakAuras.AddOption(tempGroup.id, tempGroup);
    WeakAuras.LayoutDisplayButtons(msg);
  end
  frame.buttonsScroll.frame:Show();
  WeakAuras.LockUpdateInfo();

  if (frame.needsSort) then
    WeakAuras.SortDisplayButtons();
    frame.needsSort = nil;
  end

  frame:Show();
  frame:PickOption("New");
  if not(firstLoad) then
    WeakAuras.PauseAllDynamicGroups();
    for id, button in pairs(displayButtons) do
      if(loaded[id] ~= nil) then
        button:PriorityShow(1);
      end
    end
    WeakAuras.ResumeAllDynamicGroups();
  end

  if (frame.window == "codereview") then
    frame.codereview:Close();
  end

  if (WeakAuras.mouseFrame) then
    WeakAuras.mouseFrame:OptionsOpened();
  end
  if (WeakAuras.personalRessourceDisplayFrame) then
    WeakAuras.personalRessourceDisplayFrame:OptionsOpened();
  end
end

function WeakAuras.HideOptions()
  -- dynFrame:SetScript("OnUpdate", nil);
  WeakAuras.UnlockUpdateInfo();
  WeakAuras.SetDragging()

  if(frame) then
    frame:Hide();
  end

  local tutFrame = WeakAuras.TutorialsFrame and WeakAuras.TutorialsFrame();
  if(tutFrame and tutFrame:IsVisible()) then
    tutFrame:Hide();
  end

  WeakAuras.PauseAllDynamicGroups();

  for id, data in pairs(WeakAuras.regions) do
    data.region:Collapse();
  end

  WeakAuras.ResumeAllDynamicGroups();

  WeakAuras.ReloadAll();
  WeakAuras.Resume();

  if (WeakAuras.mouseFrame) then
    WeakAuras.mouseFrame:OptionsClosed();
  end
  if (WeakAuras.personalRessourceDisplayFrame) then
    WeakAuras.personalRessourceDisplayFrame:OptionsClosed();
  end
end

function WeakAuras.IsOptionsOpen()
  if(frame and frame:IsVisible()) then
    return true;
  else
    return false;
  end
end

function WeakAuras.DoConfigUpdate()
  local function GiveDynamicInfo(id, region, data, cloneNum)
    if(WeakAuras.CanHaveDuration(data) == "timed") then
      local rem = GetTime() + 8 - (frame.count + frame.elapsed);
      if(cloneNum) then
        rem = rem + (cloneNum == 1 and (frame.count >= 1 and 1 or -3) or (frame.count >= 2 and 2 or -2));
      end
      if(region.SetDurationInfo) then
        if not(frame.count ~= 0 and region.cooldown and region.cooldown:IsVisible()) then
          region:SetDurationInfo(12, rem);
        end
      end
    elseif(type(WeakAuras.CanHaveDuration(data)) == "table") then
      local demoValues = WeakAuras.CanHaveDuration(data);
      local current, maximum = demoValues.current or 10, demoValues.maximum or 100;
      if(region.SetDurationInfo) then
        region:SetDurationInfo(current, maximum, true);
      end
    else
      if(region.SetDurationInfo) then
        region:SetDurationInfo(0, math.huge);
      end
    end
  end

  for id, region in pairs(WeakAuras.regions) do
    local data = db.displays[id];
    if(data) then
      GiveDynamicInfo(id, region.region, data);

      if(WeakAuras.clones[id]) then
        for cloneNum, cloneRegion in pairs(WeakAuras.clones[id]) do
          GiveDynamicInfo(id, cloneRegion, data, cloneNum);
        end
      end
    end
  end
end

function WeakAuras.LockUpdateInfo()
  frame.elapsed = 12;
  frame.count = 0;
  frame:SetScript("OnUpdate", function(self, elapsed)
    frame.elapsed = frame.elapsed + elapsed;
    if(frame.elapsed > 1) then
      frame.elapsed = frame.elapsed - 1;
      frame.count = (frame.count + 1) % 4;
      WeakAuras.DoConfigUpdate();
    end
  end);
end

function WeakAuras.UnlockUpdateInfo()
  frame:SetScript("OnUpdate", nil);
end

function WeakAuras.SetIconNames(data)
  if (not thumbnails[data.id]) then return end;
  WeakAuras.SetIconName(data, WeakAuras.regions[data.id].region);
  WeakAuras.SetIconName(data, thumbnails[data.id].region);
  if(WeakAuras.clones[data.id]) then
    for index, cloneRegion in pairs(WeakAuras.clones[data.id]) do
      WeakAuras.SetIconName(data, cloneRegion);
    end
  end
end

function WeakAuras.SetIconName(data, region)
  local name, icon = WeakAuras.GetNameAndIcon(data);
  WeakAuras.transmitCache[data.id] = icon;

  if(region.SetIcon) then
    region:SetIcon(icon);
  end
  if(region.SetName) then
    region:SetName(name);
  end
end

function WeakAuras.GetSortedOptionsLists()
  local loadedSorted, unloadedSorted = {}, {};
  local to_sort = {};
  for id, data in pairs(db.displays) do
    if(data.parent) then
    -- Do nothing; children will be added later
    elseif(loaded[id]) then
      tinsert(to_sort, id);
    end
  end
  table.sort(to_sort, function(a, b) return a < b end);
  for _, id in ipairs(to_sort) do
    tinsert(loadedSorted, id);
    local data = WeakAuras.GetData(id);
    local controlledChildren = data.controlledChildren;
    if(controlledChildren) then
      for _, childId in pairs(controlledChildren) do
        tinsert(loadedSorted, childId);
      end
    end
  end

  wipe(to_sort);
  for id, data in pairs(db.displays) do
    if(data.parent) then
    -- Do nothing; children will be added later
    elseif not(loaded[id]) then
      tinsert(to_sort, id);
    end
  end
  table.sort(to_sort, function(a, b) return a < b end);
  for _, id in ipairs(to_sort) do
    tinsert(unloadedSorted, id);
    local data = WeakAuras.GetData(id);
    local controlledChildren = data.controlledChildren;
    if(controlledChildren) then
      for _, childId in pairs(controlledChildren) do
        tinsert(unloadedSorted, childId);
      end
    end
  end

  return loadedSorted, unloadedSorted;
end

function WeakAuras.BuildOptions(list, callback)
  frame.loadProgress:Show();
  frame.filterInput:Hide();
  frame.filterInputClear:Hide();

  local total = 0;
  for _,_ in pairs(list) do
    total = total + 1;
  end

  local func = function()
    local num = 0;
    for id, data in pairs(list) do
      if(data) then
        if not(data.regionType == "group" or data.regionType == "dynamicgroup") then
          WeakAuras.AddOption(id, data);
          num = num + 1;
        end
      end
      frame.loadProgress:SetText(L["Creating options: "]..num.."/"..total);

      coroutine.yield();
    end

    callback();
    frame.loadProgress:Hide();
    frame.filterInput:Show();
    frame.filterInputClear:Show();
  end

  local co = coroutine.create(func);
  dynFrame:AddAction("BuildOptions", co);
end

function WeakAuras.LayoutDisplayButtons(msg)
  local total = 0;
  for _,_ in pairs(db.displays) do
    total = total + 1;
  end

  local loadedSorted, unloadedSorted = WeakAuras.GetSortedOptionsLists();

  frame.loadProgress:Show();
  frame.buttonsScroll:AddChild(frame.newButton);
  if(frame.addonsButton) then
    frame.buttonsScroll:AddChild(frame.addonsButton);
  end
  frame.buttonsScroll:AddChild(frame.loadedButton);
  frame.buttonsScroll:AddChild(frame.unloadedButton);

  local func2 = function()
    local num = frame.loadProgressNum or 0;
    for index, id in pairs(unloadedSorted) do
      local data = WeakAuras.GetData(id);
      if(data) then
        WeakAuras.EnsureDisplayButton(data);
        WeakAuras.UpdateDisplayButton(data);

        frame.buttonsScroll:AddChild(displayButtons[data.id]);
        WeakAuras.SetIconNames(data);
        if(WeakAuras.regions[data.id].region.SetStacks) then
          WeakAuras.regions[data.id].region:SetStacks(1);
        end

        if (num % 50 == 0) then
          frame.buttonsScroll:ResumeLayout()
          frame.buttonsScroll:PerformLayout()
          frame.buttonsScroll:PauseLayout()
        end

        num = num + 1;
      end
      frame.loadProgress:SetText(L["Creating buttons: "]..num.."/"..total);
      frame.loadProgressNum = num;
      coroutine.yield();
    end

    frame.buttonsScroll:ResumeLayout()
    frame.buttonsScroll:PerformLayout()
    WeakAuras.SortDisplayButtons(msg);

    WeakAuras.PauseAllDynamicGroups();
    if (WeakAuras.IsOptionsOpen()) then
      for id, button in pairs(displayButtons) do
        if(loaded[id] ~= nil) then
          button:PriorityShow(1);
        end
      end
    end
    WeakAuras.ResumeAllDynamicGroups();

    frame.loadProgress:Hide();
    frame.filterInput:Show();
    frame.filterInputClear:Show();
  end

  local func1 = function()
    local num = frame.loadProgressNum or 0;
    frame.buttonsScroll:PauseLayout()
    for index, id in pairs(loadedSorted) do
      local data = WeakAuras.GetData(id);
      if(data) then
        WeakAuras.EnsureDisplayButton(data);
        WeakAuras.UpdateDisplayButton(data);

        local button = displayButtons[data.id]
        frame.buttonsScroll:AddChild(button);
        WeakAuras.SetIconNames(data);
        if(WeakAuras.regions[data.id].region.SetStacks) then
          WeakAuras.regions[data.id].region:SetStacks(1);
        end

        num = num + 1;
      end

      if (num % 50 == 0) then
        frame.buttonsScroll:ResumeLayout()
        frame.buttonsScroll:PerformLayout()
        frame.buttonsScroll:PauseLayout()
      end

      frame.loadProgress:SetText(L["Creating buttons: "]..num.."/"..total);
      frame.loadProgressNum = num;
      coroutine.yield();
    end

    local co2 = coroutine.create(func2);
    dynFrame:AddAction("LayoutDisplayButtons2", co2);
  end

  local co1 = coroutine.create(func1);
  dynFrame:AddAction("LayoutDisplayButtons1", co1);
end


local function removeFuncs(intable)
  for i,v in pairs(intable) do
    if(i == "get" or i == "set" or i == "hidden" or i == "disabled") then
      intable[i] = nil;
    elseif(type(v) == "table" and i ~= "values") then
      removeFuncs(v);
    end
  end
end

local function hiddenChild(childOptionTable, info)
  for i=#childOptionTable,0,-1 do
    if(childOptionTable[i].hidden ~= nil) then
      if(type(childOptionTable[i].hidden) == "boolean") then
        return childOptionTable[i].hidden;
      elseif(type(childOptionTable[i].hidden) == "function") then
        return childOptionTable[i].hidden(info);
      end
    end
  end
  return false;
end

local function disabledChild(childOptionTable, info)
  for i=#childOptionTable,0,-1 do
    if(childOptionTable[i].disabled ~= nil) then
      if(type(childOptionTable[i].disabled) == "boolean") then
        return childOptionTable[i].disabled;
      elseif(type(childOptionTable[i].disabled) == "function") then
        return childOptionTable[i].disabled(info);
      end
    end
  end
  return false;
end

local function disabeldOrHiddenChild(childOptionTable, info)
  return hiddenChild(childOptionTable, info) or disabledChild(childOptionTable, info);
end

local function getAll(data, info, ...)
  local combinedValues = {};
  local first = true;
  local debug = false;
  for index, childId in ipairs(data.controlledChildren) do
    local childData = WeakAuras.GetData(childId);

    if(childData) then
      WeakAuras.EnsureOptions(childId);
      local childOptions = displayOptions[childId];
      local childOption = childOptions;
      local childOptionTable = {[0] = childOption};
      for i=1,#info do
        childOption = childOption.args[info[i]];
        childOptionTable[i] = childOption;
      end

      if (childOption and not hiddenChild(childOptionTable, info)) then
        for i=#childOptionTable,0,-1 do
          if(childOptionTable[i].get) then
            local values = {childOptionTable[i].get(info, ...)};
            if(first) then
              combinedValues = values;
              first = false;
            else
              local same = true;
              if(#combinedValues == #values) then
                for j=1,#combinedValues do
                  if(type(combinedValues[j]) == "number" and type(values[j]) == "number") then
                    if((math.floor(combinedValues[j] * 100) / 100) ~= (math.floor(values[j] * 100) / 100)) then
                      same = false;
                      break;
                    end
                  else
                    if(combinedValues[j] ~= values[j]) then
                      same = false;
                      break;
                    end
                  end
                end
              else
                same = false;
              end
              if not(same) then
                return nil;
              end
            end
            break;
          end
        end
      end
    end
    if (debug) then print("  \n") end
  end
  return unpack(combinedValues);
end
WeakAuras.getAll = getAll

local function setAll(data, info, ...)
  WeakAuras.pauseOptionsProcessing(true);
  local before = getAll(data, info, ...)
  for index, childId in ipairs(data.controlledChildren) do
    local childData = WeakAuras.GetData(childId);
    if(childData) then
      WeakAuras.EnsureOptions(childId);
      local childOptions = displayOptions[childId];
      local childOption = childOptions;
      local childOptionTable = {[0] = childOption};
      for i=1,#info do
        childOption = childOption.args[info[i]];
        childOptionTable[i] = childOption;
      end

      if (childOption and not disabeldOrHiddenChild(childOptionTable, info)) then
        for i=#childOptionTable,0,-1 do
          if(childOptionTable[i].set) then
            if (childOptionTable[i].type == "multiselect") then
              childOptionTable[i].set(info, ..., not before);
            else
              childOptionTable[i].set(info, ...);
            end
            break;
          end
        end
      end
    end
  end

  WeakAuras.pauseOptionsProcessing(false);
  WeakAuras.ScanForLoads();
  WeakAuras.SortDisplayButtons();

end
WeakAuras.setAll = setAll

local function hiddenAll(data, info)
  if(#data.controlledChildren == 0 and info[1] ~= "group") then
    return true;
  end
  for index, childId in ipairs(data.controlledChildren) do
    local childData = WeakAuras.GetData(childId);
    if(childData) then
      WeakAuras.EnsureOptions(childId);
      local childOptions = displayOptions[childId];
      local childOption = childOptions;
      local childOptionTable = {[0] = childOption};
      for i=1,#info do
        childOption = childOption.args[info[i]];
        childOptionTable[i] = childOption;
      end
      if (childOption) then
        if (not hiddenChild(childOptionTable, info)) then
          return false;
        end
      end
    end
  end

  return true;
end



local function disabledAll(data, info)
  for index, childId in ipairs(data.controlledChildren) do
    local childData = WeakAuras.GetData(childId);
    if(childData) then
      WeakAuras.EnsureOptions(childId);
      local childOptions = displayOptions[childId];
      local childOption = childOptions;
      local childOptionTable = {[0] = childOption};
      for i=1,#info do
        childOption = childOption.args[info[i]];
        childOptionTable[i] = childOption;
      end
      if (childOption) then
        if (not disabledChild(childOptionTable, info)) then
          return false;
        end
      end
    end
  end

  return true;
end

local function getChildOption(displayOptions, info)
  for i=1,#info do
    displayOptions = displayOptions.args[info[i]];
    if not(displayOptions) then
      return nil;
    end

    if (displayOptions.hidden) then
      local type = type(displayOptions.hidden);
      if (type == "bool") then
        if (displayOptions.hidden) then
          return nil;
        end
      elseif (type == "function") then
        if (displayOptions.hidden(info)) then
          return nil;
        end
      end
    end

  end
  return displayOptions
end

local function replaceNameDescFuncs(intable, data)

  local function compareTables(tableA, tableB)
    if(#tableA == #tableB) then
      for j=1,#tableA do
        if(type(tableA[j]) == "number" and type(tableB[j]) == "number") then
          if((math.floor(tableA[j] * 100) / 100) ~= (math.floor(tableB[j] * 100) / 100)) then
            return false;
          end
        else
          if(tableA[j] ~= tableB[j]) then
            return false;
          end
        end
      end
    else
      return false;
    end
    return true;
  end

  local function getValueFor(displayOptions, info, key)
    local childOptionTable = {[0] = displayOptions};
    for i=1,#info do
      displayOptions = displayOptions.args[info[i]];
      if (not displayOptions) then
        return nil;
      end
      childOptionTable[i] = displayOptions;
    end

    if (hiddenChild(childOptionTable, info)) then
      return nil;
    end

    for i=#childOptionTable,0,-1 do
      if(childOptionTable[i][key]) then
        return childOptionTable[i][key];
      end
    end
    return nil;
  end

  local function combineKeys(info)
    local combinedKeys = nil;
    for index, childId in ipairs(data.controlledChildren) do
      local childData = WeakAuras.GetData(childId);
      if(childData) then
        WeakAuras.EnsureOptions(childId);

        local values = getValueFor(displayOptions[childId], info, "values");
        if (values) then
          if (type(values) == "function") then
            values = values(info);
          end
          if (type(values) == "table") then
            combinedKeys = combinedKeys or {};
            for k, v in pairs(values) do
              combinedKeys[k] = v;
            end
          end
        end
      end
    end
    return combinedKeys;
  end

  local function regionPrefix(input)
    local index = string.find(input, ".", 1, true);
    if (index) then
      local regionType = string.sub(input, 1, index - 1);
      return regionOptions[regionType] and regionType;
    end
    return nil;
  end

  local function sameAll(info)
    local combinedValues = {};
    local first = true;
    local combinedKeys = combineKeys(info);

    for index, childId in ipairs(data.controlledChildren) do
      local childData = WeakAuras.GetData(childId);

      local regionType = regionPrefix(info[#info]);
      if(childData and (not regionType or childData.regionType == regionType)) then
        WeakAuras.EnsureOptions(childId);
        local childOptions = displayOptions[childId];

        local get = getValueFor(displayOptions[childId], info, "get");
        if (combinedKeys) then
          for key, _ in pairs(combinedKeys) do
            local values = {};
            if (get) then
              values = { get(info, key) };
            end
            if (combinedValues[key] == nil) then
              combinedValues[key] = values;
            else
              if (not compareTables(combinedValues[key], values)) then
                return nil;
              end
            end
          end
        else
          local values = {};
          if (get) then
            values = { get(info) };
          end
          if(first) then
            combinedValues = values;
            first = false;
          else
            if (not compareTables(combinedValues, values)) then
              return nil;
            end
          end
        end
      end
    end

    return true;
  end

  local function nameAll(info)
    local combinedName;
    local first = true;
    for index, childId in ipairs(data.controlledChildren) do
      local childData = WeakAuras.GetData(childId);
      if(childData) then
        WeakAuras.EnsureOptions(childId);
        local childOption = getChildOption(displayOptions[childId], info);
        if (childOption) then
          local name;
          if(type(childOption.name) == "function") then
            name = childOption.name(info);
          else
            name = childOption.name;
          end
          if(first) then
            combinedName = name;
            first = false;
          elseif not(combinedName == name) then
            return childOption.name("default");
          end
        end
      end
    end

    return combinedName;
  end

  local function descAll(info)
    local combinedDesc;
    local first = true;
    for index, childId in ipairs(data.controlledChildren) do
      local childData = WeakAuras.GetData(childId);
      if(childData) then
        WeakAuras.EnsureOptions(childId);
        local childOption = getChildOption(displayOptions[childId], info);
        if (childOption) then
          local desc;
          if(type(childOption.desc) == "function") then
            desc = childOption.desc(info);
          else
            desc = childOption.desc;
          end
          if(first) then
            combinedDesc = desc;
            first = false;
          elseif not(combinedDesc == desc) then
            return L["Not all children have the same value for this option"];
          end
        end
      end
    end
    return combinedDesc;
  end

  local function recurse(intable)
    for i,v in pairs(intable) do
      if(i == "name" and type(v) ~= "table") then
        intable.name = function(info)
          local name = nameAll(info);
          if(sameAll(info)) then
            return name;
          else
            if(name == "") then
              return name;
            else
              return "|cFF4080FF"..(name or "error");
            end
          end
        end
        intable.desc = function(info)
          if(sameAll(info)) then
            return descAll(info);
          else
            local combinedKeys = nil;
            if (intable.type == "multiselect") then
              combinedKeys = combineKeys(info)
            end

            local values = {};
            for index, childId in ipairs(data.controlledChildren) do
              local childData = WeakAuras.GetData(childId);
              if(childData) then
                WeakAuras.EnsureOptions(childId);
                local childOptions = displayOptions[childId];
                local childOption = childOptions;
                local childOptionTable = {[0] = childOption};
                for i=1,#info do
                  childOption = childOption.args[info[i]];
                  childOptionTable[i] = childOption;
                end
                if (childOption and not hiddenChild(childOptionTable, info)) then
                  for i=#childOptionTable,0,-1 do
                    if(childOptionTable[i].get) then
                      if(intable.type == "toggle") then
                        local name, tri;
                        if(type(childOption.name) == "function") then
                          name = childOption.name(info);
                          tri = true;
                        else
                          name = childOption.name;
                        end
                        if(tri and childOptionTable[i].get(info)) then
                          tinsert(values, "|cFFE0E000"..childId..": |r"..name);
                        elseif(tri) then
                          tinsert(values, "|cFFE0E000"..childId..": |r"..L["Ignored"]);
                        elseif(childOptionTable[i].get(info)) then
                          tinsert(values, "|cFFE0E000"..childId..": |r|cFF00FF00"..L["Enabled"]);
                        else
                          tinsert(values, "|cFFE0E000"..childId..": |r|cFFFF0000"..L["Disabled"]);
                        end
                      elseif(intable.type == "color") then
                        local r, g, b = childOptionTable[i].get(info);
                        r, g, b = r or 1, g or 1, b or 1;
                        tinsert(values, ("|cFF%2x%2x%2x%s"):format(r * 220 + 35, g * 220 + 35, b * 220 + 35, childId));
                      elseif(intable.type == "select") then
                        local selectValues = type(intable.values) == "table" and intable.values or intable.values(info);
                        local key = childOptionTable[i].get(info);
                        local display = key and selectValues[key] or L["None"];
                        tinsert(values, "|cFFE0E000"..childId..": |r"..display);
                      elseif(intable.type == "multiselect") then
                        local selectedValues = "";
                        for k, v in pairs(combinedKeys) do
                          if (childOptionTable[i].get(info, k)) then
                            if (not selectedValues) then
                              selectedValues = tostring(v);
                            else
                              selectedValues = selectedValues .. ", " .. tostring(v);
                            end
                          end
                        end
                        tinsert(values, "|cFFE0E000"..childId..": |r"..selectedValues);
                      else
                        local display = childOptionTable[i].get(info) or L["None"];
                        if(type(display) == "number") then
                          display = math.floor(display * 100) / 100;
                        end
                        tinsert(values, "|cFFE0E000"..childId..": |r"..display);
                      end
                      break;
                    end
                  end
                end
              end
            end
            return table.concat(values, "\n");
          end
        end
      elseif(type(v) == "table" and i ~= "values") then
        recurse(v);
      end
    end
  end
  recurse(intable);
end

local function replaceImageFuncs(intable, data)
  local function imageAll(info)
    local combinedImage = {};
    local first = true;
    for index, childId in ipairs(data.controlledChildren) do
      local childData = WeakAuras.GetData(childId);
      if(childData) then
        WeakAuras.EnsureOptions(childId);
        local childOption = displayOptions[childId];
        if not(childOption) then
          return "error"
        end
        childOption = getChildOption(childOption, info);
        if childOption and childOption.image then
          local image = {childOption.image(info)};
          if(first) then
            combinedImage = image;
            first = false;
          else
            if not(combinedImage[1] == image[1]) then
              return "", 0, 0;
            end
          end
        end
      end
    end

    return unpack(combinedImage);
  end

  local function recurse(intable)
    for i,v in pairs(intable) do
      if(i == "image" and type(v) == "function") then
        intable[i] = imageAll;
      elseif(type(v) == "table" and i ~= "values") then
        recurse(v);
      end
    end
  end
  recurse(intable);
end

local function replaceValuesFuncs(intable, data)
  local function valuesAll(info)
    local combinedValues = {};
    local handledValues = {};
    local first = true;
    for index, childId in ipairs(data.controlledChildren) do
      local childData = WeakAuras.GetData(childId);
      if(childData) then
        WeakAuras.EnsureOptions(childId);
        local childOption = displayOptions[childId];
        if not(childOption) then
          return "error"
        end

        childOption = getChildOption(childOption, info);
        if (childOption) then
          local values = childOption.values(info);
          if(first) then
            for k, v in pairs(values) do
              handledValues[k] = handledValues[k] or {};
              handledValues[k][v] = true;
              combinedValues[k] = v;
            end
            first = false;
          else
            for k, v in pairs(values) do
              if (handledValues[k] and handledValues[k][v]) then
              -- Already known key/value pair
              else
                if (combinedValues[k]) then
                  combinedValues[k] = combinedValues[k] .. "/" .. v;
                else
                  combinedValues[k] = v;
                end
                handledValues[k] = handledValues[k] or {};
                handledValues[k][v] = true;
              end
            end
          end
        end
      end
    end

    return combinedValues;
  end

  local function recurse(intable)
    for i,v in pairs(intable) do
      if(i == "values" and type(v) == "function") then
        intable[i] = valuesAll;
      elseif(type(v) == "table" and i ~= "values") then
        recurse(v);
      end
    end
  end
  recurse(intable);
end

local function GetCustomCode(data, path)
  for _, key in ipairs(path) do
    if (not data or not data[key]) then
      return nil;
    end
    data = data[key];
  end
  return data;
end

function WeakAuras.AddCodeOption(args, data, name, prefix, order, hiddenFunc, path, encloseInFunction, multipath, extraSetFunction, extraFunctions, reloadOptions)
  extraFunctions = extraFunctions or {};
  tinsert(extraFunctions, 1, {
    buttonLabel = L["Expand"],
    func = function()
      WeakAuras.OpenTextEditor(data, path, encloseInFunction, multipath, reloadOptions)
    end
  });

  args[prefix .. "_custom"] = {
    type = "input",
    width = "double",
    name = name,
    order = order,
    multiline = true,
    hidden = hiddenFunc,
    control = "WeakAurasMultiLineEditBox",
    arg = {
      extraFunctions = extraFunctions,
    },
    set = function(info, v)
      local subdata = data;
      for i = 1, #path -1 do
        local key = path[i];
        subdata[key] = subdata[key] or {};
        subdata = subdata[key];
      end

      subdata[path[#path]] = v;
      WeakAuras.Add(data);
      if (extraSetFunction) then
        extraSetFunction();
      end
      if (reloadOptions) then
        WeakAuras.ScheduleReloadOptions(data);
      end
    end,
    get = function(info)
      return GetCustomCode(data, path);
    end
  };

  args[prefix .. "_customError"] = {
    type = "description",
    name = function()
      if hiddenFunc() then
        return "";
      end

      local code = GetCustomCode(data, path);

      if (not code) then
        return ""
      end

      if (encloseInFunction) then
        code = "function() "..code.."\n end";
      end

      code = "return " .. code;

      local _, errorString = loadstring(code);
      return errorString and "|cFFFF0000"..errorString or "";
    end,
    width = "double",
    order = order + 0.002,
    hidden = function()
      if (hiddenFunc()) then
        return true;
      end

      local code = GetCustomCode(data, path);
      if (not code) then
        return true;
      end

      if (encloseInFunction) then
        code = "function() "..code.."\n end";
      end

      code = "return " .. code;

      local loadedFunction, errorString = loadstring(code);
      if(errorString and not loadedFunction) then
        return false;
      else
        return true;
      end
    end
  };
end

local function copyOptionTable(input, orderAdjustment)
  local resultOption = {};
  WeakAuras.DeepCopy(input, resultOption);
  resultOption.order = orderAdjustment + resultOption.order;
  return resultOption;
end

local function flattenRegionOptions(allOptions, withoutHeader)
  local result = {};

  local base = 100;

  for regionType, options in pairs(allOptions) do
    if (regionType ~= "border" and regionType ~= "position") then
      for optionName, option in pairs(options) do
        result[regionType .. "." .. optionName] = copyOptionTable(option, base);
      end

      base = base + 100;
    end
  end

  if (allOptions["border"]) then
    for optionName, option in pairs(allOptions["border"]) do
      result["border." .. optionName] = copyOptionTable(option, base);
    end
    base = base + 100;
  end

  if (allOptions["position"]) then
    for optionName, option in pairs(allOptions["position"]) do
      result["position." .. optionName] = copyOptionTable(option, base);
    end
  end

  return result;
end

local function addHeadersForRegionOptions(allOptions, output)
  local base = 100;
  for regionType, options in pairs(allOptions) do
    if (regionType ~= "border" and regionType ~= "position") then
      if (base > 100) then
        output[regionType .. "_spacer"] = {
          type = "description",
          name = " ",
          width = "double",
          fontSize = "large",
          order = base,
          hidden = false
        }
      end
      output[regionType .. "_title"] = {
        type = "description",
        name = regionOptions[regionType].displayName,
        width = "double",
        order = base + 0.01,
        fontSize = "large",
        hidden = false
      }
      output[regionType .. "_title_header"] = {
        type = "header",
        name = "",
        width = "double",
        order = base + 0.02,
        hidden = false
      }
      base = base + 100;
    end
  end

  output["common_spacer"] = {
    type = "description",
    name = " ",
    width = "double",
    fontSize = "large",
    order = base,
    hidden = false
  }

  output["common_title"] = {
    type = "description",
    name = L["Common Options"],
    width = "double",
    order = base + 0.01,
    fontSize = "large",
    hidden = false
  }
end

local function removePrefix(input)
  local index = string.find(input, ".", 1, true);
  if (index) then
    return string.sub(input, index + 1);
  end
  return input;
end

function WeakAuras.AddOption(id, data)
  local regionOption;
  if(regionOptions[data.regionType]) then
    regionOption = regionOptions[data.regionType].create(id, data);
  else
    regionOption = {
      [data.regionType] = {
        unsupported = {
          type = "description",
          name = L["This region of type \"%s\" is not supported."]:format(data.regionType)
        }
      }
    };
  end

  displayOptions[id] = {
    type = "group",
    childGroups = "tab",
    args = {
      region = {
        type = "group",
        name = L["Display"],
        order = 10,
        get = function(info)
          local property = removePrefix(info[#info]);
          if(info.type == "color") then
            data[property] = data[property] or {};
            local c = data[property];
            return c[1], c[2], c[3], c[4];
          else
            return data[property];
          end
        end,
        set = function(info, v, g, b, a)
          local property = removePrefix(info[#info]);
          if(info.type == "color") then
            data[property] = data[property] or {};
            local c = data[property];
            c[1], c[2], c[3], c[4] = v, g, b, a;
          elseif(info.type == "toggle") then
            data[property] = v;
          else
            data[property] = (v ~= "" and v) or nil;
          end
          WeakAuras.Add(data);
          WeakAuras.SetThumbnail(data);
          WeakAuras.SetIconNames(data);
          if(data.parent) then
            local parentData = WeakAuras.GetData(data.parent);
            if(parentData) then
              WeakAuras.Add(parentData);
              WeakAuras.SetThumbnail(parentData);
            end
          end
          WeakAuras.ResetMoverSizer();
        end,
        args = flattenRegionOptions(regionOption, false);
      },
      trigger = {
        type = "group",
        name = L["Trigger"],
        order = 20,
        args = {}
      },
      conditions = {
        type = "group",
        name = L["Conditions"],
        order = 25,
        args = {}
      },
      load = {
        type = "group",
        name = L["Load"],
        order = 30,
        get = function(info) return data.load[info[#info]] end,
        set = function(info, v)
          data.load[info[#info]] = (v ~= "" and v) or nil;
          WeakAuras.Add(data);
          WeakAuras.SetThumbnail(data);
          WeakAuras.ScanForLoads();
          WeakAuras.SortDisplayButtons();
        end,
        args = {}
      },
    }
  };

  displayOptions[id].args.action = WeakAuras.AddActionOption(id, data);
  displayOptions[id].args.animation = WeakAuras.AddAnimationOption(id, data);

  WeakAuras.ReloadTriggerOptions(data);
end

-- This is a hack...
-- Some options change which options are available, for example toggling the "inverse"
-- option of some triggers changes whether "remaining time" is available in the Conditions
-- We can't call ReloadOptions from the set call, since that removes the widgets immediately
-- which AceConfig doesn't like.
-- Thus Reload the options after a very small delay.
function WeakAuras.ScheduleReloadOptions(data)
  C_Timer.After(0.1, function()
    WeakAuras.ReloadOptions(data.id)
  end );
end

function WeakAuras.ReloadOptions(id)
  displayOptions[id] = nil;
  WeakAuras.EnsureOptions(id);
  WeakAuras.FillOptions(id)
end

function WeakAuras.EnsureOptions(id)
  if not(displayOptions[id]) then
    WeakAuras.AddOption(id, WeakAuras.GetData(id));
  end
end

function WeakAuras.GetSpellTooltipText(id)
  local tooltip = WeakAuras.GetHiddenTooltip();
  tooltip:SetSpellByID(id);
  local lines = { tooltip:GetRegions() };
  local i = 1;
  local tooltipText = "";
  while(lines[i]) do
    if(lines[i]:GetObjectType() == "FontString") then
      if(lines[i]:GetText()) then
        if(tooltipText == "") then
          tooltipText = lines[i]:GetText();
        else
          tooltipText = tooltipText.." - "..lines[i]:GetText();
        end
      end
    end
    i = i + 1;
  end
  tooltipText = tooltipText or L["No tooltip text"];
  return tooltipText;
end

function WeakAuras.DeleteConditionsForTrigger(data, triggernum)
  for _, condition in ipairs(data.conditions) do
    if (condition.trigger == triggernum) then
      condition.trigger = nil;
    end

    if (condition.trigger and condition.trigger > triggernum) then
      condition.trigger = condition.trigger - 1;
    end
  end
end

function WeakAuras.ReloadTriggerOptions(data)
  local id = data.id;
  local iconCache = spellCache.Get();
  WeakAuras.EnsureOptions(id);

  local trigger, untrigger, appendToTriggerPath, appendToUntriggerPath;
  if(data.controlledChildren) then
    optionTriggerChoices[id] = nil;
    for index, childId in pairs(data.controlledChildren) do
      if not(optionTriggerChoices[id]) then
        optionTriggerChoices[id] = optionTriggerChoices[childId];
        trigger = WeakAuras.GetData(childId).trigger;
        untrigger = WeakAuras.GetData(childId).untrigger;
      else
        if(optionTriggerChoices[id] ~= optionTriggerChoices[childId]) then
          trigger, untrigger = {}, {};
          optionTriggerChoices[id] = -1;
          break;
        end
      end
    end

    optionTriggerChoices[id] = optionTriggerChoices[id] or 0;

    local commonOptionTriggerChoice = optionTriggerChoices[id] >= 0 and optionTriggerChoices[id];
    for index, childId in pairs(data.controlledChildren) do
      local childData = WeakAuras.GetData(childId);
      if(childData) then
        optionTriggerChoices[childId] = commonOptionTriggerChoice or optionTriggerChoices[childId] or 0;
        WeakAuras.ReloadTriggerOptions(childData);
      end
    end
  else
    optionTriggerChoices[id] = optionTriggerChoices[id] or 0;
    if(optionTriggerChoices[id] == 0) then
      trigger = data.trigger;
      untrigger = data.untrigger;
    else
      trigger = data.additional_triggers and data.additional_triggers[optionTriggerChoices[id]].trigger or data.trigger;
      untrigger = data.additional_triggers and data.additional_triggers[optionTriggerChoices[id]].untrigger or data.untrigger;
    end
  end

  local function deleteTrigger()
    if(data.controlledChildren) then
      for index, childId in pairs(data.controlledChildren) do
        local childData = WeakAuras.GetData(childId);
        if(childData) then
          if (optionTriggerChoices[childId] == 0) then
            childData.trigger = childData.additional_triggers[1].trigger;
            childData.untrigger = childData.additional_triggers[1].untrigger;
            tremove(childData.additional_triggers, 1);
          else
            tremove(childData.additional_triggers, optionTriggerChoices[childId]);
            optionTriggerChoices[childId] = optionTriggerChoices[childId] - 1;
          end

          WeakAuras.DeleteConditionsForTrigger(childData, optionTriggerChoices[childId]);

          childData.numTriggers = 1 + (childData.additional_triggers and #childData.additional_triggers or 0)
          WeakAuras.ReloadTriggerOptions(childData);
        end
      end
    else
      if (optionTriggerChoices[id] == 0) then
        data.trigger = data.additional_triggers[1].trigger;
        data.untrigger = data.additional_triggers[1].untrigger;
        tremove(data.additional_triggers, 1);
      else
        tremove(data.additional_triggers, optionTriggerChoices[id]);
        optionTriggerChoices[id] = optionTriggerChoices[id] - 1;
      end

      WeakAuras.DeleteConditionsForTrigger(data, optionTriggerChoices[id]);

      data.numTriggers = 1 + (data.additional_triggers and #data.additional_triggers or 0)
    end
    WeakAuras.Add(data);
    WeakAuras.ReloadTriggerOptions(data);
  end

  local function moveTriggerDownImpl(data, i)
    if (i < 0 or i + 1 >= data.numTriggers) then
      return false;
    end

    if (i == 0) then
      local tmp = data.additional_triggers[1];
      tremove(data.additional_triggers, 1);
      tinsert(data.additional_triggers, 1, {
        trigger = data.trigger,
        untrigger = data.untrigger
      });
      data.trigger = tmp.trigger;
      data.untrigger = tmp.untrigger;
    else
      local tmp = data.additional_triggers[i + 1];
      tremove(data.additional_triggers, i + 1);
      tinsert(data.additional_triggers, i, tmp);
    end

    for _, condition in ipairs(data.conditions) do
      if (condition.check.trigger == i) then
        condition.check.trigger = i + 1;
      elseif (condition.check.trigger == i  + 1) then
        condition.check.trigger = i;
      end
    end

    return true;
  end

  local function moveTriggerDown(data, i)
    if (moveTriggerDownImpl(data, i)) then
      optionTriggerChoices[data.id] = optionTriggerChoices[data.id] + 1;
      WeakAuras.Add(data);
      WeakAuras.ReloadTriggerOptions(data);
    end
  end

  local function moveTriggerUp(data, i)
    if (moveTriggerDownImpl(data, i - 1)) then
      optionTriggerChoices[data.id] = optionTriggerChoices[data.id] - 1;
      WeakAuras.Add(data);
      WeakAuras.ReloadTriggerOptions(data);
    end
  end


  local chooseTriggerWidth = 1.2;
  if (data.controlledChildren) then
    local hasMultipleTriggers = false;
    for index, id in pairs(data.controlledChildren) do
      local childData = WeakAuras.GetData(id);
      if (childData.numTriggers ~=1) then
        hasMultipleTriggers = true;
        break;
      end
    end
    if (not hasMultipleTriggers) then
      chooseTriggerWidth = chooseTriggerWidth + 0.45;
    end
  else
    if (data.numTriggers == 1) then
      chooseTriggerWidth = chooseTriggerWidth + 0.45;
    end
  end

  if (GetAddOnEnableState(UnitName("player"), "WeakAurasTemplates") == 0) then
    chooseTriggerWidth = chooseTriggerWidth + 0.15;
  end

  local trigger_options = {
    disjunctive = {
      type = "select",
      name = L["Required for Activation"],
      width = "double",
      order = 0,
      values = function()
        if (data.additional_triggers and #data.additional_triggers > 0) then
          return WeakAuras.trigger_require_types;
        end
        return  WeakAuras.trigger_require_types_one;
      end,
      get = function()
        if (data.additional_triggers and #data.additional_triggers > 0) then
          return data.disjunctive or "all";
        else
          return (data.disjunctive and data.disjunctive ~= "all") and data.disjunctive or "any";
        end
      end,
      set = function(info, v)
        data.disjunctive = v;
        WeakAuras.Add(data);
      end
    },
    -- custom trigger combiner text editor added below
    activeTriggerMode = {
      type = "select",
      name = L["Dynamic Information"],
      width = "double",
      order = 0.3,
      values = function()
        local vals = {};
        vals[WeakAuras.trigger_modes.first_active] = L["Dynamic information from first active trigger"];
        local numTriggers = data.additional_triggers and #data.additional_triggers or 0;
        for i=0,numTriggers do
          vals[i] = L["Dynamic information from Trigger %i"]:format(i + 1);
        end
        return vals;
      end,
      get = function()
        return data.activeTriggerMode or WeakAuras.trigger_modes.first_active;
      end,
      set = function(info, v)
        data.activeTriggerMode = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.SetIconNames(data);
        WeakAuras.UpdateDisplayButton(data);
      end,
      hidden = function() return data.numTriggers <= 1 end
    },
    chooseTrigger = {
      type = "select",
      name = L["Choose Trigger"],
      order = 0.5,
      values = function()
        local ret = {[0] = L["Trigger %d"]:format(1)};
        if(data.controlledChildren) then
          for index=1,(data.numTriggers and data.numTriggers + 1 or 9) do
            local all, none, any = true, true, false;
            for _, childId in pairs(data.controlledChildren) do
              local childData = WeakAuras.GetData(childId);
              if(childData) then
                none = false;
                if(childData.additional_triggers and childData.additional_triggers[index]) then
                  any = true;
                else
                  all = false;
                end
              end
            end
            if not(none) then
              if(all) then
                ret[index] = L["Trigger %d"]:format(index + 1);
              elseif(any) then
                ret[index] = "|cFF777777"..L["Trigger %d"]:format(index + 1);
              end
            end
          end
        elseif(data.additional_triggers) then
          for index, trigger in pairs(data.additional_triggers) do
            ret[index] = L["Trigger %d"]:format(index + 1);
          end
        end
        return ret;
      end,
      get = function() return optionTriggerChoices[id]; end,
      set = function(info, v)
        if(v == 0 or (data.additional_triggers and data.additional_triggers[v])) then
          optionTriggerChoices[id] = v;
          WeakAuras.ReloadTriggerOptions(data);
        end
      end,
      width = chooseTriggerWidth
    },
    chooseTriggerSpace = {
      type = "description",
      name = "",
      order = 0.75,
      width = 0.04
    },
    addTrigger = {
      type = "execute",
      name = "",
      desc = L["Add Trigger"],
      order = 1,
      func = function()
        if(data.controlledChildren) then
          for index, childId in pairs(data.controlledChildren) do
            local childData = WeakAuras.GetData(childId);
            if(childData) then
              childData.additional_triggers = childData.additional_triggers or {};
              tinsert(childData.additional_triggers, {trigger = {}, untrigger = {}});
              childData.numTriggers = 1 + (childData.additional_triggers and #childData.additional_triggers or 0)
              optionTriggerChoices[childId] = #childData.additional_triggers;
              WeakAuras.ReloadTriggerOptions(childData);
            end
          end
        else
          data.additional_triggers = data.additional_triggers or {};
          tinsert(data.additional_triggers, {trigger = {}, untrigger = {}});
          data.numTriggers = 1 + (data.additional_triggers and #data.additional_triggers or 0)
          optionTriggerChoices[id] = #data.additional_triggers;
        end
        WeakAuras.ReloadTriggerOptions(data);
      end,
      width = 0.15,
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\add",
      imageWidth = 24,
      imageHeight = 24
    },
    deleteTrigger = {
      type = "execute",
      name = "",
      desc = L["Delete Trigger"],
      order = 1.1,
      func = deleteTrigger,
      hidden = function()
        return data.numTriggers == 1
      end,
      width = 0.15,
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\delete",
      imageWidth = 24,
      imageHeight = 24
    },
    triggerUp = {
      type = "execute",
      name = "",
      desc = L["Up"],
      order = 1.2,
      func = function()
        if(data.controlledChildren) then
          for index, childId in pairs(data.controlledChildren) do
            local childData = WeakAuras.GetData(childId);
            moveTriggerUp(childData, optionTriggerChoices[childId])
          end
          WeakAuras.Add(data);
          WeakAuras.ReloadTriggerOptions(data);
        else
          moveTriggerUp(data, optionTriggerChoices[id])
        end
      end,
      disabled = function()
        if(data.controlledChildren) then
          for index, childId in pairs(data.controlledChildren) do
            local childData = WeakAuras.GetData(childId);
            if(childData) then
              if (optionTriggerChoices[childId] ~= 0) then
                return false;
              end
            end
          end
          return true;
        else
          if (optionTriggerChoices[id] == 0) then
            return true;
          else
            return false;
          end
        end
      end,
      hidden = function()
        return data.numTriggers == 1
      end,
      width = 0.15,
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\moveup",
      imageWidth = 24,
      imageHeight = 24
    },
    triggerDown = {
      type = "execute",
      name = "",
      desc = L["Down"],
      order = 1.3,
      func = function()
        if(data.controlledChildren) then
          for index, childId in pairs(data.controlledChildren) do
            local childData = WeakAuras.GetData(childId);
            moveTriggerDown(childData, optionTriggerChoices[childId]);
          end
          WeakAuras.Add(data);
          WeakAuras.ReloadTriggerOptions(data);
        else
          moveTriggerDown(data, optionTriggerChoices[id]);
        end
      end,
      disabled = function()
        if(data.controlledChildren) then
          for index, childId in pairs(data.controlledChildren) do
            local childData = WeakAuras.GetData(childId);
            if(childData) then
              if (optionTriggerChoices[childId] ~= childData.numTriggers -1) then
                return false;
              end
            end
          end
          return true;
        else
          if (optionTriggerChoices[id] == data.numTriggers - 1) then
            return true;
          else
            return false;
          end
        end
      end,
      hidden = function()
        return data.numTriggers == 1
      end,
      width = 0.15,
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\movedown",
      imageWidth = 24,
      imageHeight = 24
    },
    applyTemplate = {
      type = "execute",
      name = "",
      desc = L["Apply Template"],
      order = 1.4,
      func = function()
        WeakAuras.OpenTriggerTemplate(data);
      end,
      hidden = function()
        return GetAddOnEnableState(UnitName("player"), "WeakAurasTemplates") == 0
      end,
      width = 0.15,
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\template",
      imageWidth = 24,
      imageHeight = 24
    },
    triggerHeader = {
      type = "header",
      name = function(info)
        if(info == "default") then
          return L["Multiple Triggers"];
        else
          if(optionTriggerChoices[id] == 0) then
            return L["Trigger %d"]:format(1);
          else
            return L["Trigger %d"]:format(optionTriggerChoices[id] + 1);
          end
        end
      end,
      order = 2
    },
    typedesc = {
      type = "toggle",
      name = L["Type"],
      order = 5,
      disabled = true,
      get = function() return true end
    },
    type = {
      type = "select",
      name = L["Type"],
      desc = L["The type of trigger"],
      order = 6,
      values = trigger_types,
      set = function(info, v)
        trigger.type = v;
        if(trigger.event) then
          local prototype = WeakAuras.event_prototypes[trigger.event];
          if(prototype) then
            if(v == "status" and prototype.type == "event") then
              trigger.event = "Health";
            elseif(v == "event" and prototype.type == "status") then
              trigger.event = "Chat Message";
            end
          end
        end
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.SetIconNames(data);
        WeakAuras.UpdateDisplayButton(data);
        WeakAuras.ReloadTriggerOptions(data);
      end
    },
  };

  local function hideTriggerCombiner()
    return not (data.disjunctive == "custom")
  end
  WeakAuras.AddCodeOption(trigger_options, data, L["Custom"], "custom_trigger_combination", 0.1, hideTriggerCombiner, {"customTriggerLogic"}, false);

  trigger_options = union(trigger_options, WeakAuras.GetGenericTriggerOptions(data, trigger, untrigger));

  local order = 81;

  if(data.controlledChildren) then
    local function options_set(info, ...)
      setAll(data, info, ...);
      WeakAuras.Add(data);
      WeakAuras.SetThumbnail(data);
      WeakAuras.SetIconNames(data);
      WeakAuras.UpdateDisplayButton(data);
      WeakAuras.ReloadTriggerOptions(data);
    end

    removeFuncs(displayOptions[id]);

    if(optionTriggerChoices[id] >= 0 and getAll(data, {"trigger", "type"}) == "aura") then
      local aura_options = WeakAuras.GetBuffTriggerOptions(data, trigger);
      displayOptions[id].args.trigger.args = union(trigger_options, aura_options);
      removeFuncs(displayOptions[id].args.trigger);
      displayOptions[id].args.trigger.args.type.set = options_set;
    elseif(optionTriggerChoices[id] >= 0 and (getAll(data, {"trigger", "type"}) == "event" or getAll(data, {"trigger", "type"}) == "status")) then
      local event = getAll(data, {"trigger", "event"});
      local unevent = getAll(data, {"trigger", "unevent"});
      if(event and WeakAuras.event_prototypes[event]) then
        local trigger_options_created;
        if(event == "Combat Log") then
          local subeventPrefix = getAll(data, {"trigger", "subeventPrefix"});
          local subeventSuffix = getAll(data, {"trigger", "subeventSuffix"});
          if(subeventPrefix and subeventSuffix) then
            trigger_options_created = true;
            displayOptions[id].args.trigger.args = union(trigger_options, WeakAuras.ConstructOptions(WeakAuras.event_prototypes[event], data, 10, subeventPrefix, subeventSuffix, optionTriggerChoices[id], nil, unevent));
          end
        end

        if not(trigger_options_created) then
          displayOptions[id].args.trigger.args = union(trigger_options, WeakAuras.ConstructOptions(WeakAuras.event_prototypes[event], data, 10, nil, nil, optionTriggerChoices[id], nil, unevent));
        end
      else
        displayOptions[id].args.trigger.args = union(trigger_options, {});
        removeFuncs(displayOptions[id].args.trigger);
      end
      removeFuncs(displayOptions[id].args.trigger);
      replaceNameDescFuncs(displayOptions[id].args.trigger, data);
      replaceImageFuncs(displayOptions[id].args.trigger, data);
      replaceValuesFuncs(displayOptions[id].args.trigger, data);

      if(displayOptions[id].args.trigger.args.unevent) then
        displayOptions[id].args.trigger.args.unevent.set = options_set;
      end
      if(displayOptions[id].args.trigger.args.subeventPrefix) then
        displayOptions[id].args.trigger.args.subeventPrefix.set = function(info, v)
          if not(subevent_actual_prefix_types[v]) then
            data.trigger.subeventSuffix = "";
          end
          options_set(info, v);
        end
      end
      if(displayOptions[id].args.trigger.args.subeventSuffix) then
        displayOptions[id].args.trigger.args.subeventSuffix.set = options_set;
      end

      if(displayOptions[id].args.trigger.args.type) then
        displayOptions[id].args.trigger.args.type.set = options_set;
      end
      if(displayOptions[id].args.trigger.args.event) then
        displayOptions[id].args.trigger.args.event.set = options_set;
      end
    else
      displayOptions[id].args.trigger.args = trigger_options;
      removeFuncs(displayOptions[id].args.trigger);
    end

    displayOptions[id].get = function(info, ...) return getAll(data, info, ...); end;
    displayOptions[id].set = function(info, ...)
      setAll(data, info, ...);
      if(type(id) == "string") then
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
      end
    end
    displayOptions[id].hidden = function(info, ...) return hiddenAll(data, info, ...); end;
    displayOptions[id].disabled = function(info, ...) return disabledAll(data, info, ...); end;

    displayOptions[id].args.trigger.args.chooseTrigger.set = options_set;
    displayOptions[id].args.trigger.args.type.set = options_set;
    if (displayOptions[id].args.trigger.args.event) then
      displayOptions[id].args.trigger.args.event.set = options_set;
    end

    replaceNameDescFuncs(displayOptions[id], data);
    replaceImageFuncs(displayOptions[id], data);
    replaceValuesFuncs(displayOptions[id], data);

    local regionOption;
    if (regionOptions[data.regionType]) then
      regionOption = regionOptions[data.regionType].create(id, data);
    else
      regionOption = {
        [data.regionType] = {
          unsupported = {
            type = "description",
            name = L["This region of type \"%s\" is not supported."]:format(data.regionType)
          }
        };
      };
    end
    displayOptions[id].args.group = {
      type = "group",
      name = L["Group"],
      order = 0,
      get = function(info)
        local property = removePrefix(info[#info]);
        if(info.type == "color") then
          data[property] = data[property] or {};
          local c = data[property];
          return c[1], c[2], c[3], c[4];
        else
          return data[property];
        end
      end,
      set = function(info, v, g, b, a)
        local property = removePrefix(info[#info]);
        if(info.type == "color") then
          data[property] = data[property] or {};
          local c = data[property];
          c[1], c[2], c[3], c[4] = v, g, b, a;
        elseif(info.type == "toggle") then
          data[property] = v;
        else
          data[property] = (v ~= "" and v) or nil;
        end
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.SetIconNames(data);
        WeakAuras.ResetMoverSizer();
      end,
      hidden = function() return false end,
      disabled = function() return false end,
      args = flattenRegionOptions(regionOption, true);
    };

    data.load.use_class = getAll(data, {"load", "use_class"});
    local single_class = getAll(data, {"load", "class"});
    data.load.class = {}
    data.load.class.single = single_class;

    displayOptions[id].args.load.args = WeakAuras.ConstructOptions(WeakAuras.load_prototype, data, 10, nil, nil, optionTriggerChoices[id], "load");
    removeFuncs(displayOptions[id].args.load);
    replaceNameDescFuncs(displayOptions[id].args.load, data);
    replaceImageFuncs(displayOptions[id].args.load, data);
    replaceValuesFuncs(displayOptions[id].args.load, data);

    WeakAuras.ReloadGroupRegionOptions(data);
  else -- One aura selected
    local function options_set(info, v)
      trigger[info[#info]] = v;
      WeakAuras.Add(data);
      WeakAuras.SetThumbnail(data);
      WeakAuras.SetIconNames(data);
      WeakAuras.UpdateDisplayButton(data);
      WeakAuras.ReloadTriggerOptions(data);
    end
    local triggernum = optionTriggerChoices[id];
    if(trigger.type == "aura") then
      local aura_options = WeakAuras.GetBuffTriggerOptions(data, trigger);
      displayOptions[id].args.trigger.args = union(trigger_options, aura_options);
    elseif(trigger.type == "event" or trigger.type == "status") then
      if(WeakAuras.event_prototypes[trigger.event]) then
        if(trigger.event == "Combat Log") then
          displayOptions[id].args.trigger.args = union(trigger_options, WeakAuras.ConstructOptions(WeakAuras.event_prototypes[trigger.event], data, 10, (trigger.subeventPrefix or ""), (trigger.subeventSuffix or ""), optionTriggerChoices[id]));
        else
          displayOptions[id].args.trigger.args = union(trigger_options, WeakAuras.ConstructOptions(WeakAuras.event_prototypes[trigger.event], data, 10, nil, nil, optionTriggerChoices[id]));
        end
        if(displayOptions[id].args.trigger.args.unevent) then
          displayOptions[id].args.trigger.args.unevent.set = options_set;
        end
        if(displayOptions[id].args.trigger.args.subeventPrefix) then
          displayOptions[id].args.trigger.args.subeventPrefix.set = function(info, v)
            if not(subevent_actual_prefix_types[v]) then
              trigger.subeventSuffix = "";
            end
            options_set(info, v);
          end
        end
        if(displayOptions[id].args.trigger.args.subeventSuffix) then
          displayOptions[id].args.trigger.args.subeventSuffix.set = options_set;
        end
      else
        print("|cFF8800FFWeakAuras|r: No prototype for", trigger.event);
        displayOptions[id].args.trigger.args = union(trigger_options, {});
      end
    else
      displayOptions[id].args.trigger.args = union(trigger_options, {});
    end

    displayOptions[id].args.load.args = WeakAuras.ConstructOptions(WeakAuras.load_prototype, data, 10, nil, nil, optionTriggerChoices[id], "load");

    if (displayOptions[id].args.trigger.args.event) then
      displayOptions[id].args.trigger.args.event.set = function(info, v, ...)
        local prototype = WeakAuras.event_prototypes[v];
        if(prototype) then
          if(prototype.automatic or prototype.automaticrequired) then
            trigger.unevent = "auto";
          else
            trigger.unevent = "timed";
          end
        end
        options_set(info, v, ...);
      end
    end
    trigger.event = trigger.event or "Health";
    trigger.subeventPrefix = trigger.subeventPrefix or "SPELL"
    trigger.subeventSuffix = trigger.subeventSuffix or "_CAST_START";

    displayOptions[id].args.trigger.get = function(info) return trigger[info[#info]] end;
    displayOptions[id].args.trigger.set = function(info, v)
      trigger[info[#info]] = (v ~= "" and v) or nil;
      WeakAuras.Add(data);
      WeakAuras.SetThumbnail(data);
      WeakAuras.SetIconNames(data);
      WeakAuras.UpdateDisplayButton(data);
    end;
  end

  displayOptions[id].args.conditions.args = {};
  -- We never want the condition options to use the hiddenAll, disabledAll functions
  displayOptions[id].args.conditions.hidden = function()
    return false;
  end
  displayOptions[id].args.conditions.disabled = function()
    return false;
  end
  WeakAuras.GetConditionOptions(data, displayOptions[id].args.conditions.args, "conditions", 0, nil);

  if(type(id) ~= "string") then
    displayOptions[id].args.group = nil;
  end
end

function WeakAuras.ReloadGroupRegionOptions(data)
  local regionTypes = {};
  local regionTypeCount = 0;
  for index, childId in ipairs(data.controlledChildren) do
    local childData = WeakAuras.GetData(childId);
    if(childData) then
      if (not regionTypes[childData.regionType]) then
        regionTypes[childData.regionType] = true;
        regionTypeCount = regionTypeCount +1;
      end
    end
  end

  local id = data.id;
  WeakAuras.EnsureOptions(id);
  local options = displayOptions[id];

  local allOptions = {};
  for regionType in pairs(regionTypes) do
    if(regionOptions[regionType]) then
      allOptions = union(allOptions, regionOptions[regionType].create(id, data));
    else
      regionType = {
        unsupported = {
          type = "description",
          name = L["Regions of type \"%s\" are not supported."]:format(regionType);
        }
      };
    end
  end

  local regionOption = flattenRegionOptions(allOptions, false);

  replaceNameDescFuncs(regionOption, data);
  replaceImageFuncs(regionOption, data);
  replaceValuesFuncs(regionOption, data);
  removeFuncs(regionOption);

  if (regionTypeCount > 1) then
    addHeadersForRegionOptions(allOptions, regionOption);
  end

  options.args.region.args = regionOption;
end

function WeakAuras.PositionOptions(id, data, hideWidthHeight, disableSelfPoint)
  local function IsParentDynamicGroup()
    return data.parent and db.displays[data.parent] and db.displays[data.parent].regionType == "dynamicgroup";
  end

  local screenWidth, screenHeight = math.ceil(GetScreenWidth() / 20) * 20, math.ceil(GetScreenHeight() / 20) * 20;
  local positionOptions = {
    position_header = {
      type = "header",
      name = L["Position Settings"],
      order = 46.0
    },
    width = {
      type = "range",
      name = L["Width"],
      order = 60,
      min = 1,
      softMax = screenWidth,
      bigStep = 1,
      hidden = hideWidthHeight,
    },
    height = {
      type = "range",
      name = L["Height"],
      order = 65,
      min = 1,
      softMax = screenHeight,
      bigStep = 1,
      hidden = hideWidthHeight,
    },
    selfPoint = {
      type = "select",
      name = L["Anchor"],
      order = 70,
      hidden = IsParentDynamicGroup,
      values = point_types,
      disabled = disableSelfPoint
    },
    anchorFrameType = {
      type = "select",
      name = L["Anchored To"],
      order = 72,
      hidden = IsParentDynamicGroup,
      values = WeakAuras.anchor_frame_types
    },
    -- Input field to select frame to anchor on
    anchorFrameFrame = {
      type = "input",
      name = L["Frame"],
      order = 72.2,
      hidden = function()
        if (IsParentDynamicGroup()) then
          return true;
        end
        return not (data.anchorFrameType == "SELECTFRAME")
      end
    },
    -- Button to select frame to anchor on
    chooseAnchorFrameFrame = {
      type = "execute",
      name = L["Choose"],
      order = 72.4,
      hidden = function()
        if (IsParentDynamicGroup()) then
          return true;
        end
        return not (data.anchorFrameType == "SELECTFRAME")
      end,
      func = function()
        WeakAuras.StartFrameChooser(data, {"anchorFrameFrame"});
      end
    },
    anchorPoint = {
      type = "select",
      name = function()
        if (data.anchorFrameType == "SCREEN") then
          return L["To Screen's"]
        elseif (data.anchorFrameType == "PRD") then
          return L["To Personal Ressource Display's"];
        elseif (data.anchorFrameType == "SELECTFRAME") then
          return L["To Frame's"];
        end
      end,
      order = 75,
      hidden = function()
        if (data.parent) then
          if (IsParentDynamicGroup()) then
            return true;
          end
          return data.anchorFrameType == "SCREEN" or data.anchorFrameType == "MOUSE";
        else
          return data.anchorFrameType == "MOUSE";
        end
      end,
      values = point_types
    },
    anchorPointGroup = {
      type = "select",
      name = function() return L["to group's"] end,
      order = 75,
      hidden = function()
        if (data.anchorFrameType ~= "SCREEN") then
          return true;
        end
        if (data.parent) then
          return IsParentDynamicGroup();
        end
        return true;
      end,
      disabled = true,
      values = {["CENTER"] = L["Anchor Point"]},
      get = function() return "CENTER"; end
    },
    anchorFrameParent = {
      type = "toggle",
      name = L["Set Parent to Anchor"],
      order = 77,
      get = function()
        return data.anchorFrameParent or data.anchorFrameParent == nil;
      end,
      hidden = function()
        return (data.anchorFrameType == "SCREEN" or data.anchorFrameType == "MOUSE");
      end,
    },
    frameStrata = {
      type = "select",
      name = L["Frame Strata"],
      order = 78,
      values = WeakAuras.frame_strata_types
    },
    anchorFrameSpace = {
      type = "execute",
      name = "",
      order = 79,
      image = function() return "", 0, 0 end,
      hidden = function()
        return not (data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup());
      end
    },
    -- IsParentDynamicGroup => xOffset4 / yOffset4
    -- InGroup/Attached to mouse/PRD/SELECTFRAME => -screen -- +screen
    -- Attached to Screen => depends on anchorPoint
    --   LEFT/BOTTOM => 0 -- +screen
    --   CENTER => -screen/2 -- +screen / 2
    --   RIGHT/TOP => -screen -- +screen
    xOffset1 = {
      type = "range",
      name = L["X Offset"],
      order = 80,
      softMin = 0,
      softMax = screenWidth,
      bigStep = 10,
      hidden = function()
        if (data.parent or data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup()) then
          return true;
        end
        return not data.anchorPoint:find("LEFT")
      end,
      get = function() return data.xOffset end,
      set = function(info, v)
        data.xOffset = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
        if(data.parent) then
          local parentData = WeakAuras.GetData(data.parent);
          if(parentData) then
            WeakAuras.Add(parentData);
            WeakAuras.SetThumbnail(parentData);
          end
        end
      end
    },
    xOffset2 = {
      type = "range",
      name = L["X Offset"],
      order = 80,
      softMin = ((-1/2) * screenWidth),
      softMax = ((1/2) * screenWidth),
      bigStep = 10,
      hidden = function()
        if (data.parent or data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup()) then
          return true;
        end
        return (data.anchorPoint:find("LEFT") or data.anchorPoint:find("RIGHT"));
      end,
      get = function() return data.xOffset end,
      set = function(info, v)
        data.xOffset = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
        if(data.parent) then
          local parentData = WeakAuras.GetData(data.parent);
          if(parentData) then
            WeakAuras.Add(parentData);
            WeakAuras.SetThumbnail(parentData);
          end
        end
      end
    },
    xOffset3 = {
      type = "range",
      name = L["X Offset"],
      order = 80,
      softMin = (-1 * screenWidth),
      softMax = 0,
      bigStep = 10,
      hidden = function()
        if (data.parent or data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup()) then
          return true;
        end
        return not data.anchorPoint:find("RIGHT");
      end,
      get = function() return data.xOffset end,
      set = function(info, v)
        data.xOffset = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
        if(data.parent) then
          local parentData = WeakAuras.GetData(data.parent);
          if(parentData) then
            WeakAuras.Add(parentData);
            WeakAuras.SetThumbnail(parentData);
          end
        end
      end
    },
    xOffset4 = {
      type = "range",
      name = L["X Offset"],
      order = 80,
      softMin = (-1 * screenWidth),
      softMax = screenWidth,
      bigStep = 10,
      hidden = function()
        if (data.parent or data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup()) then
          return false;
        end
        return true;
      end,
      get = function() return data.xOffset end,
      set = function(info, v)
        data.xOffset = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
        if(data.parent) then
          local parentData = WeakAuras.GetData(data.parent);
          if(parentData) then
            WeakAuras.Add(parentData);
            WeakAuras.SetThumbnail(parentData);
          end
        end
      end
    },
    yOffset1 = {
      type = "range",
      name = L["Y Offset"],
      order = 85,
      softMin = 0,
      softMax = screenHeight,
      bigStep = 10,
      hidden = function()
        if (data.parent or data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup()) then
          return true;
        end
        return not data.anchorPoint:find("BOTTOM");
      end,
      get = function() return data.yOffset end,
      set = function(info, v)
        data.yOffset = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
        if(data.parent) then
          local parentData = WeakAuras.GetData(data.parent);
          if(parentData) then
            WeakAuras.Add(parentData);
            WeakAuras.SetThumbnail(parentData);
          end
        end
      end
    },
    yOffset2 = {
      type = "range",
      name = L["Y Offset"],
      order = 85,
      softMin = ((-1/2) * screenHeight),
      softMax = ((1/2) * screenHeight),
      bigStep = 10,
      hidden = function()
        if (data.parent or data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup()) then
          return true;
        end
        return data.anchorPoint:find("BOTTOM") or data.anchorPoint:find("TOP");
      end,
      get = function() return data.yOffset end,
      set = function(info, v)
        data.yOffset = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
        if(data.parent) then
          local parentData = WeakAuras.GetData(data.parent);
          if(parentData) then
            WeakAuras.Add(parentData);
            WeakAuras.SetThumbnail(parentData);
          end
        end
      end
    },
    yOffset3 = {
      type = "range",
      name = L["Y Offset"],
      order = 85,
      softMin = (-1 * screenHeight),
      softMax = 0,
      bigStep = 10,
      hidden = function()
        if (data.parent or data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup()) then
          return true;
        end
        return not data.anchorPoint:find("TOP");
      end,
      get = function() return data.yOffset end,
      set = function(info, v)
        data.yOffset = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
        if(data.parent) then
          local parentData = WeakAuras.GetData(data.parent);
          if(parentData) then
            WeakAuras.Add(parentData);
            WeakAuras.SetThumbnail(parentData);
          end
        end
      end
    },
    yOffset4 = {
      type = "range",
      name = L["Y Offset"],
      order = 85,
      softMin = (-1 * screenHeight),
      softMax = screenHeight,
      bigStep = 10,
      hidden = function()
        if (data.parent or data.anchorFrameType ~= "SCREEN" or IsParentDynamicGroup()) then
          return false;
        end
        return true;
      end,
      get = function() return data.yOffset end,
      set = function(info, v)
        data.yOffset = v;
        WeakAuras.Add(data);
        WeakAuras.SetThumbnail(data);
        WeakAuras.ResetMoverSizer();
        if(data.parent) then
          local parentData = WeakAuras.GetData(data.parent);
          if(parentData) then
            WeakAuras.Add(parentData);
            WeakAuras.SetThumbnail(parentData);
          end
        end
      end
    },
  };

  return positionOptions;
end

function WeakAuras.AddPositionOptions(input, id, data)
  return union(input, WeakAuras.PositionOptions(id, data));
end

function WeakAuras.BorderOptions(id, data, showBackDropOptions)
  local borderOptions = {
    border_header = {
      type = "header",
      name = L["Border Settings"],
      order = 46.0
    },
    border = {
      type = "toggle",
      name = L["Border"],
      order = 46.05
    },
    borderEdge = {
      type = "select",
      dialogControl = "LSM30_Border",
      name = L["Border Style"],
      order = 46.1,
      values = AceGUIWidgetLSMlists.border,
      disabled = function() return not data.border end,
      hidden = function() return not data.border end,
    },
    borderBackdrop = {
      type = "select",
      dialogControl = "LSM30_Background",
      name = L["Backdrop Style"],
      order = 46.2,
      values = AceGUIWidgetLSMlists.background,
      disabled = function() return not data.border end,
      hidden = function() return not data.border end,
    },
    borderOffset = {
      type = "range",
      name = L["Border Offset"],
      order = 46.3,
      softMin = 0,
      softMax = 32,
      bigStep = 1,
      disabled = function() return not data.border end,
      hidden = function() return not data.border end,
    },
    borderSize = {
      type = "range",
      name = L["Border Size"],
      order = 46.4,
      softMin = 1,
      softMax = 64,
      bigStep = 1,
      disabled = function() return not data.border end,
      hidden = function() return not data.border end,
    },
    borderInset = {
      type = "range",
      name = L["Border Inset"],
      order = 46.5,
      softMin = 1,
      softMax = 32,
      bigStep = 1,
      disabled = function() return not data.border end,
      hidden = function() return not data.border end,
    },
    borderColor = {
      type = "color",
      name = L["Border Color"],
      hasAlpha = true,
      order = 46.6,
      disabled = function() return not data.border end,
      hidden = function() return not data.border end,
    },
    borderInFront  = {
      type = "toggle",
      name = L["Border in Front"],
      order = 46.7,
      disabled = function() return not data.border end,
      hidden = function() return not data.border or not showBackDropOptions  end,
    },
    backdropInFront  = {
      type = "toggle",
      name = L["Backdrop in Front"],
      order = 46.75,
      disabled = function() return not data.border end,
      hidden = function() return not data.border or not showBackDropOptions end,
    },
    backdropColor = {
      type = "color",
      name = L["Backdrop Color"],
      hasAlpha = true,
      order = 46.8,
      disabled = function() return not data.border end,
      hidden = function() return not data.border end,
    },
  }

  return borderOptions;
end

function WeakAuras.AddBorderOptions(input, id, data)
  return union(input, WeakAuras.BorderOptions(id, data));
end


function WeakAuras.OpenTextEditor(...)
  frame.texteditor:Open(...);
end

function WeakAuras.ExportToString(id)
  frame.importexport:Open("export", id);
end

function WeakAuras.ExportToTable(id)
  frame.importexport:Open("table", id);
end

function WeakAuras.ImportFromString()
  frame.importexport:Open("import");
end

function WeakAuras.CloseImportExport()
  frame.codereview:Close();
  frame.importexport:Close();
end

function WeakAuras.ConvertDisplay(data, newType)
  local id = data.id;
  -- thumbnails[id].region:SetScript("OnUpdate", nil);
  thumbnails[id].region:Hide();
  thumbnails[id] = nil;

  WeakAuras.Convert(data, newType);
  displayButtons[id]:SetViewRegion(WeakAuras.regions[id].region);
  displayButtons[id]:Initialize();
  displayOptions[id] = nil;
  WeakAuras.AddOption(id, data);
  frame:FillOptions(displayOptions[id]);
  WeakAuras.UpdateDisplayButton(data);
  frame.mover.moving.region = WeakAuras.regions[id].region;
  WeakAuras.ResetMoverSizer();
end

function WeakAuras.NewDisplayButton(data)
  local id = data.id;
  WeakAuras.ScanForLoads();
  WeakAuras.EnsureDisplayButton(db.displays[id]);
  WeakAuras.UpdateDisplayButton(db.displays[id]);
  if(WeakAuras.regions[id].region.SetStacks) then
    WeakAuras.regions[id].region:SetStacks(1);
  end
  frame.buttonsScroll:AddChild(displayButtons[id]);
  WeakAuras.AddOption(id, data);
  WeakAuras.SetIconNames(data);
  WeakAuras.SortDisplayButtons();
end

function WeakAuras.UpdateGroupOrders(data)
  if(data.controlledChildren) then
    local total = #data.controlledChildren;
    for index, id in pairs(data.controlledChildren) do
      local button = WeakAuras.GetDisplayButton(id);
      button:SetGroupOrder(index, total);
    end
  end
end

function WeakAuras.UpdateButtonsScroll()
  if WeakAuras.IsOptionsProcessingPaused() then return end
  frame.buttonsScroll:DoLayout()
end

local previousFilter;
function WeakAuras.SortDisplayButtons(filter, overrideReset, id)
  if (WeakAuras.IsOptionsProcessingPaused()) then
    return;
  end
  local recenter = false;
  filter = filter or (overrideReset and previousFilter or "");
  if(frame.filterInput:GetText() ~= filter) then
    frame.filterInput:SetText(filter);
  end
  if(previousFilter and previousFilter ~= "" and (filter == "" or not filter)) then
    recenter = true;
  end
  previousFilter = filter;
  filter = filter:lower();

  wipe(frame.buttonsScroll.children);
  tinsert(frame.buttonsScroll.children, frame.newButton);
  if(frame.addonsButton) then
    tinsert(frame.buttonsScroll.children, frame.addonsButton);
  end
  tinsert(frame.buttonsScroll.children, frame.loadedButton);
  local numLoaded = 0;
  local to_sort = {};
  local children = {};
  local containsFilter = false;
  for id, child in pairs(displayButtons) do
    containsFilter = false;
    local data = WeakAuras.GetData(id);
    if not(data) then
      print("|cFF8800FFWeakAuras|r: No data for", id);
    else
      if(filter and data.controlledChildren) then
        for index, childId in pairs(data.controlledChildren) do
          if(childId:lower():find(filter, 1, true)) then
            containsFilter = true;
            break;
          end
        end
      end
      if(
        frame.loadedButton:GetExpanded()
        and (not filter or id:lower():find(filter, 1, true) or containsFilter)
        ) then
        child.frame:Show();
        local group = child:GetGroup();
        if(group) then
          if(loaded[group]) then
            if(loaded[id]) then
              child:EnableLoaded();
            else
              child:DisableLoaded();
            end
            children[group] = children[group] or {};
            tinsert(children[group], child);
          end
        else
          if(loaded[id] ~= nil) then
            if(loaded[id]) then
              child:EnableLoaded();
            else
              child:DisableLoaded();
            end
            tinsert(to_sort, child);
          end
        end
      else
        child.frame:Hide();
      end
    end
  end
  table.sort(to_sort, function(a, b) return a:GetTitle() < b:GetTitle() end);
  for _, child in ipairs(to_sort) do
    tinsert(frame.buttonsScroll.children, child);
    local controlledChildren = children[child:GetTitle()];
    if(controlledChildren) then
      table.sort(controlledChildren, function(a, b) return a:GetGroupOrder() < b:GetGroupOrder(); end);
      for _, groupchild in ipairs(controlledChildren) do
        if(child:GetExpanded()) then
          tinsert(frame.buttonsScroll.children, groupchild);
        else
          groupchild.frame:Hide();
        end
      end
    end
  end

  tinsert(frame.buttonsScroll.children, frame.unloadedButton);
  local numUnloaded = 0;
  wipe(to_sort);
  wipe(children);
  for id, child in pairs(displayButtons) do
    containsFilter = false;
    local data = WeakAuras.GetData(id);
    if(filter and data.controlledChildren) then
      for index, childId in pairs(data.controlledChildren) do
        if(childId:lower():find(filter, 1, true)) then
          containsFilter = true;
          break;
        end
      end
    end
    if(
      frame.unloadedButton:GetExpanded()
      and (not filter or id:lower():find(filter, 1, true) or containsFilter)
      ) then
      local group = child:GetGroup();
      if(group) then
        if not(loaded[group]) then
          if(loaded[id]) then
            child:EnableLoaded();
          else
            child:DisableLoaded();
          end
          children[group] = children[group] or {};
          tinsert(children[group], child);
        end
      else
        if(loaded[id] == nil) then
          child:DisableLoaded();
          tinsert(to_sort, child);
        end
      end
    else
      child.frame:Hide();
    end
  end
  table.sort(to_sort, function(a, b) return a:GetTitle() < b:GetTitle() end);
  for _, child in ipairs(to_sort) do
    tinsert(frame.buttonsScroll.children, child);
    local controlledChildren = children[child:GetTitle()];
    if(controlledChildren) then
      table.sort(controlledChildren, function(a, b) return a:GetGroupOrder() < b:GetGroupOrder(); end);
      for _, groupchild in ipairs(controlledChildren) do
        if(child:GetExpanded()) then
          tinsert(frame.buttonsScroll.children, groupchild);
        else
          groupchild.frame:Hide();
        end
      end
    end
  end

  frame.buttonsScroll:DoLayout();
  if(recenter) then
    frame:CenterOnPicked();
  end
end

WeakAuras.afterScanForLoads = function()
  if(frame) then
    if (frame:IsVisible()) then
      WeakAuras.SortDisplayButtons(nil, true);
    else
      frame.needsSort = true;
    end
  end
end

function WeakAuras.IsPickedMultiple()
  if(frame.pickedDisplay == tempGroup) then
    return true;
  else
    return false;
  end
end

function WeakAuras.IsDisplayPicked(id)
  if(frame.pickedDisplay == tempGroup) then
    for index, childId in pairs(tempGroup.controlledChildren) do
      if(id == childId) then
        return true;
      end
    end
    return false;
  else
    return frame.pickedDisplay == id;
  end
end

function WeakAuras.PickDisplay(id)
  frame:PickDisplay(id);
end

function WeakAuras.PickAndEditDisplay(id)
  frame:PickDisplay(id);
  displayButtons[id].callbacks.OnRenameClick();
end

function WeakAuras.ClearPick(id)
  frame:ClearPick(id);
end

function WeakAuras.ClearPicks()
  frame:ClearPicks();
end

function WeakAuras.PickDisplayMultiple(id)
  frame:PickDisplayMultiple(id);
end

function WeakAuras.FillOptions(id)
  frame:FillOptions(displayOptions[id]);
end

function WeakAuras.GetDisplayButton(id)
  if(id and displayButtons[id]) then
    return displayButtons[id];
  end
end

function WeakAuras.AddDisplayButton(data)
  WeakAuras.EnsureDisplayButton(data);
  WeakAuras.UpdateDisplayButton(data);
  frame.buttonsScroll:AddChild(displayButtons[data.id]);
  WeakAuras.AddOption(data.id, data);
  WeakAuras.SetIconNames(data);
  if(WeakAuras.regions[data.id] and WeakAuras.regions[data.id].region.SetStacks) then
    WeakAuras.regions[data.id].region:SetStacks(1);
  end
end

function WeakAuras.EnsureDisplayButton(data)
  local id = data.id;
  if not(displayButtons[id]) then
    displayButtons[id] = AceGUI:Create("WeakAurasDisplayButton");
    if(displayButtons[id]) then
      displayButtons[id]:SetData(data);
      displayButtons[id]:Initialize();
    else
      print("|cFF8800FFWeakAuras|r: Error creating button for", id);
    end
  end
end

function WeakAuras.SetGrouping(data)
  for id, button in pairs(displayButtons) do
    button:SetGrouping(data);
  end
end

function WeakAuras.SetDragging(data, drop)
  WeakAuras_DropDownMenu:Hide()
  for id, button in pairs(displayButtons) do
    button:SetDragging(data, drop)
  end
end

function WeakAuras.DropIndicator()
  local indicator = frame.dropIndicator
  if not indicator then
    indicator = CreateFrame("Frame", "WeakAuras_DropIndicator")
    indicator:SetHeight(4)
    indicator:SetFrameStrata("FULLSCREEN")

    local texture = indicator:CreateTexture(nil, "FULLSCREEN")
    texture:SetBlendMode("ADD")
    texture:SetAllPoints(indicator)
    texture:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")

    local icon = indicator:CreateTexture(nil, "OVERLAY")
    icon:SetSize(16,16)
    icon:SetPoint("CENTER", indicator)

    indicator.icon = icon
    indicator.texture = texture
    frame.dropIndicator = indicator
    indicator:Hide()
  end
  return indicator
end

function WeakAuras.UpdateDisplayButton(data)
  local id = data.id;
  local button = displayButtons[id];
  if (button) then
    button:SetIcon(WeakAuras.SetThumbnail(data));
  end
end

function WeakAuras.SetThumbnail(data)
  local regionType = data.regionType;
  local regionTypes = WeakAuras.regionTypes;
  if not(regionType) then
    error("Improper arguments to WeakAuras.SetThumbnail - regionType not defined");
  else
    local id = data.id;
    local button = displayButtons[id];
    if (not button) then return end;
    local thumbnail;
    if((not thumbnails[id]) or (not thumbnails[id].region) or thumbnails[id].regionType ~= regionType) then
      if(regionOptions[regionType] and regionOptions[regionType].createThumbnail and regionOptions[regionType].modifyThumbnail) then
        thumbnail = regionOptions[regionType].createThumbnail(button.frame, regionTypes[regionType].create);
      else
        thumbnail = button.frame:CreateTexture();
        thumbnail:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
      end
      thumbnails[id] = {
        regionType = regionType,
        region = thumbnail
      };
    end

    thumbnail = thumbnails[id].region;
    if(regionOptions[regionType] and regionOptions[regionType].modifyThumbnail) then
      WeakAuras.validate(data, regionTypes[regionType].default);
      regionOptions[regionType].modifyThumbnail(button.frame, thumbnail, data, regionTypes[regionType].modify);
    end

    return thumbnail;
  end
end

function WeakAuras.OpenTexturePicker(data, field, textures, stopMotion)
  frame.texturePicker:Open(data, field, textures, stopMotion);
end

function WeakAuras.OpenIconPicker(data, field)
  frame.iconPicker:Open(data, field);
end

function WeakAuras.OpenModelPicker(data, field)
  if not(IsAddOnLoaded("WeakAurasModelPaths")) then
    local loaded, reason = LoadAddOn("WeakAurasModelPaths");
    if not(loaded) then
      print("|cff9900FF".."WeakAurasModelPaths"..FONT_COLOR_CODE_CLOSE.." could not be loaded: "..RED_FONT_COLOR_CODE.._G["ADDON_"..reason]);
      WeakAuras.ModelPaths = {};
    end
    frame.modelPicker.modelTree:SetTree(WeakAuras.ModelPaths);
  end
  frame.modelPicker:Open(data, field);
end

function WeakAuras.OpenCodeReview(data)
  frame.codereview:Open(data);
end

function WeakAuras.CloseCodeReview(data)
  frame.codereview:Close();
end

function WeakAuras.OpenTriggerTemplate(data)
  if not(IsAddOnLoaded("WeakAurasTemplates")) then
    local loaded, reason = LoadAddOn("WeakAurasTemplates");
    if not(loaded) then
      print("|cff9900FF".."WeakAurasTemplates"..FONT_COLOR_CODE_CLOSE.." could not be loaded: "..RED_FONT_COLOR_CODE.._G["ADDON_"..reason]);
      return;
    end
    frame.newView = WeakAuras.CreateTemplateView(frame);
  end
  frame.newView:Open(data);
end

function WeakAuras.ResetMoverSizer()
  if(frame and frame.mover and frame.moversizer and frame.mover.moving.region and frame.mover.moving.data) then
    frame.moversizer:SetToRegion(frame.mover.moving.region, frame.mover.moving.data);
  end
end

function WeakAuras.ShowCloneDialog(data)
  if(
    not(
    data.parent
    and WeakAuras.GetData(data.parent)
    and WeakAuras.GetData(data.parent).regionType == "dynamicgroup"
    )
    and not(odb.preventCloneDialog)
    ) then
    StaticPopupDialogs["WEAKAURAS_CLONE_OPTION_ENABLED"] = {
      text = L["Clone option enabled dialog"],
      button1 = L["Yes"],
      button2 = L["No"],
      button3 = L["Never"],
      OnAccept = function()
        local new_id = data.id.." Group";
        local num = 2;
        while(WeakAuras.GetData(new_id)) do
          new_id = "New "..num;
          num = num + 1;
        end

        local parentData = {
          id = new_id,
          regionType = "dynamicgroup",
          trigger = {},
          load = {}
        };
        WeakAuras.Add(parentData);
        WeakAuras.NewDisplayButton(parentData);

        tinsert(parentData.controlledChildren, data.id);
        data.parent = parentData.id;
        WeakAuras.Add(parentData);
        WeakAuras.Add(data);

        local button = WeakAuras.GetDisplayButton(data.id);
        button:SetGroup(parentData.id, true);
        button:SetGroupOrder(1, #parentData.controlledChildren);

        local parentButton = WeakAuras.GetDisplayButton(parentData.id);
        parentButton.callbacks.UpdateExpandButton();
        WeakAuras.UpdateDisplayButton(parentData);
        WeakAuras.ReloadGroupRegionOptions(parentData);
        WeakAuras.SortDisplayButtons();
        parentButton:Expand();
      end,
      OnCancel = function()
      -- do nothing
      end,
      OnAlt = function()
        odb.preventCloneDialog = true
      end,
      hideOnEscape = true,
      whileDead = true,
      timeout = 0,
      preferredindex = STATICPOPUP_NUMDIALOGS
    };

    StaticPopup_Show("WEAKAURAS_CLONE_OPTION_ENABLED");
  end
end
