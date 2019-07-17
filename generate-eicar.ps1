# Generate an EICAR test file from base64 string
$eicar_base64="WDVdKylEOilEPDVOKlBaNVsvRUlDQVItUE9URU5USUFMTFktVU5XQU5URUQtT0JKRUNULVRFU1QhJCpNKkw="
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($eicar_base64)) | Out-File -Encoding "ASCII" C:\EICAR-TEST.txt
