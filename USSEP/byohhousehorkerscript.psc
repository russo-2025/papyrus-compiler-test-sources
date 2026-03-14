Scriptname BYOHHouseHorkerScript extends Actor  
{; makes them "tame" after you build the hatchery}

Faction Property WEPlayerFriend  Auto  

Event OnCellAttach()
	; check linked hatchery for fish
	BYOHHouseFishHatcheryScript myHatchery = GetLinkedRef() as BYOHHouseFishHatcheryScript
	if myHatchery && myHatchery.IsEnabled() ; USSEP 4.1.8 Bug #26495 - stop checking if fish are ready, the horkers shift hostility unpredictably because of this. && myHatchery.iSpawnCount > 0
		AddToFaction(WEPlayerFriend)
	endif
endEvent