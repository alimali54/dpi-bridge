#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Inet.au3>

#RequireAdmin

; --- Degiskenler ---
Local $gdpiDir = @ScriptDir & "\goodbyedpi"
Local $dnsDir = @ScriptDir & "\dnscrypt-proxy"
Local $pcapDir = @ScriptDir & "\go-pcap2socks"
Local $testUrl = "https://www.roblox.com"
Local $params[] = ["-5 --blacklist hosts.txt --dns-addr 1.1.1.1 --dns-port 53 --dnsv6-addr 2606:4700:4700::1111 --dnsv6-port 53", "-6 --blacklist hosts.txt --dns-addr 1.1.1.1 --dns-port 53 --dnsv6-addr 2606:4700:4700::1111 --dnsv6-port 53", "-7 --blacklist hosts.txt --dns-addr 1.1.1.1 --dns-port 53 --dnsv6-addr 2606:4700:4700::1111 --dnsv6-port 53", "-8 --blacklist hosts.txt --dns-addr 1.1.1.1 --dns-port 53 --dnsv6-addr 2606:4700:4700::1111 --dnsv6-port 53", "-9 --blacklist hosts.txt --dns-addr 1.1.1.1 --dns-port 53 --dnsv6-addr 2606:4700:4700::1111 --dnsv6-port 53", "-5 --set-ttl 5 --blacklist hosts.txt --dns-addr 1.1.1.1 --dns-port 53 --dnsv6-addr 2606:4700:4700::1111 --dnsv6-port 53", "--set-ttl 3 --blacklist hosts.txt --dns-addr 1.1.1.1 --dns-port 53 --dnsv6-addr 2606:4700:4700::1111 --dnsv6-port 53"]
Local $statusText = ""

; GUI
Local $hGUI = GUICreate("PlayStation Discord & Roblox Erişimi", 500, 500)
Local $iLabel = GUICtrlCreateLabel("Sistem kontrol ediliyor...", 20, 20, 460, 460)
GUICtrlSetFont(-1, 10, 400, 0, "Consolas")
GUISetState(@SW_SHOW)

Func LogMsg($msg)
    $statusText &= "> " & $msg & @CRLF
    GUICtrlSetData($iLabel, $statusText)
EndFunc

; Güvenlik Duvari Sorgu Fonksiyonu
Func HasFirewallRule($fullPath)
	Local $fixedPath = StringReplace($fullPath, "I", "i")
    Local $psCmd = 'powershell -Command "Get-NetFirewallApplicationFilter -Program ''' & $fixedPath & ''' -ErrorAction SilentlyContinue"'
    Local $iPID = Run(@ComSpec & ' /c ' & $psCmd, "", @SW_HIDE, $STDOUT_CHILD)
    ProcessWaitClose($iPID)
    Return (StringLen(StdoutRead($iPID)) > 10)
EndFunc

; SERVIS TEMIZLEME FONKSIYONU (Kapanista çalısır)
Func CleanUpServices()
    LogMsg("Servisler temizleniyor...")
    Local $commands[] = ['sc stop "GoodbyeDPI"', 'sc delete "GoodbyeDPI"', 'sc stop "WinDivert"', 'sc delete "WinDivert"', 'sc stop "WinDivert14"', 'sc delete "WinDivert14"']
    For $cmd In $commands
        RunWait(@ComSpec & " /c " & $cmd, "", @SW_HIDE)
    Next
EndFunc

CleanUpServices()

; --- ADIM 1: NPCAP KONTROL  ---
If Not FileExists(@SystemDir & "\Packet.dll") Then
    LogMsg("HATA: Npcap yüklü değil! Program durduruldu.")
    MsgBox(16, "Hata", "Lütfen npcap.com üzerinden Npcap kurun.")
    Exit
EndIf
LogMsg("[OK] Npcap yüklü.")

; --- ADIM 2: GÜVENLIK DUVARI TETIKLEME ---
Local $apps[2] = [$dnsDir & "\dnscrypt-proxy.exe", $pcapDir & "\go-pcap2socks.exe"]
Local $appNames[2] = ["dnscrypt-proxy.exe", "go-pcap2socks.exe"]

For $i = 0 To 1
    If Not HasFirewallRule($apps[$i]) Then
        LogMsg("!!! " & $appNames[$i] & " için izin bulunamadı.")
        LogMsg("5 saniye sonra pencere açılacak, lütfen GÜVENLIK DUVARI İZNİ VERİN.")
        Sleep(5000)
        Local $tmpPID = Run($apps[$i], StringLeft($apps[$i], StringInStr($apps[$i], "\", 0, -1)), @SW_HIDE)
        MsgBox(64, "Onay", $appNames[$i] & " için izin verdiyseniz Tamam'a basın.")
        ProcessClose($tmpPID)
        If HasFirewallRule($apps[$i]) Then
            LogMsg("[OK] " & $appNames[$i] & " izni alındı.")
        Else
            LogMsg("[UYARI] İzin hala görünmüyor, sorun çıkabilir.")
        EndIf
    Else
        LogMsg("[OK] " & $appNames[$i] & " güvenlik duvarı izni mevcut.")
    EndIf
Next

; --- ADIM 3: GOODBYEDPI PARAMETRE DENEME ---
LogMsg("--- Sürücü Kontrolü ---")

; WinDivert dosyalarının yolları (64 bit sistem varsayılarak)
Local $gdpiFile = $gdpiDir & "\goodbyedpi.exe"
Local $driverFile = $gdpiDir & "\WinDivert64.sys"
Local $dllFile = $gdpiDir & "\WinDivert.dll"

If Not FileExists($driverFile) Or Not FileExists($dllFile) Or Not FileExists($gdpiFile) Then
    LogMsg("!!! KRİTİK HATA: WinDivert dosyaları eksik!")
    LogMsg("Anti-virüs (Kaspersky) dosyaları silmiş olabilir.")
    LogMsg("Lütfen klasörü dışlananlara ekleyin ve dosyaları geri yükleyin.")
    MsgBox(16, "Anti-Virüs Engeli", "WinDivert sürücü dosyaları bulunamadı. Kaspersky karantinayı kontrol edin.")
    Exit
EndIf

LogMsg("[OK] Sürücü dosyaları mevcut. Denemeler başlıyor...")

Local $finalParam = ""
HttpSetUserAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64)")

For $p In $params
    LogMsg("Deneniyor: " & $p)
    ProcessClose("goodbyedpi.exe")
    Run($gdpiDir & "\goodbyedpi.exe " & $p, $gdpiDir, @SW_HIDE) ; Arka planda çalismasi daha stabil olur

    ; Donmayi Önleyen kontrol mekanizmasi
    Local $hDownload = InetGet($testUrl, @TempDir & "\test.dat", 1, 1) ; 1, 1 = zorla indir ve arka planda yap
    Local $iTimer = TimerInit()

    While Not InetGetInfo($hDownload, 2) ; Indirme bitene kadar bekle
        If TimerDiff($iTimer) > 6000 Then ExitLoop ; 6 saniye bekledik, tik yoksa  ik
        Sleep(250) ; CPU'yu yormamak i in kisa bekleme
    WEnd

    Local $iBytes = InetGetInfo($hDownload, 0)
    InetClose($hDownload)
    FileDelete(@TempDir & "\test.dat")

    If $iBytes > 0 Then
        LogMsg("[BAŞARILI] Erişim engeli aşma başarılı!")
        $finalParam = $p
        ExitLoop
    EndIf
    LogMsg("Başarısız")
Next

If $finalParam == "" Then
    LogMsg("HATA: Hiçbir parametre çalışmadı. Program kapatılıyor.")
	Sleep(2000)
	CleanUpServices()
	Exit
EndIf

; --- ADIM 4: DIGERLERINI BASLAT VE BILGI VER ---
LogMsg("DNSCrypt başlatılıyor...")
Run($dnsDir & "\dnscrypt-proxy.exe", $dnsDir, @SW_HIDE)

LogMsg("Go-Pcap2Socks başlatılıyor...")
Run($pcapDir & "\go-pcap2socks.exe", $pcapDir, @SW_HIDE)

Sleep(2000)
If ProcessExists("dnscrypt-proxy.exe") And ProcessExists("go-pcap2socks.exe") Then
    LogMsg("-------------------------------------------")
    LogMsg("PLAYSTATION MANUEL AĞ AYARLARI:")
    LogMsg("-------------------------------------------")
    LogMsg("IP Adresi  : 172.24.2.2-255 (Örn: 172.24.2.10)")
    LogMsg("Ağ Maskesi : 255.255.0.0")
    LogMsg("Ağ Geçidi  : 172.24.2.1")
    LogMsg("DNS 1      : " & @IPAddress1)
    LogMsg("DNS 2      : " & @IPAddress1)
    LogMsg("-------------------------------------------")
    LogMsg("SİSTEM ÇALIŞIYOR! İyi oyunlar.")
Else
    LogMsg("HATA: Araçlardan biri başlatılamadı.")
EndIf

While 1
    If GUIGetMsg() = $GUI_EVENT_CLOSE Then
        ProcessClose("goodbyedpi.exe")
        ProcessClose("dnscrypt-proxy.exe")
        ProcessClose("go-pcap2socks.exe")
		CleanUpServices()
        Exit
    EndIf
WEnd
