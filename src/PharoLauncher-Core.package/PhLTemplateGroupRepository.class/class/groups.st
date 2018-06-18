private
groups
	"self resetGroups"
	"self groups"
	^ Groups
		ifNil: [ 
			Groups := OrderedDictionary new.
			Groups at: PhLJenkins2Server inriaRmod put: false.
			Groups at: PhLJenkins2Server inriaPharoContribution put: true.
			Groups at: PhLJenkins2Server inriaPharo put: true.
			Groups at: PhLJenkins2Server inriaMoose put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo60 put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo70 put: true.
			Groups at: PhLFixedURLsTemplateGroup forDeprecatedDistributions put: true.
			Groups at: PhLFixedURLsTemplateGroup forOfficialDistributions put: true.
			Groups at: PhLFixedURLsTemplateGroup forPharoMooc put: true.
			Groups at: PhLDownloadedTemplateGroup default put: true.
			^ Groups ]