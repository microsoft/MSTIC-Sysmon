# Managing Sysmon Configurations

* We are currently creating Sysmon configs based on services or adversarial techniques we perform research on while developing detections.
* We believe that organizing our Sysmon configs at a higher level over event IDs allows us to manage them a little bit better and expedites the conversations around coverage over techniques used by threat actors.
* You can use these configs to monitor interesting patterns of behavior mapped to [MITRE ATT&CK](https://attack.mitre.org/).

## Split Configs by Event ID

Once we document our rule collection either by services or adversarial techniques, we can run the following script to split every config in by each Sysmon event ID documented. Those files are automatically created on their respective folders under the [event-based](event-based) folder.

```PowerShell
Import-Module .\scripts\Split-XmlConfig.ps1

Get-ChildItem .\attack-based\ -File | Select-Object -ExpandProperty Fullname | Split-XmlConfig
```

## Creating a Master Configuration

Finally, we can create main configs for inclusions and exclusions defined by each config under the [event-based](event-based) folder. These might be configs that you could use in your lab environment (For production, make sure they go through a review process. **Use them at your own risk**).

```PowerShell
Import-Module .\scripts\ConvertTo-XmlMainConfig.ps1

ConvertTo-XmlMainConfig
```

## Community Contributions

We hope to extend and improve these concepts with the help of the InfoSec community. Feel free to reach out to us and open an issue for new ideas or feedback. Once again, we use this approach while doing research in our lab environment. Therefore, test everything before deploying anything in production. 

## Maintainers

* Russ ([@russmcsec](https://twitter.com/russmcsec))
* Jessen Kurien ([@jessen_kurien](https://twitter.com/jessen_kurien))
* Roberto Rodriguez ([@Cyb3rWard0g](https://twitter.com/Cyb3rWard0g))

## Credits - Great Community

### Researchers
* Florian Roth [@cyb3rops](https://twitter.com/cyb3rops)
* Tony Lambert [@ForensicITGuy](https://twitter.com/ForensicITGuy)
* [bfuzzy1](https://twitter.com/bfuzzy1)

### Projects
* [https://github.com/Neo23x0/auditd/blob/master/audit.rules](https://github.com/Neo23x0/auditd/blob/master/audit.rules)
* [https://github.com/SigmaHQ/sigma](https://github.com/SigmaHQ/sigma)
* [https://github.com/bfuzzy1/auditd-attack/blob/master/auditd-attack/auditd-attack.rules](https://github.com/bfuzzy1/auditd-attack/blob/master/auditd-attack/auditd-attack.rules)
* [https://github.com/redcanaryco/atomic-red-team](https://github.com/redcanaryco/atomic-red-team)