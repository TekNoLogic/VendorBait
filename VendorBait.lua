
local myname, ns = ...

local f = ns.newShiner(QuestRewardScrollChildFrame)
f:Hide()


local function update()
	f:Hide()
	local bestp, besti = 0
	for i=1,GetNumQuestChoices() do
		local name, _, qty = GetQuestItemInfo("choice", i)
		local link = GetQuestItemLink("choice", i)
		if not link then return ns.StartTimer(GetTime() + 1, update) end

		local price = link and select(11, GetItemInfo(link))
		if not price then return
		elseif (price * (qty or 1)) > bestp then
			bestp = price * (qty or 1)
			besti = i
		end
	end

	if besti then
		local qif = QuestInfo_GetRewardButton(QuestInfoFrame.rewardsFrame, besti)
		f:ClearAllPoints()
		f:SetAllPoints(qif.Icon)
		f:Show()
	end
end
ns.RegisterEvent("QUEST_COMPLETE", update)
ns.RegisterEvent("QUEST_ITEM_UPDATE", update)
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", update)


if QuestFrameRewardPanel:IsVisible() then update() end
