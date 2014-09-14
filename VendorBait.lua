
local myname, ns = ...

local f = LibStub("tekShiner").new(QuestRewardScrollChildFrame)
f:Hide()


local function retry() f:GetScript("OnEvent")(f) end
f:RegisterEvent("QUEST_COMPLETE")
f:RegisterEvent("QUEST_ITEM_UPDATE")
f:RegisterEvent("GET_ITEM_INFO_RECEIVED")
f:SetScript("OnEvent", function(self, ...)
	self:Hide()
	local bestp, besti = 0
	for i=1,GetNumQuestChoices() do
		local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
		if not link then return ns.StartTimer(GetTime() + 1, retry) end

		local price = link and select(11, GetItemInfo(link))
		if not price then return
		elseif (price * (qty or 1)) > bestp then bestp, besti = (price * (qty or 1)), i end
	end

	if besti then
		local framename = "QuestInfoItem"
		if ns.isWOD then framename = "QuestInfoRewardsFrameQuestInfoItem" end
		self:ClearAllPoints()
		self:SetAllPoints(framename..besti.."IconTexture")
		self:Show()
	end
end)


if ns.isWOD and QuestFrameRewardPanel:IsVisible() then retry() end
if not ns.isWOD and QuestInfoItem1:IsVisible() then retry() end
