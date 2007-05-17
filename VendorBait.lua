
local _G = getfenv(0)
local model = CreateFrame("Model", nil, QuestRewardScrollFrame)
model:SetModel"Interface\\Buttons\\UI-AutoCastButton.mdx"
model:SetSequence(0)
model:SetSequenceTime(0, 0)
model:SetScale(1.5)
model:SetFrameLevel(QuestRewardItem1:GetFrameLevel()+1)


local f = CreateFrame("Frame")
f:RegisterEvent("QUEST_COMPLETE")
f:SetScript("OnEvent", function()
	if not _G.GetSellValue then return end

	model:Hide()
	local bestp, besti, unk = 0
	for i=1,GetNumQuestChoices() do
		local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
		local price = _G.GetSellValue(link)
		if not price then unk = true
		elseif price > bestp then bestp, besti = price, i end
	end

	if not unk and besti then
		model:ClearAllPoints()
		model:SetAllPoints("QuestRewardItem"..besti.."IconTexture")
		model:Show()
	end
end)
