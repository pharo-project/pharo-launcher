Class {
	#name : #PhLJenkins2ServerTest,
	#superclass : #PhLJenkins2EntityTest,
	#category : #'PharoLauncher-Tests-Download'
}

{ #category : #'instance creation' }
PhLJenkins2ServerTest class >> newInstance [
	^ PhLJenkins2Server name: 'foo' url: 'bar' asUrl
]

{ #category : #'instance creation' }
PhLJenkins2ServerTest class >> newSecureInstance [
	^ self newInstance
		username: 'BadetitouTheUnicorn';
		password: 'dkewjdcnriuwefjncreiuhf';
		yourself
]

{ #category : #responses }
PhLJenkins2ServerTest >> defaultJobName [
	^ 'theJobName'
]

{ #category : #responses }
PhLJenkins2ServerTest >> defaultJobUrlString [
	^ 'http://server/segment'
]

{ #category : #responses }
PhLJenkins2ServerTest >> noJobsResponse [
	^ '{"jobs" : []}'
]

{ #category : #responses }
PhLJenkins2ServerTest >> oneJobResponse [
	^ '{"jobs" : [
		{
			"name" : "',self defaultJobName,'",
			"url" : "' , self defaultJobUrlString, '"
		}
		]}'
]

{ #category : #tests }
PhLJenkins2ServerTest >> testNoJob [
	self setUpResponse: self noJobsResponse.
	self assert: self newInstance jobs isEmpty
]

{ #category : #tests }
PhLJenkins2ServerTest >> testWith1Job [
	| job server |
	self setUpResponse: self oneJobResponse.
	server := self newInstance.
	self assert: server jobs size equals: 1.
	job := server jobs first.
	self assert: job name equals: self defaultJobName.
	self assert: job url equals: self defaultJobUrlString asUrl
]
