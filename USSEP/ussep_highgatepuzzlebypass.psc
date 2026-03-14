Scriptname USSEP_HighGatePuzzleBypass extends ObjectReference  

Quest Property HGRQuest Auto
ObjectReference Property PuzzleDoor Auto
ObjectReference Property OpenMarker Auto

Auto State Waiting
	Event OnTriggerenter( ObjectReference ActorRef )
		GoToState( "Dormant" )

		if( Game.GetPlayer() == ActorRef )
			if( HGRQuest.GetStage() >= 30 )
				PuzzleDoor.Activate( OpenMarker )
			endif
		endif
	EndEvent
EndState

State Dormant
	Event OnTriggerEnter( ObjectReference ActorRef )
	EndEvent
EndState

Event OnReset()
	GotoState( "Waiting" )
EndEvent
