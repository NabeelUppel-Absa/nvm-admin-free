Open Powershell and run:
1. `cd $Env:USERPROFILE`;
2. `Invoke-WebRequest https://raw.githubusercontent.com/jchip/nvm/v1.9.0/install.ps1 -OutFile install.ps1;`
   a. This might fail the first time around, just run it again and it should be fine
3. `.\install.ps1 -nvmhome $Env:USERPROFILE\nvm;`
If you see the following error
```
. \ install. psl :File cannot be Loaded because running scripts is disabled on this system.
For more information, see about_Execution_PoLicies at https:/go.microsoft.com/fwIink/?LinkID=13517@.
At line: 1 char: 1
+ .\install.psl —nvmhome $Env:USERPROFILE\nvm;
+ ~~~~~~~~~~~~~
+ CategoryInfo 			: SecurityError: [ ], PSSecurityException
+ FullyQualifiedErrorId	:UnauthorizedAccess
```
   a. Run this command `Set-ExecutionPolicy RemoteSigned -Scope Process` and follow the prompts
   b. Run step 3 again.
4. `del install.ps1`



To test that everything has installed correctly `run nvm -v`
From here you can install a version of node 
1. `nvm install 14.21.3`
2. `nvm use 14.21.3`
3. `node -v` as a sanity and confirmation check
