--聖邪のステンドグラス
function c16598965.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16598965,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_TODECK+CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,16598965)
	e1:SetTarget(c16598965.target)
	e1:SetOperation(c16598965.activate)
	c:RegisterEffect(e1)
end
function c16598965.filter(c,race)
	return c:IsRace(race) and c:IsType(TYPE_EFFECT) and c:IsFaceup()
end
function c16598965.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local f1=Duel.IsExistingMatchingCard(c16598965.filter,tp,LOCATION_MZONE,0,1,nil,RACE_FAIRY) and Duel.IsPlayerCanDraw(tp,3)
	local f2=Duel.IsExistingMatchingCard(c16598965.filter,tp,LOCATION_MZONE,0,1,nil,RACE_FIEND) and Duel.IsPlayerCanDraw(1-tp,1)
	if chk==0 then return f1 or f2 end
end
function c16598965.activate(e,tp,eg,ep,ev,re,r,rp)
	local f1=Duel.IsExistingMatchingCard(c16598965.filter,tp,LOCATION_MZONE,0,1,nil,RACE_FAIRY) and Duel.IsPlayerCanDraw(tp,3)
	local f2=Duel.IsExistingMatchingCard(c16598965.filter,tp,LOCATION_MZONE,0,1,nil,RACE_FIEND) and Duel.IsPlayerCanDraw(1-tp,1)
	local res=false
	if f1 and (not f2 or Duel.SelectYesNo(tp,aux.Stringid(16598965,1))) and Duel.Draw(tp,3,REASON_EFFECT)==3 then
		res=true
		local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,nil)
		if #g<2 then return end
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
		local sg=g:Select(tp,2,2,nil)
		Duel.SendtoDeck(sg,nil,0,REASON_EFFECT)
		Duel.SortDecktop(tp,tp,2)
		for i=1,2 do
			local mg=Duel.GetDecktopGroup(tp,1)
			Duel.MoveSequence(mg:GetFirst(),1)
		end
	end
	if f2 and (not res or Duel.SelectYesNo(tp,aux.Stringid(16598965,2))) and Duel.Draw(1-tp,1,REASON_EFFECT)==1 then
		Duel.ShuffleHand(1-tp)
		Duel.BreakEffect()
		local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
		if #g==0 then return end
		local sg=g:RandomSelect(1-tp,1)
		Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
		local g1=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
		if #g1==0 then return end
		Duel.BreakEffect()
		Duel.DiscardHand(1-tp,aux.TRUE,1,1,REASON_EFFECT+REASON_DISCARD)
	end
end
