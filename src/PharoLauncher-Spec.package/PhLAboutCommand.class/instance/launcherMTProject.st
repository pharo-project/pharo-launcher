querying
launcherMTProject
	^ project ifNil: [ project := MCModel2MTModelVisitor new 
		visitConfiguration: self launcherMetacalloConfiguration 
		withVersion: self launcherCurrentMetacalloVersion ]