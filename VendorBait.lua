
local f = LibStub("tekShiner").new(QuestRewardScrollChildFrame)
f:Hide()


f:RegisterEvent("QUEST_COMPLETE")
f:SetScript("OnEvent", function(self)
	self:Hide()
	local bestp, besti = 0
	for i=1,GetNumQuestChoices() do
		local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
		local price = link and select(11, GetItemInfo(link))
		if not price then return
		elseif (price * (qty or 1)) > bestp then bestp, besti = (price * (qty or 1)), i end
	end

	if besti then
		self:ClearAllPoints()
		self:SetAllPoints("QuestInfoItem"..besti.."IconTexture")
		self:Show()
	end
end)


if QuestInfoItem1:IsVisible() then f:GetScript("OnEvent")(f) end
