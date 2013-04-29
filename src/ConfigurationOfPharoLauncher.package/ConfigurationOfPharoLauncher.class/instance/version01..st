accessing
version01: spec
        <version: '0.1' imports: #('0.1-baseline')>

        spec for: #common do: [
			spec package: 'Image-Launcher-UI' with: 'Image-Launcher-UI-ErwanDouaille.1'.
			spec package: 'Image-Launcher-Core' with: 'Image-Launcher-Core-ErwanDouaille.1'.
			spec project: 'XMLSupport' with: '1.2.0'.
		].