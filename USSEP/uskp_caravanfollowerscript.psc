ScriptName USKP_CaravanFollowerScript Extends ReferenceAlias Conditional

Int Property CaravanNumber Auto
{1: Caravan A, 2: Caravan B, 3: Caravan C - This conforms to the original vanilla API}

Int Property MemberIndex Auto
{0: Leader, 1: Follower 1, 2: Follower 2, 3: Follower 3}

Event OnDeath (Actor akKiller)
	
  (GetOwningQuest() as CaravanScript).UpdateAliases (CaravanNumber, MemberIndex)
	
EndEvent
