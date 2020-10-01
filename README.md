# Enable WSL

Enable and Install WSL 2

```sh
$ dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
$ dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
(.. restart ..)
$ wsl --set-default-version 2
$
```
