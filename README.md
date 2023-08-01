# nanoagent_helmchart
Public Nano Agent Helm Chart repository



Default settings that can be altered in Values.yaml



|Parameter| 	Parameter from values.yaml	 | Default State	 | Default Value (if enabled) | Details                                                                                                                                                                                                          |
|---------|------------------------------|----------------|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|CPU resource request| 	requests: cpu               | 	N/A	          | 100m                       |                                                                                                                                                                                                                  |
|CPU resource limit| 	limits: cpu     | 	N/A	          | 6000m                      |
|Memory resource request| 	requests: memory            | 	N/A           | 	512Mi                     |                                                                                                                                                                                                                  |
|Memory resource limit| 	limits: memory	| N/A	                               | 10240Mi         |                                                                                                                                                                                                                  |
|Priority class	| priorityClassDefault	        | enabled: false | 	1000                      |                                                                                                                                                                                                                  |
|Namespace	| namespaceSpyderbat	          | enabled: true	 | spyderbat                  |                                                                                                                                                                                                                  |
|Omit Envionment | OMITENVIRONMENT | | "no" | "no" emit all environment variables. "everything" omits all environment variables and "allbutredacted" uses our rules to encrypt variables that look like they contain secrets and emit only those for analysis. |
|AWS Secrets Manager | aws:secretsmanager:enabled | | false | Whether to use AWS SM integration to retrieve agent registration code. |
|AWS Secrets Manager | aws:secretsmanager:rolearn| | ""| The arn of the role for the eks spyderbat service account to assume|
|AWS Secrets Manager | aws:secretsmanager:secretarn| | "" | the arn of the secret that the pods will attempt to mount to read the registration code from.|


To configure access via a proxy you can add additional parameters to the Helm command line:

```
--set nanoagent.httpproxy=http://123.123.123.123:2/ --set nanoagent.httpsproxy=http://123.123.123.123:2/
```


To set the resource limits additional parameters like there can be added to the Helm command line.  We recommend 3-5% of the resources on a node as a limit

```
--set resources.limits.cpu=2000m --set resources.limits.memory=8192M
```

A readonly service account can be used instead of the read/write one.   This can be enabled by setting serviceAccount.readonly to true and then using spyderbat-cluster-readonly in serviceAccount.role.   Doing this will prevent kubernetes "actions" from being functional, killing a pod with guardian will not function properly.





# To update this and get it hosted live.

1. Update the version of Chart.yaml
1. Commit and push the updates
1. In the nanoagent_helm repo, git pull and run ```make update```
1. Review the changes and then git push
