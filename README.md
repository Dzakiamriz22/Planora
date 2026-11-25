<div align="center">
  <img src="assets/logo/planora_logo.svg" alt="Logo Planora" width="108" height="108" />
  <h1>Planora</h1>
  <p><strong>Rencanakan. Tabung. Tercapai.</strong></p>
  <p>Aplikasi Android untuk merencanakan banyak tujuan keuangan sekaligus — simpel, otomatis hitung ulang, dan 100% offline di HP kamu.</p>

  <p>
    <a href="https://github.com/Dzakiamriz22/Planora/releases/latest">
      <img src="https://img.shields.io/badge/Download_APK-v2.1.0-0B4A34?style=for-the-badge&logo=android&logoColor=white" alt="Download APK Planora v2.1.0" />
    </a>
  </p>

  <p>
    <img src="https://img.shields.io/badge/Versi-2.1.0-0B4A34?style=flat-square" alt="Versi 2.1.0" />
    <img src="https://img.shields.io/badge/Flutter-3.50+-02569B?style=flat-square&logo=flutter&logoColor=white" alt="Flutter" />
    <img src="https://img.shields.io/badge/Android-Offline--First-3DDC84?style=flat-square&logo=android&logoColor=white" alt="Android Offline-First" />
    <img src="https://img.shields.io/badge/License-MIT-43524A?style=flat-square" alt="Lisensi MIT" />
  </p>
</div>

---

## Kenapa Planora?

Punya banyak rencana — dana darurat, liburan, DP rumah, beli kendaraan, sampai investasi rutin — tapi semuanya datang dari satu penghasilan bulanan?

Sering kali kalau dihitung manual di catatan atau spreadsheet, total rencana nabung diam-diam melebihi kemampuan gaji, atau angka target dan estimasi waktu tercapainya jadi nggak sinkron.

**Planora** hadir buat bikin perencanaan keuangan pribadi jadi jauh lebih tenang:
- **Batas nabung bulanan otomatis terjaga** — dihitung dari penghasilan dikurangi biaya hidup minimum kamu. Kalau salah satu tujuan kamu naikkan sampai melewati batas, Planora bantu atur ulang porsi tujuan lain dengan persetujuan kamu dulu.
- **Ubah satu angka, semuanya ikut update** — ganti target, ubah setoran bulanan, atau catat setoran baru, estimasi kapan tercapai dan sisa kebutuhan langsung berubah otomatis.
- **Harga barang & target DP tidak ketukar** — untuk tujuan beli kredit (seperti rumah atau kendaraan), harga penuh tetap terlihat, tapi target nabungnya cukup sebesar DP + biaya saja.
- **Catat tempat & isi tabungan secara terpisah** — kamu tahu uangnya disimpan di mana (bank, e-wallet, aplikasi investasi, atau lainnya) dan dipecah ke instrumen apa saja (tunai, RDPU, obligasi, emas, saham, dll.).
- **Ganti prioritas lewat Fase** — mau fokus ngejar dana darurat dulu, lalu nanti geser ke DP rumah? Cukup buat fase sendiri dan ganti kapan pun tanpa repot ubah satu per satu.
- **100% lokal & tanpa akun** — mulai dari nol (kosong total), nggak perlu daftar/login, nggak butuh internet, dan data bisa kamu cadangkan sendiri kapan saja lewat file JSON.

---

## Tampilan Aplikasi

### 4 Halaman Utama

| Beranda | Portofolio | Fase Alokasi | Pengaturan |
| :---: | :---: | :---: | :---: |
| <img src="docs/screenshots/01-beranda.png" alt="Tampilan Beranda Planora" width="210" /> | <img src="docs/screenshots/02-portofolio.png" alt="Tampilan Portofolio Planora" width="210" /> | <img src="docs/screenshots/03-fase.png" alt="Tampilan Fase Alokasi Planora" width="210" /> | <img src="docs/screenshots/04-pengaturan.png" alt="Tampilan Pengaturan Planora" width="210" /> |

### Detail & Formulir

| Detail Porto | Form Porto | Form Fase |
| :---: | :---: | :---: |
| <img src="docs/screenshots/05-detail-porto.png" alt="Tampilan Detail Porto" width="230" /> | <img src="docs/screenshots/06-form-porto.png" alt="Tampilan Form Porto" width="230" /> | <img src="docs/screenshots/07-form-fase.png" alt="Tampilan Form Fase" width="230" /> |

> *Contoh angka di screenshot di atas hanya ilustrasi tampilan. Saat pertama kali dipasang, Planora mulai dalam keadaan kosong (`Rp 0`) supaya kamu bisa mengisi rencana sesuai kondisi kamu sendiri.*

---

## Dibangun Dengan

- **Flutter & Dart** — tampilan bersih dengan font lokal `Sora` & `Manrope` (tetap tampil rapi meski tanpa internet) + dukungan mode gelap mengikuti sistem HP.
- **Drift (SQLite)** — penyimpanan lokal di HP yang cepat dan aman.
- **Riverpod** — setiap perubahan setoran, target, atau gaji langsung memperbarui semua halaman tanpa perlu refresh.
- **go_router** — navigasi 4 tab yang ringan dan rapi.

---

## Cara Coba di Komputer / HP Sendiri

Pastikan sudah memasang **Flutter SDK** (`3.50+`), **Java JDK 17**, dan **Android SDK**.

```bash
# 1. Clone repo ini
git clone https://github.com/Dzakiamriz22/Planora.git
cd Planora

# 2. Ambil semua package
flutter pub get

# 3. Jalankan tes otomatis (opsional, untuk cek semua perhitungan)
flutter test

# 4. Jalankan langsung ke HP Android yang terhubung kabel USB
flutter run
```

---

## Privasi & Catatan Penting

- **Data 100% di HP kamu:** Planora tidak punya server, tidak pakai iklan/pelacak, tidak minta izin internet, dan tidak pernah meminta login atau akses ke akun bank/investasi kamu. Selengkapnya ada di [PRIVACY.md](PRIVACY.md).
- **Catatan penting:** Planora adalah alat bantu perencanaan pribadi, bukan penasihat keuangan. Estimasi tanggal tercapai maupun simulasi cicilan hanyalah hitungan ilustrasi berdasarkan angka asumsi yang kamu masukkan sendiri.

---

## Lisensi

Proyek ini dirilis dengan lisensi [MIT](LICENSE).
