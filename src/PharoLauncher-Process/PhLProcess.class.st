Class {
	#name : #PhLProcess,
	#superclass : #FFILibrary,
	#category : #'PharoLauncher-Process'
}

{ #category : #'*PharoLauncher-Process' }
PhLProcess class >> clear: externalStructure [
	^ self memSet: externalStructure value: 0
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess class >> closeHandle: handle [
	^ self uniqueInstance closeHandle: handle
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess class >> createProcess: app command: cmd [ 
	^ self createProcess: app command: cmd waits: true
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess class >> createProcess: app command: cmd waits: waits [
	| startupInfo processInfo result cmdString kNoWindow |
	kNoWindow := 16r08000000.
	cmd ifNotNil: [ cmdString := ExternalAddress fromString: cmd ].
	startupInfo := PhLStartupInfo externalNew.
	processInfo := PhLProcessInformation externalNew.
	result := self uniqueInstance
		createProcess: app
		command: (cmdString ifNil: [ ExternalAddress null ])
		processAttributes: nil
		threadAttributes: nil
		inheritHandles: 0
		creationFlags: kNoWindow
		environment: nil
		directory: nil
		startup: startupInfo getHandle
		processInformation: processInfo getHandle.
	result isZero
		ifTrue: [ ^ result ].
	waits
		ifTrue: [ self uniqueInstance waitForSingleObject: processInfo process milliSeconds: 16rffffffff ].
	self closeHandle: processInfo process.
	self closeHandle: processInfo thread.
	processInfo free.
	startupInfo free.
	cmdString ifNotNil: [ cmdString free ].
	^ result
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess class >> getLastError [
	^ self uniqueInstance getLastError
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess class >> memSet: externalStructure value: value [
	^ self uniqueInstance memSet: externalStructure getHandle value: value size: externalStructure class structureSize
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess class >> runAsyncCommand: command [
	^ Smalltalk os isWindows
		ifTrue: [ self createProcess: 'C:\Windows\System32\cmd.exe' command: '/C ', command waits: false]
		ifFalse: [ LibC system: command]
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess class >> runCommand: command [
	^ Smalltalk os isWindows
		ifTrue: [ self createProcess: 'C:\Windows\System32\cmd.exe' command: '/C ', command]
		ifFalse: [ LibC system: command]
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess >> closeHandle: handle [
	^ self ffiCall: #(int CloseHandle(void * handle)) module: #Kernel32
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess >> createProcess: appName command: command processAttributes: procAttr threadAttributes: threadAttr inheritHandles: inherit creationFlags: flags environment: env directory: dir startup: startup processInformation: processInfo [
	^ self ffiCall: #(int CreateProcessA (const char * appName, char * command, 0, 0, 0, ulong flags, 0, 0, ExternalAddress * startup, ExternalAddress * processInfo)) module: #Kernel32
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess >> getLastError [
	^ self ffiCall: #(uint GetLastError(void)) module: #Kernel32
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess >> memSet: ptr value: value size: size [
	^ self ffiCall: #(ExternalAddress * memset(ExternalAddress * ptr, int value, size_t size))
]

{ #category : #'*PharoLauncher-Process' }
PhLProcess >> waitForSingleObject: handle milliSeconds: ms [
	^ self ffiCall: #( uint WaitForSingleObject (void * handle, uint ms)) module: #Kernel32
]

{ #category : #'accessing platform' }
PhLProcess >> win32ModuleName [
	^ 'msvcrt.dll'
]
