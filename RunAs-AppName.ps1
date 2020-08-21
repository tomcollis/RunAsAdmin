$User = ".\admin"
$PasswordFile = "\\NetworkPath\Scripts\Password.txt"
$KeyFile = "\\NetworkPath\Scripts\AES.key"
$key = Get-Content $KeyFile
$MyCredential = New-Object -TypeName System.Management.Automation.PSCredential  -ArgumentList $User, (Get-Content $PasswordFile | ConvertTo-SecureString -Key $key)
$UserName = $MyCredential.UserName
$Password = $MyCredential.GetNetworkCredential().Password
.\PsExec -accepteula -u $UserName -p $Password -d "C:\Program Files (x86)\ApplicationPath\Application.exe"
