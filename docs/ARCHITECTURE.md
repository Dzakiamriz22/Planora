# Arsitektur & Skema Database Planora (v3.3.0)

Dokumen ini merangkum struktur kode, lapisan perhitungan, skema database SQLite (Drift), dan aturan privasi yang berjalan di kode Planora saat ini.

## 1. Struktur Proyek

```text
lib/
├── app.dart                         # Router GoRouter (5 tab utama + rute detail/form)
├── main.dart                        # Entry point, inisialisasi DB & notifikasi tanpa minta izin
├── core/
│   ├── calc/
│   │   ├── planora_calc.dart        # Plafon nabung, kebutuhan bulanan, rebalance, cicilan
│   │   ├── planora_v22_calc.dart    # Persen komponen, auto-balance, split setoran, insight, streak
│   │   ├── plan_percent_calc.dart   # Plan berbasis persen (sharePercentX100) & preset
│   │   ├── stock_lot_calc.dart      # Saham langsung berbasis lot (1 lot = 100 lbr, average cost)
│   │   ├── global_composition_calc.dart # Agregasi persen instrumen lintas semua portofolio
│   │   └── cash_flow_calc.dart      # Arus kas bulanan, sisa kas, budget status, saran anti-dobel
│   ├── format/formatters.dart       # Formatter rupiah/persen/tanggal + lapisan Mode Privasi terpusat
│   ├── notifications/reminder_service.dart # Penjadwal lokal & rationale dialog Android 13+
│   └── theme/                       # Token warna, tipografi lokal (Sora/Manrope/JetBrains Mono)
├── data/
│   ├── db/
│   │   ├── tables.dart              # Definisi 11 tabel Drift
│   │   ├── app_database.dart        # Migrasi skema 1 -> 6 yang idempotent & terverifikasi
│   │   └── seed_data.dart           # Initial state kosong + seed 5 kategori pemasukan & 10 pengeluaran
│   └── repositories/                # Portfolio, Plan, Stock, CashFlow, Profile, Settings (JSON backup)
├── features/
│   ├── home/                        # Beranda, GlobalCompositionCard, Arus Kas ringkas
│   ├── portfolios/                  # Daftar, Detail, Form Porto, Setoran, Saham Lot, Riwayat
│   ├── plans/                       # Daftar & Form Plan (% Persen / Rp Nominal tepat)
│   ├── cashflow/                    # Tab Arus Kas, entri cepat Pemasukan/Pengeluaran, kelola kategori
│   ├── settings/                    # Profil Keuangan, Mode Privasi, Pengingat Lokal, Ekspor/Impor/Reset
│   ├── profile/                     # Profil lokal & preferensi tema
│   └── onboarding/ & splash/
└── widgets/                         # Komponen UI bersama, grafik fl_chart, logo vektor Tangga Tujuan
```

## 2. Skema Database (Drift — `schemaVersion: 6`)

| No | Tabel | Keterangan |
|---:|---|---|
| 1 | `user_profiles` | Profil lokal (nama sapaan, foto lokal, preferensi tema) |
| 2 | `settings` | Gaji rencana, biaya hidup, return default, batas Plan, pengingat, `hide_amounts` |
| 3 | `portfolios` | Daftar tujuan keuangan (`cash`, `down_payment`, `no_target`) |
| 4 | `portfolio_components` | Alokasi instrumen per porto (`target_percent`, `actual_amount`, `mechanism`, `legacy_opening_amount`) |
| 5 | `contributions` | Catatan setoran & penyesuaian saldo portofolio |
| 6 | `stock_transactions` | Transaksi beli/jual saham langsung berbasis lot |
| 7 | `plans` | Daftar Plan bulanan (`total_amount`, `is_active`) |
| 8 | `plan_allocations` | Porsi tiap porto dalam Plan (`share_percent_x100`, opsional `fixed_amount`) |
| 9 | `price_references` | Catatan referensi harga pribadi |
| 10 | `cash_flow_categories` | Kategori Arus Kas terpisah per `type` (`income` / `expense`), mendukung sembunyikan |
| 11 | `cash_flow_transactions` | Transaksi Pemasukan (+) & Pengeluaran (−) dengan soft delete (`deleted_at`) |

## 3. Prinsip Arsitektur & Privasi

- **Rumus terpisah dari UI:** Seluruh logika perhitungan uang berada di `lib/core/calc/` sebagai fungsi murni sehingga mudah diuji unit.
- **Anti dobel antara Arus Kas dan Plan/Portofolio:** Gaji di Profil Keuangan tetap merupakan *rencana* untuk batas tabungan & Plan; catatan pemasukan di Arus Kas adalah *aktual* dan tidak pernah otomatis mengubah gaji rencana, Plan, maupun saldo portofolio.
- **Izin Android minimal:** Release manifest hanya memuat `POST_NOTIFICATIONS` dan `RECEIVE_BOOT_COMPLETED` (tanpa `INTERNET`, tanpa exact alarm, dan tanpa izin penyimpanan).
