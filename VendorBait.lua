
local myname, ns = ...

local f = LibStub("tekShiner").new(QuestRewardScrollChildFrame)
f:Hide()


local function update()
	f:Hide()
	local bestp, besti = 0
	for i=1,GetNumQuestChoices() do
		local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
		if not link then return ns.StartTimer(GetTime() + 1, update) end

		local price = link and select(11, GetItemInfo(link))
		if not price then return
		elseif (price * (qty or 1)) > bestp then bestp, besti = (price * (qty or 1)), i end
	end

	if besti then
		local framename = "QuestInfoItem"
		if ns.isWOD then framename = "QuestInfoRewardsFrameQuestInfoItem" end
		f:ClearAllPoints()
		f:SetAllPoints(framename..besti.."IconTexture")
		f:Show()
	end
end)
ns.RegisterEvent("QUEST_COMPLETE", update)
ns.RegisterEvent("QUEST_ITEM_UPDATE", update)
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", update)


if ns.isWOD and QuestFrameRewardPanel:IsVisible() then update() end
if not ns.isWOD and QuestInfoItem1:IsVisible() then update() end
