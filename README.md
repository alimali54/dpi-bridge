<img width="552" height="527" alt="Ekran görüntüsü 2025-12-25 104912" src="https://github.com/user-attachments/assets/2c23fb5c-42dc-4e79-8389-bb0cf8f95426" />

## Nedir?

Bu araç Playstation trafiğini PC üzerinden geçirerek internete çıkarır. Böylece PC'de GoodbyeDPI ile erişim engelini aştığınızda Playstation'da da aşmış olursunuz.

GoodbyeDPI'ı sadece Roblox ve Discord domainleri etkileyecek şekilde yapılandırdım. Playstation'un tüm trafiği PC'den geçse de sadece Roblox ve Discord domainleri DPI bypass işleminden etkilenir, normal trafik etkilenmez.

PC ve Playstation'un aynı ağda olması yeterlidir. PC'yi kablo ile PS'e bağlama veya PC'den hotspot açma gibi işlemlere ihtiyaç yoktur.
Playstation'da NAT tipi bozulmaz. Kendi denemelerimde normalde NAT 2 alırken işlemler sonrasında da NAT 2 alıyorum.

| Trafik Türü | İşlem (DPI Bypass) | Sonuç |
| :--- | :---: | :--- |
| **Discord (Sesli Sohbet & API)** | ✅ AKTİF | Bağlantı sorunları çözülür. |
| **Roblox (Web & Oyun)** | ✅ AKTİF | Erişim engeli aşılır. |
| **PSN Servisleri (Store, Güncelleme)** | ❌ PASİF | Orijinal hızda ve doğrudan bağlanır. |
| **Online Oyun Trafiği (Ping/Lag)** | ❌ PASİF | Paketler ellenmez, gecikme yaşanmaz. |
| **Video Akış (Youtube, Netflix)** | ❌ PASİF | Bypass işlemine girmeden standart akar. |

> [!NOTE]
> **Gecikme Hakkında:** Trafik bilgisayarınız üzerinden köprülenerek geçtiği için, bilgisayarınızın donanım performansına ve ağ kalitesine bağlı olarak çok minimal bir gecikme (ping) artışı yaşanabilir. En iyi performans için hem PC'nin hem de konsolun kablolu (Ethernet) bağlantı veya 5 Ghz Wi-Fi kullanması önerilir. 

## Çalışma mantığı

Bu araç seti, bilgisayarınızı bir ağ geçidine dönüştürür. Süreç şu şekilde işler:

1. **GoodbyeDPI:** Yerel ağ trafiğindeki DPI (Derin Paket İnceleme) engellerini aşarak yasaklı veya sorunlu domainlere (Roblox, Discord vb.) erişim sağlar.
2. **Go-Pcap2Socks:** Bilgisayarınızda sanal bir ağ katmanı oluşturur. Konsolunuza (PS5/Xbox) programın belirttiği **172.24.x.x** bloğundaki IP adreslerini girdiğinizde, konsolunuz internete çıkmak için PC'nizi bir router olarak kullanmaya başlar.

## Gereksinimler
1.  **PC:** 64 Bit Windows işletim sistemi.
2.  **Sürücü:** [Npcap](https://npcap.com/) yüklü olmalıdır.

## Kullanım Talimatları

1.  Programı **Yönetici Olarak** çalıştırın.
2.  Güvenlik duvarı uyarıları gelirse "Erişime İzin Ver" butonuna tıklayın.
3.  Program "SİSTEM ÇALIŞIYOR" mesajını verene kadar bekleyin.
4.  Konsolunuzun (PS/Xbox) ağ ayarlarına gidin ve **Manuel** kurulumu seçin:

| Ayar | Değer |
| :--- | :--- |
| **IP Adresi** | `172.24.2.10` (veya 172.24.2.2 - 255 arası herhangi bir sayı) |
| **Alt Ağ Maskesi** | `255.255.0.0` |
| **Ağ Geçidi** | `172.24.2.1` |
| **Birincil DNS** | 1.1.1.1 | (DNS'e ne yazıldığının önemi yok, PC'nin DNS'ini alacaktır)
| **İkincil DNS** | 8.8.8.8 |

## Kurulum (Geliştiriciler İçin)

Kaynak kodundan derlemek isterseniz:
1. [AutoIt v3](https://www.autoitscript.com/site/autoit/) indirin ve kurun.
2. `.au3` dosyasını `Compile Script to .exe` seçeneği ile derleyin.


## 📜 Credits

Bu proje, aşağıdaki harika açık kaynaklı araçları bir araya getirerek çalışmaktadır:

* **[GoodbyeDPI](https://github.com/ValdikSS/GoodbyeDPI)** - ValdikSS tarafından geliştirilen pasif DPI engelleyici.
* **[go-pcap2socks](https://github.com/DaniilSokolyuk/go-pcap2socks)** - Pcap trafiğini SOCKS vekillere yönlendiren ağ köprüsü.
* **[Npcap](https://npcap.com/)** - Windows için paket yakalama kütüphanesi.
* **Google Gemini:** Ben söyledim, gemini kodları yazdı :)

Bu araçların her biri kendi lisansları altında korunmaktadır. Onların emeği olmadan bu proje mümkün olmazdı.
