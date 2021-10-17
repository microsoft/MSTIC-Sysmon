function Split-XmlConfig {
    param (
        [CmdletBinding()]
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName=$true)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "The Path argument must be a file. Folder paths are not allowed."
            }
            if($_ -notmatch "(\.xml)"){
                throw "The file specified in the path argument must be of type xml"
            }
            return $true 
        })]
        [Alias('FullName')]
        [System.IO.FileInfo]$Path
    )
    process {
        $currentConfig = New-Object xml
        $currentConfig.load((Convert-Path $Path))
        # Remove all comments
        $allComments = $currentConfig.Sysmon.SelectNodes("//comment()")
        $allComments | Foreach-Object {[void]$_.ParentNode.RemoveChild($_)}
        # Remove current rule groups
        $currentRuleGroups = $currentConfig.SelectNodes("//RuleGroup")
        $currentRuleGroups | Foreach-Object {[void]$_.ParentNode.RemoveChild($_)}

        $ruleGroupNames = @("ProcessCreate","NetworkConnect","ProcessTerminate","FileDelete","FileCreate")
        foreach ($rule in $currentRuleGroups) {
            # Copy current config
            $newConfig = [xml]($currentConfig.OuterXml)
            # Import rule from current config to new config XML document
            $ruleImported = $newConfig.ImportNode($rule, $true)
            # Add imported rule to new config
            $eventFiltering = $newConfig.SelectSingleNode("//EventFiltering")
            [void]$eventFiltering.AppendChild($ruleImported)

            # Create XML document
            $ruleGroupName = $rule | Get-Member -MemberType Property -Name $ruleGroupNames | Select-Object -ExpandProperty Name
            $folderPath = Get-ChildItem $PSScriptRoot\_events\* -filter "*$ruleGroupName*" -Directory | ForEach-Object { $_.fullname }
            $outputFile = Split-Path $Path -leaf
            $newConfig.Save((Join-Path -Path $folderPath -ChildPath $outputFile))
        }
    }
}