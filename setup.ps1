$typename = "System.Management.Automation.Host.ChoiceDescription";
$yes = New-Object $typename("&Yes", "インストールする");
$no = New-Object $typename("&No", "インストール済みです");
$assembly= $yes.getType().AssemblyQualifiedName;
$choice = new-object "System.Collections.ObjectModel.Collection``1[[$assembly]]";
$choice.add($yes);
$choice.add($no);

# Setup
function ChocoSetup() {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
}

# Package Install
function ChocoPackageInstall() {
    cinst .\packages.config -y;
}

# Package update
function ChocoPackageUpdate() {
    $packagesInfo = [xml](Get-Content "$PSScriptRoot\packages.config");
    $packageList = [string]::Empty;
    foreach ($packageInfo in $packagesInfo.packages) {
        $packageList = $packageList + $packageInfo.package.id + " ";
    }
    $cmd = "choco update $packageList -y;";
    Write-Host $cmd;
    Invoke-Expression $cmd;
}

# Main
$answer = $host.UI.PromptForChoice("<Chocolateyインストール>", "Chocolateyのインストールを行いますか？", $choice, 0);
if ($answer -eq 0) {
    ChocoSetup;
}
$answer = $host.UI.PromptForChoice("<Packageインストール>", "Packageのインストールを行いますか？", $choice, 0);
if ($answer -eq 0) {
    ChocoPackageInstall;
}
$answer = $host.UI.PromptForChoice("<Packageアップデート>", "Packageのアップデートを行いますか？", $choice, 0);
if ($answer -eq 0) {
    ChocoPackageUpdate;
}
