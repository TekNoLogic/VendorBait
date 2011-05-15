
local timeout = CreateFrame("Frame")
timeout:Hide()

local f = LibStub("tekShiner").new(QuestRewardScrollChildFrame)
f:Hide()


f:RegisterEvent("QUEST_COMPLETE")
f:RegisterEvent("QUEST_ITEM_UPDATE")
f:RegisterEvent("GET_ITEM_INFO_RECEIVED")
f:SetScript("OnEvent", function(self, ...)
	self:Hide()
	local bestp, besti = 0
	for i=1,GetNumQuestChoices() do
		local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
		if not link then
			timeout:Show()
			return
		end
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


local elapsed
timeout:SetScript("OnShow", function() elapsed = 0 end)
timeout:SetScript("OnHide", function() f:GetScript("OnEvent")(f) end)
timeout:SetScript("OnUpdate", function(self, elap)
	elapsed = elapsed + elap
	if elapsed < 1 then return end
	self:Hide()
end)

if QuestInfoItem1:IsVisible() then f:GetScript("OnEvent")(f) end
