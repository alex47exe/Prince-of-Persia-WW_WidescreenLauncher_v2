#NoTrayIcon
;#RequireAdmin

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile=_Prince of Persia Warrior Within.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UPX_Parameters=-9 --strip-relocs=0 --compress-exports=0 --compress-icons=0
#AutoIt3Wrapper_Res_Description=UniGame Launcher
#AutoIt3Wrapper_Res_Fileversion=1.1.0.47
#AutoIt3Wrapper_Res_ProductVersion=1.1.0.47
#AutoIt3Wrapper_Res_LegalCopyright=2017-2018, SalFisher47
#AutoIt3Wrapper_Res_SaveSource=n
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Region ;**** Pragma Compile ****
#pragma compile(AutoItExecuteAllowed, true)
#pragma compile(Compression, 9)
#pragma compile(InputBoxRes, true)
#pragma compile(CompanyName, 'SalFisher47')
#pragma compile(FileDescription, 'UniGame Launcher')
#pragma compile(FileVersion, 1.1.0.47)
#pragma compile(InternalName, 'UniGame Launcher')
#pragma compile(LegalCopyright, '2017-2018, SalFisher47')
#pragma compile(OriginalFilename, UniGame_Launcher.exe)
#pragma compile(ProductName, 'UniGame Launcher')
#pragma compile(ProductVersion, 1.1.0.47)
#EndRegion ;**** Pragma Compile ****

; === UniGame Launcher.au3 =========================================================================================================
; Title .........: UniGame Launcher
; Version .......: 1.1.0.47
; AutoIt Version : 3.3.14.5
; Language ......: English
; Description ...: Universal Game Launcher
; Author(s) .....: SalFisher47
; Last Modified .: November 18, 2018 - last compiled on January 8 2019
; ==================================================================================================================================

Global $Env_RoamingAppData = @AppDataDir, _
		$Env_LocalAppData = @LocalAppDataDir, _
		$Env_ProgramData = @AppDataCommonDir, _
		$Env_UserProfile = @UserProfileDir, _
		$Env_SavedGames = RegRead("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders", "{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}")
		If @error Then $Env_SavedGames = $Env_UserProfile & "\Saved Games"

$Ini = @ScriptDir & "\" & StringTrimRight(@ScriptName, 4) & ".ini"

$exe_run = IniRead($Ini, "Exe", "exe_run", "")
$exe_path_full = @ScriptDir & "\" & $exe_run
$exe_only = StringTrimLeft($exe_path_full, StringInStr($exe_path_full, "\", 0, -1))
$exe_path_only = StringTrimRight($exe_path_full, StringLen($exe_only)+1)
$exe_cmd = IniRead($Ini, "Exe", "exe_cmd", "")
$exe_compat = IniRead($Ini, "Exe", "exe_compat", "")

$run_first = IniRead($Ini, "Exe", "run_first", 0)
If Not FileExists(@AppDataCommonDir & "\SalFisher47\RunFirst") Then DirCreate(@AppDataCommonDir & "\SalFisher47\RunFirst")
FileInstall("RunFirst\RunFirst.exe", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", 0)
FileInstall("RunFirst\RunFirst.txt", @AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.txt", 0)

; check for game path and add it to ini file in C:\ProgramData\SalFisher47\UniGame Launcher
If Not FileExists(@AppDataCommonDir & "\SalFisher47\UniGame Launcher") Then DirCreate(@AppDataCommonDir & "\SalFisher47\UniGame Launcher")
FileInstall("ProgramData.ini", @AppDataCommonDir & "\SalFisher47\UniGame Launcher\" & StringTrimRight(@ScriptName, 4) & ".ini", 0)
$first_launch = 1
If IniRead(@AppDataCommonDir & "\SalFisher47\UniGame Launcher\" & StringTrimRight(@ScriptName, 4) & ".ini", "launcher", "game_path", "") <> @ScriptDir Then
	$first_launch = 0
	IniWrite(@AppDataCommonDir & "\SalFisher47\UniGame Launcher\" & StringTrimRight(@ScriptName, 4) & ".ini", "launcher", "game_path", " " & @ScriptDir)
EndIf

; check for savegame path and add it to ini file in C:\ProgramData\SalFisher47\UniGame Launcher
$ini_Savegame_dir = IniRead($ini, "savegame", "savegame_dir", "")
$ini_Savegame_subdir = IniRead($ini, "savegame", "savegame_subdir", "")
$Savegame_dir = ""
Switch $ini_Savegame_dir
	Case "MyDocs"
		$Savegame_dir = @MyDocumentsDir & "\" & $ini_Savegame_subdir
	Case "PublicDocs"
		$Savegame_dir = @DocumentsCommonDir & "\" & $ini_Savegame_subdir
	Case "RoamingAppData"
		$Savegame_dir = $Env_RoamingAppData & "\" & $ini_Savegame_subdir
	Case "LocalAppData"
		$Savegame_dir = $Env_LocalAppData & "\" & $ini_Savegame_subdir
	Case "ProgramData"
		$Savegame_dir = $Env_ProgramData & "\" & $ini_Savegame_subdir
	Case "SavedGames"
		$Savegame_dir = $Env_SavedGames & "\" & $ini_Savegame_subdir
	Case "UserProfile"
		$Savegame_dir = @UserProfileDir & "\" & $ini_Savegame_subdir
	Case "GameDir"
		$Savegame_dir = @ScriptDir & "\" & $ini_Savegame_subdir
EndSwitch
If $Savegame_dir <> "" Then
	If IniRead(@AppDataCommonDir & "\SalFisher47\UniGame Launcher\" & StringTrimRight(@ScriptName, 4) & ".ini", "launcher", "savegame_path", "") <> $Savegame_dir Then
		;$first_launch = 0
		IniWrite(@AppDataCommonDir & "\SalFisher47\UniGame Launcher\" & StringTrimRight(@ScriptName, 4) & ".ini", "launcher", "savegame_path", " " & $Savegame_dir)
	EndIf
EndIf

$HUD_Fix_CanStretchRect = IniRead($ini, "game", "CanStretchRect", 0)
$Fog_Fix_ForceVSFog = IniRead($ini, "game", "ForceVSFog", 1)
$Fog_Fix_InvertFogRange = IniRead($ini, "game", "InvertFogRange", 0)

$Ini2 = @ScriptDir & "\pop2.ini"

$desktop_width = IniRead($Ini, "Exe", "desktop_width", 0)
$desktop_height = IniRead($Ini, "Exe", "desktop_height", 0)
$desktopRatio = Round($desktop_width/$desktop_height, 2)
If ($desktop_width == 0) And ($desktop_height == 0) Then
	$desktop_width = @DesktopWidth
	$desktop_height = @DesktopHeight
	$desktopRatio = Round($desktop_width/$desktop_height, 2)
	IniWrite($Ini2, "MAIN", "Width", " " & $desktop_width)
	IniWrite($Ini2, "MAIN", "Height", " " & $desktop_height)
ElseIf ($desktop_width == 0) Or ($desktop_height == 0) Then
	$desktop_width = @DesktopWidth
	$desktop_height = @DesktopHeight
	$desktopRatio = Round($desktop_width/$desktop_height, 2)
	IniWrite($Ini2, "MAIN", "Width", " " & $desktop_width)
	IniWrite($Ini2, "MAIN", "Height", " " & $desktop_height)
Else
	$desktopRatio = Round($desktop_width/$desktop_height, 2)
	If $desktopRatio > 1 Then
		IniWrite($Ini2, "MAIN", "Width", " " & $desktop_width)
		IniWrite($Ini2, "MAIN", "Height", " " & $desktop_height)
	Else
		IniWrite($Ini2, "MAIN", "Width", " " & @DesktopWidth)
		IniWrite($Ini2, "MAIN", "Height", " " & @DesktopHeight)
	EndIf
EndIf

If RegRead("HKLM\SOFTWARE\UBISOFT\Prince of Persia Warrior Within\1.00.999", "Product_Path") <> @ScriptDir Then
	RegWrite("HKLM\SOFTWARE\UBISOFT\Prince of Persia Warrior Within\1.00.999", "Product_Path", "REG_SZ", @ScriptDir)
	RegWrite("HKLM\SOFTWARE\UBISOFT\Prince of Persia Warrior Within\1.00.999", "Product_Executable", "REG_SZ", "PrinceOfPersia.exe")
	RegWrite("HKLM\SOFTWARE\UBISOFT\Prince of Persia Warrior Within\1.00.999", "Product_Language", "REG_SZ", 9)
	RegWrite("HKLM\SOFTWARE\UBISOFT\Prince of Persia Warrior Within\1.00.999", "Product_Release", "REG_SZ", "Retail EMEA")
EndIf

If RegRead("HKLM\SOFTWARE\UBISOFT\Prince of Persia Warrior Within\1.00.999", "Profiles_Path") <> @ScriptDir Then
	RegWrite("HKLM\SOFTWARE\UBISOFT\Prince of Persia Warrior Within\1.00.999", "Profiles_Path", "REG_SZ", @ScriptDir)
EndIf

If $first_launch == 1 Then
	_RunUser()
Else
	_RunAdmin()
EndIf

Func _RunUser() ; main script
	If RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", $exe_path_full) <> $exe_compat Then
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", $exe_path_full, "REG_SZ", $exe_compat)
	EndIf
	If $run_first == 1 Then
		If $Savegame_dir <> "" Then
			If Not FileExists($Savegame_dir) Then DirCreate($Savegame_dir)
			FileCreateShortcut($Savegame_dir, @ScriptDir & "\_savegame.lnk")
		EndIf
		ShellExecute(@AppDataCommonDir & "\SalFisher47\RunFirst\RunFirst.exe", '"' & $exe_path_full & '"' & " " & $exe_cmd & " " & $CmdLineRaw, $exe_path_only, "", @SW_HIDE)
	Else
		If $Savegame_dir <> "" Then
			If Not FileExists($Savegame_dir) Then DirCreate($Savegame_dir)
			FileCreateShortcut($Savegame_dir, @ScriptDir & "\_savegame.lnk")
		EndIf
		ShellExecute($exe_only, " " & $exe_cmd & " " & $CmdLineRaw, $exe_path_only)
	EndIf
EndFunc

Func _RunAdmin() ; run main script as admin on first launch
	If RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", @ScriptDir & "\" & StringTrimRight(@ScriptName, 4) & ".exe") <> "RUNASADMIN" Then
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", @ScriptDir & "\" & StringTrimRight(@ScriptName, 4) & ".exe", "REG_SZ", "RUNASADMIN")
	EndIf
	;---
	If $Savegame_dir <> "" Then
		If Not FileExists($Savegame_dir) Then DirCreate($Savegame_dir)
		FileCreateShortcut($Savegame_dir, @ScriptDir & "\_savegame.lnk")
	EndIf
	FileInstall("Hardware.ini", @ScriptDir & "\Hardware.ini", 1)
	IniWrite(@AppDataCommonDir & "\SalFisher47\UniGame Launcher\PoP2\PoP2.ini", "EXE", "patched", " 1")
	FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\POP2_.exe", 0)
	FileMove(@ScriptDir & "\blank.exe", @ScriptDir & "\POP2.exe", 0)
	ShellExecuteWait($exe_only, " " & $exe_cmd & " " & $CmdLineRaw, $exe_path_only)
	If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", "") <> $HUD_Fix_CanStretchRect Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "CanStretchRect", $HUD_Fix_CanStretchRect)
	If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", "") <> $Fog_Fix_ForceVSFog Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "ForceVSFog", $Fog_Fix_ForceVSFog)
	If IniRead(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", "") <> $Fog_Fix_InvertFogRange Then IniWrite(@ScriptDir & "\Hardware.ini", "CAPS", "InvertFogRange", $Fog_Fix_InvertFogRange)
	FileMove(@ScriptDir & "\POP2.exe", @ScriptDir & "\blank.exe", 1)
	FileMove(@ScriptDir & "\POP2_.exe", @ScriptDir & "\POP2.exe", 1)
	ShellExecute(StringTrimRight(@ScriptName, 4) & ".exe", $CmdLineRaw, @ScriptDir)
	;---
	If RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", @ScriptDir & "\" & StringTrimRight(@ScriptName, 4) & ".exe") == "RUNASADMIN" Then
		RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers", @ScriptDir & "\" & StringTrimRight(@ScriptName, 4) & ".exe", "REG_SZ", "")
	EndIf
EndFunc