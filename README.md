# 🏠 SIMKO - Sistem Informasi Manajemen Kost

Sistem Informasi Kost (SIMKO) adalah aplikasi berbasis web untuk mengelola data penghuni, kamar kost, pembayaran, pengeluaran, komplain, hingga notifikasi.

Database ini berfungsi sebagai _back-end_ penyimpanan data utama untuk aplikasi tersebut, dibangun menggunakan **MySQL/MariaDB**.

---

## 📂 Struktur Proyek

```
D:Porto Aplikasi/
├── Flutter/
│   └── aplikasi Kost/
│       ├── database mysql (kode sql)
│       ├── flutter_application_simko (kode Flutter)
│       └── API (kode PHP)

````

---

## 🧾 Tentang File `simko_db.sql`

File ini berisi seluruh **struktur dan data awal** untuk database `simko_db`, termasuk:

| Tabel                 | Fungsi                                                                 |
|----------------------|------------------------------------------------------------------------|
| `penghuni`           | Menyimpan data penghuni kost                                            |
| `kost`               | Data kamar kost (ukuran, fasilitas, harga, status)                      |
| `data_sewa`          | Riwayat penyewaan kamar oleh penghuni                                   |
| `pembayaran`         | Riwayat pembayaran kost tiap bulan                                      |
| `komplain`           | Komplain dari penghuni terhadap fasilitas atau lingkungan               |
| `permintaan_pindah`  | Permintaan pindah kamar oleh penghuni                                   |
| `permintaan_berhenti`| Permintaan berhenti sewa kost                                           |
| `notifikasi`         | Pemberitahuan dari admin atau sistem                                    |
| `notifikasi_penghuni`| Pengumuman massal untuk semua penghuni                                  |
| `informasi_umum`     | Panduan, kontak, syarat & ketentuan                                     |
| `pengeluaran`        | Biaya operasional kost bulanan                                          |

---

## ⚙️ Cara Menggunakan

1. **Buat database**
   ```sql
   CREATE DATABASE simko_db;
````

2. **Import database**

   * Melalui `phpMyAdmin`, klik tab **Import**, lalu pilih `simko_db.sql`
   * Atau gunakan command line:

     ```bash
     mysql -u root -p simko_db < simko_db.sql
     ```

3. **Integrasikan ke aplikasi PHP**

   * Edit file `config.php` atau koneksi database Anda:

     ```php
     $conn = new mysqli("localhost", "root", "", "simko_db");
     ```

---

## 🛡️ Keamanan

* Password pengguna di-hash menggunakan `bcrypt`
* Gunakan `HTTPS` dan validasi input untuk keamanan di versi produksi

---

## 📸 Contoh Fitur Aplikasi (berdasarkan struktur ini)

* ✅ Login penghuni dan admin
* 📅 Riwayat sewa kamar
* 💰 Pembayaran bulanan (cash & transfer)
* 🔔 Notifikasi status pembayaran
* 📢 Pengumuman umum
* 🧾 Manajemen pengeluaran bulanan
* 📝 Laporan komplain, pindah, dan berhenti

---

## 👨‍💻 Dibuat Oleh

**Nama**: Rijal
**Email**: [learnrijal@gmail.com]


---

## 🤝 Lisensi

Open-source untuk keperluan pembelajaran dan pengembangan.
Silakan gunakan, modifikasi, dan kontribusi kembali ke proyek ini.

```
MIT License
```

---

## 📬 Kontribusi

Silakan fork repo ini dan kirim pull request jika:

* Menambahkan fitur baru
* Memperbaiki struktur database
* Menambahkan dummy data
* Memberikan dokumentasi tambahan

---

## ⭐ Penutup

Terima kasih sudah menggunakan SIMKO.
Semoga bermanfaat untuk pengelolaan kost Anda!

```

---

Kalau kamu ingin saya bantu:
- Mengemas ini jadi file `.md` siap diunduh
- Menyesuaikan dengan nama tim/developer kamu
- Atau menambahkan screenshot mockup aplikasi

Silakan bilang!
```
