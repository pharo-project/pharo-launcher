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

	| createCommand aMatchWithBaseline matchNoBaseline|
	
	createCommand := PhLImageCreateFromRemoteRepoCliCommand new.
	matchNoBaseline := (context arguments: { 'launcher'. 'image'. 'create'. 'fromRepo'. 'pharo-project/pharo-launcher:development'. } asArray) doMatch.
	matchNoBaseline := ((matchNoBaseline at: #image) at: #create) at: #fromRepo.
	createCommand setArguments: matchNoBaseline.
	
	"Baseline name is implicit - determined from repo name: pharo-launcher"
	self assert: createCommand baselineName	equals: 'PharoLauncher'.
		
	aMatchWithBaseline := (context arguments: { 'launcher'. 'image'. 'create'. 'fromRepo'. 'pharo-project/pharo-launcher:development'. '--baseline'. 'SomeBaseline'. } asArray) doMatch.
	aMatchWithBaseline := ((aMatchWithBaseline at: #image) at: #create) at: #fromRepo.
	createCommand setArguments: aMatchWithBaseline.

	"Baseline name is explicit - defined by CLI argument"
	self assert: createCommand baselineName	equals: 'SomeBaseline'.
]

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testInvalidRepoNames [

	| createCommand  shouldFailNames|
	
	createCommand := PhLImageCreateFromRemoteRepoCliCommand new.
	shouldFailNames := #('owner' 'owner/project:' 'owner/some-project:someNoise#$%^&').
	shouldFailNames do: [:repoName | 
		|aMatch|
 		aMatch := (context arguments: { 'launcher'. 'image'. 'create'. 'fromRepo'. repoName. } asArray) doMatch.
		aMatch := ((aMatch at: #image) at: #create) at: #fromRepo.
		createCommand setArguments: aMatch.
		self should: [createCommand validateRepoFullName] raise: Error. 
	]
	
]

{ #category : #tests }
PhLImageCreateFromRemoteRepoCliCommandTest >> testValidateRepoFullName [

	| createCommand  validRepoNames |
	
	createCommand := PhLImageCreateFromRemoteRepoCliCommand new.
	validRepoNames := #('owner/project' 'owner/project:branch' 'owner/some-project:feature/branch-name').
	validRepoNames do: [:repoName | 
		|aMatch|
 		aMatch := (context arguments: { 'launcher'. 'image'. 'create'. 'fromRepo'. repoName. } asArray) doMatch.
		aMatch := ((aMatch at: #image) at: #create) at: #fromRepo.
		createCommand setArguments: aMatch.
		createCommand validateRepoFullName. 
	]
	
]
