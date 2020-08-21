$PasswordFile = ".\Password.txt"
$Key = Get-Content $KeyFile
$Password = "P@55w0rd" | ConvertTo-SecureString -AsPlainText -Force
$Password | ConvertFrom-SecureString -key $Key | Out-File $PasswordFile
