# Managing Sysmon Configurations

* We are currently creating Sysmon configs based on services or adversarial techniques we perform research on while developing detections.
* We believe that keeping the configs development at a higher level over event IDs allows to manage them a little bit better and expedites the conversations of coverage over techniques used by threat actors.
* You can use attack based configs while exploring your environment to focus in a few interesting behaviors performed by potential threat actors in your organization.

## Split Configs by Event ID

Once we document our rule collection either by services or adversarial techniques, we can run the following script to split every config in by each Sysmon event ID documented. Those files are automatically created on their respective folders under the [event-based](event-based) folder.

```PowerShell
Import-Module .\scripts\Split-XmlConfig.ps1

Get-ChildItem .\attack-based\ -File | Select-Object -ExpandProperty Fullname | Split-XmlConfig
```

## Creating a Master Configuration

Finally, we can create main configs for inclusions and exclusions defined by each config under the [event-based](event-based) folder. These might be configs that you could use in your lab environment (For production, make sure it goes **after several reviews**. **use it at your own risk**).

```PowerShell
Import-Module .\scripts\ConvertTo-XmlMainConfig.ps1

ConvertTo-XmlMainConfig
```

## Community Contributions

We hope to improve these concepts with the help of the InfoSec community. Feel free to reach out to us and open an issue for new ideas or feedback. Once again, we use this approach while doing research in our lab environment. Therefore, test everything before using it somewhere else. 

## Maintainers

* Russ ([@russmcsec](https://twitter.com/russmcsec))
* Jessen Kurien ([@jessen_kurien](https://twitter.com/jessen_kurien))
* Roberto Rodriguez ([@Cyb3rWard0g](https://twitter.com/Cyb3rWard0g))