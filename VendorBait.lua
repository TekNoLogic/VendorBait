
local mrsparkle = {}
local f = CreateFrame("Frame", nil, QuestRewardItem1)
f:Hide()

for i=1,4 do
	local tex = f:CreateTexture(nil, "BACKGROUND")
	tex:SetTexture("Interface\\ItemSocketingFrame\\UI-ItemSockets")
	tex:SetTexCoord(0.3984375, 0.4453125, 0.40234375, 0.44921875)
	tex:SetBlendMode("ADD")
	tex:SetWidth(13) tex:SetHeight(13)
	mrsparkle[i] = tex
end


local elapsed = 0
f:SetScript("OnShow", function() elapsed = 0 end)
f:SetScript("OnUpdate", function(self, elap)
	local speed = 2.5
	elapsed = elapsed + elap
	if elapsed > speed then elapsed = 0 end

	local distance = self:GetWidth()
	mrsparkle[1]:SetPoint("CENTER", self, "TOPLEFT", elapsed/speed*distance, 0)
	mrsparkle[2]:SetPoint("CENTER", self, "BOTTOMRIGHT", -elapsed/speed*distance, 0)
	mrsparkle[3]:SetPoint("CENTER", self, "TOPRIGHT", 0, -elapsed/speed*distance)
	mrsparkle[4]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, elapsed/speed*distance)
end)


f:RegisterEvent("QUEST_COMPLETE")
f:SetScript("OnEvent", function(self)
	if not _G.GetSellValue then return end

	self:Hide()
	local bestp, besti = 0
	for i=1,GetNumQuestChoices() do
		local link, name, _, qty = GetQuestItemLink("choice", i), GetQuestItemInfo("choice", i)
		local price = link and _G.GetSellValue(link)
		if not price then return
		elseif price > bestp then bestp, besti = price, i end
	end

	if besti then
		self:ClearAllPoints()
		self:SetAllPoints("QuestRewardItem"..besti.."IconTexture")
		self:Show()
	end
end)


if QuestRewardItem1:IsVisible() then f:GetScript("OnEvent")(f) end
