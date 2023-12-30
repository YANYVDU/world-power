﻿function MC_Maratha_GunpowderSepoys(teamID, techID)
    local playerID = Teams[teamID]:GetLeaderID()
    local player = Players[playerID]
    if player:GetCivilizationType() ~= civilizationMarathaID then return end
    if techID == techGunpowderID then
        local capital = player:GetCapitalCity()
        player:InitUnit(unitSepoyID, capital:GetX(), capital:GetY())
        player:InitUnit(unitSepoyID, capital:GetX(), capital:GetY())
    end
end
GameEvents.TeamTechResearched.Add(MC_Maratha_GunpowderSepoys)



		--建筑对全局杰作产出
		GreatWorkyieldChange = 0
		for row in  GameInfo.Building_GreatWorkYieldChanges( thisBuildingAndYieldTypes ) do
			GreatWorkyieldChange = GreatWorkyieldChange + (row.Yield or 0)
		end


iImmobileWhileDamaged = GameInfo.UnitPromotions["PROMOTION_IMMOBILE_WHILE_DAMAGED"].ID




-- ****************************************
-- 异种研究所
-- ****************************************	
function JurassicParkBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer == nil or (not pPlayer:IsMajorCiv()) then
	 	return
	         end
    if pPlayer:GetCurrentEra()~=GameInfoTypes.ERA_FUTURE  then
			return
	   end
	if  pPlayer:HasWonder(GameInfoTypes.BUILDING_FW_JURASSIC_PARK)  then

		local iCheckForDinos = LocalizingRandom(1, 100)
		if (iCheckForDinos < 90) then
			local tPlots ={}
			local tPlots2 ={}
			for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(GameInfoTypes.BUILDING_FW_JURASSIC_PARK) then	
						local pCentralPlot = pCity:Plot()
			             for pPlot in PlotAreaSpiralIterator(pCentralPlot, 4, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
							local iTerrain = pPlot:GetTerrainType()
							local iOwner = pPlot:GetOwner()
							if (((iTerrain == GameInfoTypes.TERRAIN_PLAINS) or 
							(iTerrain == GameInfoTypes.TERRAIN_GRASS)) 
							and (iOwner == iPlayer) and (pPlot:GetNumUnits() == 0) and not (pPlot:IsMountain())) then
								table.insert(tPlots, pPlot)
								end
                            if (((iTerrain == GameInfoTypes.TERRAIN_OCEAN) ) 
							and (iOwner == iPlayer) and (pPlot:GetNumUnits() == 0) 
							and not (pPlot:IsMountain())) then
								table.insert(tPlots2, pPlot)
								end
								--print("Inserted plot")
							end
						end
					end
				--end
			--end
			if #tPlots > 0 then
				local randomNumber = LocalizingRandom(1, #tPlots)
				local tPlot = tPlots[randomNumber]
				local iDinoNumber = LocalizingRandom(1, 100)
				--print("单位种类 " .. 根据随机数确定)
				if (iDinoNumber >= 80) and  (pPlayer:GetUnitClassCount(GameInfo.UnitClasses.UNITCLASS_ALIEN_SIEGE_WORM.ID) == 0 ) then 
					iDinoType = GameInfoTypes.UNIT_ALIEN_SIEGE_WORM
					local nUnit = pPlayer:InitUnit(iDinoType, tPlot:GetX(), tPlot:GetY())
				end
				if (iDinoNumber <= 10) and  (pPlayer:GetUnitClassCount(GameInfo.UnitClasses.UNITCLASS_HOVER_WORM.ID) == 0 ) 
				and pPlayer:IsHasTech(GameInfo.Technologies["TECH_COGNITIVE"].ID) then 
					iDinoType3 = GameInfoTypes.UNIT_HOVER_WORM
					local nUnit3 = pPlayer:InitUnit(iDinoType3, tPlot:GetX(), tPlot:GetY())
					end
				end
             if #tPlots2 > 0 then
				local randomNumber = LocalizingRandom(1, #tPlots2)
				local tPlot2 = tPlots2[randomNumber]
				local iDinoNumber = ROG_GetTrueRandom(1, 100)
				if (iDinoNumber <= 15) and  (pPlayer:GetUnitClassCount(GameInfo.UnitClasses.UNITCLASS_NAVAL_MONSTER.ID) == 0 ) 
				and pPlayer:IsHasTech(GameInfo.Technologies["TECH_MATTERTRANSMISSION"].ID) then 
					iDinoType2 = GameInfoTypes.UNIT_NAVAL_MONSTER
					local nUnit2 = pPlayer:InitUnit(iDinoType2, tPlot2:GetX(), tPlot2:GetY())
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JurassicParkBonus)



GameEvents.PlayerCanFoundCityRegardless.Add(function(iPlayer, iPlotX, iPlotY) return false end) 



function OnUnitCanRangeAttackAt(iPlayer,iPlotX, iPlotY)
	local pPlayer = Players[iPlayer]
	local pPlot = Map.GetPlot(iPlotX, iPlotY)
	
	if (pUnitInfo.RangedPillage > 0) then
		local pPlot = Map.GetPlot(iX, iY)
		local ePlayer = Players[pPlot:GetOwner()]
		local iRangedPillage = pUnitInfo.RangedPillage

    	if (pPlot:GetImprovementType() ~= -1 and PlayersAtWar(ePlayer, pPlayer)) then
      		print(string.format("%s can range pillage the improvement at (%i, %i)", pUnit:GetName(), iX, iY))

      		if (iRangedPillage == 1 or not pPlot:IsImprovementPillaged()) then
        		-- TODO - for an AI player, does this unit want to pillage the tile?  This opens a whole can of worms!
	    		return pPlayer:IsHuman();
	  		end
		elseif (pPlot:IsRoute()) then
      	print(string.format("%s can range pillage the route at (%i, %i)", pUnit:GetName(), iX, iY))

      		if (iRangedPillage == 1 or not pPlot:IsRoutePillaged()) then
        		-- TODO - for an AI player, does this unit want to pillage the tile?  This opens a whole can of worms!
	   	 		return pPlayer:IsHuman();
	  		end
		end
  	end
  return false;
end
GameEvents.UnitCanRangeAttackAt.Add(OnUnitCanRangeAttackAt)

local tMissions = {
iMove = MissionTypes.MISSION_MOVE_TO,
iRoute = MissionTypes.MISSION_ROUTE_TO,
iMovetoUnit = MissionTypes.MISSION_MOVE_TO_UNIT,
iSwap = MissionTypes.MISSION_SWAP_UNITS
}

function ImmobileWhileDamaged(iPlayer, iUnit, iMission)
local pPlayer = Players[iPlayer]
local pUnit = pPlayer:GetUnitByID(iUnit)

if (pUnit:IsHasPromotion(iImmobileWhileDamaged)) and (pUnit:GetCurrHitPoints() < pUnit:GetMaxHitPoints()) then
for sKey, iValue in pairs(tMissions) do
if iMission == iValue then
return false
end
end
end

return true

end
GameEvents.CanStartMission.Add(ImmobileWhileDamaged)












#if defined(MOD_ROG_CORE)
				if (pkDefender->GetIgnoreDamageChance() > 0)
				{
					int iRand = GC.getGame().getJonRandNum(100, "Ignore Damage Chance");
					if (iRand <= pkDefender->GetIgnoreDamageChance())
					{
						iDamage = 0;
					}
				}
#endif
		
		<Row Tag="TXT_KEY_CITYVIEW_BASE_YIELD_TT_FROM_GARRISONED_UNIT">
			<Text>[NEWLINE][ICON_BULLET]{1_Num}{2_IconString} 来自驻军</Text>
		</Row>





	// Garrisoned Unit
	CvUnit* pGarrisonedUnit = GetGarrisonedUnit();
	int iStrengthFromUnits = 0;
	if(pGarrisonedUnit)
	{
#if defined(MOD_UNITS_MAX_HP)
		int iMaxHits = pGarrisonedUnit->GetMaxHitPoints();
#else
		int iMaxHits = GC.getMAX_HIT_POINTS();
#endif
		iStrengthFromUnits = pGarrisonedUnit->GetBaseCombatStrength() * 100 * (iMaxHits - pGarrisonedUnit->getDamage()) / iMaxHits;
	}




int CvCity::getCrimeFromGarrisonedUnit() const
{
	int iCrimeFromGarrisonedUnit = 0;
	// Garrisoned Unit
	CvUnit* pGarrisonedUnit = GetGarrisonedUnit();
	if (pGarrisonedUnit)
	{
		int iGarrisonedStrength = 0;
		iGarrisonedStrength = pGarrisonedUnit->GetBaseCombatStrength();

		if (iGarrisonedStrength <= 30)
		{
			iCrimeFromGarrisonedUnit = 3;
		}
		else if (iGarrisonedStrength >30 && iGarrisonedStrength<= 60)
		{
			iCrimeFromGarrisonedUnit = 5;
		}
		else if (iGarrisonedStrength > 60 && iGarrisonedStrength <= 100)
		{
			iCrimeFromGarrisonedUnit = 7;
		}
		else if (iGarrisonedStrength > 100 && iGarrisonedStrength <= 200)
		{
			iCrimeFromGarrisonedUnit = 10;
		}
		else if (iGarrisonedStrength > 200 )
		{
			iCrimeFromGarrisonedUnit = 15;
		}
	}
	return iCrimeFromGarrisonedUnit;
}



	if (eIndex == YIELD_CRIME && owner.isGoldenAge())
	{
		iTempMod = GC.getMAX_HIT_POINTS();
		iModifier += iTempMod;
		if (iTempMod != 0 && toolTipSink)
			GC.getGame().BuildProdModHelpText(toolTipSink, "TXT_KEY_PRODMOD_YIELD_GOLDEN_AGE", iTempMod);
	}

	if (eIndex == YIELD_LOYALTY && owner.isGoldenAge())
	{
		iTempMod = GC.getCITY_LOYALTY_GOLDEN_AGE_YIELD();
		iModifier += iTempMod;
		if (iTempMod != 0 && toolTipSink)
			GC.getGame().BuildProdModHelpText(toolTipSink, "TXT_KEY_PRODMOD_YIELD_GOLDEN_AGE", iTempMod);
	}

		inline int getCITY_CRIME_GOLDEN_AGE_YIELD()
	{
		return m_iCITY_CRIME_GOLDEN_AGE_YIELD;
	}
	inline int getCITY_LOYALTY_GOLDEN_AGE_YIELD()
	{
		return m_iCITY_LOYALTY_GOLDEN_AGE_YIELD;
	}