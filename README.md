# nanoagent_helmchart
Public Nano Agent Helm Chart repository



Default settings that can be altered in Values.yaml



|Parameter| 	Parameter from values.yaml	 | Default State	 | Default Value (if enabled) | Details                                                                                                                                                                                                          |
|---------|------------------------------|----------------|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|CPU resource request| 	requests: cpu               | 	N/A	          | 100m                       |                                                                                                                                                                                                                  |
|CPU resource limit| 	limits: cpu     | 	N/A	          | 1000m                      |
|Memory resource request| 	requests: memory            | 	N/A           | 	512Mi                     |                                                                                                                                                                                                                  |
|Memory resource limit| 	limits: memory	| N/A	                               | 2048Mi         |                                                                                                                                                                                                                  |
|Priority class	| priorityClassDefault	        | enabled: false | 	1000                      |                                                                                                                                                                                                                  |
|Namespace	| namespaceSpyderbat	          | enabled: true	 | spyderbat                  |                                                                                                                                                                                                                  |
|Omit Envionment | OMITENVIRONMENT | | "no" | "no" emit all environment variables. "everything" omits all environment variables and "allbutredacted" uses our rules to encrypt variables that look like they contain secrets and emit only those for analysis. |
