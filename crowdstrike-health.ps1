# try a raw tcp connection to the crowdstrike cloud service on port 443, allow a 100ms timeout before closing the connection
# we start by assuming we can't connect and if we can switch to $true
$Timeout=100
$conn_success=$false

$client = New-Object System.Net.Sockets.TcpClient 
$beginConnect = $client.BeginConnect("ts01-b.cloudsink.net",443,$null,$null) 
if($client.Connected) { 
    $conn_success=$true
} else { 
    # Wait 
    Start-Sleep -Milli $TimeOut 
    if($client.Connected) { 
        $conn_success=$true
    }
} 
$client.Close() 
   

# check if the required trusted root ca "DigiCert High Assurance EV Root CA" exists and is not expired
$certificate=Get-Childitem cert:\LocalMachine\root -Recurse | Where Subject -eq "CN=DigiCert High Assurance EV Root CA, OU=www.digicert.com, O=DigiCert Inc, C=US"
if($certificate -ne $null){
    if($certificate.GetExpirationDateString() -gt (Get-date)){
        $cert_status="Valid"
    }else{
        $cert_status="Expired"
    }
}else{
    $cert_status="Missing"
}


if($conn_success -eq $true -and $cert_status -eq "Valid"){
    Write-Output "Healthy"
}elseif($conn_success -eq $true -and $cert_status -eq "Expired"){
    Write-Output "Cert Expired"
}elseif($conn_success -eq $true -and $cert_status -eq "Missing"){
    Write-Output "Cert Missing"
}elseif($conn_success -eq $false -and $cert_status -eq "Valid"){
    Write-Output "Connection Error"
}elseif($conn_success -eq $false -and $cert_status -eq "Expired"){
    Write-Output "Cert Expired and Connection Error"
}elseif($conn_success -eq $false -and $cert_status -eq "Missing"){
    Write-Output "Cert Missing and Connection Error"
}
