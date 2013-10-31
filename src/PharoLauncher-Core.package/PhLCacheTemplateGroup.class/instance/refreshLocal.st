action
refreshLocal
	"Request for fetching the content of my template group, but only if it's fast (e.g., no network access)."

	delegate isLocal
		ifTrue: [ self refresh ]