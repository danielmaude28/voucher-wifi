# voucher-wifi

Paket OpenWrt untuk captive portal Wi-Fi tamu berbasis **openNDS** dan voucher.

> Status: periksa kompatibilitas target OpenWrt dan perangkat sebelum memasang di router produksi. Workflow CI saat ini membangun target `ramips/mt76x8`.

## Fitur

- Membuat SSID tamu terbuka dengan isolasi client Wi-Fi.
- Mengarahkan gateway openNDS ke bridge `br-guest`.
- Membuat dan menampilkan voucher melalui perintah `voucher`.
- Menyimpan data master di `/etc/voucher-wifi/vouchers.txt` dan data aktif openNDS di `/tmp/ndslog/vouchers.txt`.

## Instalasi dan konfigurasi

1. Pastikan router menjalankan OpenWrt yang kompatibel dan paket `opennds` tersedia.
2. Pasang paket `voucher-wifi`.
3. Jalankan `voucher setup "Nama WiFi Tamu"` sebagai root.
4. Periksa konfigurasi jaringan, firewall, DHCP, dan status openNDS sebelum membagikan SSID.

**Peringatan:** perintah setup mengubah konfigurasi UCI untuk network, DHCP, wireless, firewall, dan openNDS, lalu me-reload layanan terkait. Cadangkan konfigurasi router terlebih dahulu. SSID dibuat tanpa enkripsi; keamanan akses bergantung pada captive portal dan konfigurasi firewall. Uji pemisahan guest dari LAN pada perangkat sebenarnya.

## Perintah voucher

```sh
voucher add 60 10       # 10 voucher, masa berlaku 60 menit
voucher add 120 1 2048 512
voucher list
voucher save
voucher sync
```

Parameter `add`: `MENIT [JUMLAH] [DOWN_KBPS] [UP_KBPS]`. Menit 1–525600, jumlah 1–500, dan batas kecepatan 0–100000000. Nilai 0 untuk kecepatan berarti tanpa batas sesuai interpretasi konfigurasi openNDS.

Data aktif berada di `/tmp`, yang umumnya bersifat sementara dan hilang saat reboot. Data master berada di konfigurasi persisten. Karena openNDS dapat memperbarui status voucher terpakai, jangan menyalin file master ke file aktif saat openNDS sedang berjalan: sinkronisasi hanya menginisialisasi file aktif jika belum ada. Periksa kebijakan backup dan pemulihan sesuai versi openNDS yang digunakan.

## Build

GitHub Actions membangun paket untuk target yang ditetapkan di `.github/workflows/build.yml`, mengunggah artifact, lalu memperbarui GitHub Release bernama `latest`. Build CI bukan pengganti pengujian pada router fisik.

## Pengujian sebelum produksi

- Jalankan pemeriksaan sintaks shell melalui workflow.
- Instal pada router uji dan pastikan bridge, DHCP, DNS, firewall, dan openNDS aktif.
- Pastikan klien guest dapat mengakses internet tetapi tidak dapat mengakses subnet LAN/router yang sensitif.
- Uji voucher valid, kedaluwarsa, duplikat, pemakaian bersamaan, reboot, dan pemulihan data.
