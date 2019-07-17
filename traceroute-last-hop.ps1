Add-Type -AssemblyName System.Web

# Older windows versions don't have the cmdlet used.  If doesn't exist output as such
if(Get-Command Test-NetConnection -ErrorAction SilentlyContinue){

    $mytrace = Test-NetConnection "54.219.148.161" -TraceRoute -WarningAction SilentlyContinue

    # go through the loop in reverse until we find an ip address not equal to 0.0.0.0 or TimedOut
    for($i = $mytrace.TraceRoute.Length - 1; $i -gt 0; $i--){
        if($mytrace.TraceRoute[$i] -ne "0.0.0.0" -and $mytrace.TraceRoute[$i] -ne "TimedOut"){
            return $mytrace.TraceRoute[$i]
        }
    }
}else{
    return "Cmdlet Doesn't Exist"
}
