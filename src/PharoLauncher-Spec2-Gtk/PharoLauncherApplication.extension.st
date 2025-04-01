Extension { #name : 'PharoLauncherApplication' }

{ #category : '*PharoLauncher-Spec2-Gtk' }
PharoLauncherApplication classSide >> openGtk [
	<script>
	
	^ self new
		useBackend: #Gtk with: PhLGtkConfiguration new;
		openAsWorld: false;
		run
]
