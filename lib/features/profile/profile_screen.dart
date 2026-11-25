import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:planora/core/format/formatters.dart';
import 'package:planora/core/theme/app_theme.dart';
import 'package:planora/core/theme/planora_colors.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/repositories/profile_repository.dart';
import 'package:planora/features/shared/planora_providers.dart';
import 'package:planora/widgets/planora_widgets.dart';

/// Layar Profil Pengguna Lokal — bukan akun online (FR-03, Bab A.4).
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _fullNameCtrl = TextEditingController();
  final _nickNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  DateTime? _birthDate;
  String _themePref = 'ikut_sistem';
  String? _avatarPath;
  bool _clearAvatar = false;
  bool _initialized = false;
  bool _saving = false;

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _nickNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _init(UserProfile p) {
    if (_initialized) return;
    _initialized = true;
    _fullNameCtrl.text = p.displayNameFull ?? '';
    _nickNameCtrl.text = p.displayName ?? '';
    _emailCtrl.text = p.emailLocal ?? '';
    _phoneCtrl.text = p.phoneLocal ?? '';
    _birthDate = AppFormatters.parseIsoDate(p.birthDate);
    _themePref = p.themePref;
    _avatarPath = p.avatarPath;
  }

  Future<void> _pickPhoto() async {
    final picked = await FilePicker.pickFiles(type: FileType.image);
    if (picked.isEmpty || picked.first.path == null) return;
    final savedPath = await ref
        .read(profileRepositoryProvider)
        .saveLocalAvatarFile(picked.first.path!);
    setState(() {
      _avatarPath = savedPath;
      _clearAvatar = false;
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref.read(profileRepositoryProvider).updateProfile(
            displayNameFull: _fullNameCtrl.text,
            displayName: _nickNameCtrl.text,
            emailLocal: _emailCtrl.text,
            phoneLocal: _phoneCtrl.text,
            birthDate:
                _birthDate != null ? AppFormatters.toIsoDate(_birthDate!) : null,
            avatarPath: _clearAvatar ? null : _avatarPath,
            clearAvatar: _clearAvatar,
            themePref: _themePref,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil lokal berhasil disimpan.')),
        );
        context.pop();
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileStreamProvider);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: profileAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Gagal memuat profil: $e')),
          data: (profile) {
            _init(profile);
            final hasPhoto = !_clearAvatar &&
                _avatarPath != null &&
                _avatarPath!.isNotEmpty &&
                File(_avatarPath!).existsSync();
            final initial = (_nickNameCtrl.text.trim().isNotEmpty
                    ? _nickNameCtrl.text.trim()[0]
                    : (_fullNameCtrl.text.trim().isNotEmpty
                        ? _fullNameCtrl.text.trim()[0]
                        : ''))
                .toUpperCase();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 6),
                  child: Row(
                    children: [
                      PlanoraAppBarIconButton(
                        icon: Icons.chevron_left_rounded,
                        tooltip: 'Kembali',
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Profil Pengguna',
                        style: AppTheme.sora(
                          size: 17,
                          weight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    children: [
                      PlanoraNoteBox(
                        child: Text(
                          'Tersimpan di HP ini, bukan akun online. Profil ini opsional dan tidak dikirim ke server mana pun.',
                          style: AppTheme.manrope(
                            size: 12,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Avatar lokal
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: PlanoraColors.primary,
                              backgroundImage:
                                  hasPhoto ? FileImage(File(_avatarPath!)) : null,
                              child: hasPhoto
                                  ? null
                                  : (initial.isNotEmpty
                                      ? Text(
                                          initial,
                                          style: AppTheme.sora(
                                            size: 26,
                                            weight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.person_outline,
                                          color: Colors.white,
                                          size: 36,
                                        )),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton.icon(
                                  onPressed: _pickPhoto,
                                  icon: const Icon(Icons.photo_outlined, size: 18),
                                  label: const Text('Pilih Foto'),
                                ),
                                if (hasPhoto)
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: PlanoraColors.danger,
                                    ),
                                    onPressed: () =>
                                        setState(() => _clearAvatar = true),
                                    child: const Text('Hapus Foto'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 14),
                      TextFormField(
                        controller: _nickNameCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Nama sapaan (opsional)',
                          helperText:
                              'Satu-satunya sumber nama sapaan di Beranda.',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _fullNameCtrl,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: 'Nama tampil lengkap (opsional)',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email catatan lokal (opsional)',
                          helperText: 'Tidak diverifikasi dan tidak dikirim.',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Nomor HP catatan lokal (opsional)',
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _birthDate ?? DateTime(1998, 1, 1),
                            firstDate: DateTime(1940, 1, 1),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() => _birthDate = picked);
                          }
                        },
                        icon: const Icon(Icons.cake_outlined, size: 18),
                        label: Text(
                          _birthDate == null
                              ? 'Tanggal lahir: Belum diisi (opsional)'
                              : 'Tanggal lahir: ${AppFormatters.shortDate(_birthDate!)}',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'PREFERENSI TEMA',
                        style: AppTheme.uppercaseLabel(
                          color: PlanoraColors.inkMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(
                            value: 'ikut_sistem',
                            label: Text('Ikut sistem'),
                          ),
                          ButtonSegment(
                            value: 'terang',
                            label: Text('Terang'),
                          ),
                          ButtonSegment(
                            value: 'gelap',
                            label: Text('Gelap'),
                          ),
                        ],
                        selected: {_themePref},
                        onSelectionChanged: (set) =>
                            setState(() => _themePref = set.first),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _saving ? null : _save,
                      child: const Text('Simpan Profil'),
                    ),
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
