private
compatibleVmUrls
	^ Dictionary newFromPairs: { 
		self class imageFormatPreSpur . self vmUrlTemplate format: { '50-preSpur' . '' . self downloadPathOSTypeSegment . 'stable' } .
		self class imageFormat32bits . self vmUrlTemplate format: { '70' . '' . self downloadPathOSTypeSegment . 'stable' } .
		self class imageFormat64bits . self vmUrlTemplate format: { '70' . '64' . self downloadPathOSTypeSegment . 'stable' }
	}