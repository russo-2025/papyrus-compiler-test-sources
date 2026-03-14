Scriptname DA14SammyScript extends ReferenceAlias  

ReferenceAlias Property DA14GiantAlias  Auto  

Event OnActivate(ObjectReference akActionRef)
	if akActionRef == Game.GetPlayer()
		if !GetOwningQuest().IsStageDone(75) && !GetOwningQuest().IsStageDone(85) ; USSEP 4.2.9 Bug #32447
			GetOwningQuest().SetStage(75)
			DA14GiantAlias.GetActorRef().StartCombat(Game.GetPlayer())
			GetActorRef().EvaluatePackage()
		endif
	endif
endEvent
