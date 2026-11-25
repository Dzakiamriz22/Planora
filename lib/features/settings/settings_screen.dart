import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:planora/core/calc/planora_calc.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/settings_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';
import 'package:planora/widgets/rupiah_text_field.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  Future<void> _showEditProfileSheet(Setting s) async {
    final formKey = GlobalKey<FormState>();
    final salaryCtrl = TextEditingController(
      text: s.monthlySalary != null
          ? AppFormatters.number(s.monthlySalary!)
          : '',
    );
    final minLivingCtrl = TextEditingController(
      text: s.minimumLivingCost != null
          ? AppFormatters.number(s.minimumLivingCost!)
          : '',
    );
    final curLivingCtrl = TextEditingController(
      text: s.currentLivingCost != null
          ? AppFormatters.number(s.currentLivingCost!)
          : '',
    );
    final returnCtrl =
        TextEditingController(text: s.defaultAnnualReturnPct.toString());

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          final sal = parseRupiahInput(salaryCtrl.text);
          final minL = parseRupiahInput(minLivingCtrl.text);
          final previewCeiling = sal > 0
              ? PlanoraCalc.ceiling(
                  monthlySalary: sal,
                  minimumLivingCost: minL,
                )
              : null;
          final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;

          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Edit Profil Keuangan',
                      style: AppTheme.sora(size: 17, weight: FontWeight.w700),
                    ),
                    const SizedBox(height: 14),
                    RupiahTextField(
                      controller: salaryCtrl,
                      label: 'Gaji bulanan',
                      onChanged: (_) => setSheetState(() {}),
                    ),
                    const SizedBox(height: 12),
                    RupiahTextField(
                      controller: minLivingCtrl,
                      label: 'Biaya hidup minimum',
                      onChanged: (_) => setSheetState(() {}),
                    ),
                    const SizedBox(height: 12),
                    RupiahTextField(
                      controller: curLivingCtrl,
                      label: 'Biaya hidup saat ini (opsional)',
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: returnCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Return default (%/tahun)',
                        suffixText: '%',
                      ),
                      validator: (v) {
                        final d =
                            double.tryParse((v ?? '').replaceAll(',', '.'));
                        if (d == null || d < 0 || d > 100) {
                          return 'Masukkan angka antara 0 dan 100.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    PlanoraNoteBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Plafon nabung (otomatis)',
                            style: AppTheme.manrope(size: 12.5),
                          ),
                          Text(
                            previewCeiling == null
                                ? 'Belum diatur'
                                : '${AppFormatters.rupiah(previewCeiling)}/bln',
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w800,
                              color: PlanoraColors.primary,
                              tabular: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () async {
                        if (!formKey.currentState!.validate()) return;
                        final salVal = parseRupiahInput(salaryCtrl.text);
                        final minVal = parseRupiahInput(minLivingCtrl.text);
                        final curVal = parseRupiahInput(curLivingCtrl.text);
                        await ref
                            .read(settingsRepositoryProvider)
                            .updateFinancialProfile(
                              monthlySalary: salVal > 0 ? salVal : null,
                              minimumLivingCost: salVal > 0 ? minVal : null,
                              currentLivingCost: curVal > 0 ? curVal : null,
                              defaultAnnualReturnPct: double.tryParse(
                                    returnCtrl.text.replaceAll(',', '.'),
                                  ) ??
                                  5.0,
                            );
                        if (ctx.mounted) Navigator.of(ctx).pop();
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Profil keuangan diperbarui. Plafon dan seluruh layar dihitung ulang.',
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Simpan Profil Keuangan'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showPhaseLimitSheet(Setting s) async {
    var enabled = s.phaseLimitEnabled;
    final amountCtrl = TextEditingController(
      text: s.phaseLimitAmount != null
          ? AppFormatters.number(s.phaseLimitAmount!)
          : '',
    );

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) {
          final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + bottomInset),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Batas Per Porto dalam Fase',
                  style: AppTheme.sora(size: 17, weight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  'Opsional. Jika diaktifkan, berlaku untuk seluruh porto tanpa memandang platform atau instrumen saat fase disimpan.',
                  style: AppTheme.manrope(
                    size: 12.5,
                    color: PlanoraColors.inkMuted,
                  ),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Aktifkan batas per porto'),
                  value: enabled,
                  onChanged: (v) => setSheetState(() => enabled = v),
                ),
                if (enabled) ...[
                  const SizedBox(height: 8),
                  RupiahTextField(
                    controller: amountCtrl,
                    label: 'Batas maksimal per porto / bulan',
                  ),
                ],
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () async {
                    final amt = parseRupiahInput(amountCtrl.text);
                    if (enabled && amt <= 0) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        const SnackBar(
                          content: Text('Masukkan nominal batas lebih dari Rp 0.'),
                        ),
                      );
                      return;
                    }
                    await ref.read(settingsRepositoryProvider).updatePhaseLimit(
                          enabled: enabled,
                          amount: enabled ? amt : null,
                        );
                    if (ctx.mounted) Navigator.of(ctx).pop();
                  },
                  child: const Text('Simpan Pengaturan Batas'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showPriceRefsManager(List<PriceReference> refs) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => Consumer(
        builder: (ctx, ref, _) {
          final liveRefs =
              ref.watch(priceReferencesStreamProvider).value ?? refs;
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Referensi Harga',
                      style: AppTheme.sora(size: 17, weight: FontWeight.w700),
                    ),
                    TextButton.icon(
                      onPressed: () => _showPriceRefDialog(),
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Tambah'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (liveRefs.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Belum ada referensi harga tersimpan. Ketuk Tambah untuk membuat referensi buatan Anda sendiri.',
                      textAlign: TextAlign.center,
                      style: AppTheme.manrope(
                        size: 12.5,
                        color: PlanoraColors.inkMuted,
                      ),
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: liveRefs.length,
                      separatorBuilder: (_, _) => const Divider(),
                      itemBuilder: (_, i) {
                        final r = liveRefs[i];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            r.name,
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w800,
                            ),
                          ),
                          subtitle: Text(
                            'Penuh ${AppFormatters.rupiah(r.fullPrice)} • DP + biaya ${AppFormatters.rupiah(r.downPayment + r.fees)}',
                            style: AppTheme.manrope(size: 11.5, tabular: true),
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (action) {
                              if (action == 'edit') {
                                _showPriceRefDialog(existing: r);
                              } else if (action == 'delete') {
                                ref
                                    .read(settingsRepositoryProvider)
                                    .deletePriceReference(r.id);
                              }
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Hapus'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _showPriceRefDialog({PriceReference? existing}) async {
    final nameCtrl = TextEditingController(text: existing?.name ?? '');
    final fullCtrl = TextEditingController(
      text: existing != null ? AppFormatters.number(existing.fullPrice) : '',
    );
    final dpCtrl = TextEditingController(
      text: existing != null ? AppFormatters.number(existing.downPayment) : '',
    );
    final feesCtrl = TextEditingController(
      text: existing != null ? AppFormatters.number(existing.fees) : '0',
    );
    final noteCtrl = TextEditingController(text: existing?.note ?? '');
    final key = GlobalKey<FormState>();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          existing == null ? 'Tambah Referensi Harga' : 'Edit Referensi Harga',
        ),
        content: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nama referensi (teks bebas)',
                    hintText: 'Contoh: Rumah tipe 45 kota tujuan',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 10),
                RupiahTextField(
                  controller: fullCtrl,
                  label: 'Harga penuh',
                  validator: (v) => parseRupiahInput(v ?? '') <= 0
                      ? 'Harus lebih dari Rp 0'
                      : null,
                ),
                const SizedBox(height: 10),
                RupiahTextField(controller: dpCtrl, label: 'Uang muka (DP)'),
                const SizedBox(height: 10),
                RupiahTextField(controller: feesCtrl, label: 'Biaya tambahan'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: noteCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Keterangan (opsional)',
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () async {
              if (!key.currentState!.validate()) return;
              await ref.read(settingsRepositoryProvider).upsertPriceReference(
                    id: existing?.id,
                    name: nameCtrl.text.trim(),
                    fullPrice: parseRupiahInput(fullCtrl.text),
                    downPayment: parseRupiahInput(dpCtrl.text),
                    fees: parseRupiahInput(feesCtrl.text),
                    note: noteCtrl.text.trim(),
                  );
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportJson() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      builder: (ctx) {
        final mutedColor = Theme.of(ctx).colorScheme.onSurfaceVariant;
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ekspor Cadangan (JSON)',
                style: AppTheme.sora(size: 16, weight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              Text(
                'Pilih cara menyimpan file cadangan data Planora Anda.',
                style: AppTheme.manrope(
                  size: 12.5,
                  color: mutedColor,
                ),
              ),
              const SizedBox(height: 14),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: const Icon(Icons.save_alt_rounded,
                    color: PlanoraColors.primary),
                title: Text(
                  'Simpan ke Perangkat',
                  style: AppTheme.manrope(size: 14, weight: FontWeight.w700),
                ),
                subtitle: Text(
                  'Pilih folder lokal (misalnya Download) langsung di HP.',
                  style: AppTheme.manrope(
                    size: 12,
                    color: mutedColor,
                  ),
                ),
                onTap: () => Navigator.of(ctx).pop('save'),
              ),
              const Divider(height: 1),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: const Icon(Icons.share_outlined,
                    color: PlanoraColors.primary),
                title: Text(
                  'Bagikan File',
                  style: AppTheme.manrope(size: 14, weight: FontWeight.w700),
                ),
                subtitle: Text(
                  'Kirim file cadangan lewat aplikasi lain (Drive, chat, email).',
                  style: AppTheme.manrope(
                    size: 12,
                    color: mutedColor,
                  ),
                ),
                onTap: () => Navigator.of(ctx).pop('share'),
              ),
            ],
          ),
        );
      },
    );
    if (choice == null || !mounted) return;

    try {
      final jsonStr =
          await ref.read(settingsRepositoryProvider).exportAllToJson();
      final fileName =
          'planora_backup_${AppFormatters.toIsoDate(DateTime.now())}.json';

      if (choice == 'save') {
        final bytes = Uint8List.fromList(utf8.encode(jsonStr));
        final savedPath = await FilePicker.saveFile(
          dialogTitle: 'Simpan Cadangan Planora',
          fileName: fileName,
          bytes: bytes,
        );
        if (savedPath != null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Cadangan disimpan: $fileName')),
          );
        }
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final file = File(p.join(tempDir.path, fileName));
      await file.writeAsString(jsonStr);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: 'Cadangan data Planora ($fileName)',
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengekspor JSON: $e')),
        );
      }
    }
  }

  Future<void> _importJson() async {
    try {
      final picked = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (picked.isEmpty || picked.first.path == null) return;

      final content = await File(picked.first.path!).readAsString();
      if (!mounted) return;

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Impor Data Cadangan?'),
          content: const Text(
            'Impor ini akan menggantikan seluruh data Planora saat ini (profil, porto, komponen, setoran, fase, dan referensi) dengan isi file JSON yang dipilih.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Impor Sekarang'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;
      await ref.read(settingsRepositoryProvider).importAllFromJson(content);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dipulihkan dari JSON.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengimpor JSON: $e')),
        );
      }
    }
  }

  Future<void> _resetDataDoubleConfirm() async {
    final step1 = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset ke Keadaan Kosong? (1/2)'),
        content: const Text(
          'Seluruh porto, komponen, catatan setoran, fase, referensi harga, profil lokal, dan foto profil akan dihapus dan dikembalikan ke keadaan kosong total.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: PlanoraColors.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Lanjutkan'),
          ),
        ],
      ),
    );
    if (step1 != true || !mounted) return;

    final step2 = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Terakhir (2/2)'),
        content: const Text(
          'Tindakan ini tidak dapat dibatalkan dan menghapus seluruh data lokal Anda. Pastikan Anda sudah mengekspor cadangan JSON bila diperlukan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: PlanoraColors.danger),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Ya, Hapus & Kosongkan'),
          ),
        ],
      ),
    );
    if (step2 != true) return;

    await ref.read(settingsRepositoryProvider).resetToEmpty();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Seluruh data dihapus. Aplikasi kembali kosong.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(settingsStreamProvider);
    final profile = ref.watch(userProfileStreamProvider).value;
    final refs = ref.watch(priceReferencesStreamProvider).value ?? const [];
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: settingsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Gagal memuat pengaturan: $e')),
          data: (setting) {
            final ceiling = PlanoraCalc.ceiling(
              monthlySalary: setting.monthlySalary,
              minimumLivingCost: setting.minimumLivingCost,
            );
            final returnText = setting.defaultAnnualReturnPct ==
                    setting.defaultAnnualReturnPct.roundToDouble()
                ? '${setting.defaultAnnualReturnPct.round()}% /tahun'
                : '${setting.defaultAnnualReturnPct.toStringAsFixed(1).replaceAll('.', ',')}% /tahun';

            final profileName = profile?.displayName?.trim().isNotEmpty == true
                ? profile!.displayName!
                : (profile?.displayNameFull?.trim().isNotEmpty == true
                    ? profile!.displayNameFull!
                    : 'Profil belum diatur');

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Pengaturan',
                    style: AppTheme.sora(
                      size: 21,
                      weight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                ),

                // Kartu Profil Pengguna Lokal (Bab A.4)
                PlanoraCard(
                  onTap: () => context.push('/profile'),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: PlanoraColors.primary,
                        backgroundImage: (profile?.avatarPath != null &&
                                profile!.avatarPath!.isNotEmpty &&
                                File(profile.avatarPath!).existsSync())
                            ? FileImage(File(profile.avatarPath!))
                            : null,
                        child: (profile?.avatarPath != null &&
                                profile!.avatarPath!.isNotEmpty &&
                                File(profile.avatarPath!).existsSync())
                            ? null
                            : const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileName,
                              style: AppTheme.manrope(
                                size: 14,
                                weight: FontWeight.w800,
                                color: cs.onSurface,
                              ),
                            ),
                            Text(
                              'Profil lokal di perangkat ini',
                              style: AppTheme.manrope(
                                size: 11.5,
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Atur',
                        style: AppTheme.manrope(
                          size: 13,
                          weight: FontWeight.w800,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 1. Profil Keuangan
                PlanoraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profil Keuangan',
                            style: AppTheme.manrope(
                              size: 13.5,
                              weight: FontWeight.w800,
                              color: cs.onSurface,
                            ),
                          ),
                          InkWell(
                            onTap: () => _showEditProfileSheet(setting),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 2,
                              ),
                              child: Text(
                                'Ubah',
                                style: AppTheme.manrope(
                                  size: 12.5,
                                  weight: FontWeight.w800,
                                  color: cs.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      PlanoraKeyValueRow(
                        label: 'Gaji bulanan',
                        value: setting.monthlySalary != null
                            ? AppFormatters.rupiah(setting.monthlySalary!)
                            : 'Belum diatur',
                        onTap: () => _showEditProfileSheet(setting),
                      ),
                      const Divider(),
                      PlanoraKeyValueRow(
                        label: 'Biaya hidup minimum',
                        value: setting.minimumLivingCost != null
                            ? AppFormatters.rupiah(setting.minimumLivingCost!)
                            : 'Belum diatur',
                        onTap: () => _showEditProfileSheet(setting),
                      ),
                      const Divider(),
                      PlanoraKeyValueRow(
                        label: 'Return default',
                        value: returnText,
                        onTap: () => _showEditProfileSheet(setting),
                      ),
                      const Divider(),
                      PlanoraKeyValueRow(
                        label: 'Plafon nabung (otomatis)',
                        value: ceiling != null
                            ? '${AppFormatters.rupiah(ceiling)}/bln'
                            : 'Belum diatur',
                        valueColor: cs.primary,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Mengubah gaji atau biaya hidup langsung menghitung ulang plafon dan seluruh layar.',
                        style: AppTheme.manrope(
                          size: 11.5,
                          color: cs.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Batas Per Porto dalam Fase (FR-21)
                PlanoraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Batas Fase',
                        style: AppTheme.manrope(
                          size: 13.5,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      PlanoraKeyValueRow(
                        label: 'Batas per porto per bulan',
                        value: setting.phaseLimitEnabled &&
                                setting.phaseLimitAmount != null
                            ? AppFormatters.rupiah(setting.phaseLimitAmount!)
                            : 'Nonaktif',
                        valueColor: cs.primary,
                        onTap: () => _showPhaseLimitSheet(setting),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 2. Referensi Harga
                PlanoraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Referensi Harga',
                        style: AppTheme.manrope(
                          size: 13.5,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      PlanoraKeyValueRow(
                        label: '${refs.length} referensi tersimpan',
                        value: 'Kelola',
                        valueColor: cs.primary,
                        onTap: () => _showPriceRefsManager(refs),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 3. Data
                PlanoraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data',
                        style: AppTheme.manrope(
                          size: 13.5,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      PlanoraKeyValueRow(
                        label: 'Ekspor cadangan (JSON)',
                        value: 'Ekspor',
                        valueColor: cs.primary,
                        onTap: _exportJson,
                      ),
                      const Divider(),
                      PlanoraKeyValueRow(
                        label: 'Impor cadangan',
                        value: 'Pilih File',
                        valueColor: cs.primary,
                        onTap: _importJson,
                      ),
                      const Divider(),
                      PlanoraKeyValueRow(
                        label: 'Reset ke keadaan kosong',
                        value: 'Reset',
                        valueColor: PlanoraColors.danger,
                        onTap: _resetDataDoubleConfirm,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Reset meminta konfirmasi ganda dan menghapus seluruh porto, setoran, fase, referensi, serta profil lokal.',
                        style: AppTheme.manrope(
                          size: 11.5,
                          color: cs.onSurfaceVariant,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Penyimpanan & Masa Depan (Bab E.2)
                PlanoraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Penyimpanan & Masa Depan',
                        style: AppTheme.manrope(
                          size: 13.5,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Seluruh data Anda tersimpan lokal di perangkat ini tanpa akun online dan tanpa izin internet. Struktur data sudah disiapkan untuk sinkronisasi cloud opsional pada versi 3.0 mendatang.',
                        style: AppTheme.manrope(
                          size: 12,
                          color: cs.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 4. Tentang
                PlanoraCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tentang',
                        style: AppTheme.manrope(
                          size: 13.5,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const PlanoraKeyValueRow(
                        label: 'Aplikasi',
                        value: 'Planora 2.1.0',
                      ),
                      const Divider(),
                      PlanoraKeyValueRow(
                        label: 'Paket',
                        value: 'com.planora.app',
                        valueStyle: AppTheme.mono(
                          size: 11.5,
                          weight: FontWeight.w500,
                          color: cs.onSurface,
                        ),
                      ),
                      const Divider(),
                      const PlanoraKeyValueRow(
                        label: 'Penyimpanan',
                        value: 'Lokal di perangkat',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
