"
Exception signaled when a Pharo Launcher process launched exceeds the timeout given.
"
Class {
	#name : #PhLProcessTimeOut,
	#superclass : #PhLError,
	#category : #'PharoLauncher-Core-Download'
}

{ #category : #accessing }
PhLProcessTimeOut >> longDescription [
	^ 'Process took too much time. Aborted!'
]

{ #category : #accessing }
PhLProcessTimeOut >> name [
	^ 'Process timeout'
]
