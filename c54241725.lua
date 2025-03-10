--真源の帝王
function c54241725.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_ATTACK+TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(54241725,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCountLimit(1)
	e2:SetTarget(c54241725.drtg)
	e2:SetOperation(c54241725.drop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(54241725,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,54241725)
	e3:SetHintTiming(0,TIMING_MAIN_END+TIMING_END_PHASE)
	e3:SetCost(c54241725.spcost)
	e3:SetTarget(c54241725.sptg)
	e3:SetOperation(c54241725.spop)
	c:RegisterEffect(e3)
end
function c54241725.tdfilter(c)
	return c:IsSetCard(0xbe) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToDeck()
end
function c54241725.drtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c54241725.tdfilter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingTarget(c54241725.tdfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c54241725.tdfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c54241725.drop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()<=0 then return end
	Duel.SendtoDeck(tg,nil,0,REASON_EFFECT)
	Duel.ShuffleDeck(tp)
	Duel.BreakEffect()
	Duel.Draw(tp,1,REASON_EFFECT)
end
function c54241725.cfilter(c)
	return c:IsSetCard(0xbe) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToRemoveAsCost()
end
function c54241725.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c54241725.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler())
		and e:GetHandler():GetFlagEffect(54241725)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c54241725.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:GetHandler():RegisterFlagEffect(54241725,RESET_CHAIN,0,1)
end
function c54241725.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,54241725,0,TYPES_NORMAL_TRAP_MONSTER,1000,2400,5,RACE_FAIRY,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c54241725.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.IsPlayerCanSpecialSummonMonster(tp,54241725,0,TYPES_NORMAL_TRAP_MONSTER,1000,2400,5,RACE_FAIRY,ATTRIBUTE_LIGHT) then
		c:AddMonsterAttribute(TYPE_NORMAL)
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
	end
end
