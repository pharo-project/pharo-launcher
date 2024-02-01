Extension { #name : #MacOSPlatform }

{ #category : #'*PharoLauncher-CLI' }
MacOSPlatform >> processListArgs [

	^ 'pgrep -ai -f "pharo.*\.image" | xargs ps -o pid,args= -p | grep -v -e "PID"'

]

{ #category : #'*PharoLauncher-CLI' }
MacOSPlatform >> processStartDateArgs [
	
	^ 'xargs -I{} date -jf "%a %b %e %T %Y" "{}" ''+%Y-%m-%d %H:%M:%S'''
]
