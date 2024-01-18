#Install-Module -Name 'Harden-Windows-Security-Module' -Force
#Write-Host "Utilizing Additional Hardening Script" 
#Protect-WindowsSecurity
#Additional Information : https://hotcakex.github.io/#apply-the-latest-hardening-measures-directly-from-this-github-repository

  get-windowsoptionalfeature -online -featurename *Media* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename DirectoryServices-ADAM-Client | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *IIS* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *Print* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename SimpleTCP | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *SMB* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *Telnet* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *RasRip* | disable-windowsoptionalfeature -online -norestart

    get-windowsoptionalfeature -online -featurename *WorkFolders* | disable-windowsoptionalfeature -online -norestart
