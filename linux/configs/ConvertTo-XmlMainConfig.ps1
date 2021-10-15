function ConvertTo-XmlMainConfig {
    $newConfig = [xml]@'
<!--
    SysmonForLinux

    Copyright (c) Microsoft Corporation

    All rights reserved.

    MIT License

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ""Software""), to deal in the Software without
 restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom th
e Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE
 AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI
NG FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
-->
<Sysmon schemaversion="4.81">
  <EventFiltering>
    <!-- Event ID 1 == ProcessCreate. Log all newly created processes except-->
    <RuleGroup name="" groupRelation="or">
        <ProcessCreate onmatch="exclude"/>
    </RuleGroup>
    <!-- Event ID 3 == NetworkConnect Detected. Log all network connections except -->
    <RuleGroup name="" groupRelation="or">
        <NetworkConnect onmatch="exclude"/>
    </RuleGroup>
    <!-- Event ID 5 == ProcessTerminate. Log all processes terminated except -->
    <RuleGroup name="" groupRelation="or">
        <ProcessTerminate onmatch="exclude"/>
    </RuleGroup>
    <!-- Event ID 9 == RawAccessRead. Log all raw access read -->
    <RuleGroup name="" groupRelation="or">
      <RawAccessRead onmatch="exclude"/>
    </RuleGroup>
    <!-- Event ID 11 == FileCreate. Log every file creation except -->
    <RuleGroup name="" groupRelation="or">
        <FileCreate onmatch="exclude"/>
    </RuleGroup>
    <!--Event ID 23 == FileDelete. Log all files being deleted except-->
    <RuleGroup name="" groupRelation="or">
        <FileDelete onmatch="exclude"/>
    </RuleGroup>
  </EventFiltering>
</Sysmon>
'@

    $atomicConfigs = Get-ChildItem $PSScriptRoot\..\configs\events\* -Filter "*.xml" -Recurse | ForEach-Object {$_.fullname}
    foreach ($config in $atomicConfigs) {
        # read atomic config
        $xmlObject = New-Object xml
        $xmlObject.load((Convert-Path $config))
        ## Get rule group
        $ruleGroup = $xmlObject.SelectSingleNode("//RuleGroup")
        ## Get event name
        $ruleGroupNames = @("ProcessCreate","NetworkConnect","ProcessTerminate","FileDelete","FileCreate")
        $ruleGroupName = $ruleGroup | Get-Member -MemberType Property -Name $ruleGroupNames | Select-Object -ExpandProperty Name
        ## Get Event Node
        $eventNode = $newConfig.SelectSingleNode("//RuleGroup/$ruleGroupName")
        ## Append rules
        foreach ($node in $ruleGroup.$RuleGroupName.ChildNodes) {
            [void]$eventNode.AppendChild($newConfig.ImportNode($node, $true))   
        }
    }
    $newConfig.save((Join-Path -Path (Convert-Path $PSScriptRoot\..\configs\) -ChildPath 'main.xml'))
}