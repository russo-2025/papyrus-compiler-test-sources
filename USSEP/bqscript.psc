Scriptname BQScript extends Quest  Conditional
{Script on BQ quests, has common properties and functions.}

MiscObject Property Gold001 Auto
Int Property RewardAmount = 100 Auto
{Default = 100; How much gold to reward player.}

Keyword Property BQActiveQuest Auto

LocationAlias Property Alias_Location Auto
LocationAlias Property Hold Auto

function RewardPlayer()
	Game.GetPlayer().AddItem(Gold001, RewardAmount)

EndFunction

function PlayerChangedLocation()

	if getStage() < 10
		;USKP 2.0.4 - Somehow this quest is getting a bad location for the primary alias and this should not be possible.
		;Further diagnosis after seeing an alias dump shows *ALL* aliases are broken, so just kill it and be done with it.
		if( Alias_Location.GetLocation() == None )
			;no need to delete anything here, all aliases will be null
			stop()
		Else
			if Game.GetPlayer().IsInLocation(Alias_Location.GetLocation()) == False
	; 			debug.trace(self + " player is no longer in location and hasn't picked up quest, shutting down quest so it can happen elsewhere.")
				Hold.GetLocation().setKeywordData(BQActiveQuest, 0)

				;USSEP Bug #34295 - Fix for save bloat caused by letters not being deleted.
				ReferenceAlias Alias_Letter = Self.GetAlias(9) as ReferenceAlias  ;All four bounty quests use alias 9 as as the alias.
				if( Alias_Letter != None )
					Alias_Letter.GetReference().Delete()
				endif
				;END Fix for 34295
				stop()
			EndIf
		EndIf
	EndIf
EndFunction
