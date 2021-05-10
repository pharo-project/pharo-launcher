Extension { #name : #PharoLauncherApplication }

{ #category : #'*PharoLauncher-Spec2-Gtk' }
PharoLauncherApplication class >> openGtk [
	<script>
	
	^ (Default := self new)
		useBackend: #Gtk with: PhLGtkConfiguration new;
		openAsWorld: false;
		run
]
