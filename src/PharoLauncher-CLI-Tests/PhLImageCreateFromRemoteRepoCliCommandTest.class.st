"
A PhLImageCreateFromRemoteRepoCliCommandTest is a test class for testing the behavior of PhLImageCreateFromRemoteRepoCliCommand
"
Class {
	#name : #PhLImageCreateFromRemoteRepoCliCommandTest,
	#superclass : #PhLImageCliCommandTest,
	#category : #'PharoLauncher-CLI-Tests'
}

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testBaselineName [

	| createCommand |

	createCommand := (PhLImageCreateFromRemoteRepoCliCommand asCliCommand activationWith: #('fromRepo' 'pharo-project/pharo-launcher:development')) command.
	
	"Baseline name is implicit - determined from repo name: pharo-launcher"
	self assert: createCommand baselineName	equals: 'PharoLauncher'.
	
	createCommand := (PhLImageCreateFromRemoteRepoCliCommand asCliCommand activationWith: #('fromRepo' 'pharo-project/pharo-launcher:development' '--baseline' 'SomeBaseline')) command. 	
	
	"Baseline name is explicit - defined by CLI argument"
	self assert: createCommand baselineName	equals: 'SomeBaseline'.
]

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testCreateFromRemoteRepoMissingArgs [

	self runCommand: #('launcher' 'image' 'create' 'fromRepo').
	self assertFailure.
	self assert: (self errorString includesSubstring: 'specify the Github repository').
]

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testInvalidRepoNames [

	| shouldFailNames commandSpec |
	commandSpec := PhLImageCreateFromRemoteRepoCliCommand asCliCommand.
	shouldFailNames := #('owner' 'owner/project:' 'owner/some-project:someNoise#$%^&').
	shouldFailNames do: [:repoName | 
		|createCommand|
 		createCommand := (commandSpec activationWith: { 'fromRepo'. repoName. } asArray) command.
		self should: [createCommand validateRepoFullName] raise: PhLError. 
	]
	
]

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testMcLoadProjectFromRepo [

	| createCommand |

	createCommand := (PhLImageCreateFromRemoteRepoCliCommand asCliCommand activationWith: #('fromRepo' 'pharo-project/pharo-launcher:development' '--group' 'tests')) command.
	
	"Baseline name is implicit - determined from repo name: pharo-launcher"
	self assert: createCommand mcLoadProjectFromRepo 	equals: 'Iceberg remoteTypeSelector: #httpsUrl. Metacello new baseline: ''PharoLauncher''; repository: ''github://pharo-project/pharo-launcher:development/src''; onConflictUseIncoming; load: ''tests''' surroundedByDoubleQuotes.
]

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testValidCreateFromRemoteRepo [

	|aReport|
	aReport := self validationReportFor: #('launcher' 'image' 'create' 'fromRepo' 'pharo/pharo-launcher').
	self assert: aReport isSuccess description: aReport printString.
]

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testValidCreateFromRemoteRepoWithAllArgs [

	|aReport|
	aReport := self validationReportFor:  #('launcher' 'image' 'create' 'fromRepo' 'pharo/pharo-launcher' '--newImageName' 'MyTestImage' '--templateName' 'Mooc' '--templateCategory' 'Offcial' '--subfolder' 'dev/src' '--baseline' 'myBaseline').
	self assert: aReport isSuccess description: aReport printString.
]

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testValidateRepoFullName [

	| commandSpec validRepoNames invalidRepoName createCommand |
	
	commandSpec := PhLImageCreateFromRemoteRepoCliCommand asCliCommand.
	validRepoNames := #('owner/project' 'owner/project:branch' 'owner/some-project:feature/branch-name' 'owner/project:v1' 'owner/project:v1.1' 'owner/project:v1.1a' 'owner/project:V1.1.1a' 'owner/project:1.0-RC-somecomment').

	validRepoNames do: [:repoName | 
		createCommand := (commandSpec activationWith: { 'fromRepo'. repoName }) command.
		self 
			assert: createCommand isValidRepoFullName 
			description: 'Valid repository name not validated: ', repoName.
	].

	invalidRepoName := 'owner/project:'.
	createCommand := (commandSpec activationWith: { 'fromRepo'. invalidRepoName }) command.
	self 
		deny: createCommand isValidRepoFullName 
		description: 'Invalid repository name validated: ', invalidRepoName.
]
