Extension { #name : #UnixPlatform }

{ #category : #'*PharoLauncher-CLI' }
UnixPlatform >> processListArgs [

	^ 'pgrep -ai -f "pharo.*\.image"'

]

{ #category : #'*PharoLauncher-CLI' }
UnixPlatform >> processStartDateArgs [
	
	^ 'xargs -I{} date -d "{}" ''+%Y-%m-%d %H:%M:%S'''
]
