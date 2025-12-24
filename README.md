Bu araç, bilgisayarınızı akıllı bir ağ geçidine (Gateway) dönüştürerek; **PlayStation, Xbox ve Nintendo Switch** gibi konsollardan Discord (Sesli Sohbet) ve Roblox'a sorunsuz bir şekilde bağlanmanızı sağlar.
<img width="502" height="527" alt="Ekran Alıntısı" src="https://github.com/user-attachments/assets/58027d21-c7b2-4138-8dbf-cd6a79489e5e" />

## ✨ Öne Çıkan Özellikler

* **Geniş Cihaz Desteği:** PlayStation 4/5, Xbox One, Xbox Series X/S ve Nintendo Switch ile tam uyumlu.
* **⚠️ Kritik Avantaj:** NAT tipini bozmaz, online oyunlarda (FC 25, CoD, GTA Online) bağlantı sorunu veya "NAT Failed" hatası çıkarmaz.
* **Otomatik Bypass:** GoodbyeDPI parametrelerini kendi dener ve en uygun olanı bulur.
* **Güvenli DNS:** DNSCrypt-Proxy entegrasyonu ile şifrelenmiş DNS trafiği sağlar.
* **Akıllı Kontrol:** Npcap sürücüsü ve Güvenlik Duvarı izinlerini otomatik denetler.

## 🛠️ Gereksinimler

1.  **PC:** 64 Bit Windows işletim sistemi.
2.  **Sürücü:** [Npcap](https://npcap.com/) yüklü olmalıdır.
3.  **Dosyalar:** `goodbyedpi`, `dnscrypt-proxy` ve `go-pcap2socks` klasörleri programla aynı dizinde olmalıdır.

## 🚀 Kullanım Talimatları

1.  Programı **Yönetici Olarak** çalıştırın.
2.  Güvenlik duvarı uyarıları gelirse "Erişime İzin Ver" butonuna tıklayın.
3.  Program "SİSTEM ÇALIŞIYOR" mesajını verene kadar bekleyin.
4.  Konsolunuzun (PS/Xbox) ağ ayarlarına gidin ve **Manuel** kurulumu seçin:

| Ayar | Değer |
| :--- | :--- |
| **IP Adresi** | `172.24.2.10` (veya 172.24.2.2 - 255 arası herhangi bir sayı) |
| **Alt Ağ Maskesi** | `255.255.0.0` |
| **Ağ Geçidi** | `172.24.2.1` |
| **Birincil DNS** | *Programın sonunda verilen Local IP* |
| **İkincil DNS** | *Programın sonunda verilen Local IP* |

## 📦 Kurulum (Geliştiriciler İçin)

Kaynak kodundan derlemek isterseniz:
1. [AutoIt v3](https://www.autoitscript.com/site/autoit/) indirin ve kurun.
2. `.au3` dosyasını `Compile Script to .exe` seçeneği ile derleyin.

## 📜 Lisans

Bu proje **MIT Lisansı** ile lisanslanmıştır. Daha fazla bilgi için `LICENSE` dosyasına göz atın.

## 📜 Credits & Acknowledgments

Bu proje, aşağıdaki harika açık kaynaklı araçları bir araya getirerek çalışmaktadır:

* **[GoodbyeDPI](https://github.com/ValdikSS/GoodbyeDPI)** - ValdikSS tarafından geliştirilen pasif DPI engelleyici.
* **[dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy)** - DNS trafiğini şifrelemek ve güvenli DNS kullanmak için.
* **[go-pcap2socks](https://github.com/DaniilSokolyuk/go-pcap2socks)** - Pcap trafiğini SOCKS vekillere yönlendiren ağ köprüsü.
* **[Npcap](https://npcap.com/)** - Windows için paket yakalama kütüphanesi.

Bu araçların her biri kendi lisansları altında korunmaktadır. Onların emeği olmadan bu proje mümkün olmazdı.

---
*Not: Bu araç bağımsız bir projedir ve üçüncü taraf yazılımların (GoodbyeDPI, DNSCrypt, go-pcap2socks vb.) otomatize edilmesini sağlar.*
