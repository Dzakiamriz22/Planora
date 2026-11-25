# Kebijakan Privasi — Planora

**Berlaku sejak:** 25 November 2026  
**Aplikasi:** Planora (`com.planora.app`)

Planora dirancang dengan prinsip **privasi sejak desain (privacy by design)**:

1. **Tidak Ada Pengumpulan Data**  
   Planora tidak mengumpulkan, mengirim, menjual, atau membagikan data pribadi maupun data keuangan Anda ke server pengembang atau pihak ketiga mana pun.

2. **Penyimpanan 100% Lokal di Perangkat**  
   Seluruh data — termasuk profil lokal, penghasilan, biaya hidup, portofolio, komponen instrumen, catatan setoran, fase alokasi, referensi harga, serta foto profil opsional — hanya tersimpan di penyimpanan internal perangkat Android Anda (SQLite lokal dan folder privat aplikasi).

3. **Tanpa Akun & Tanpa Izin Internet**  
   Versi 2.1 tidak memerlukan pendaftaran atau login akun, tidak menggunakan izin internet pada manifes rilis, tidak menyertakan SDK analitik/pelacak/iklan, dan menonaktifkan Android Auto Backup (`android:allowBackup="false"`).

4. **Tanpa Kredensial Pihak Ketiga**  
   Field *Platform* pada portofolio hanyalah label catatan lokal milik Anda. Planora tidak pernah meminta kata sandi, PIN, OTP, atau token API dari bank, broker, atau aplikasi investasi mana pun.

5. **Kendali Penuh di Tangan Anda**  
   - **Ekspor:** Anda dapat mengekspor seluruh data Anda kapan saja ke file JSON melalui pemilih file sistem Android. File tersebut sepenuhnya berada di bawah kendali Anda.
   - **Impor:** Anda dapat memulihkan data dari file JSON cadangan Anda secara lokal.
   - **Hapus / Reset:** Fitur *Reset ke keadaan kosong* menghapus seluruh database lokal dan file foto profil dari perangkat Anda secara permanen.

Jika ada pertanyaan terkait kebijakan privasi ini, silakan buka *Issue* di repositori resmi [github.com/Dzakiamriz22/Planora](https://github.com/Dzakiamriz22/Planora).
