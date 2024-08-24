Здравствуйте, пишу инструкцию для себя, но вдруг и Вам поможет 24.08.2024.

инструкция не расматривает вопросы с  .NET Framework 4.5 (or later)

# 1 нужно узнать версию Powershell

вводим в поиск windows 
```
Powershell
```
так как я уже выполнил этот процесс, то элементы могут отображаться не так как у Вас

![image](https://github.com/user-attachments/assets/9447ba02-8c02-483c-a105-9650eadaf8f1)




Powershell запускается строго **не под**  администратором




![image](https://github.com/user-attachments/assets/321902f3-b415-4ef2-82b8-f8276c1a17e8)


**power shell не дает делать скриншоты терминала**

вводим в терминал Powershell
```Powershell
 $PSVersionTable.PSVersion
```

Получим примерно следующее

![image](https://github.com/user-attachments/assets/34774024-2866-4fc2-818b-b22de3530481)


если версия меньше  
Major  Minor  Build  Revision

5      1      0      0


то  переходим по ссылки и скачиваем последнюю стабильную версию
![image](https://github.com/user-attachments/assets/7e0d535e-df8d-404f-9ed3-6bbebaa910fc)

https://learn.microsoft.com/ru-ru/powershell/scripting/install/installing-powershell?view=powershell-7.4


обязательно закрываем и открываем терминал Powershell и перезагружам пк

# 2 проверить установку curl

```
curl --version
```

если windows 11 то curl стоит по умолчанию


![image](https://github.com/user-attachments/assets/44899061-a8a4-49c4-893b-d41c59deb19d)


иначе  можно выбрать принцип установки curl

https://curl.se/download.html#Win64

если ваш метод 

 https://scoop.sh/
 
то обязательно закрываем и открываем терминал Powershell и перезагружам пк

после кажого действия 

и еще раз 

обязательно закрываем и открываем терминал Powershell и перезагружам пк

в помощь

```Powershell  
Test-Path "C:\Windows\System32\Robocopy.exe"
```

```Powershell
notepad $PROFILE
```
![image](https://github.com/user-attachments/assets/b0d477d6-38ae-4bb7-91c3-2e978589b99b)

вставляем в блокнот настроек профиля Powershell

```notepad
$env:RBENV_ROOT = "C:\Ruby-on-Windows"
& "$env:RBENV_ROOT\rbenv\bin\rbenv.ps1" init
$env:PATH += ";C:\Windows\System32"
```
**сохраняем и закрываем**

Powershell запускается строго **не под**  администратором
устанавливает scoop

```Powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```


обязательно закрываем и открываем терминал Powershell и перезагружам пк

после кажого действия 

и еще раз 

обязательно закрываем и открываем терминал Powershell и перезагружам пк


иструкции и команды по установке curl c сайта

![image](https://github.com/user-attachments/assets/899e0835-a26b-44e7-ba3b-7d9b40af93a6)


```
https://scoop.sh/#/apps?q=curl&id=09e3750a1f0a703b6de0f8fa4ca1263ef5d59ad3
```

```
scoop bucket add main
```
```
scoop install main/curl
```

обязательно закрываем и открываем терминал Powershell и перезагружам пк

после кажого действия 

и еще раз 

обязательно закрываем и открываем терминал Powershell и перезагружам пк

```
curl --version
```

#  установка проекта rbenv для windows

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser                      
$env:RBENV_ROOT = "C:\Ruby-on-Windows"
iwr -useb "https://github.com/ccmywish/rbenv-for-windows/raw/main/tools/install.ps1" | iex
```

обязательно закрываем и открываем терминал Powershell и перезагружам пк

после кажого действия 

и еще раз 

обязательно закрываем и открываем терминал Powershell и перезагружам пк

# бинго

проверка успеха

```
rbenv --version
rbenv versions 
```

вместо команды list список поддерживаемых версий

```
https://github.com/ccmywish/rbenv-for-windows/blob/main/share/versions.txt
```

работает  ```ruby -v```
