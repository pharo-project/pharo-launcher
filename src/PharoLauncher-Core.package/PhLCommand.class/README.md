I'm the abstract superclass of all commands. I implement the command pattern. My main entry methods are #execute and #isApplicable.

I rely on the existence of a context (instance of PhLCommandContext) to query and change my environment.