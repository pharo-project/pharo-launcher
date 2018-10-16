private
compatibleVmUrls
	"50-preSpur stable is not the latest stable pre-Spur VM. 40 vm is the latest stable pre-Spur"
	^ Dictionary newFromPairs: { 
		self class imageFormat6504 . self vmUrlTemplate format: { '13' . '' . self downloadPathOSTypeSegment . 'stable' } .
		self class imageFormatPreSpur . self vmUrlTemplate format: { '40' . '' . self downloadPathOSTypeSegment . 'stable' } .
		self class imageFormat32bits . self vmUrlTemplate format: { '70' . '' . self downloadPathOSTypeSegment . 'stable' } .
		self class imageFormat64bits . self vmUrlTemplate format: { '70' . '64' . self downloadPathOSTypeSegment . 'stable' }
	}