ScriptName CaravanLeaderScript Extends ReferenceAlias  Conditional

Int Property CaravanNumber Auto
{1: Caravan A, 2: Caravan B, 3: Caravan C - This conforms to the original vanilla API}

Event OnUpdateGameTime()

  Actor LeaderRef = GetActorReference()

  (GetOwningQuest() as CaravanScript).UpdateCaravan (CaravanNumber, LeaderRef, LeaderRef, WeAreDisablingCamp = True)

EndEvent

Event OnDeath (Actor akKiller)
	
  (GetOwningQuest() as CaravanScript).UpdateAliases (CaravanNumber, 0)
	
EndEvent
