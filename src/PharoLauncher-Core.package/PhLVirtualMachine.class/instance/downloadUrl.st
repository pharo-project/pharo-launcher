querying
downloadUrl
	| manager |
	manager := PhLVirtualMachineManager new.
	
	^ manager vmUrlTemplate
		format: { self pharoVersion . self archPath . manager downloadPathOSTypeSegment . 'stable' }