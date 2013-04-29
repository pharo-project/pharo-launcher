accessing
baseline01: spec 
        <version: '0.1-baseline'>
        
        spec for: #common do: [
		spec blessing: #baseline.
		spec repository: 'http://smalltalkhub.com/mc/ErwanDouaille/ImageLauncher/main/'.
		
		spec package: 'Image-Launcher-UI' with: 'Image-Launcher-UI-ErwanDouaille.1'. "add spec configurationOf ?"
		spec package: 'Image-Launcher-Core'with: [ spec requires: 'XMLSupport' ].
            spec project: 'XMLSupport' with: [
			spec
				className: 'ConfigurationOfXMLSupport';
				loads: #('default');
				file: 'ConfigurationOfXMLSupport';
				repository: 'http://www.squeaksource.com/XMLSupport' 
			].
	].

