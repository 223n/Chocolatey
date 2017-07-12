$typename = "System.Management.Automation.Host.ChoiceDescription";
$yes = New-Object $typename("&Yes", "インストールする");
$no = New-Object $typename("&No", "インストール済みです");
$assembly= $yes.getType().AssemblyQualifiedName;
$choice = new-object "System.Collections.ObjectModel.Collection``1[[$assembly]]";
$choice.add($yes);
$choice.add($no);

# Setup
function ChocoSetup() {
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'));
}

# Package Install
function ChocoPackageInstall() {
    choco install keepass -y;
    choco install rdcman -y;
    choco install visualstudiocode -y;
    choco install wireshark -y;
    choco install teraterm -y;
    #choco install bginfo -y;  # Errorが発生する
    choco install zoomit -y;
    choco install hosts.editor -y;
    choco install sourcetree -y;
    choco install chocolateygui -y;
    choco install winscp -y;
}

# Package update
function ChocoPackageUpdate() {
    choco update keepass -y;
    choco update rdcman -y;
    choco update visualstudiocode -y;
    choco update wireshark -y;
    choco update teraterm -y;
    #choco update bginfo -y;  # Errorが発生する
    choco update zoomit -y;
    choco update hosts.editor -y;
    choco update sourcetree -y;
    choco update chocolateygui -y;
    choco update winscp -y;
}

# Main
$answer = $host.UI.PromptForChoice("<実行確認>", "インストールを開始しますか？", $choice, 0);
if ($answer -eq 0) {
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
}

