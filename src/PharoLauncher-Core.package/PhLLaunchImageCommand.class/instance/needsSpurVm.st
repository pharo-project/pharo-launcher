action
needsSpurVm
	|version byteStream|

	byteStream := FileStream fileNamed: context singleImageName.
	byteStream binary.
	version := byteStream nextLittleEndianNumber: 4.
	byteStream close.
	^version~=6505
