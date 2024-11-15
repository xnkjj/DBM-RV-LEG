-- Lua APIs
local tinsert, tremove, wipe = table.insert, table.remove, wipe
local pairs, type, error = pairs, type, error
local _G = _G

-- WoW APIs
local GetScreenWidth, GetScreenHeight, CreateFrame, GetAddOnInfo, PlaySound, IsAddOnLoaded, LoadAddOn, UnitName
  = GetScreenWidth, GetScreenHeight, CreateFrame, GetAddOnInfo, PlaySound, IsAddOnLoaded, LoadAddOn, UnitName

local AceGUI = LibStub("AceGUI-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local WeakAuras = WeakAuras
local L = WeakAuras.L

local displayButtons = WeakAuras.displayButtons
local displayOptions = WeakAuras.displayOptions
local loaded = WeakAuras.loaded
local regionOptions = WeakAuras.regionOptions
local savedVars = WeakAuras.savedVars
local tempGroup = WeakAuras.tempGroup

local function CreateDecoration(frame)
  local deco = CreateFrame("Frame", nil, frame)
  deco:SetSize(17, 40)

  local bg1 = deco:CreateTexture(nil, "BACKGROUND")
  bg1:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
  bg1:SetTexCoord(0.31, 0.67, 0, 0.63)
  bg1:SetAllPoints(deco)

  local bg2 = deco:CreateTexture(nil, "BACKGROUND")
  bg2:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
  bg2:SetTexCoord(0.235, 0.275, 0, 0.63)
  bg2:SetPoint("RIGHT", bg1, "LEFT")
  bg2:SetSize(10, 40)

  local bg3 = deco:CreateTexture(nil, "BACKGROUND")
  bg3:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
  bg3:SetTexCoord(0.72, 0.76, 0, 0.63)
  bg3:SetPoint("LEFT", bg1, "RIGHT")
  bg3:SetSize(10, 40)

  return deco
end

local function CreateDecorationWide(frame)
  local deco1 = frame:CreateTexture(nil, "OVERLAY")
  deco1:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
  deco1:SetTexCoord(0.31, 0.67, 0, 0.63)
  deco1:SetSize(120, 40)

  local deco2 = frame:CreateTexture(nil, "OVERLAY")
  deco2:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
  deco2:SetTexCoord(0.21, 0.31, 0, 0.63)
  deco2:SetPoint("RIGHT", deco1, "LEFT")
  deco2:SetSize(30, 40)

  local deco3 = frame:CreateTexture(nil, "OVERLAY")
  deco3:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
  deco3:SetTexCoord(0.67, 0.77, 0, 0.63)
  deco3:SetPoint("LEFT", deco1, "RIGHT")
  deco3:SetSize(30, 40)

  return deco1
end

local function CreateFrameSizer(frame, callback, position)
  callback = callback or (function() end)

  local left, right, top, bottom, xOffset1, yOffset1, xOffset2, yOffset2;
  if (position == "BOTTOMLEFT") then
    left, right, top, bottom = 1, 0, 0, 1
    xOffset1, yOffset1 = 6, 6
    xOffset2, yOffset2 = 0, 0
  elseif (position == "BOTTOMRIGHT") then
    left, right, top, bottom = 0, 1, 0, 1
    xOffset1, yOffset1 = 0, 6
    xOffset2, yOffset2 = -6, 0
  elseif (position == "TOPLEFT") then
    left, right, top, bottom = 1, 0, 1, 0
    xOffset1, yOffset1 = 6, 0
    xOffset2, yOffset2 = 0, -6
  elseif (position == "TOPRIGHT") then
    left, right, top, bottom = 0, 1, 1, 0
    xOffset1, yOffset1 = 0, 0
    xOffset2, yOffset2 = -6, -6
  end

  local handle = CreateFrame("BUTTON", nil, frame)
  handle:SetPoint(position, frame)
  handle:SetSize(25, 25)
  handle:EnableMouse()

  handle:SetScript("OnMouseDown", function() frame:StartSizing(position) end)
  handle:SetScript("OnMouseUp", function()
    frame:StopMovingOrSizing()
    callback()
  end)

  local normal = handle:CreateTexture(nil, "OVERLAY")
  normal:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
  normal:SetTexCoord(left, right, top, bottom)
  normal:SetPoint("BOTTOMLEFT", handle, xOffset1, yOffset1)
  normal:SetPoint("TOPRIGHT", handle, xOffset2, yOffset2)
  handle:SetNormalTexture(normal)

  local pushed = handle:CreateTexture(nil, "OVERLAY")
  pushed:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
  pushed:SetTexCoord(left, right, top, bottom)
  pushed:SetPoint("BOTTOMLEFT", handle, xOffset1, yOffset1)
  pushed:SetPoint("TOPRIGHT", handle, xOffset2, yOffset2)
  handle:SetPushedTexture(pushed)

  local highlight = handle:CreateTexture(nil, "OVERLAY")
  highlight:SetTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
  highlight:SetTexCoord(left, right, top, bottom)
  highlight:SetPoint("BOTTOMLEFT", handle, xOffset1, yOffset1)
  highlight:SetPoint("TOPRIGHT", handle, xOffset2, yOffset2)
  handle:SetHighlightTexture(highlight)

  return handle
end

function WeakAuras.CreateFrame()
  local WeakAuras_DropDownMenu = CreateFrame("frame", "WeakAuras_DropDownMenu", nil, "UIDropDownMenuTemplate");
  local frame;
  local db = savedVars.db;
  local odb = savedVars.odb;
  -------- Mostly Copied from AceGUIContainer-Frame--------
  frame = CreateFrame("FRAME", nil, UIParent);
  frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
  });
  frame:SetBackdropColor(0, 0, 0, 1);
  frame:EnableMouse(true);
  frame:SetMovable(true);
  frame:SetResizable(true);
  frame:SetMinResize(610, 240);
  frame:SetFrameStrata("DIALOG");
  frame.window = "default";

  local xOffset, yOffset;
  if(db.frame) then
    xOffset, yOffset = db.frame.xOffset, db.frame.yOffset;
  end
  if not(xOffset and yOffset) then
    xOffset = (610 - GetScreenWidth()) / 2;
    yOffset = (492 - GetScreenHeight()) / 2;
  end
  frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", xOffset, yOffset);
  frame:Hide();

  local width, height;
  if(db.frame) then
    width, height = db.frame.width, db.frame.height;
  end
  if not(width and height) then
    width, height = 630, 492;
  end
  frame:SetWidth(width);
  frame:SetHeight(height);

  local close = CreateDecoration(frame)
  close:SetPoint("TOPRIGHT", -30, 12)

  local closebutton = CreateFrame("BUTTON", nil, close)
  closebutton:SetWidth(30);
  closebutton:SetHeight(30);
  closebutton:SetPoint("CENTER", close, "CENTER", 1, -1);
  closebutton:SetNormalTexture("Interface\\BUTTONS\\UI-Panel-MinimizeButton-Up.blp");
  closebutton:SetPushedTexture("Interface\\BUTTONS\\UI-Panel-MinimizeButton-Down.blp");
  closebutton:SetHighlightTexture("Interface\\BUTTONS\\UI-Panel-MinimizeButton-Highlight.blp");
  closebutton:SetScript("OnClick", WeakAuras.HideOptions);

  local import = CreateDecoration(frame)
  import:SetPoint("TOPRIGHT", -100, 12)
  --import:Hide()

  local importbutton = CreateFrame("CheckButton", nil, import, "OptionsCheckButtonTemplate")
  importbutton:SetWidth(30);
  importbutton:SetHeight(30);
  importbutton:SetPoint("CENTER", import, "CENTER", 1, -1);
  importbutton:SetHitRectInsets(0,0,0,0)
  importbutton:SetChecked(db.import_disabled)

  importbutton:SetScript("PostClick", function(self)
    if self:GetChecked() then
      PlaySound(856)
      db.import_disabled = true
    else
      PlaySound(857)
      db.import_disabled = nil
    end
  end)
  importbutton:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
    GameTooltip:SetText(L["Disable Import"])
    GameTooltip:AddLine(L["If this option is enabled, you are no longer able to import auras."], 1, 1, 1)
    GameTooltip:Show()
  end)
  importbutton:SetScript("OnLeave", GameTooltip_Hide)

  local titlebg = CreateDecorationWide(frame)
  titlebg:SetPoint("TOP", 0, 12)

  local title = CreateFrame("Frame", nil, frame)

  local function commitWindowChanges()
    local xOffset = frame:GetRight() - GetScreenWidth();
    local yOffset = frame:GetTop() - GetScreenHeight();
    if(title:GetRight() > GetScreenWidth()) then
      xOffset = xOffset + (GetScreenWidth() - title:GetRight());
    elseif(title:GetLeft() < 0) then
      xOffset = xOffset + (0 - title:GetLeft());
    end
    if(title:GetTop() > GetScreenHeight()) then
      yOffset = yOffset + (GetScreenHeight() - title:GetTop());
    elseif(title:GetBottom() < 0) then
      yOffset = yOffset + (0 - title:GetBottom());
    end
    db.frame = db.frame or {};
    db.frame.xOffset = xOffset;
    db.frame.yOffset = yOffset;
    if(not frame.minimized) then
      db.frame.width = frame:GetWidth();
      db.frame.height = frame:GetHeight();
    end
    frame:ClearAllPoints();
    frame:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", xOffset, yOffset);
  end

  title:EnableMouse(true)
  title:SetScript("OnMouseDown", function() frame:StartMoving() end)
  title:SetScript("OnMouseUp", function()
    frame:StopMovingOrSizing();
    commitWindowChanges();
  end);
  title:SetPoint("BOTTOMLEFT", titlebg, "BOTTOMLEFT", -25, 0);
  title:SetPoint("TOPRIGHT", titlebg, "TOPRIGHT", 25, 0);

  local titletext = title:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  titletext:SetPoint("TOP", titlebg, "TOP", 0, -14)
  titletext:SetText("WeakAuras " .. WeakAuras.versionString);

  CreateFrameSizer(frame, commitWindowChanges, "BOTTOMLEFT");
  CreateFrameSizer(frame, commitWindowChanges, "BOTTOMRIGHT");

  local minimize = CreateDecoration(frame)
  minimize:SetPoint("TOPRIGHT", -65, 12)

  local minimizebutton = CreateFrame("BUTTON", nil, minimize)
  minimizebutton:SetWidth(30);
  minimizebutton:SetHeight(30);
  minimizebutton:SetPoint("CENTER", minimize, "CENTER", 1, -1);
  minimizebutton:SetNormalTexture("Interface\\BUTTONS\\UI-Panel-CollapseButton-Up.blp");
  minimizebutton:SetPushedTexture("Interface\\BUTTONS\\UI-Panel-CollapseButton-Down.blp");
  minimizebutton:SetHighlightTexture("Interface\\BUTTONS\\UI-Panel-MinimizeButton-Highlight.blp");
  minimizebutton:SetScript("OnClick", function()
    if(frame.minimized) then
      frame.minimized = nil;
      if db.frame then
        if db.frame.height < 240 then
          db.frame.height = 500
        end
      end
      frame:SetHeight(db.frame and db.frame.height or 500);
      if(frame.window == "default") then
        frame.buttonsContainer.frame:Show();
        frame.container.frame:Show();
      elseif(frame.window == "texture") then
        frame.texturePicker.frame:Show();
      elseif(frame.window == "icon") then
        frame.iconPicker.frame:Show();
      elseif(frame.window == "model") then
        frame.modelPicker.frame:Show();
      elseif(frame.window == "importexport") then
        frame.importexport.frame:Show();
      elseif(frame.window == "texteditor") then
        frame.texteditor.frame:Show();
      elseif(frame.window == "codereview") then
        frame.codereview.frame:Show();
      elseif(frame.window == "newView") then
        frame.newView.frame:Show();
      end
      minimizebutton:SetNormalTexture("Interface\\BUTTONS\\UI-Panel-CollapseButton-Up.blp");
      minimizebutton:SetPushedTexture("Interface\\BUTTONS\\UI-Panel-CollapseButton-Down.blp");
    else
      frame.minimized = true;
      frame:SetHeight(40);
      frame.buttonsContainer.frame:Hide();
      frame.texturePicker.frame:Hide();
      frame.iconPicker.frame:Hide();
      frame.modelPicker.frame:Hide();
      frame.importexport.frame:Hide();
      frame.texteditor.frame:Hide();
      frame.codereview.frame:Hide();
      if (frame.newView) then
        frame.newView.frame:Hide();
      end
      frame.container.frame:Hide();
      minimizebutton:SetNormalTexture("Interface\\BUTTONS\\UI-Panel-ExpandButton-Up.blp");
      minimizebutton:SetPushedTexture("Interface\\BUTTONS\\UI-Panel-ExpandButton-Down.blp");
    end
  end);

  local _, _, _, enabled, loadable = GetAddOnInfo("WeakAurasTutorials");
  if(enabled and loadable) then
    local tutorial = CreateDecoration(frame)
    tutorial:SetPoint("TOPRIGHT", -140, 12)

    local tutorialbutton = CreateFrame("BUTTON", nil, tutorial)
    tutorialbutton:SetWidth(30);
    tutorialbutton:SetHeight(30);
    tutorialbutton:SetPoint("CENTER", tutorial, "CENTER", 1, -1);
    tutorialbutton:SetNormalTexture("Interface\\GossipFrame\\DailyActiveQuestIcon");
    tutorialbutton:GetNormalTexture():ClearAllPoints();
    tutorialbutton:GetNormalTexture():SetSize(16, 16);
    tutorialbutton:GetNormalTexture():SetPoint("center", -2, 0);
    tutorialbutton:SetPushedTexture("Interface\\GossipFrame\\DailyActiveQuestIcon");
    tutorialbutton:GetPushedTexture():ClearAllPoints();
    tutorialbutton:GetPushedTexture():SetSize(16, 16);
    tutorialbutton:GetPushedTexture():SetPoint("center", -2, -2);
    tutorialbutton:SetHighlightTexture("Interface\\BUTTONS\\UI-Panel-MinimizeButton-Highlight.blp");
    tutorialbutton:SetScript("OnClick", function()
      if not(IsAddOnLoaded("WeakAurasTutorials")) then
        local loaded, reason = LoadAddOn("WeakAurasTutorials");
        if not(loaded) then
          print("|cff9900FF".."WeakAurasTutorials"..FONT_COLOR_CODE_CLOSE.." could not be loaded: "..RED_FONT_COLOR_CODE.._G["ADDON_"..reason]);
          return;
        end
      end
      WeakAuras.ToggleTutorials();
    end);
  end

  local container = AceGUI:Create("InlineGroup");
  container.frame:SetParent(frame);
  container.frame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -17, 12);
  container.frame:SetPoint("TOPLEFT", frame, "TOPRIGHT", -423, -10);
  container.frame:Show();
  container.frame:SetClipsChildren(true);
  container.titletext:Hide();
  frame.container = container;

  frame.texturePicker = WeakAuras.TexturePicker(frame)
  frame.iconPicker = WeakAuras.IconPicker(frame)
  frame.modelPicker = WeakAuras.ModelPicker(frame)
  frame.importexport = WeakAuras.ImportExport(frame)
  frame.texteditor = WeakAuras.TextEditor(frame)
  frame.codereview = WeakAuras.CodeReview(frame);

  frame.moversizer, frame.mover = WeakAuras.MoverSizer(frame);

  local buttonsContainer = AceGUI:Create("InlineGroup");
  buttonsContainer:SetWidth(170);
  buttonsContainer.frame:SetParent(frame);
  buttonsContainer.frame:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 17, 12);
  buttonsContainer.frame:SetPoint("TOP", frame, "TOP", 0, -10);
  buttonsContainer.frame:SetPoint("right", container.frame, "left", -17);
  buttonsContainer.frame:Show();
  frame.buttonsContainer = buttonsContainer;

  local loadProgress = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  loadProgress:SetPoint("TOP", buttonsContainer.frame, "TOP", 0, -4)
  loadProgress:SetText(L["Creating options: "].."0/0");
  frame.loadProgress = loadProgress;

  local filterInput = CreateFrame("editbox", "WeakAurasFilterInput", buttonsContainer.frame, "InputBoxTemplate");

  filterInput:SetAutoFocus(false);
  filterInput:SetScript("OnTextChanged", function(...) WeakAuras.SortDisplayButtons(filterInput:GetText()) end);
  filterInput:SetScript("OnEnterPressed", function(...) filterInput:ClearFocus() end);
  filterInput:SetScript("OnEscapePressed", function(...) filterInput:SetText(""); filterInput:ClearFocus() end);
  filterInput:SetWidth(150);
  filterInput:SetPoint("BOTTOMLEFT", buttonsContainer.frame, "TOPLEFT", 2, -18);
  filterInput:SetPoint("TOPLEFT", buttonsContainer.frame, "TOPLEFT", 2, -2);
  filterInput:SetTextInsets(16, 0, 0, 0);

  local searchIcon = filterInput:CreateTexture(nil, "overlay");
  searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon");
  searchIcon:SetVertexColor(0.6, 0.6, 0.6);
  searchIcon:SetWidth(14);
  searchIcon:SetHeight(14);
  searchIcon:SetPoint("left", filterInput, "left", 3, -1);
  filterInput:SetFont("Fonts\\FRIZQT__.TTF", 10);
  frame.filterInput = filterInput;
  filterInput:Hide();

  local filterInputClear = CreateFrame("BUTTON", nil, buttonsContainer.frame);
  frame.filterInputClear = filterInputClear;
  filterInputClear:SetWidth(12);
  filterInputClear:SetHeight(12);
  filterInputClear:SetPoint("left", filterInput, "right", 0, -1);
  filterInputClear:SetNormalTexture("Interface\\Common\\VoiceChat-Muted");
  filterInputClear:SetHighlightTexture("Interface\\BUTTONS\\UI-Panel-MinimizeButton-Highlight.blp");
  filterInputClear:SetScript("OnClick", function() filterInput:SetText(""); filterInput:ClearFocus() end);
  filterInputClear:Hide();

  local buttonsScroll = AceGUI:Create("ScrollFrame");
  buttonsScroll:SetLayout("ButtonsScrollLayout");
  buttonsScroll.width = "fill";
  buttonsScroll.height = "fill";
  buttonsContainer:SetLayout("fill");
  buttonsContainer:AddChild(buttonsScroll);
  buttonsScroll.DeleteChild = function(self, delete)
    for index, widget in ipairs(buttonsScroll.children) do
      if(widget == delete) then
        tremove(buttonsScroll.children, index);
      end
    end
    delete:OnRelease();
    buttonsScroll:DoLayout();
  end
  frame.buttonsScroll = buttonsScroll;

  function buttonsScroll:GetScrollPos()
    local status = self.status or self.localstatus;
    return status.offset, status.offset + self.scrollframe:GetHeight();
  end

  -- override SetScroll to make childrens visible as needed
  local oldSetScroll = buttonsScroll.SetScroll;
  buttonsScroll.SetScroll = function(self, value)
    if (self:GetScrollPos() ~= value) then
      oldSetScroll(self, value);
      self:DoLayout();
    end
  end

  function buttonsScroll:SetScrollPos(top, bottom)
    local status = self.status or self.localstatus;
    local viewheight = self.scrollframe:GetHeight();
    local height = self.content:GetHeight();
    local move;

    local viewtop = -1 * status.offset;
    local viewbottom = -1 * (status.offset + viewheight);
    if(top > viewtop) then
      move = top - viewtop;
    elseif(bottom < viewbottom) then
      move = bottom - viewbottom;
    else
      move = 0;
    end

    status.offset = status.offset - move;

    self.content:ClearAllPoints();
    self.content:SetPoint("TOPLEFT", 0, status.offset);
    self.content:SetPoint("TOPRIGHT", 0, status.offset);

    status.scrollvalue = status.offset / ((height - viewheight) / 1000.0);

    self:FixScroll();
  end

  local newButton = AceGUI:Create("WeakAurasNewHeaderButton");
  newButton:SetText(L["New"]);
  newButton:SetClick(function() frame:PickOption("New") end);
  frame.newButton = newButton;

  local numAddons = 0;
  for addon, addonData in pairs(WeakAuras.addons) do
    numAddons = numAddons + 1;
  end
  if(numAddons > 0) then
    local addonsButton = AceGUI:Create("WeakAurasNewHeaderButton");
    addonsButton:SetText(L["Addons"]);
    addonsButton:SetDescription(L["Manage displays defined by Addons"]);
    addonsButton:SetClick(function() frame:PickOption("Addons") end);
    frame.addonsButton = addonsButton;
  end

  local loadedButton = AceGUI:Create("WeakAurasLoadedHeaderButton");
  loadedButton:SetText(L["Loaded"]);
  loadedButton:Disable();
  loadedButton:EnableExpand();
  if(odb.loadedCollapse) then
    loadedButton:Collapse();
  else
    loadedButton:Expand();
  end
  loadedButton:SetOnExpandCollapse(function()
    if(loadedButton:GetExpanded()) then
      odb.loadedCollapse = nil;
    else
      odb.loadedCollapse = true;
    end
    WeakAuras.SortDisplayButtons()
  end);
  loadedButton:SetExpandDescription(L["Expand all loaded displays"]);
  loadedButton:SetCollapseDescription(L["Collapse all loaded displays"]);
  loadedButton:SetViewClick(function()
    if(loadedButton.view.func() == 2) then
      for id, child in pairs(displayButtons) do
        if(loaded[id] ~= nil) then
          child:PriorityHide(2);
        end
      end
    else
      for id, child in pairs(displayButtons) do
        if(loaded[id] ~= nil) then
          child:PriorityShow(2);
        end
      end
    end
  end);
  loadedButton:SetViewTest(function()
    local none, all = true, true;
    for id, child in pairs(displayButtons) do
      if(loaded[id] ~= nil) then
        if(child:GetVisibility() ~= 2) then
          all = false;
        end
        if(child:GetVisibility() ~= 0) then
          none = false;
        end
      end
    end
    if(all) then
      return 2;
    elseif(none) then
      return 0;
    else
      return 1;
    end
  end);
  loadedButton:SetViewDescription(L["Toggle the visibility of all loaded displays"]);
  frame.loadedButton = loadedButton;

  local unloadedButton = AceGUI:Create("WeakAurasLoadedHeaderButton");
  unloadedButton:SetText(L["Not Loaded"]);
  unloadedButton:Disable();
  unloadedButton:EnableExpand();
  if(odb.unloadedCollapse) then
    unloadedButton:Collapse();
  else
    unloadedButton:Expand();
  end
  unloadedButton:SetOnExpandCollapse(function()
    if(unloadedButton:GetExpanded()) then
      odb.unloadedCollapse = nil;
    else
      odb.unloadedCollapse = true;
    end
    WeakAuras.SortDisplayButtons()
  end);
  unloadedButton:SetExpandDescription(L["Expand all non-loaded displays"]);
  unloadedButton:SetCollapseDescription(L["Collapse all non-loaded displays"]);
  unloadedButton:SetViewClick(function()
    if(unloadedButton.view.func() == 2) then
      for id, child in pairs(displayButtons) do
        if(loaded[id] == nil) then
          child:PriorityHide(2);
        end
      end
    else
      for id, child in pairs(displayButtons) do
        if not(loaded[id] == nil) then
          child:PriorityShow(2);
        end
      end
    end
  end);
  unloadedButton:SetViewTest(function()
    local none, all = true, true;
    for id, child in pairs(displayButtons) do
      if(loaded[id] == nil) then
        if(child:GetVisibility() ~= 2) then
          all = false;
        end
        if(child:GetVisibility() ~= 0) then
          none = false;
        end
      end
    end
    if(all) then
      return 2;
    elseif(none) then
      return 0;
    else
      return 1;
    end
  end);
  unloadedButton:SetViewDescription(L["Toggle the visibility of all non-loaded displays"]);
  frame.unloadedButton = unloadedButton;

  frame.FillOptions = function(self, optionTable)
    AceConfig:RegisterOptionsTable("WeakAuras", optionTable);
    AceConfigDialog:Open("WeakAuras", container);
    container:SetTitle("");
  end

  frame.ClearPick = function(self, id)
    local index = nil;
    for i, childId in pairs(tempGroup.controlledChildren) do
      if (childId == id) then
        index = i;
        break;
      end
    end

    tremove(tempGroup.controlledChildren, index);
    displayButtons[id]:ClearPick();

    WeakAuras.ReloadTriggerOptions(tempGroup);
    self:FillOptions(displayOptions[tempGroup.id]);
  end

  frame.ClearPicks = function(self, except)
    WeakAuras.PauseAllDynamicGroups();

    frame.pickedDisplay = nil;
    frame.pickedOption = nil;
    wipe(tempGroup.controlledChildren);
    for id, button in pairs(displayButtons) do
      button:ClearPick();
    end
    newButton:ClearPick();
    if(frame.addonsButton) then
      frame.addonsButton:ClearPick();
    end
    loadedButton:ClearPick();
    unloadedButton:ClearPick();
    container:ReleaseChildren();
    self.moversizer:Hide();

    WeakAuras.ResumeAllDynamicGroups();
  end

  frame.PickOption = function(self, option)
    self:ClearPicks();
    self.moversizer:Hide();
    self.pickedOption = option;
    if(option == "New") then
      newButton:Pick();

      local containerScroll = AceGUI:Create("ScrollFrame");
      containerScroll:SetLayout("flow");
      container:SetLayout("fill");
      container:AddChild(containerScroll);

      if(GetAddOnEnableState(UnitName("player"), "WeakAurasTemplates") ~= 0) then
        local button = AceGUI:Create("WeakAurasNewButton");
        button:SetTitle(L["From Template"]);
        button:SetDescription(L["Offer a guided way to create auras for your class"])
        button:SetIcon("Interface\\Icons\\INV_Misc_Book_06");
        button:SetClick(function()
          WeakAuras.OpenTriggerTemplate();
        end);
        containerScroll:AddChild(button);
      end

      for regionType, regionData in pairs(regionOptions) do
        local button = AceGUI:Create("WeakAurasNewButton");
        button:SetTitle(regionData.displayName);
        if(type(regionData.icon) == "string") then
          button:SetIcon(regionData.icon);
        elseif(type(regionData.icon) == "function") then
          button:SetIcon(regionData.icon());
        end
        button:SetDescription(regionData.description);
        button:SetClick(function()
          local new_id = "New";
          local num = 2;
          while(db.displays[new_id]) do
            new_id = "New "..num;
            num = num + 1;
          end

          local data = {
            id = new_id,
            regionType = regionType,
            activeTriggerMode = WeakAuras.trigger_modes.first_active,
            disjunctive = "all",
            trigger = {
              type = "aura",
              unit = "player",
              debuffType = "HELPFUL"
            },
            load = {}
          };
          WeakAuras.Add(data);
          WeakAuras.NewDisplayButton(data);
          WeakAuras.PickAndEditDisplay(new_id);
        end);
        containerScroll:AddChild(button);
      end
      local importButton = AceGUI:Create("WeakAurasNewButton");
      importButton:SetTitle(L["Import"]);

      local data = {
        outline = false,
        color = {1, 1, 1, 1},
        justify = "CENTER",
        font = "Friz Quadrata TT",
        fontSize = 8,
        displayText = [[
          b4vmErLxtfM
          xu5fDEn1CEn
          vmUmJyZ4hyY
          DtnEnvBEnfz
          EnfzErLxtjx
          zNL2BUrvEWv
          MxtfwDYfMyH
          jNxtLgzEnLt
          LDNx051u25L
          tXmdmY4fDE5
        ]];
      };

      local thumbnail = regionOptions["text"].createThumbnail(UIParent);
      regionOptions["text"].modifyThumbnail(UIParent, thumbnail, data);
      thumbnail.mask:SetPoint("BOTTOMLEFT", thumbnail, "BOTTOMLEFT", 3, 3);
      thumbnail.mask:SetPoint("TOPRIGHT", thumbnail, "TOPRIGHT", -3, -3);

      importButton:SetIcon(thumbnail);
      importButton:SetDescription(L["Import a display from an encoded string"]);
      importButton:SetClick(WeakAuras.ImportFromString);
      containerScroll:AddChild(importButton);
    elseif(option == "Addons") then
      frame.addonsButton:Pick();

      local containerScroll = AceGUI:Create("ScrollFrame");
      containerScroll:SetLayout("AbsoluteList");
      container:SetLayout("fill");
      container:AddChild(containerScroll);

      WeakAuras.CreateImportButtons();
      WeakAuras.SortImportButtons(containerScroll);
    else
      error("An options button other than New or Addons was selected... but there are no other options buttons!");
    end
  end

  frame.PickDisplay = function(self, id)
    self:ClearPicks();
    local data = WeakAuras.GetData(id);

    local function finishPicking()
      displayButtons[id]:Pick();
      self.pickedDisplay = id;
      local data = db.displays[id];
      WeakAuras.ReloadTriggerOptions(data);
      self:FillOptions(displayOptions[id]);
      WeakAuras.regions[id].region:Collapse();
      WeakAuras.regions[id].region:Expand();
      self.moversizer:SetToRegion(WeakAuras.regions[id].region, db.displays[id]);
      local _, _, _, _, yOffset = displayButtons[id].frame:GetPoint(1);
      if (not yOffset) then
        yOffset = displayButtons[id].frame.yOffset;
      end
      if (yOffset) then
        self.buttonsScroll:SetScrollPos(yOffset, yOffset - 32);
      end
      if(data.controlledChildren) then
        for index, childId in pairs(data.controlledChildren) do
          displayButtons[childId]:PriorityShow(1);
        end
      end
      WeakAuras.ResumeAllDynamicGroups();
    end

    local list = {};
    local num = 0;
    if(data.controlledChildren) then
      for index, childId in pairs(data.controlledChildren) do
        if not(displayOptions[childId]) then
          list[childId] = WeakAuras.GetData(childId);
          num = num + 1;
        end
      end
    end
    WeakAuras.EnsureOptions(id);
    if(num > 1) then
      WeakAuras.PauseAllDynamicGroups();
      WeakAuras.BuildOptions(list, finishPicking);
    else
      WeakAuras.PauseAllDynamicGroups();
      finishPicking();
    end
  end

  frame.CenterOnPicked = function(self)
    if(self.pickedDisplay) then
      local centerId = type(self.pickedDisplay) == "string" and self.pickedDisplay or self.pickedDisplay.controlledChildren[1];

      if(displayButtons[centerId]) then
        local _, _, _, _, yOffset = displayButtons[centerId].frame:GetPoint(1);
        if not yOffset then
          yOffset = displayButtons[centerId].frame.yOffset
        end
        if yOffset then
          self.buttonsScroll:SetScrollPos(yOffset, yOffset - 32);
        end
      end
    end
  end

  frame.PickDisplayMultiple = function(self, id)
    if not(self.pickedDisplay) then
      self:PickDisplay(id);
    else
      local wasGroup = false;
      if(type(self.pickedDisplay) == "string") then
        if(WeakAuras.GetData(self.pickedDisplay).controlledChildren) then
          wasGroup = true;
        elseif not(WeakAuras.IsDisplayPicked(id)) then
          tinsert(tempGroup.controlledChildren, self.pickedDisplay);
        end
      end
      if(wasGroup) then
        self:PickDisplay(id);
      elseif not(WeakAuras.IsDisplayPicked(id)) then
        self.pickedDisplay = tempGroup;
        WeakAuras.EnsureOptions(id);
        displayButtons[id]:Pick();
        tinsert(tempGroup.controlledChildren, id);
        WeakAuras.ReloadTriggerOptions(tempGroup);
        self:FillOptions(displayOptions[tempGroup.id]);
      end
    end
  end

  frame.RefreshPick = function(self)
    if(type(self.pickedDisplay) == "string") then
      WeakAuras.EnsureOptions(self.pickedDisplay);
      self:FillOptions(displayOptions[self.pickedDisplay]);
    else
      WeakAuras.EnsureOptions(tempGroup.id);
      self:FillOptions(displayOptions[tempGroup.id]);
    end
  end

  frame:SetClampedToScreen(true);
  local w,h = frame:GetSize();
  local left,right,top,bottom = w/2,-w/2,0,h-25
  frame:SetClampRectInsets(left,right,top,bottom);

  return frame;
end
