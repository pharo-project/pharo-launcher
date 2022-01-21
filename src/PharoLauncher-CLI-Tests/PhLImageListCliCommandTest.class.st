Class {
	#name : #PhLImageListCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageListCliCommandTest >> testDelimiter [


	| aMatch aCommand |

	aMatch := (context arguments: #('launcher' 'image' 'list' '--delimiter' ' * ')) doMatch.
	aMatch := (aMatch at: #image) at: #list.


	aCommand :=  PhLImageListCliCommand new.

	aCommand setArguments: aMatch.
	self assert: aCommand delimiter equals: ' * '.
]

{ #category : #tests }
PhLImageListCliCommandTest >> testDelimiterImplicit [


	| aMatch aCommand |

	aMatch := (context arguments: #('launcher' 'image' 'list')) doMatch.
	aMatch := (aMatch at: #image) at: #list.


	aCommand :=  PhLImageListCliCommand new.

	aCommand setArguments: aMatch.
	self assert: aCommand delimiter equals: ' '.
]

{ #category : #tests }
PhLImageListCliCommandTest >> testDelimiterMissingArg [


	| aMatch aCommand |

	aMatch := (context arguments: #('launcher' 'image' 'list' '--delimiter')) doMatch.
	aMatch := (aMatch at: #image) at: #list.

	aCommand :=  PhLImageListCliCommand new.

	aCommand setArguments: aMatch.
	self should: [aCommand delimiter] raise: NotFound.
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListEmptyListImageShouldSucceed [
	
	self runCommand: #('launcher' 'image' 'list').
	 
	self assertSuccess.  
	self assert: self outputString equals:''.
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'list' '--brief' '--delimiter' '+').
	 
	self assertSuccess.  
	self assert: (self outputString includesSubstring:'myImage1').
	self assert: (self outputString includesSubstring:'myImage2').
	"self assert: (self outputString includesSubstring:'architecture: 64')."
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageShouldSucceedOutputInSTON [
	| images |
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	
	self runCommand: #('launcher' 'image' 'list' '--ston').
	 
	self assertSuccess.  
	images := STON fromString: self outputString.
	self assert: images size equals: 2.
	self assert: images first name equals: 'myImage1'.
	
]

{ #category : #tests }
PhLImageListCliCommandTest >> testListImageWithImageNameShouldSucceed [
	self addImageNamed: 'myImage1'.
	self addImageNamed: 'myImage2'.
	self addImageNamed: 'shouldNotBeListed'.
	self addImageNamed: 'myImage3'.
	
	self runCommand: #('launcher' 'image' 'list' '--name' 'myImage').
	 
	self assertSuccess.  
	self assert: (self outputString includesSubstring:'myImage1').
	self assert: (self outputString includesSubstring:'myImage2').
	self assert: (self outputString includesSubstring:'myImage3').
	self deny: (self outputString includesSubstring: 'shouldNotBeListed')
]
