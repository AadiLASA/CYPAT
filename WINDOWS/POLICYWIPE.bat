cd C:\Windows\System32
secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose
RD /S /Q "%WinDir%\System32\GroupPolicy"
RD /S /Q "%WinDir%\System32\GroupPolicyUsers"
gpupdate.exe /force
