# Sysmon for Linux Config

An open-source initiative to document Sysmon for Linux configurations based on adversarial behavior mapped to [MITRE ATT&CK](https://attack.mitre.org/).

## Goals
* Enable the maintenance of separate configs to define data collection strategies in a more flexible way.
* Expedite conversations around data coverage over techniques used by real threat actors.
* Facilitate selective merging of configs based on interesting patterns of behavior mapped to [MITRE ATT&CK](https://attack.mitre.org/).

## Creating a Main Configuration

* Run the following script to split every attack based config by Sysmon event IDs. Those files will be automatically created under the [_events](_events) folder.

```PowerShell
Import-Module .\Split-XmlConfig.ps1

Get-ChildItem .\attack-based\ -Recurse -File | Select-Object -ExpandProperty Fullname | Split-XmlConfig
```

* Finally, create the main config (**Inclusions Only** for now) by running the following command:

```PowerShell
Import-Module .\ConvertTo-MainConfig.ps1

ConvertTo-MainConfig
```

## Community Contributions

We hope to extend and improve these concepts with the help of the InfoSec community. Feel free to reach out to us and open an issue for new ideas or feedback. Once again, we use this approach while doing research in our lab environment. Therefore, test everything before deploying anything in production. 

## Maintainers

* Russ ([@russmcsec](https://twitter.com/russmcsec))
* Jessen Kurien ([@jessen_kurien](https://twitter.com/jessen_kurien))
* Roberto Rodriguez ([@Cyb3rWard0g](https://twitter.com/Cyb3rWard0g))

## Credits - Great Community

### Researchers
* Matt Graeber [@mattifestation](https://twitter.com/mattifestation)
* Florian Roth [@cyb3rops](https://twitter.com/cyb3rops)
* Tony Lambert [@ForensicITGuy](https://twitter.com/ForensicITGuy)
* [bfuzzy1](https://twitter.com/bfuzzy1)

### Resources
* [Initial Idea (2017) - Roberto Rodriguez and Matt Graeber](https://twitter.com/mattifestation/status/936630498964725760?s=20)]
* [https://posts.specterops.io/working-with-sysmon-configurations-like-a-pro-through-better-tooling-be7ad7f99a47](https://posts.specterops.io/working-with-sysmon-configurations-like-a-pro-through-better-tooling-be7ad7f99a47)
* [https://github.com/mattifestation/PSSysmonTools](https://github.com/mattifestation/PSSysmonTools)
* [https://github.com/Neo23x0/auditd/blob/master/audit.rules](https://github.com/Neo23x0/auditd/blob/master/audit.rules)
* [https://github.com/SigmaHQ/sigma](https://github.com/SigmaHQ/sigma)
* [https://github.com/bfuzzy1/auditd-attack/blob/master/auditd-attack/auditd-attack.rules](https://github.com/bfuzzy1/auditd-attack/blob/master/auditd-attack/auditd-attack.rules)
* [https://github.com/redcanaryco/atomic-red-team](https://github.com/redcanaryco/atomic-red-team)