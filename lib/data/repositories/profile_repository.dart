import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:planora/data/db/app_database.dart';
import 'package:planora/data/db/database_provider.dart';

/// Repository Profil Pengguna lokal (FR-03, Bab D.3, cloud-ready via owner_id).
class ProfileRepository {
  ProfileRepository(this._db);

  final AppDatabase _db;

  Stream<UserProfile> watchProfile() {
    return _db.select(_db.userProfiles).watchSingle();
  }

  Future<UserProfile> getProfile() {
    return _db.select(_db.userProfiles).getSingle();
  }

  Future<void> updateProfile({
    String? displayNameFull,
    String? displayName,
    String? emailLocal,
    String? phoneLocal,
    String? birthDate,
    String? avatarPath,
    bool clearAvatar = false,
    String? themePref,
  }) async {
    final current = await getProfile();
    final nowIso = DateTime.now().toUtc().toIso8601String();

    String? nextAvatar = current.avatarPath;
    if (clearAvatar) {
      if (current.avatarPath != null && current.avatarPath!.isNotEmpty) {
        final f = File(current.avatarPath!);
        if (await f.exists()) {
          await f.delete().catchError((_) => f);
        }
      }
      nextAvatar = null;
    } else if (avatarPath != null) {
      nextAvatar = avatarPath;
    }

    await (_db.update(_db.userProfiles)..where((t) => t.id.equals(current.id)))
        .write(
      UserProfilesCompanion(
        displayNameFull: Value(_cleanOrNull(displayNameFull)),
        displayName: Value(_cleanOrNull(displayName)),
        emailLocal: Value(_cleanOrNull(emailLocal)),
        phoneLocal: Value(_cleanOrNull(phoneLocal)),
        birthDate: Value(_cleanOrNull(birthDate)),
        avatarPath: Value(nextAvatar),
        themePref: Value(themePref ?? current.themePref),
        updatedAt: Value(nowIso),
      ),
    );
  }

  /// Menyalin file foto profil yang dipilih pengguna ke folder lokal aplikasi (bukan BLOB DB).
  Future<String> saveLocalAvatarFile(String sourcePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final ext = p.extension(sourcePath).isEmpty ? '.jpg' : p.extension(sourcePath);
    final destPath = p.join(
      appDir.path,
      'planora_avatar_${DateTime.now().millisecondsSinceEpoch}$ext',
    );
    await File(sourcePath).copy(destPath);
    return destPath;
  }

  String? _cleanOrNull(String? v) {
    if (v == null) return null;
    final trimmed = v.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(appDatabaseProvider));
});
