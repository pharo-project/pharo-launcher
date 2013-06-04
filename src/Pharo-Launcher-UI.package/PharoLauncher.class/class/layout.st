accessing
layout
	<spec: #default>
	^ SpecLayout composed
		add: #images right: 0.66;
		addVSplitter;
		add: #templates left: 0.34;
		yourself