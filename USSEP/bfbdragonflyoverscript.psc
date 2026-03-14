scriptname BFBdragonFlyoverSCRIPT extends objectReference
;USSEP 4.3.2 Bug #15086 - Script has been modified so that the intended control quest will stop and allow the corpse to be culled by the game.

ReferenceAlias property Dragon auto
objectReference property initialPosition auto
objectReference property dragonsEnabled auto
quest property BFBquest auto

bool doEnterOnce
bool doLeaveOnce

EVENT OnTriggerEnter(objectReference actronaut)
	if doEnterOnce == FALSE && actronaut == game.getPlayer() && BFBquest.isStageDone(90) == TRUE && dragonsEnabled.isEnabled()
		doEnterOnce = TRUE
		Dragon.GetReference().moveTo(initialPosition)
		Dragon.GetReference().enable()
	endif
endEVENT

EVENT OnTriggerLeave(objectReference actronaut)
	if doLeaveOnce == FALSE && actronaut == game.getPlayer() && Dragon.GetReference().isEnabled() == TRUE
		doLeaveOnce = TRUE
		BFBquest.setStage(91)
		Dragon.GetActorReference().setActorValue("aggression", 1)
		Dragon.GetActorReference().startCombat(game.getPlayer())
		self.disable()
	endif
endEVENT
