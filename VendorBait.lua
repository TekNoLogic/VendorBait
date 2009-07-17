
local f = LibStub("tekShiner").new(QuestRewardItem1)
f:Hide()


f:RegisterEvent("QUEST_COMPLETE")
f:SetScript("OnEvent", function(self)
	if not _G.GetSellValue then return end

	self:Hide()
	local bestp, besti = 0
	for i=1,GetNumQuestChoices() do
		local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
		local price = link and _G.GetSellValue(link)
		if not price then return
		elseif (price * (qty or 1)) > bestp then bestp, besti = (price * (qty or 1)), i end
	end

	if besti then
		self:ClearAllPoints()
		self:SetAllPoints("QuestRewardItem"..besti.."IconTexture")
		self:Show()
	end
end)


if QuestRewardItem1:IsVisible() then f:GetScript("OnEvent")(f) end
