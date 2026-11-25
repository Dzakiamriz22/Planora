// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameFullMeta = const VerificationMeta(
    'displayNameFull',
  );
  @override
  late final GeneratedColumn<String> displayNameFull = GeneratedColumn<String>(
    'display_name_full',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailLocalMeta = const VerificationMeta(
    'emailLocal',
  );
  @override
  late final GeneratedColumn<String> emailLocal = GeneratedColumn<String>(
    'email_local',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneLocalMeta = const VerificationMeta(
    'phoneLocal',
  );
  @override
  late final GeneratedColumn<String> phoneLocal = GeneratedColumn<String>(
    'phone_local',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<String> birthDate = GeneratedColumn<String>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarPathMeta = const VerificationMeta(
    'avatarPath',
  );
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
    'avatar_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themePrefMeta = const VerificationMeta(
    'themePref',
  );
  @override
  late final GeneratedColumn<String> themePref = GeneratedColumn<String>(
    'theme_pref',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ikut_sistem'),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('IDR'),
  );
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumn<String> locale = GeneratedColumn<String>(
    'locale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('id_ID'),
  );
  static const VerificationMeta _isLocalOnlyMeta = const VerificationMeta(
    'isLocalOnly',
  );
  @override
  late final GeneratedColumn<bool> isLocalOnly = GeneratedColumn<bool>(
    'is_local_only',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_local_only" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayNameFull,
    displayName,
    emailLocal,
    phoneLocal,
    birthDate,
    avatarPath,
    themePref,
    currency,
    locale,
    isLocalOnly,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name_full')) {
      context.handle(
        _displayNameFullMeta,
        displayNameFull.isAcceptableOrUnknown(
          data['display_name_full']!,
          _displayNameFullMeta,
        ),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('email_local')) {
      context.handle(
        _emailLocalMeta,
        emailLocal.isAcceptableOrUnknown(data['email_local']!, _emailLocalMeta),
      );
    }
    if (data.containsKey('phone_local')) {
      context.handle(
        _phoneLocalMeta,
        phoneLocal.isAcceptableOrUnknown(data['phone_local']!, _phoneLocalMeta),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
        _avatarPathMeta,
        avatarPath.isAcceptableOrUnknown(data['avatar_path']!, _avatarPathMeta),
      );
    }
    if (data.containsKey('theme_pref')) {
      context.handle(
        _themePrefMeta,
        themePref.isAcceptableOrUnknown(data['theme_pref']!, _themePrefMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('locale')) {
      context.handle(
        _localeMeta,
        locale.isAcceptableOrUnknown(data['locale']!, _localeMeta),
      );
    }
    if (data.containsKey('is_local_only')) {
      context.handle(
        _isLocalOnlyMeta,
        isLocalOnly.isAcceptableOrUnknown(
          data['is_local_only']!,
          _isLocalOnlyMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayNameFull: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_full'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      emailLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email_local'],
      ),
      phoneLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_local'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_date'],
      ),
      avatarPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_path'],
      ),
      themePref: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_pref'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      locale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locale'],
      )!,
      isLocalOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_local_only'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String? displayNameFull;
  final String? displayName;
  final String? emailLocal;
  final String? phoneLocal;
  final String? birthDate;
  final String? avatarPath;

  /// `ikut_sistem` | `terang` | `gelap`
  final String themePref;
  final String currency;
  final String locale;
  final bool isLocalOnly;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const UserProfile({
    required this.id,
    this.displayNameFull,
    this.displayName,
    this.emailLocal,
    this.phoneLocal,
    this.birthDate,
    this.avatarPath,
    required this.themePref,
    required this.currency,
    required this.locale,
    required this.isLocalOnly,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || displayNameFull != null) {
      map['display_name_full'] = Variable<String>(displayNameFull);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || emailLocal != null) {
      map['email_local'] = Variable<String>(emailLocal);
    }
    if (!nullToAbsent || phoneLocal != null) {
      map['phone_local'] = Variable<String>(phoneLocal);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<String>(birthDate);
    }
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    map['theme_pref'] = Variable<String>(themePref);
    map['currency'] = Variable<String>(currency);
    map['locale'] = Variable<String>(locale);
    map['is_local_only'] = Variable<bool>(isLocalOnly);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      displayNameFull: displayNameFull == null && nullToAbsent
          ? const Value.absent()
          : Value(displayNameFull),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      emailLocal: emailLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(emailLocal),
      phoneLocal: phoneLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneLocal),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      themePref: Value(themePref),
      currency: Value(currency),
      locale: Value(locale),
      isLocalOnly: Value(isLocalOnly),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      displayNameFull: serializer.fromJson<String?>(json['displayNameFull']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      emailLocal: serializer.fromJson<String?>(json['emailLocal']),
      phoneLocal: serializer.fromJson<String?>(json['phoneLocal']),
      birthDate: serializer.fromJson<String?>(json['birthDate']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      themePref: serializer.fromJson<String>(json['themePref']),
      currency: serializer.fromJson<String>(json['currency']),
      locale: serializer.fromJson<String>(json['locale']),
      isLocalOnly: serializer.fromJson<bool>(json['isLocalOnly']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayNameFull': serializer.toJson<String?>(displayNameFull),
      'displayName': serializer.toJson<String?>(displayName),
      'emailLocal': serializer.toJson<String?>(emailLocal),
      'phoneLocal': serializer.toJson<String?>(phoneLocal),
      'birthDate': serializer.toJson<String?>(birthDate),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'themePref': serializer.toJson<String>(themePref),
      'currency': serializer.toJson<String>(currency),
      'locale': serializer.toJson<String>(locale),
      'isLocalOnly': serializer.toJson<bool>(isLocalOnly),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  UserProfile copyWith({
    String? id,
    Value<String?> displayNameFull = const Value.absent(),
    Value<String?> displayName = const Value.absent(),
    Value<String?> emailLocal = const Value.absent(),
    Value<String?> phoneLocal = const Value.absent(),
    Value<String?> birthDate = const Value.absent(),
    Value<String?> avatarPath = const Value.absent(),
    String? themePref,
    String? currency,
    String? locale,
    bool? isLocalOnly,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => UserProfile(
    id: id ?? this.id,
    displayNameFull: displayNameFull.present
        ? displayNameFull.value
        : this.displayNameFull,
    displayName: displayName.present ? displayName.value : this.displayName,
    emailLocal: emailLocal.present ? emailLocal.value : this.emailLocal,
    phoneLocal: phoneLocal.present ? phoneLocal.value : this.phoneLocal,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
    themePref: themePref ?? this.themePref,
    currency: currency ?? this.currency,
    locale: locale ?? this.locale,
    isLocalOnly: isLocalOnly ?? this.isLocalOnly,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      displayNameFull: data.displayNameFull.present
          ? data.displayNameFull.value
          : this.displayNameFull,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      emailLocal: data.emailLocal.present
          ? data.emailLocal.value
          : this.emailLocal,
      phoneLocal: data.phoneLocal.present
          ? data.phoneLocal.value
          : this.phoneLocal,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      avatarPath: data.avatarPath.present
          ? data.avatarPath.value
          : this.avatarPath,
      themePref: data.themePref.present ? data.themePref.value : this.themePref,
      currency: data.currency.present ? data.currency.value : this.currency,
      locale: data.locale.present ? data.locale.value : this.locale,
      isLocalOnly: data.isLocalOnly.present
          ? data.isLocalOnly.value
          : this.isLocalOnly,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('displayNameFull: $displayNameFull, ')
          ..write('displayName: $displayName, ')
          ..write('emailLocal: $emailLocal, ')
          ..write('phoneLocal: $phoneLocal, ')
          ..write('birthDate: $birthDate, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('themePref: $themePref, ')
          ..write('currency: $currency, ')
          ..write('locale: $locale, ')
          ..write('isLocalOnly: $isLocalOnly, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayNameFull,
    displayName,
    emailLocal,
    phoneLocal,
    birthDate,
    avatarPath,
    themePref,
    currency,
    locale,
    isLocalOnly,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.displayNameFull == this.displayNameFull &&
          other.displayName == this.displayName &&
          other.emailLocal == this.emailLocal &&
          other.phoneLocal == this.phoneLocal &&
          other.birthDate == this.birthDate &&
          other.avatarPath == this.avatarPath &&
          other.themePref == this.themePref &&
          other.currency == this.currency &&
          other.locale == this.locale &&
          other.isLocalOnly == this.isLocalOnly &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String?> displayNameFull;
  final Value<String?> displayName;
  final Value<String?> emailLocal;
  final Value<String?> phoneLocal;
  final Value<String?> birthDate;
  final Value<String?> avatarPath;
  final Value<String> themePref;
  final Value<String> currency;
  final Value<String> locale;
  final Value<bool> isLocalOnly;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.displayNameFull = const Value.absent(),
    this.displayName = const Value.absent(),
    this.emailLocal = const Value.absent(),
    this.phoneLocal = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.themePref = const Value.absent(),
    this.currency = const Value.absent(),
    this.locale = const Value.absent(),
    this.isLocalOnly = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    this.displayNameFull = const Value.absent(),
    this.displayName = const Value.absent(),
    this.emailLocal = const Value.absent(),
    this.phoneLocal = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.themePref = const Value.absent(),
    this.currency = const Value.absent(),
    this.locale = const Value.absent(),
    this.isLocalOnly = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? displayNameFull,
    Expression<String>? displayName,
    Expression<String>? emailLocal,
    Expression<String>? phoneLocal,
    Expression<String>? birthDate,
    Expression<String>? avatarPath,
    Expression<String>? themePref,
    Expression<String>? currency,
    Expression<String>? locale,
    Expression<bool>? isLocalOnly,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayNameFull != null) 'display_name_full': displayNameFull,
      if (displayName != null) 'display_name': displayName,
      if (emailLocal != null) 'email_local': emailLocal,
      if (phoneLocal != null) 'phone_local': phoneLocal,
      if (birthDate != null) 'birth_date': birthDate,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (themePref != null) 'theme_pref': themePref,
      if (currency != null) 'currency': currency,
      if (locale != null) 'locale': locale,
      if (isLocalOnly != null) 'is_local_only': isLocalOnly,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? id,
    Value<String?>? displayNameFull,
    Value<String?>? displayName,
    Value<String?>? emailLocal,
    Value<String?>? phoneLocal,
    Value<String?>? birthDate,
    Value<String?>? avatarPath,
    Value<String>? themePref,
    Value<String>? currency,
    Value<String>? locale,
    Value<bool>? isLocalOnly,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      displayNameFull: displayNameFull ?? this.displayNameFull,
      displayName: displayName ?? this.displayName,
      emailLocal: emailLocal ?? this.emailLocal,
      phoneLocal: phoneLocal ?? this.phoneLocal,
      birthDate: birthDate ?? this.birthDate,
      avatarPath: avatarPath ?? this.avatarPath,
      themePref: themePref ?? this.themePref,
      currency: currency ?? this.currency,
      locale: locale ?? this.locale,
      isLocalOnly: isLocalOnly ?? this.isLocalOnly,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayNameFull.present) {
      map['display_name_full'] = Variable<String>(displayNameFull.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (emailLocal.present) {
      map['email_local'] = Variable<String>(emailLocal.value);
    }
    if (phoneLocal.present) {
      map['phone_local'] = Variable<String>(phoneLocal.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<String>(birthDate.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (themePref.present) {
      map['theme_pref'] = Variable<String>(themePref.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (locale.present) {
      map['locale'] = Variable<String>(locale.value);
    }
    if (isLocalOnly.present) {
      map['is_local_only'] = Variable<bool>(isLocalOnly.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayNameFull: $displayNameFull, ')
          ..write('displayName: $displayName, ')
          ..write('emailLocal: $emailLocal, ')
          ..write('phoneLocal: $phoneLocal, ')
          ..write('birthDate: $birthDate, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('themePref: $themePref, ')
          ..write('currency: $currency, ')
          ..write('locale: $locale, ')
          ..write('isLocalOnly: $isLocalOnly, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id)',
    ),
  );
  static const VerificationMeta _monthlySalaryMeta = const VerificationMeta(
    'monthlySalary',
  );
  @override
  late final GeneratedColumn<int> monthlySalary = GeneratedColumn<int>(
    'monthly_salary',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minimumLivingCostMeta = const VerificationMeta(
    'minimumLivingCost',
  );
  @override
  late final GeneratedColumn<int> minimumLivingCost = GeneratedColumn<int>(
    'minimum_living_cost',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentLivingCostMeta = const VerificationMeta(
    'currentLivingCost',
  );
  @override
  late final GeneratedColumn<int> currentLivingCost = GeneratedColumn<int>(
    'current_living_cost',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultAnnualReturnPctMeta =
      const VerificationMeta('defaultAnnualReturnPct');
  @override
  late final GeneratedColumn<double> defaultAnnualReturnPct =
      GeneratedColumn<double>(
        'default_annual_return_pct',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(5.0),
      );
  static const VerificationMeta _phaseLimitEnabledMeta = const VerificationMeta(
    'phaseLimitEnabled',
  );
  @override
  late final GeneratedColumn<bool> phaseLimitEnabled = GeneratedColumn<bool>(
    'phase_limit_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("phase_limit_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _phaseLimitAmountMeta = const VerificationMeta(
    'phaseLimitAmount',
  );
  @override
  late final GeneratedColumn<int> phaseLimitAmount = GeneratedColumn<int>(
    'phase_limit_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _onboardingDoneMeta = const VerificationMeta(
    'onboardingDone',
  );
  @override
  late final GeneratedColumn<bool> onboardingDone = GeneratedColumn<bool>(
    'onboarding_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _seedVersionMeta = const VerificationMeta(
    'seedVersion',
  );
  @override
  late final GeneratedColumn<int> seedVersion = GeneratedColumn<int>(
    'seed_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    monthlySalary,
    minimumLivingCost,
    currentLivingCost,
    defaultAnnualReturnPct,
    phaseLimitEnabled,
    phaseLimitAmount,
    onboardingDone,
    seedVersion,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('monthly_salary')) {
      context.handle(
        _monthlySalaryMeta,
        monthlySalary.isAcceptableOrUnknown(
          data['monthly_salary']!,
          _monthlySalaryMeta,
        ),
      );
    }
    if (data.containsKey('minimum_living_cost')) {
      context.handle(
        _minimumLivingCostMeta,
        minimumLivingCost.isAcceptableOrUnknown(
          data['minimum_living_cost']!,
          _minimumLivingCostMeta,
        ),
      );
    }
    if (data.containsKey('current_living_cost')) {
      context.handle(
        _currentLivingCostMeta,
        currentLivingCost.isAcceptableOrUnknown(
          data['current_living_cost']!,
          _currentLivingCostMeta,
        ),
      );
    }
    if (data.containsKey('default_annual_return_pct')) {
      context.handle(
        _defaultAnnualReturnPctMeta,
        defaultAnnualReturnPct.isAcceptableOrUnknown(
          data['default_annual_return_pct']!,
          _defaultAnnualReturnPctMeta,
        ),
      );
    }
    if (data.containsKey('phase_limit_enabled')) {
      context.handle(
        _phaseLimitEnabledMeta,
        phaseLimitEnabled.isAcceptableOrUnknown(
          data['phase_limit_enabled']!,
          _phaseLimitEnabledMeta,
        ),
      );
    }
    if (data.containsKey('phase_limit_amount')) {
      context.handle(
        _phaseLimitAmountMeta,
        phaseLimitAmount.isAcceptableOrUnknown(
          data['phase_limit_amount']!,
          _phaseLimitAmountMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_done')) {
      context.handle(
        _onboardingDoneMeta,
        onboardingDone.isAcceptableOrUnknown(
          data['onboarding_done']!,
          _onboardingDoneMeta,
        ),
      );
    }
    if (data.containsKey('seed_version')) {
      context.handle(
        _seedVersionMeta,
        seedVersion.isAcceptableOrUnknown(
          data['seed_version']!,
          _seedVersionMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      monthlySalary: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_salary'],
      ),
      minimumLivingCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minimum_living_cost'],
      ),
      currentLivingCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_living_cost'],
      ),
      defaultAnnualReturnPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_annual_return_pct'],
      )!,
      phaseLimitEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}phase_limit_enabled'],
      )!,
      phaseLimitAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}phase_limit_amount'],
      ),
      onboardingDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_done'],
      )!,
      seedVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seed_version'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String id;
  final String ownerId;
  final int? monthlySalary;
  final int? minimumLivingCost;
  final int? currentLivingCost;
  final double defaultAnnualReturnPct;
  final bool phaseLimitEnabled;
  final int? phaseLimitAmount;
  final bool onboardingDone;
  final int seedVersion;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const Setting({
    required this.id,
    required this.ownerId,
    this.monthlySalary,
    this.minimumLivingCost,
    this.currentLivingCost,
    required this.defaultAnnualReturnPct,
    required this.phaseLimitEnabled,
    this.phaseLimitAmount,
    required this.onboardingDone,
    required this.seedVersion,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    if (!nullToAbsent || monthlySalary != null) {
      map['monthly_salary'] = Variable<int>(monthlySalary);
    }
    if (!nullToAbsent || minimumLivingCost != null) {
      map['minimum_living_cost'] = Variable<int>(minimumLivingCost);
    }
    if (!nullToAbsent || currentLivingCost != null) {
      map['current_living_cost'] = Variable<int>(currentLivingCost);
    }
    map['default_annual_return_pct'] = Variable<double>(defaultAnnualReturnPct);
    map['phase_limit_enabled'] = Variable<bool>(phaseLimitEnabled);
    if (!nullToAbsent || phaseLimitAmount != null) {
      map['phase_limit_amount'] = Variable<int>(phaseLimitAmount);
    }
    map['onboarding_done'] = Variable<bool>(onboardingDone);
    map['seed_version'] = Variable<int>(seedVersion);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      monthlySalary: monthlySalary == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlySalary),
      minimumLivingCost: minimumLivingCost == null && nullToAbsent
          ? const Value.absent()
          : Value(minimumLivingCost),
      currentLivingCost: currentLivingCost == null && nullToAbsent
          ? const Value.absent()
          : Value(currentLivingCost),
      defaultAnnualReturnPct: Value(defaultAnnualReturnPct),
      phaseLimitEnabled: Value(phaseLimitEnabled),
      phaseLimitAmount: phaseLimitAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(phaseLimitAmount),
      onboardingDone: Value(onboardingDone),
      seedVersion: Value(seedVersion),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      monthlySalary: serializer.fromJson<int?>(json['monthlySalary']),
      minimumLivingCost: serializer.fromJson<int?>(json['minimumLivingCost']),
      currentLivingCost: serializer.fromJson<int?>(json['currentLivingCost']),
      defaultAnnualReturnPct: serializer.fromJson<double>(
        json['defaultAnnualReturnPct'],
      ),
      phaseLimitEnabled: serializer.fromJson<bool>(json['phaseLimitEnabled']),
      phaseLimitAmount: serializer.fromJson<int?>(json['phaseLimitAmount']),
      onboardingDone: serializer.fromJson<bool>(json['onboardingDone']),
      seedVersion: serializer.fromJson<int>(json['seedVersion']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'monthlySalary': serializer.toJson<int?>(monthlySalary),
      'minimumLivingCost': serializer.toJson<int?>(minimumLivingCost),
      'currentLivingCost': serializer.toJson<int?>(currentLivingCost),
      'defaultAnnualReturnPct': serializer.toJson<double>(
        defaultAnnualReturnPct,
      ),
      'phaseLimitEnabled': serializer.toJson<bool>(phaseLimitEnabled),
      'phaseLimitAmount': serializer.toJson<int?>(phaseLimitAmount),
      'onboardingDone': serializer.toJson<bool>(onboardingDone),
      'seedVersion': serializer.toJson<int>(seedVersion),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  Setting copyWith({
    String? id,
    String? ownerId,
    Value<int?> monthlySalary = const Value.absent(),
    Value<int?> minimumLivingCost = const Value.absent(),
    Value<int?> currentLivingCost = const Value.absent(),
    double? defaultAnnualReturnPct,
    bool? phaseLimitEnabled,
    Value<int?> phaseLimitAmount = const Value.absent(),
    bool? onboardingDone,
    int? seedVersion,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => Setting(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    monthlySalary: monthlySalary.present
        ? monthlySalary.value
        : this.monthlySalary,
    minimumLivingCost: minimumLivingCost.present
        ? minimumLivingCost.value
        : this.minimumLivingCost,
    currentLivingCost: currentLivingCost.present
        ? currentLivingCost.value
        : this.currentLivingCost,
    defaultAnnualReturnPct:
        defaultAnnualReturnPct ?? this.defaultAnnualReturnPct,
    phaseLimitEnabled: phaseLimitEnabled ?? this.phaseLimitEnabled,
    phaseLimitAmount: phaseLimitAmount.present
        ? phaseLimitAmount.value
        : this.phaseLimitAmount,
    onboardingDone: onboardingDone ?? this.onboardingDone,
    seedVersion: seedVersion ?? this.seedVersion,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      monthlySalary: data.monthlySalary.present
          ? data.monthlySalary.value
          : this.monthlySalary,
      minimumLivingCost: data.minimumLivingCost.present
          ? data.minimumLivingCost.value
          : this.minimumLivingCost,
      currentLivingCost: data.currentLivingCost.present
          ? data.currentLivingCost.value
          : this.currentLivingCost,
      defaultAnnualReturnPct: data.defaultAnnualReturnPct.present
          ? data.defaultAnnualReturnPct.value
          : this.defaultAnnualReturnPct,
      phaseLimitEnabled: data.phaseLimitEnabled.present
          ? data.phaseLimitEnabled.value
          : this.phaseLimitEnabled,
      phaseLimitAmount: data.phaseLimitAmount.present
          ? data.phaseLimitAmount.value
          : this.phaseLimitAmount,
      onboardingDone: data.onboardingDone.present
          ? data.onboardingDone.value
          : this.onboardingDone,
      seedVersion: data.seedVersion.present
          ? data.seedVersion.value
          : this.seedVersion,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('monthlySalary: $monthlySalary, ')
          ..write('minimumLivingCost: $minimumLivingCost, ')
          ..write('currentLivingCost: $currentLivingCost, ')
          ..write('defaultAnnualReturnPct: $defaultAnnualReturnPct, ')
          ..write('phaseLimitEnabled: $phaseLimitEnabled, ')
          ..write('phaseLimitAmount: $phaseLimitAmount, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('seedVersion: $seedVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    monthlySalary,
    minimumLivingCost,
    currentLivingCost,
    defaultAnnualReturnPct,
    phaseLimitEnabled,
    phaseLimitAmount,
    onboardingDone,
    seedVersion,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.monthlySalary == this.monthlySalary &&
          other.minimumLivingCost == this.minimumLivingCost &&
          other.currentLivingCost == this.currentLivingCost &&
          other.defaultAnnualReturnPct == this.defaultAnnualReturnPct &&
          other.phaseLimitEnabled == this.phaseLimitEnabled &&
          other.phaseLimitAmount == this.phaseLimitAmount &&
          other.onboardingDone == this.onboardingDone &&
          other.seedVersion == this.seedVersion &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<int?> monthlySalary;
  final Value<int?> minimumLivingCost;
  final Value<int?> currentLivingCost;
  final Value<double> defaultAnnualReturnPct;
  final Value<bool> phaseLimitEnabled;
  final Value<int?> phaseLimitAmount;
  final Value<bool> onboardingDone;
  final Value<int> seedVersion;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.monthlySalary = const Value.absent(),
    this.minimumLivingCost = const Value.absent(),
    this.currentLivingCost = const Value.absent(),
    this.defaultAnnualReturnPct = const Value.absent(),
    this.phaseLimitEnabled = const Value.absent(),
    this.phaseLimitAmount = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.seedVersion = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String id,
    required String ownerId,
    this.monthlySalary = const Value.absent(),
    this.minimumLivingCost = const Value.absent(),
    this.currentLivingCost = const Value.absent(),
    this.defaultAnnualReturnPct = const Value.absent(),
    this.phaseLimitEnabled = const Value.absent(),
    this.phaseLimitAmount = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.seedVersion = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Setting> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<int>? monthlySalary,
    Expression<int>? minimumLivingCost,
    Expression<int>? currentLivingCost,
    Expression<double>? defaultAnnualReturnPct,
    Expression<bool>? phaseLimitEnabled,
    Expression<int>? phaseLimitAmount,
    Expression<bool>? onboardingDone,
    Expression<int>? seedVersion,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (monthlySalary != null) 'monthly_salary': monthlySalary,
      if (minimumLivingCost != null) 'minimum_living_cost': minimumLivingCost,
      if (currentLivingCost != null) 'current_living_cost': currentLivingCost,
      if (defaultAnnualReturnPct != null)
        'default_annual_return_pct': defaultAnnualReturnPct,
      if (phaseLimitEnabled != null) 'phase_limit_enabled': phaseLimitEnabled,
      if (phaseLimitAmount != null) 'phase_limit_amount': phaseLimitAmount,
      if (onboardingDone != null) 'onboarding_done': onboardingDone,
      if (seedVersion != null) 'seed_version': seedVersion,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<int?>? monthlySalary,
    Value<int?>? minimumLivingCost,
    Value<int?>? currentLivingCost,
    Value<double>? defaultAnnualReturnPct,
    Value<bool>? phaseLimitEnabled,
    Value<int?>? phaseLimitAmount,
    Value<bool>? onboardingDone,
    Value<int>? seedVersion,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      minimumLivingCost: minimumLivingCost ?? this.minimumLivingCost,
      currentLivingCost: currentLivingCost ?? this.currentLivingCost,
      defaultAnnualReturnPct:
          defaultAnnualReturnPct ?? this.defaultAnnualReturnPct,
      phaseLimitEnabled: phaseLimitEnabled ?? this.phaseLimitEnabled,
      phaseLimitAmount: phaseLimitAmount ?? this.phaseLimitAmount,
      onboardingDone: onboardingDone ?? this.onboardingDone,
      seedVersion: seedVersion ?? this.seedVersion,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (monthlySalary.present) {
      map['monthly_salary'] = Variable<int>(monthlySalary.value);
    }
    if (minimumLivingCost.present) {
      map['minimum_living_cost'] = Variable<int>(minimumLivingCost.value);
    }
    if (currentLivingCost.present) {
      map['current_living_cost'] = Variable<int>(currentLivingCost.value);
    }
    if (defaultAnnualReturnPct.present) {
      map['default_annual_return_pct'] = Variable<double>(
        defaultAnnualReturnPct.value,
      );
    }
    if (phaseLimitEnabled.present) {
      map['phase_limit_enabled'] = Variable<bool>(phaseLimitEnabled.value);
    }
    if (phaseLimitAmount.present) {
      map['phase_limit_amount'] = Variable<int>(phaseLimitAmount.value);
    }
    if (onboardingDone.present) {
      map['onboarding_done'] = Variable<bool>(onboardingDone.value);
    }
    if (seedVersion.present) {
      map['seed_version'] = Variable<int>(seedVersion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('monthlySalary: $monthlySalary, ')
          ..write('minimumLivingCost: $minimumLivingCost, ')
          ..write('currentLivingCost: $currentLivingCost, ')
          ..write('defaultAnnualReturnPct: $defaultAnnualReturnPct, ')
          ..write('phaseLimitEnabled: $phaseLimitEnabled, ')
          ..write('phaseLimitAmount: $phaseLimitAmount, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('seedVersion: $seedVersion, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PortfoliosTable extends Portfolios
    with TableInfo<$PortfoliosTable, Portfolio> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PortfoliosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformPresetMeta = const VerificationMeta(
    'platformPreset',
  );
  @override
  late final GeneratedColumn<String> platformPreset = GeneratedColumn<String>(
    'platform_preset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _platformNameMeta = const VerificationMeta(
    'platformName',
  );
  @override
  late final GeneratedColumn<String> platformName = GeneratedColumn<String>(
    'platform_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fullPriceMeta = const VerificationMeta(
    'fullPrice',
  );
  @override
  late final GeneratedColumn<int> fullPrice = GeneratedColumn<int>(
    'full_price',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _downPaymentMeta = const VerificationMeta(
    'downPayment',
  );
  @override
  late final GeneratedColumn<int> downPayment = GeneratedColumn<int>(
    'down_payment',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _feesMeta = const VerificationMeta('fees');
  @override
  late final GeneratedColumn<int> fees = GeneratedColumn<int>(
    'fees',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _savedTargetMeta = const VerificationMeta(
    'savedTarget',
  );
  @override
  late final GeneratedColumn<int> savedTarget = GeneratedColumn<int>(
    'saved_target',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<String> targetDate = GeneratedColumn<String>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthlyPlanMeta = const VerificationMeta(
    'monthlyPlan',
  );
  @override
  late final GeneratedColumn<int> monthlyPlan = GeneratedColumn<int>(
    'monthly_plan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _annualReturnPctMeta = const VerificationMeta(
    'annualReturnPct',
  );
  @override
  late final GeneratedColumn<double> annualReturnPct = GeneratedColumn<double>(
    'annual_return_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(5.0),
  );
  static const VerificationMeta _calcModeMeta = const VerificationMeta(
    'calcMode',
  );
  @override
  late final GeneratedColumn<String> calcMode = GeneratedColumn<String>(
    'calc_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('deposit_driven'),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('savings'),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF0E7C66),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    name,
    category,
    platformPreset,
    platformName,
    fullPrice,
    downPayment,
    fees,
    savedTarget,
    targetDate,
    monthlyPlan,
    annualReturnPct,
    calcMode,
    icon,
    color,
    note,
    sortOrder,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'portfolios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Portfolio> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('platform_preset')) {
      context.handle(
        _platformPresetMeta,
        platformPreset.isAcceptableOrUnknown(
          data['platform_preset']!,
          _platformPresetMeta,
        ),
      );
    }
    if (data.containsKey('platform_name')) {
      context.handle(
        _platformNameMeta,
        platformName.isAcceptableOrUnknown(
          data['platform_name']!,
          _platformNameMeta,
        ),
      );
    }
    if (data.containsKey('full_price')) {
      context.handle(
        _fullPriceMeta,
        fullPrice.isAcceptableOrUnknown(data['full_price']!, _fullPriceMeta),
      );
    }
    if (data.containsKey('down_payment')) {
      context.handle(
        _downPaymentMeta,
        downPayment.isAcceptableOrUnknown(
          data['down_payment']!,
          _downPaymentMeta,
        ),
      );
    }
    if (data.containsKey('fees')) {
      context.handle(
        _feesMeta,
        fees.isAcceptableOrUnknown(data['fees']!, _feesMeta),
      );
    }
    if (data.containsKey('saved_target')) {
      context.handle(
        _savedTargetMeta,
        savedTarget.isAcceptableOrUnknown(
          data['saved_target']!,
          _savedTargetMeta,
        ),
      );
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('monthly_plan')) {
      context.handle(
        _monthlyPlanMeta,
        monthlyPlan.isAcceptableOrUnknown(
          data['monthly_plan']!,
          _monthlyPlanMeta,
        ),
      );
    }
    if (data.containsKey('annual_return_pct')) {
      context.handle(
        _annualReturnPctMeta,
        annualReturnPct.isAcceptableOrUnknown(
          data['annual_return_pct']!,
          _annualReturnPctMeta,
        ),
      );
    }
    if (data.containsKey('calc_mode')) {
      context.handle(
        _calcModeMeta,
        calcMode.isAcceptableOrUnknown(data['calc_mode']!, _calcModeMeta),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Portfolio map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Portfolio(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      platformPreset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform_preset'],
      ),
      platformName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform_name'],
      ),
      fullPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}full_price'],
      ),
      downPayment: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}down_payment'],
      ),
      fees: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fees'],
      ),
      savedTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saved_target'],
      ),
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_date'],
      ),
      monthlyPlan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_plan'],
      )!,
      annualReturnPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}annual_return_pct'],
      )!,
      calcMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calc_mode'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $PortfoliosTable createAlias(String alias) {
    return $PortfoliosTable(attachedDatabase, alias);
  }
}

class Portfolio extends DataClass implements Insertable<Portfolio> {
  final String id;
  final String ownerId;
  final String name;

  /// `cash`, `down_payment`, atau `no_target`
  final String category;

  /// Enum generik: `aperd` | `broker` | `bank` | `ewallet` | `self_storage` | `other`
  final String? platformPreset;

  /// Nama platform teks bebas tulisan pengguna sendiri
  final String? platformName;
  final int? fullPrice;
  final int? downPayment;
  final int? fees;
  final int? savedTarget;
  final String? targetDate;
  final int monthlyPlan;
  final double annualReturnPct;

  /// `target_driven` atau `deposit_driven`
  final String calcMode;
  final String icon;
  final int color;
  final String? note;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const Portfolio({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.category,
    this.platformPreset,
    this.platformName,
    this.fullPrice,
    this.downPayment,
    this.fees,
    this.savedTarget,
    this.targetDate,
    required this.monthlyPlan,
    required this.annualReturnPct,
    required this.calcMode,
    required this.icon,
    required this.color,
    this.note,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || platformPreset != null) {
      map['platform_preset'] = Variable<String>(platformPreset);
    }
    if (!nullToAbsent || platformName != null) {
      map['platform_name'] = Variable<String>(platformName);
    }
    if (!nullToAbsent || fullPrice != null) {
      map['full_price'] = Variable<int>(fullPrice);
    }
    if (!nullToAbsent || downPayment != null) {
      map['down_payment'] = Variable<int>(downPayment);
    }
    if (!nullToAbsent || fees != null) {
      map['fees'] = Variable<int>(fees);
    }
    if (!nullToAbsent || savedTarget != null) {
      map['saved_target'] = Variable<int>(savedTarget);
    }
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<String>(targetDate);
    }
    map['monthly_plan'] = Variable<int>(monthlyPlan);
    map['annual_return_pct'] = Variable<double>(annualReturnPct);
    map['calc_mode'] = Variable<String>(calcMode);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<int>(color);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  PortfoliosCompanion toCompanion(bool nullToAbsent) {
    return PortfoliosCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      name: Value(name),
      category: Value(category),
      platformPreset: platformPreset == null && nullToAbsent
          ? const Value.absent()
          : Value(platformPreset),
      platformName: platformName == null && nullToAbsent
          ? const Value.absent()
          : Value(platformName),
      fullPrice: fullPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(fullPrice),
      downPayment: downPayment == null && nullToAbsent
          ? const Value.absent()
          : Value(downPayment),
      fees: fees == null && nullToAbsent ? const Value.absent() : Value(fees),
      savedTarget: savedTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(savedTarget),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      monthlyPlan: Value(monthlyPlan),
      annualReturnPct: Value(annualReturnPct),
      calcMode: Value(calcMode),
      icon: Value(icon),
      color: Value(color),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Portfolio.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Portfolio(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      platformPreset: serializer.fromJson<String?>(json['platformPreset']),
      platformName: serializer.fromJson<String?>(json['platformName']),
      fullPrice: serializer.fromJson<int?>(json['fullPrice']),
      downPayment: serializer.fromJson<int?>(json['downPayment']),
      fees: serializer.fromJson<int?>(json['fees']),
      savedTarget: serializer.fromJson<int?>(json['savedTarget']),
      targetDate: serializer.fromJson<String?>(json['targetDate']),
      monthlyPlan: serializer.fromJson<int>(json['monthlyPlan']),
      annualReturnPct: serializer.fromJson<double>(json['annualReturnPct']),
      calcMode: serializer.fromJson<String>(json['calcMode']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      note: serializer.fromJson<String?>(json['note']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'platformPreset': serializer.toJson<String?>(platformPreset),
      'platformName': serializer.toJson<String?>(platformName),
      'fullPrice': serializer.toJson<int?>(fullPrice),
      'downPayment': serializer.toJson<int?>(downPayment),
      'fees': serializer.toJson<int?>(fees),
      'savedTarget': serializer.toJson<int?>(savedTarget),
      'targetDate': serializer.toJson<String?>(targetDate),
      'monthlyPlan': serializer.toJson<int>(monthlyPlan),
      'annualReturnPct': serializer.toJson<double>(annualReturnPct),
      'calcMode': serializer.toJson<String>(calcMode),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<int>(color),
      'note': serializer.toJson<String?>(note),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  Portfolio copyWith({
    String? id,
    String? ownerId,
    String? name,
    String? category,
    Value<String?> platformPreset = const Value.absent(),
    Value<String?> platformName = const Value.absent(),
    Value<int?> fullPrice = const Value.absent(),
    Value<int?> downPayment = const Value.absent(),
    Value<int?> fees = const Value.absent(),
    Value<int?> savedTarget = const Value.absent(),
    Value<String?> targetDate = const Value.absent(),
    int? monthlyPlan,
    double? annualReturnPct,
    String? calcMode,
    String? icon,
    int? color,
    Value<String?> note = const Value.absent(),
    int? sortOrder,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => Portfolio(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    name: name ?? this.name,
    category: category ?? this.category,
    platformPreset: platformPreset.present
        ? platformPreset.value
        : this.platformPreset,
    platformName: platformName.present ? platformName.value : this.platformName,
    fullPrice: fullPrice.present ? fullPrice.value : this.fullPrice,
    downPayment: downPayment.present ? downPayment.value : this.downPayment,
    fees: fees.present ? fees.value : this.fees,
    savedTarget: savedTarget.present ? savedTarget.value : this.savedTarget,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    monthlyPlan: monthlyPlan ?? this.monthlyPlan,
    annualReturnPct: annualReturnPct ?? this.annualReturnPct,
    calcMode: calcMode ?? this.calcMode,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    note: note.present ? note.value : this.note,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Portfolio copyWithCompanion(PortfoliosCompanion data) {
    return Portfolio(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      platformPreset: data.platformPreset.present
          ? data.platformPreset.value
          : this.platformPreset,
      platformName: data.platformName.present
          ? data.platformName.value
          : this.platformName,
      fullPrice: data.fullPrice.present ? data.fullPrice.value : this.fullPrice,
      downPayment: data.downPayment.present
          ? data.downPayment.value
          : this.downPayment,
      fees: data.fees.present ? data.fees.value : this.fees,
      savedTarget: data.savedTarget.present
          ? data.savedTarget.value
          : this.savedTarget,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      monthlyPlan: data.monthlyPlan.present
          ? data.monthlyPlan.value
          : this.monthlyPlan,
      annualReturnPct: data.annualReturnPct.present
          ? data.annualReturnPct.value
          : this.annualReturnPct,
      calcMode: data.calcMode.present ? data.calcMode.value : this.calcMode,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      note: data.note.present ? data.note.value : this.note,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Portfolio(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('platformPreset: $platformPreset, ')
          ..write('platformName: $platformName, ')
          ..write('fullPrice: $fullPrice, ')
          ..write('downPayment: $downPayment, ')
          ..write('fees: $fees, ')
          ..write('savedTarget: $savedTarget, ')
          ..write('targetDate: $targetDate, ')
          ..write('monthlyPlan: $monthlyPlan, ')
          ..write('annualReturnPct: $annualReturnPct, ')
          ..write('calcMode: $calcMode, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('note: $note, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    ownerId,
    name,
    category,
    platformPreset,
    platformName,
    fullPrice,
    downPayment,
    fees,
    savedTarget,
    targetDate,
    monthlyPlan,
    annualReturnPct,
    calcMode,
    icon,
    color,
    note,
    sortOrder,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Portfolio &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.name == this.name &&
          other.category == this.category &&
          other.platformPreset == this.platformPreset &&
          other.platformName == this.platformName &&
          other.fullPrice == this.fullPrice &&
          other.downPayment == this.downPayment &&
          other.fees == this.fees &&
          other.savedTarget == this.savedTarget &&
          other.targetDate == this.targetDate &&
          other.monthlyPlan == this.monthlyPlan &&
          other.annualReturnPct == this.annualReturnPct &&
          other.calcMode == this.calcMode &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.note == this.note &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class PortfoliosCompanion extends UpdateCompanion<Portfolio> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> platformPreset;
  final Value<String?> platformName;
  final Value<int?> fullPrice;
  final Value<int?> downPayment;
  final Value<int?> fees;
  final Value<int?> savedTarget;
  final Value<String?> targetDate;
  final Value<int> monthlyPlan;
  final Value<double> annualReturnPct;
  final Value<String> calcMode;
  final Value<String> icon;
  final Value<int> color;
  final Value<String?> note;
  final Value<int> sortOrder;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const PortfoliosCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.platformPreset = const Value.absent(),
    this.platformName = const Value.absent(),
    this.fullPrice = const Value.absent(),
    this.downPayment = const Value.absent(),
    this.fees = const Value.absent(),
    this.savedTarget = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.monthlyPlan = const Value.absent(),
    this.annualReturnPct = const Value.absent(),
    this.calcMode = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.note = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PortfoliosCompanion.insert({
    required String id,
    required String ownerId,
    required String name,
    required String category,
    this.platformPreset = const Value.absent(),
    this.platformName = const Value.absent(),
    this.fullPrice = const Value.absent(),
    this.downPayment = const Value.absent(),
    this.fees = const Value.absent(),
    this.savedTarget = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.monthlyPlan = const Value.absent(),
    this.annualReturnPct = const Value.absent(),
    this.calcMode = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.note = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       name = Value(name),
       category = Value(category),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Portfolio> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? platformPreset,
    Expression<String>? platformName,
    Expression<int>? fullPrice,
    Expression<int>? downPayment,
    Expression<int>? fees,
    Expression<int>? savedTarget,
    Expression<String>? targetDate,
    Expression<int>? monthlyPlan,
    Expression<double>? annualReturnPct,
    Expression<String>? calcMode,
    Expression<String>? icon,
    Expression<int>? color,
    Expression<String>? note,
    Expression<int>? sortOrder,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (platformPreset != null) 'platform_preset': platformPreset,
      if (platformName != null) 'platform_name': platformName,
      if (fullPrice != null) 'full_price': fullPrice,
      if (downPayment != null) 'down_payment': downPayment,
      if (fees != null) 'fees': fees,
      if (savedTarget != null) 'saved_target': savedTarget,
      if (targetDate != null) 'target_date': targetDate,
      if (monthlyPlan != null) 'monthly_plan': monthlyPlan,
      if (annualReturnPct != null) 'annual_return_pct': annualReturnPct,
      if (calcMode != null) 'calc_mode': calcMode,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (note != null) 'note': note,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PortfoliosCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? name,
    Value<String>? category,
    Value<String?>? platformPreset,
    Value<String?>? platformName,
    Value<int?>? fullPrice,
    Value<int?>? downPayment,
    Value<int?>? fees,
    Value<int?>? savedTarget,
    Value<String?>? targetDate,
    Value<int>? monthlyPlan,
    Value<double>? annualReturnPct,
    Value<String>? calcMode,
    Value<String>? icon,
    Value<int>? color,
    Value<String?>? note,
    Value<int>? sortOrder,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PortfoliosCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      category: category ?? this.category,
      platformPreset: platformPreset ?? this.platformPreset,
      platformName: platformName ?? this.platformName,
      fullPrice: fullPrice ?? this.fullPrice,
      downPayment: downPayment ?? this.downPayment,
      fees: fees ?? this.fees,
      savedTarget: savedTarget ?? this.savedTarget,
      targetDate: targetDate ?? this.targetDate,
      monthlyPlan: monthlyPlan ?? this.monthlyPlan,
      annualReturnPct: annualReturnPct ?? this.annualReturnPct,
      calcMode: calcMode ?? this.calcMode,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      note: note ?? this.note,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (platformPreset.present) {
      map['platform_preset'] = Variable<String>(platformPreset.value);
    }
    if (platformName.present) {
      map['platform_name'] = Variable<String>(platformName.value);
    }
    if (fullPrice.present) {
      map['full_price'] = Variable<int>(fullPrice.value);
    }
    if (downPayment.present) {
      map['down_payment'] = Variable<int>(downPayment.value);
    }
    if (fees.present) {
      map['fees'] = Variable<int>(fees.value);
    }
    if (savedTarget.present) {
      map['saved_target'] = Variable<int>(savedTarget.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<String>(targetDate.value);
    }
    if (monthlyPlan.present) {
      map['monthly_plan'] = Variable<int>(monthlyPlan.value);
    }
    if (annualReturnPct.present) {
      map['annual_return_pct'] = Variable<double>(annualReturnPct.value);
    }
    if (calcMode.present) {
      map['calc_mode'] = Variable<String>(calcMode.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PortfoliosCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('platformPreset: $platformPreset, ')
          ..write('platformName: $platformName, ')
          ..write('fullPrice: $fullPrice, ')
          ..write('downPayment: $downPayment, ')
          ..write('fees: $fees, ')
          ..write('savedTarget: $savedTarget, ')
          ..write('targetDate: $targetDate, ')
          ..write('monthlyPlan: $monthlyPlan, ')
          ..write('annualReturnPct: $annualReturnPct, ')
          ..write('calcMode: $calcMode, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('note: $note, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PortfolioComponentsTable extends PortfolioComponents
    with TableInfo<$PortfolioComponentsTable, PortfolioComponent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PortfolioComponentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _portfolioIdMeta = const VerificationMeta(
    'portfolioId',
  );
  @override
  late final GeneratedColumn<String> portfolioId = GeneratedColumn<String>(
    'portfolio_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES portfolios (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id)',
    ),
  );
  static const VerificationMeta _instrumentTypeMeta = const VerificationMeta(
    'instrumentType',
  );
  @override
  late final GeneratedColumn<String> instrumentType = GeneratedColumn<String>(
    'instrument_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeNoteMeta = const VerificationMeta(
    'codeNote',
  );
  @override
  late final GeneratedColumn<String> codeNote = GeneratedColumn<String>(
    'code_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    portfolioId,
    ownerId,
    instrumentType,
    name,
    amount,
    codeNote,
    sortOrder,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'portfolio_components';
  @override
  VerificationContext validateIntegrity(
    Insertable<PortfolioComponent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('portfolio_id')) {
      context.handle(
        _portfolioIdMeta,
        portfolioId.isAcceptableOrUnknown(
          data['portfolio_id']!,
          _portfolioIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_portfolioIdMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('instrument_type')) {
      context.handle(
        _instrumentTypeMeta,
        instrumentType.isAcceptableOrUnknown(
          data['instrument_type']!,
          _instrumentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instrumentTypeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('code_note')) {
      context.handle(
        _codeNoteMeta,
        codeNote.isAcceptableOrUnknown(data['code_note']!, _codeNoteMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PortfolioComponent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PortfolioComponent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      portfolioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portfolio_id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      instrumentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instrument_type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      codeNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code_note'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $PortfolioComponentsTable createAlias(String alias) {
    return $PortfolioComponentsTable(attachedDatabase, alias);
  }
}

class PortfolioComponent extends DataClass
    implements Insertable<PortfolioComponent> {
  final String id;
  final String portfolioId;
  final String ownerId;
  final String instrumentType;
  final String? name;
  final int amount;
  final String? codeNote;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const PortfolioComponent({
    required this.id,
    required this.portfolioId,
    required this.ownerId,
    required this.instrumentType,
    this.name,
    required this.amount,
    this.codeNote,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['portfolio_id'] = Variable<String>(portfolioId);
    map['owner_id'] = Variable<String>(ownerId);
    map['instrument_type'] = Variable<String>(instrumentType);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || codeNote != null) {
      map['code_note'] = Variable<String>(codeNote);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  PortfolioComponentsCompanion toCompanion(bool nullToAbsent) {
    return PortfolioComponentsCompanion(
      id: Value(id),
      portfolioId: Value(portfolioId),
      ownerId: Value(ownerId),
      instrumentType: Value(instrumentType),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      amount: Value(amount),
      codeNote: codeNote == null && nullToAbsent
          ? const Value.absent()
          : Value(codeNote),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory PortfolioComponent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PortfolioComponent(
      id: serializer.fromJson<String>(json['id']),
      portfolioId: serializer.fromJson<String>(json['portfolioId']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      instrumentType: serializer.fromJson<String>(json['instrumentType']),
      name: serializer.fromJson<String?>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
      codeNote: serializer.fromJson<String?>(json['codeNote']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'portfolioId': serializer.toJson<String>(portfolioId),
      'ownerId': serializer.toJson<String>(ownerId),
      'instrumentType': serializer.toJson<String>(instrumentType),
      'name': serializer.toJson<String?>(name),
      'amount': serializer.toJson<int>(amount),
      'codeNote': serializer.toJson<String?>(codeNote),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  PortfolioComponent copyWith({
    String? id,
    String? portfolioId,
    String? ownerId,
    String? instrumentType,
    Value<String?> name = const Value.absent(),
    int? amount,
    Value<String?> codeNote = const Value.absent(),
    int? sortOrder,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => PortfolioComponent(
    id: id ?? this.id,
    portfolioId: portfolioId ?? this.portfolioId,
    ownerId: ownerId ?? this.ownerId,
    instrumentType: instrumentType ?? this.instrumentType,
    name: name.present ? name.value : this.name,
    amount: amount ?? this.amount,
    codeNote: codeNote.present ? codeNote.value : this.codeNote,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  PortfolioComponent copyWithCompanion(PortfolioComponentsCompanion data) {
    return PortfolioComponent(
      id: data.id.present ? data.id.value : this.id,
      portfolioId: data.portfolioId.present
          ? data.portfolioId.value
          : this.portfolioId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      instrumentType: data.instrumentType.present
          ? data.instrumentType.value
          : this.instrumentType,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      codeNote: data.codeNote.present ? data.codeNote.value : this.codeNote,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PortfolioComponent(')
          ..write('id: $id, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ownerId: $ownerId, ')
          ..write('instrumentType: $instrumentType, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('codeNote: $codeNote, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    portfolioId,
    ownerId,
    instrumentType,
    name,
    amount,
    codeNote,
    sortOrder,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PortfolioComponent &&
          other.id == this.id &&
          other.portfolioId == this.portfolioId &&
          other.ownerId == this.ownerId &&
          other.instrumentType == this.instrumentType &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.codeNote == this.codeNote &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class PortfolioComponentsCompanion extends UpdateCompanion<PortfolioComponent> {
  final Value<String> id;
  final Value<String> portfolioId;
  final Value<String> ownerId;
  final Value<String> instrumentType;
  final Value<String?> name;
  final Value<int> amount;
  final Value<String?> codeNote;
  final Value<int> sortOrder;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const PortfolioComponentsCompanion({
    this.id = const Value.absent(),
    this.portfolioId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.instrumentType = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.codeNote = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PortfolioComponentsCompanion.insert({
    required String id,
    required String portfolioId,
    required String ownerId,
    required String instrumentType,
    this.name = const Value.absent(),
    required int amount,
    this.codeNote = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       portfolioId = Value(portfolioId),
       ownerId = Value(ownerId),
       instrumentType = Value(instrumentType),
       amount = Value(amount),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PortfolioComponent> custom({
    Expression<String>? id,
    Expression<String>? portfolioId,
    Expression<String>? ownerId,
    Expression<String>? instrumentType,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<String>? codeNote,
    Expression<int>? sortOrder,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (portfolioId != null) 'portfolio_id': portfolioId,
      if (ownerId != null) 'owner_id': ownerId,
      if (instrumentType != null) 'instrument_type': instrumentType,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (codeNote != null) 'code_note': codeNote,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PortfolioComponentsCompanion copyWith({
    Value<String>? id,
    Value<String>? portfolioId,
    Value<String>? ownerId,
    Value<String>? instrumentType,
    Value<String?>? name,
    Value<int>? amount,
    Value<String?>? codeNote,
    Value<int>? sortOrder,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PortfolioComponentsCompanion(
      id: id ?? this.id,
      portfolioId: portfolioId ?? this.portfolioId,
      ownerId: ownerId ?? this.ownerId,
      instrumentType: instrumentType ?? this.instrumentType,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      codeNote: codeNote ?? this.codeNote,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (portfolioId.present) {
      map['portfolio_id'] = Variable<String>(portfolioId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (instrumentType.present) {
      map['instrument_type'] = Variable<String>(instrumentType.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (codeNote.present) {
      map['code_note'] = Variable<String>(codeNote.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PortfolioComponentsCompanion(')
          ..write('id: $id, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ownerId: $ownerId, ')
          ..write('instrumentType: $instrumentType, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('codeNote: $codeNote, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContributionsTable extends Contributions
    with TableInfo<$ContributionsTable, Contribution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _portfolioIdMeta = const VerificationMeta(
    'portfolioId',
  );
  @override
  late final GeneratedColumn<String> portfolioId = GeneratedColumn<String>(
    'portfolio_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES portfolios (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    portfolioId,
    ownerId,
    amount,
    date,
    note,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contribution> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('portfolio_id')) {
      context.handle(
        _portfolioIdMeta,
        portfolioId.isAcceptableOrUnknown(
          data['portfolio_id']!,
          _portfolioIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_portfolioIdMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contribution map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contribution(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      portfolioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portfolio_id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ContributionsTable createAlias(String alias) {
    return $ContributionsTable(attachedDatabase, alias);
  }
}

class Contribution extends DataClass implements Insertable<Contribution> {
  final String id;
  final String portfolioId;
  final String ownerId;
  final int amount;
  final String date;
  final String? note;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const Contribution({
    required this.id,
    required this.portfolioId,
    required this.ownerId,
    required this.amount,
    required this.date,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['portfolio_id'] = Variable<String>(portfolioId);
    map['owner_id'] = Variable<String>(ownerId);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  ContributionsCompanion toCompanion(bool nullToAbsent) {
    return ContributionsCompanion(
      id: Value(id),
      portfolioId: Value(portfolioId),
      ownerId: Value(ownerId),
      amount: Value(amount),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Contribution.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contribution(
      id: serializer.fromJson<String>(json['id']),
      portfolioId: serializer.fromJson<String>(json['portfolioId']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<String>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'portfolioId': serializer.toJson<String>(portfolioId),
      'ownerId': serializer.toJson<String>(ownerId),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<String>(date),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  Contribution copyWith({
    String? id,
    String? portfolioId,
    String? ownerId,
    int? amount,
    String? date,
    Value<String?> note = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => Contribution(
    id: id ?? this.id,
    portfolioId: portfolioId ?? this.portfolioId,
    ownerId: ownerId ?? this.ownerId,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Contribution copyWithCompanion(ContributionsCompanion data) {
    return Contribution(
      id: data.id.present ? data.id.value : this.id,
      portfolioId: data.portfolioId.present
          ? data.portfolioId.value
          : this.portfolioId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contribution(')
          ..write('id: $id, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ownerId: $ownerId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    portfolioId,
    ownerId,
    amount,
    date,
    note,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contribution &&
          other.id == this.id &&
          other.portfolioId == this.portfolioId &&
          other.ownerId == this.ownerId &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class ContributionsCompanion extends UpdateCompanion<Contribution> {
  final Value<String> id;
  final Value<String> portfolioId;
  final Value<String> ownerId;
  final Value<int> amount;
  final Value<String> date;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const ContributionsCompanion({
    this.id = const Value.absent(),
    this.portfolioId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContributionsCompanion.insert({
    required String id,
    required String portfolioId,
    required String ownerId,
    required int amount,
    required String date,
    this.note = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       portfolioId = Value(portfolioId),
       ownerId = Value(ownerId),
       amount = Value(amount),
       date = Value(date),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Contribution> custom({
    Expression<String>? id,
    Expression<String>? portfolioId,
    Expression<String>? ownerId,
    Expression<int>? amount,
    Expression<String>? date,
    Expression<String>? note,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (portfolioId != null) 'portfolio_id': portfolioId,
      if (ownerId != null) 'owner_id': ownerId,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContributionsCompanion copyWith({
    Value<String>? id,
    Value<String>? portfolioId,
    Value<String>? ownerId,
    Value<int>? amount,
    Value<String>? date,
    Value<String?>? note,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ContributionsCompanion(
      id: id ?? this.id,
      portfolioId: portfolioId ?? this.portfolioId,
      ownerId: ownerId ?? this.ownerId,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (portfolioId.present) {
      map['portfolio_id'] = Variable<String>(portfolioId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContributionsCompanion(')
          ..write('id: $id, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ownerId: $ownerId, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhasesTable extends Phases with TableInfo<$PhasesTable, Phase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    name,
    description,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phases';
  @override
  VerificationContext validateIntegrity(
    Insertable<Phase> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Phase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Phase(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $PhasesTable createAlias(String alias) {
    return $PhasesTable(attachedDatabase, alias);
  }
}

class Phase extends DataClass implements Insertable<Phase> {
  final String id;
  final String ownerId;
  final String name;
  final String? description;
  final bool isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const Phase({
    required this.id,
    required this.ownerId,
    required this.name,
    this.description,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  PhasesCompanion toCompanion(bool nullToAbsent) {
    return PhasesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Phase.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Phase(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  Phase copyWith({
    String? id,
    String? ownerId,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isActive,
    int? sortOrder,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => Phase(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Phase copyWithCompanion(PhasesCompanion data) {
    return Phase(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Phase(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    name,
    description,
    isActive,
    sortOrder,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Phase &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class PhasesCompanion extends UpdateCompanion<Phase> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const PhasesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhasesCompanion.insert({
    required String id,
    required String ownerId,
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Phase> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<int>? sortOrder,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhasesCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<int>? sortOrder,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PhasesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhasesCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhaseAllocationsTable extends PhaseAllocations
    with TableInfo<$PhaseAllocationsTable, PhaseAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhaseAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phaseIdMeta = const VerificationMeta(
    'phaseId',
  );
  @override
  late final GeneratedColumn<String> phaseId = GeneratedColumn<String>(
    'phase_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES phases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _portfolioIdMeta = const VerificationMeta(
    'portfolioId',
  );
  @override
  late final GeneratedColumn<String> portfolioId = GeneratedColumn<String>(
    'portfolio_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES portfolios (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id)',
    ),
  );
  static const VerificationMeta _monthlyAmountMeta = const VerificationMeta(
    'monthlyAmount',
  );
  @override
  late final GeneratedColumn<int> monthlyAmount = GeneratedColumn<int>(
    'monthly_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    phaseId,
    portfolioId,
    ownerId,
    monthlyAmount,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phase_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhaseAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('phase_id')) {
      context.handle(
        _phaseIdMeta,
        phaseId.isAcceptableOrUnknown(data['phase_id']!, _phaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseIdMeta);
    }
    if (data.containsKey('portfolio_id')) {
      context.handle(
        _portfolioIdMeta,
        portfolioId.isAcceptableOrUnknown(
          data['portfolio_id']!,
          _portfolioIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_portfolioIdMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('monthly_amount')) {
      context.handle(
        _monthlyAmountMeta,
        monthlyAmount.isAcceptableOrUnknown(
          data['monthly_amount']!,
          _monthlyAmountMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {phaseId, portfolioId},
  ];
  @override
  PhaseAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhaseAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      phaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phase_id'],
      )!,
      portfolioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portfolio_id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      monthlyAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $PhaseAllocationsTable createAlias(String alias) {
    return $PhaseAllocationsTable(attachedDatabase, alias);
  }
}

class PhaseAllocation extends DataClass implements Insertable<PhaseAllocation> {
  final String id;
  final String phaseId;
  final String portfolioId;
  final String ownerId;
  final int monthlyAmount;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const PhaseAllocation({
    required this.id,
    required this.phaseId,
    required this.portfolioId,
    required this.ownerId,
    required this.monthlyAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['phase_id'] = Variable<String>(phaseId);
    map['portfolio_id'] = Variable<String>(portfolioId);
    map['owner_id'] = Variable<String>(ownerId);
    map['monthly_amount'] = Variable<int>(monthlyAmount);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  PhaseAllocationsCompanion toCompanion(bool nullToAbsent) {
    return PhaseAllocationsCompanion(
      id: Value(id),
      phaseId: Value(phaseId),
      portfolioId: Value(portfolioId),
      ownerId: Value(ownerId),
      monthlyAmount: Value(monthlyAmount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory PhaseAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhaseAllocation(
      id: serializer.fromJson<String>(json['id']),
      phaseId: serializer.fromJson<String>(json['phaseId']),
      portfolioId: serializer.fromJson<String>(json['portfolioId']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      monthlyAmount: serializer.fromJson<int>(json['monthlyAmount']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'phaseId': serializer.toJson<String>(phaseId),
      'portfolioId': serializer.toJson<String>(portfolioId),
      'ownerId': serializer.toJson<String>(ownerId),
      'monthlyAmount': serializer.toJson<int>(monthlyAmount),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  PhaseAllocation copyWith({
    String? id,
    String? phaseId,
    String? portfolioId,
    String? ownerId,
    int? monthlyAmount,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => PhaseAllocation(
    id: id ?? this.id,
    phaseId: phaseId ?? this.phaseId,
    portfolioId: portfolioId ?? this.portfolioId,
    ownerId: ownerId ?? this.ownerId,
    monthlyAmount: monthlyAmount ?? this.monthlyAmount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  PhaseAllocation copyWithCompanion(PhaseAllocationsCompanion data) {
    return PhaseAllocation(
      id: data.id.present ? data.id.value : this.id,
      phaseId: data.phaseId.present ? data.phaseId.value : this.phaseId,
      portfolioId: data.portfolioId.present
          ? data.portfolioId.value
          : this.portfolioId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      monthlyAmount: data.monthlyAmount.present
          ? data.monthlyAmount.value
          : this.monthlyAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhaseAllocation(')
          ..write('id: $id, ')
          ..write('phaseId: $phaseId, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ownerId: $ownerId, ')
          ..write('monthlyAmount: $monthlyAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    phaseId,
    portfolioId,
    ownerId,
    monthlyAmount,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhaseAllocation &&
          other.id == this.id &&
          other.phaseId == this.phaseId &&
          other.portfolioId == this.portfolioId &&
          other.ownerId == this.ownerId &&
          other.monthlyAmount == this.monthlyAmount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class PhaseAllocationsCompanion extends UpdateCompanion<PhaseAllocation> {
  final Value<String> id;
  final Value<String> phaseId;
  final Value<String> portfolioId;
  final Value<String> ownerId;
  final Value<int> monthlyAmount;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const PhaseAllocationsCompanion({
    this.id = const Value.absent(),
    this.phaseId = const Value.absent(),
    this.portfolioId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.monthlyAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhaseAllocationsCompanion.insert({
    required String id,
    required String phaseId,
    required String portfolioId,
    required String ownerId,
    this.monthlyAmount = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       phaseId = Value(phaseId),
       portfolioId = Value(portfolioId),
       ownerId = Value(ownerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PhaseAllocation> custom({
    Expression<String>? id,
    Expression<String>? phaseId,
    Expression<String>? portfolioId,
    Expression<String>? ownerId,
    Expression<int>? monthlyAmount,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (phaseId != null) 'phase_id': phaseId,
      if (portfolioId != null) 'portfolio_id': portfolioId,
      if (ownerId != null) 'owner_id': ownerId,
      if (monthlyAmount != null) 'monthly_amount': monthlyAmount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhaseAllocationsCompanion copyWith({
    Value<String>? id,
    Value<String>? phaseId,
    Value<String>? portfolioId,
    Value<String>? ownerId,
    Value<int>? monthlyAmount,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PhaseAllocationsCompanion(
      id: id ?? this.id,
      phaseId: phaseId ?? this.phaseId,
      portfolioId: portfolioId ?? this.portfolioId,
      ownerId: ownerId ?? this.ownerId,
      monthlyAmount: monthlyAmount ?? this.monthlyAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (phaseId.present) {
      map['phase_id'] = Variable<String>(phaseId.value);
    }
    if (portfolioId.present) {
      map['portfolio_id'] = Variable<String>(portfolioId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (monthlyAmount.present) {
      map['monthly_amount'] = Variable<int>(monthlyAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhaseAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('phaseId: $phaseId, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ownerId: $ownerId, ')
          ..write('monthlyAmount: $monthlyAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PriceReferencesTable extends PriceReferences
    with TableInfo<$PriceReferencesTable, PriceReference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PriceReferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_profiles (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullPriceMeta = const VerificationMeta(
    'fullPrice',
  );
  @override
  late final GeneratedColumn<int> fullPrice = GeneratedColumn<int>(
    'full_price',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _downPaymentMeta = const VerificationMeta(
    'downPayment',
  );
  @override
  late final GeneratedColumn<int> downPayment = GeneratedColumn<int>(
    'down_payment',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _feesMeta = const VerificationMeta('fees');
  @override
  late final GeneratedColumn<int> fees = GeneratedColumn<int>(
    'fees',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerId,
    name,
    fullPrice,
    downPayment,
    fees,
    note,
    sortOrder,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'price_references';
  @override
  VerificationContext validateIntegrity(
    Insertable<PriceReference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('full_price')) {
      context.handle(
        _fullPriceMeta,
        fullPrice.isAcceptableOrUnknown(data['full_price']!, _fullPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_fullPriceMeta);
    }
    if (data.containsKey('down_payment')) {
      context.handle(
        _downPaymentMeta,
        downPayment.isAcceptableOrUnknown(
          data['down_payment']!,
          _downPaymentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_downPaymentMeta);
    }
    if (data.containsKey('fees')) {
      context.handle(
        _feesMeta,
        fees.isAcceptableOrUnknown(data['fees']!, _feesMeta),
      );
    } else if (isInserting) {
      context.missing(_feesMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PriceReference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PriceReference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      fullPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}full_price'],
      )!,
      downPayment: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}down_payment'],
      )!,
      fees: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fees'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $PriceReferencesTable createAlias(String alias) {
    return $PriceReferencesTable(attachedDatabase, alias);
  }
}

class PriceReference extends DataClass implements Insertable<PriceReference> {
  final String id;
  final String ownerId;
  final String name;
  final int fullPrice;
  final int downPayment;
  final int fees;
  final String? note;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const PriceReference({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.fullPrice,
    required this.downPayment,
    required this.fees,
    this.note,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
    this.remoteId,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['name'] = Variable<String>(name);
    map['full_price'] = Variable<int>(fullPrice);
    map['down_payment'] = Variable<int>(downPayment);
    map['fees'] = Variable<int>(fees);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  PriceReferencesCompanion toCompanion(bool nullToAbsent) {
    return PriceReferencesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      name: Value(name),
      fullPrice: Value(fullPrice),
      downPayment: Value(downPayment),
      fees: Value(fees),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory PriceReference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PriceReference(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      name: serializer.fromJson<String>(json['name']),
      fullPrice: serializer.fromJson<int>(json['fullPrice']),
      downPayment: serializer.fromJson<int>(json['downPayment']),
      fees: serializer.fromJson<int>(json['fees']),
      note: serializer.fromJson<String?>(json['note']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'name': serializer.toJson<String>(name),
      'fullPrice': serializer.toJson<int>(fullPrice),
      'downPayment': serializer.toJson<int>(downPayment),
      'fees': serializer.toJson<int>(fees),
      'note': serializer.toJson<String?>(note),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  PriceReference copyWith({
    String? id,
    String? ownerId,
    String? name,
    int? fullPrice,
    int? downPayment,
    int? fees,
    Value<String?> note = const Value.absent(),
    int? sortOrder,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => PriceReference(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    name: name ?? this.name,
    fullPrice: fullPrice ?? this.fullPrice,
    downPayment: downPayment ?? this.downPayment,
    fees: fees ?? this.fees,
    note: note.present ? note.value : this.note,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  PriceReference copyWithCompanion(PriceReferencesCompanion data) {
    return PriceReference(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      name: data.name.present ? data.name.value : this.name,
      fullPrice: data.fullPrice.present ? data.fullPrice.value : this.fullPrice,
      downPayment: data.downPayment.present
          ? data.downPayment.value
          : this.downPayment,
      fees: data.fees.present ? data.fees.value : this.fees,
      note: data.note.present ? data.note.value : this.note,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PriceReference(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('fullPrice: $fullPrice, ')
          ..write('downPayment: $downPayment, ')
          ..write('fees: $fees, ')
          ..write('note: $note, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerId,
    name,
    fullPrice,
    downPayment,
    fees,
    note,
    sortOrder,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PriceReference &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.name == this.name &&
          other.fullPrice == this.fullPrice &&
          other.downPayment == this.downPayment &&
          other.fees == this.fees &&
          other.note == this.note &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class PriceReferencesCompanion extends UpdateCompanion<PriceReference> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> name;
  final Value<int> fullPrice;
  final Value<int> downPayment;
  final Value<int> fees;
  final Value<String?> note;
  final Value<int> sortOrder;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const PriceReferencesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.name = const Value.absent(),
    this.fullPrice = const Value.absent(),
    this.downPayment = const Value.absent(),
    this.fees = const Value.absent(),
    this.note = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PriceReferencesCompanion.insert({
    required String id,
    required String ownerId,
    required String name,
    required int fullPrice,
    required int downPayment,
    required int fees,
    this.note = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       name = Value(name),
       fullPrice = Value(fullPrice),
       downPayment = Value(downPayment),
       fees = Value(fees),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PriceReference> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? name,
    Expression<int>? fullPrice,
    Expression<int>? downPayment,
    Expression<int>? fees,
    Expression<String>? note,
    Expression<int>? sortOrder,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (name != null) 'name': name,
      if (fullPrice != null) 'full_price': fullPrice,
      if (downPayment != null) 'down_payment': downPayment,
      if (fees != null) 'fees': fees,
      if (note != null) 'note': note,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PriceReferencesCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? name,
    Value<int>? fullPrice,
    Value<int>? downPayment,
    Value<int>? fees,
    Value<String?>? note,
    Value<int>? sortOrder,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PriceReferencesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      fullPrice: fullPrice ?? this.fullPrice,
      downPayment: downPayment ?? this.downPayment,
      fees: fees ?? this.fees,
      note: note ?? this.note,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (fullPrice.present) {
      map['full_price'] = Variable<int>(fullPrice.value);
    }
    if (downPayment.present) {
      map['down_payment'] = Variable<int>(downPayment.value);
    }
    if (fees.present) {
      map['fees'] = Variable<int>(fees.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PriceReferencesCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('fullPrice: $fullPrice, ')
          ..write('downPayment: $downPayment, ')
          ..write('fees: $fees, ')
          ..write('note: $note, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $PortfoliosTable portfolios = $PortfoliosTable(this);
  late final $PortfolioComponentsTable portfolioComponents =
      $PortfolioComponentsTable(this);
  late final $ContributionsTable contributions = $ContributionsTable(this);
  late final $PhasesTable phases = $PhasesTable(this);
  late final $PhaseAllocationsTable phaseAllocations = $PhaseAllocationsTable(
    this,
  );
  late final $PriceReferencesTable priceReferences = $PriceReferencesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    settings,
    portfolios,
    portfolioComponents,
    contributions,
    phases,
    phaseAllocations,
    priceReferences,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'portfolios',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('portfolio_components', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'portfolios',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('contributions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'phases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('phase_allocations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'portfolios',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('phase_allocations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      required String id,
      Value<String?> displayNameFull,
      Value<String?> displayName,
      Value<String?> emailLocal,
      Value<String?> phoneLocal,
      Value<String?> birthDate,
      Value<String?> avatarPath,
      Value<String> themePref,
      Value<String> currency,
      Value<String> locale,
      Value<bool> isLocalOnly,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> id,
      Value<String?> displayNameFull,
      Value<String?> displayName,
      Value<String?> emailLocal,
      Value<String?> phoneLocal,
      Value<String?> birthDate,
      Value<String?> avatarPath,
      Value<String> themePref,
      Value<String> currency,
      Value<String> locale,
      Value<bool> isLocalOnly,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$UserProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile> {
  $$UserProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SettingsTable, List<Setting>> _settingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.settings,
    aliasName: 'user_profiles__id__settings__owner_id',
  );

  $$SettingsTableProcessedTableManager get settingsRefs {
    final manager = $$SettingsTableTableManager(
      $_db,
      $_db.settings,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_settingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PortfoliosTable, List<Portfolio>>
  _portfoliosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.portfolios,
    aliasName: 'user_profiles__id__portfolios__owner_id',
  );

  $$PortfoliosTableProcessedTableManager get portfoliosRefs {
    final manager = $$PortfoliosTableTableManager(
      $_db,
      $_db.portfolios,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_portfoliosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PortfolioComponentsTable,
    List<PortfolioComponent>
  >
  _portfolioComponentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.portfolioComponents,
        aliasName: 'user_profiles__id__portfolio_components__owner_id',
      );

  $$PortfolioComponentsTableProcessedTableManager get portfolioComponentsRefs {
    final manager = $$PortfolioComponentsTableTableManager(
      $_db,
      $_db.portfolioComponents,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _portfolioComponentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContributionsTable, List<Contribution>>
  _contributionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contributions,
    aliasName: 'user_profiles__id__contributions__owner_id',
  );

  $$ContributionsTableProcessedTableManager get contributionsRefs {
    final manager = $$ContributionsTableTableManager(
      $_db,
      $_db.contributions,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contributionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhasesTable, List<Phase>> _phasesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.phases,
    aliasName: 'user_profiles__id__phases__owner_id',
  );

  $$PhasesTableProcessedTableManager get phasesRefs {
    final manager = $$PhasesTableTableManager(
      $_db,
      $_db.phases,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_phasesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhaseAllocationsTable, List<PhaseAllocation>>
  _phaseAllocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phaseAllocations,
    aliasName: 'user_profiles__id__phase_allocations__owner_id',
  );

  $$PhaseAllocationsTableProcessedTableManager get phaseAllocationsRefs {
    final manager = $$PhaseAllocationsTableTableManager(
      $_db,
      $_db.phaseAllocations,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _phaseAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PriceReferencesTable, List<PriceReference>>
  _priceReferencesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.priceReferences,
    aliasName: 'user_profiles__id__price_references__owner_id',
  );

  $$PriceReferencesTableProcessedTableManager get priceReferencesRefs {
    final manager = $$PriceReferencesTableTableManager(
      $_db,
      $_db.priceReferences,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _priceReferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameFull => $composableBuilder(
    column: $table.displayNameFull,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emailLocal => $composableBuilder(
    column: $table.emailLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneLocal => $composableBuilder(
    column: $table.phoneLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themePref => $composableBuilder(
    column: $table.themePref,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLocalOnly => $composableBuilder(
    column: $table.isLocalOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> settingsRefs(
    Expression<bool> Function($$SettingsTableFilterComposer f) f,
  ) {
    final $$SettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.settings,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SettingsTableFilterComposer(
            $db: $db,
            $table: $db.settings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> portfoliosRefs(
    Expression<bool> Function($$PortfoliosTableFilterComposer f) f,
  ) {
    final $$PortfoliosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableFilterComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> portfolioComponentsRefs(
    Expression<bool> Function($$PortfolioComponentsTableFilterComposer f) f,
  ) {
    final $$PortfolioComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.portfolioComponents,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfolioComponentsTableFilterComposer(
            $db: $db,
            $table: $db.portfolioComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contributionsRefs(
    Expression<bool> Function($$ContributionsTableFilterComposer f) f,
  ) {
    final $$ContributionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableFilterComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> phasesRefs(
    Expression<bool> Function($$PhasesTableFilterComposer f) f,
  ) {
    final $$PhasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phases,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhasesTableFilterComposer(
            $db: $db,
            $table: $db.phases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> phaseAllocationsRefs(
    Expression<bool> Function($$PhaseAllocationsTableFilterComposer f) f,
  ) {
    final $$PhaseAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phaseAllocations,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhaseAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.phaseAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> priceReferencesRefs(
    Expression<bool> Function($$PriceReferencesTableFilterComposer f) f,
  ) {
    final $$PriceReferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.priceReferences,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PriceReferencesTableFilterComposer(
            $db: $db,
            $table: $db.priceReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameFull => $composableBuilder(
    column: $table.displayNameFull,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emailLocal => $composableBuilder(
    column: $table.emailLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneLocal => $composableBuilder(
    column: $table.phoneLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themePref => $composableBuilder(
    column: $table.themePref,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLocalOnly => $composableBuilder(
    column: $table.isLocalOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayNameFull => $composableBuilder(
    column: $table.displayNameFull,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emailLocal => $composableBuilder(
    column: $table.emailLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneLocal => $composableBuilder(
    column: $table.phoneLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themePref =>
      $composableBuilder(column: $table.themePref, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<bool> get isLocalOnly => $composableBuilder(
    column: $table.isLocalOnly,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  Expression<T> settingsRefs<T extends Object>(
    Expression<T> Function($$SettingsTableAnnotationComposer a) f,
  ) {
    final $$SettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.settings,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.settings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> portfoliosRefs<T extends Object>(
    Expression<T> Function($$PortfoliosTableAnnotationComposer a) f,
  ) {
    final $$PortfoliosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableAnnotationComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> portfolioComponentsRefs<T extends Object>(
    Expression<T> Function($$PortfolioComponentsTableAnnotationComposer a) f,
  ) {
    final $$PortfolioComponentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.portfolioComponents,
          getReferencedColumn: (t) => t.ownerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PortfolioComponentsTableAnnotationComposer(
                $db: $db,
                $table: $db.portfolioComponents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> contributionsRefs<T extends Object>(
    Expression<T> Function($$ContributionsTableAnnotationComposer a) f,
  ) {
    final $$ContributionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> phasesRefs<T extends Object>(
    Expression<T> Function($$PhasesTableAnnotationComposer a) f,
  ) {
    final $$PhasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phases,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhasesTableAnnotationComposer(
            $db: $db,
            $table: $db.phases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> phaseAllocationsRefs<T extends Object>(
    Expression<T> Function($$PhaseAllocationsTableAnnotationComposer a) f,
  ) {
    final $$PhaseAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phaseAllocations,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhaseAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.phaseAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> priceReferencesRefs<T extends Object>(
    Expression<T> Function($$PriceReferencesTableAnnotationComposer a) f,
  ) {
    final $$PriceReferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.priceReferences,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PriceReferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.priceReferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (UserProfile, $$UserProfilesTableReferences),
          UserProfile,
          PrefetchHooks Function({
            bool settingsRefs,
            bool portfoliosRefs,
            bool portfolioComponentsRefs,
            bool contributionsRefs,
            bool phasesRefs,
            bool phaseAllocationsRefs,
            bool priceReferencesRefs,
          })
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> displayNameFull = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> emailLocal = const Value.absent(),
                Value<String?> phoneLocal = const Value.absent(),
                Value<String?> birthDate = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<String> themePref = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<bool> isLocalOnly = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                displayNameFull: displayNameFull,
                displayName: displayName,
                emailLocal: emailLocal,
                phoneLocal: phoneLocal,
                birthDate: birthDate,
                avatarPath: avatarPath,
                themePref: themePref,
                currency: currency,
                locale: locale,
                isLocalOnly: isLocalOnly,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> displayNameFull = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> emailLocal = const Value.absent(),
                Value<String?> phoneLocal = const Value.absent(),
                Value<String?> birthDate = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<String> themePref = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> locale = const Value.absent(),
                Value<bool> isLocalOnly = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                displayNameFull: displayNameFull,
                displayName: displayName,
                emailLocal: emailLocal,
                phoneLocal: phoneLocal,
                birthDate: birthDate,
                avatarPath: avatarPath,
                themePref: themePref,
                currency: currency,
                locale: locale,
                isLocalOnly: isLocalOnly,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserProfilesTable, UserProfile>(table),
                  $$UserProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                settingsRefs = false,
                portfoliosRefs = false,
                portfolioComponentsRefs = false,
                contributionsRefs = false,
                phasesRefs = false,
                phaseAllocationsRefs = false,
                priceReferencesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (settingsRefs) db.settings,
                    if (portfoliosRefs) db.portfolios,
                    if (portfolioComponentsRefs) db.portfolioComponents,
                    if (contributionsRefs) db.contributions,
                    if (phasesRefs) db.phases,
                    if (phaseAllocationsRefs) db.phaseAllocations,
                    if (priceReferencesRefs) db.priceReferences,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (settingsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          Setting,
                          $SettingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._settingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).settingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (portfoliosRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          Portfolio,
                          $PortfoliosTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._portfoliosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).portfoliosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (portfolioComponentsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          PortfolioComponent,
                          $PortfolioComponentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._portfolioComponentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).portfolioComponentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (contributionsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          Contribution,
                          $ContributionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._contributionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).contributionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (phasesRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          Phase,
                          $PhasesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._phasesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).phasesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (phaseAllocationsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          PhaseAllocation,
                          $PhaseAllocationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._phaseAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).phaseAllocationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (priceReferencesRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          PriceReference,
                          $PriceReferencesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._priceReferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).priceReferencesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (UserProfile, $$UserProfilesTableReferences),
      UserProfile,
      PrefetchHooks Function({
        bool settingsRefs,
        bool portfoliosRefs,
        bool portfolioComponentsRefs,
        bool contributionsRefs,
        bool phasesRefs,
        bool phaseAllocationsRefs,
        bool priceReferencesRefs,
      })
    >;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String id,
  required String ownerId,
  Value<int?> monthlySalary,
  Value<int?> minimumLivingCost,
  Value<int?> currentLivingCost,
  Value<double> defaultAnnualReturnPct,
  Value<bool> phaseLimitEnabled,
  Value<int?> phaseLimitAmount,
  Value<bool> onboardingDone,
  Value<int> seedVersion,
  required String createdAt,
  required String updatedAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<String?> deletedAt,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<int?> monthlySalary,
  Value<int?> minimumLivingCost,
  Value<int?> currentLivingCost,
  Value<double> defaultAnnualReturnPct,
  Value<bool> phaseLimitEnabled,
  Value<int?> phaseLimitAmount,
  Value<bool> onboardingDone,
  Value<int> seedVersion,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<String?> deletedAt,
  Value<int> rowid,
});

final class $$SettingsTableReferences
    extends BaseReferences<_$AppDatabase, $SettingsTable, Setting> {
  $$SettingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) =>
      db.userProfiles.createAlias('settings__owner_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minimumLivingCost => $composableBuilder(
    column: $table.minimumLivingCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentLivingCost => $composableBuilder(
    column: $table.currentLivingCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultAnnualReturnPct => $composableBuilder(
    column: $table.defaultAnnualReturnPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get phaseLimitEnabled => $composableBuilder(
    column: $table.phaseLimitEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get phaseLimitAmount => $composableBuilder(
    column: $table.phaseLimitAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seedVersion => $composableBuilder(
    column: $table.seedVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserProfilesTableFilterComposer get ownerId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minimumLivingCost => $composableBuilder(
    column: $table.minimumLivingCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentLivingCost => $composableBuilder(
    column: $table.currentLivingCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultAnnualReturnPct => $composableBuilder(
    column: $table.defaultAnnualReturnPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get phaseLimitEnabled => $composableBuilder(
    column: $table.phaseLimitEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get phaseLimitAmount => $composableBuilder(
    column: $table.phaseLimitAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seedVersion => $composableBuilder(
    column: $table.seedVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserProfilesTableOrderingComposer get ownerId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get monthlySalary => $composableBuilder(
    column: $table.monthlySalary,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minimumLivingCost => $composableBuilder(
    column: $table.minimumLivingCost,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentLivingCost => $composableBuilder(
    column: $table.currentLivingCost,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultAnnualReturnPct => $composableBuilder(
    column: $table.defaultAnnualReturnPct,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get phaseLimitEnabled => $composableBuilder(
    column: $table.phaseLimitEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get phaseLimitAmount => $composableBuilder(
    column: $table.phaseLimitAmount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingDone => $composableBuilder(
    column: $table.onboardingDone,
    builder: (column) => column,
  );

  GeneratedColumn<int> get seedVersion => $composableBuilder(
    column: $table.seedVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$UserProfilesTableAnnotationComposer get ownerId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, $$SettingsTableReferences),
          Setting,
          PrefetchHooks Function({bool ownerId})
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<int?> monthlySalary = const Value.absent(),
                Value<int?> minimumLivingCost = const Value.absent(),
                Value<int?> currentLivingCost = const Value.absent(),
                Value<double> defaultAnnualReturnPct = const Value.absent(),
                Value<bool> phaseLimitEnabled = const Value.absent(),
                Value<int?> phaseLimitAmount = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<int> seedVersion = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                ownerId: ownerId,
                monthlySalary: monthlySalary,
                minimumLivingCost: minimumLivingCost,
                currentLivingCost: currentLivingCost,
                defaultAnnualReturnPct: defaultAnnualReturnPct,
                phaseLimitEnabled: phaseLimitEnabled,
                phaseLimitAmount: phaseLimitAmount,
                onboardingDone: onboardingDone,
                seedVersion: seedVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                Value<int?> monthlySalary = const Value.absent(),
                Value<int?> minimumLivingCost = const Value.absent(),
                Value<int?> currentLivingCost = const Value.absent(),
                Value<double> defaultAnnualReturnPct = const Value.absent(),
                Value<bool> phaseLimitEnabled = const Value.absent(),
                Value<int?> phaseLimitAmount = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<int> seedVersion = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                ownerId: ownerId,
                monthlySalary: monthlySalary,
                minimumLivingCost: minimumLivingCost,
                currentLivingCost: currentLivingCost,
                defaultAnnualReturnPct: defaultAnnualReturnPct,
                phaseLimitEnabled: phaseLimitEnabled,
                phaseLimitAmount: phaseLimitAmount,
                onboardingDone: onboardingDone,
                seedVersion: seedVersion,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, Setting>(table),
                  $$SettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ownerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ownerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ownerId,
                        referencedTable: $$SettingsTableReferences
                            ._ownerIdTable(db),
                        referencedColumn: $$SettingsTableReferences
                            ._ownerIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, $$SettingsTableReferences),
      Setting,
      PrefetchHooks Function({bool ownerId})
    >;
typedef $$PortfoliosTableCreateCompanionBuilder = PortfoliosCompanion Function({
  required String id,
  required String ownerId,
  required String name,
  required String category,
  Value<String?> platformPreset,
  Value<String?> platformName,
  Value<int?> fullPrice,
  Value<int?> downPayment,
  Value<int?> fees,
  Value<int?> savedTarget,
  Value<String?> targetDate,
  Value<int> monthlyPlan,
  Value<double> annualReturnPct,
  Value<String> calcMode,
  Value<String> icon,
  Value<int> color,
  Value<String?> note,
  Value<int> sortOrder,
  required String createdAt,
  required String updatedAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<String?> deletedAt,
  Value<int> rowid,
});
typedef $$PortfoliosTableUpdateCompanionBuilder = PortfoliosCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> name,
  Value<String> category,
  Value<String?> platformPreset,
  Value<String?> platformName,
  Value<int?> fullPrice,
  Value<int?> downPayment,
  Value<int?> fees,
  Value<int?> savedTarget,
  Value<String?> targetDate,
  Value<int> monthlyPlan,
  Value<double> annualReturnPct,
  Value<String> calcMode,
  Value<String> icon,
  Value<int> color,
  Value<String?> note,
  Value<int> sortOrder,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<String?> deletedAt,
  Value<int> rowid,
});

final class $$PortfoliosTableReferences
    extends BaseReferences<_$AppDatabase, $PortfoliosTable, Portfolio> {
  $$PortfoliosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) =>
      db.userProfiles.createAlias('portfolios__owner_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PortfolioComponentsTable,
    List<PortfolioComponent>
  >
  _portfolioComponentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.portfolioComponents,
        aliasName: 'portfolios__id__portfolio_components__portfolio_id',
      );

  $$PortfolioComponentsTableProcessedTableManager get portfolioComponentsRefs {
    final manager = $$PortfolioComponentsTableTableManager(
      $_db,
      $_db.portfolioComponents,
    ).filter((f) => f.portfolioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _portfolioComponentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ContributionsTable, List<Contribution>>
  _contributionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.contributions,
    aliasName: 'portfolios__id__contributions__portfolio_id',
  );

  $$ContributionsTableProcessedTableManager get contributionsRefs {
    final manager = $$ContributionsTableTableManager(
      $_db,
      $_db.contributions,
    ).filter((f) => f.portfolioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contributionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhaseAllocationsTable, List<PhaseAllocation>>
  _phaseAllocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phaseAllocations,
    aliasName: 'portfolios__id__phase_allocations__portfolio_id',
  );

  $$PhaseAllocationsTableProcessedTableManager get phaseAllocationsRefs {
    final manager = $$PhaseAllocationsTableTableManager(
      $_db,
      $_db.phaseAllocations,
    ).filter((f) => f.portfolioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _phaseAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PortfoliosTableFilterComposer
    extends Composer<_$AppDatabase, $PortfoliosTable> {
  $$PortfoliosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platformPreset => $composableBuilder(
    column: $table.platformPreset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platformName => $composableBuilder(
    column: $table.platformName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fullPrice => $composableBuilder(
    column: $table.fullPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get downPayment => $composableBuilder(
    column: $table.downPayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fees => $composableBuilder(
    column: $table.fees,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get savedTarget => $composableBuilder(
    column: $table.savedTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthlyPlan => $composableBuilder(
    column: $table.monthlyPlan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get annualReturnPct => $composableBuilder(
    column: $table.annualReturnPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calcMode => $composableBuilder(
    column: $table.calcMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserProfilesTableFilterComposer get ownerId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> portfolioComponentsRefs(
    Expression<bool> Function($$PortfolioComponentsTableFilterComposer f) f,
  ) {
    final $$PortfolioComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.portfolioComponents,
      getReferencedColumn: (t) => t.portfolioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfolioComponentsTableFilterComposer(
            $db: $db,
            $table: $db.portfolioComponents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> contributionsRefs(
    Expression<bool> Function($$ContributionsTableFilterComposer f) f,
  ) {
    final $$ContributionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.portfolioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableFilterComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> phaseAllocationsRefs(
    Expression<bool> Function($$PhaseAllocationsTableFilterComposer f) f,
  ) {
    final $$PhaseAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phaseAllocations,
      getReferencedColumn: (t) => t.portfolioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhaseAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.phaseAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PortfoliosTableOrderingComposer
    extends Composer<_$AppDatabase, $PortfoliosTable> {
  $$PortfoliosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platformPreset => $composableBuilder(
    column: $table.platformPreset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platformName => $composableBuilder(
    column: $table.platformName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fullPrice => $composableBuilder(
    column: $table.fullPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get downPayment => $composableBuilder(
    column: $table.downPayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fees => $composableBuilder(
    column: $table.fees,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get savedTarget => $composableBuilder(
    column: $table.savedTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyPlan => $composableBuilder(
    column: $table.monthlyPlan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get annualReturnPct => $composableBuilder(
    column: $table.annualReturnPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calcMode => $composableBuilder(
    column: $table.calcMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserProfilesTableOrderingComposer get ownerId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PortfoliosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PortfoliosTable> {
  $$PortfoliosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get platformPreset => $composableBuilder(
    column: $table.platformPreset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get platformName => $composableBuilder(
    column: $table.platformName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fullPrice =>
      $composableBuilder(column: $table.fullPrice, builder: (column) => column);

  GeneratedColumn<int> get downPayment => $composableBuilder(
    column: $table.downPayment,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fees =>
      $composableBuilder(column: $table.fees, builder: (column) => column);

  GeneratedColumn<int> get savedTarget => $composableBuilder(
    column: $table.savedTarget,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get monthlyPlan => $composableBuilder(
    column: $table.monthlyPlan,
    builder: (column) => column,
  );

  GeneratedColumn<double> get annualReturnPct => $composableBuilder(
    column: $table.annualReturnPct,
    builder: (column) => column,
  );

  GeneratedColumn<String> get calcMode =>
      $composableBuilder(column: $table.calcMode, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$UserProfilesTableAnnotationComposer get ownerId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> portfolioComponentsRefs<T extends Object>(
    Expression<T> Function($$PortfolioComponentsTableAnnotationComposer a) f,
  ) {
    final $$PortfolioComponentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.portfolioComponents,
          getReferencedColumn: (t) => t.portfolioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PortfolioComponentsTableAnnotationComposer(
                $db: $db,
                $table: $db.portfolioComponents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> contributionsRefs<T extends Object>(
    Expression<T> Function($$ContributionsTableAnnotationComposer a) f,
  ) {
    final $$ContributionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contributions,
      getReferencedColumn: (t) => t.portfolioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContributionsTableAnnotationComposer(
            $db: $db,
            $table: $db.contributions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> phaseAllocationsRefs<T extends Object>(
    Expression<T> Function($$PhaseAllocationsTableAnnotationComposer a) f,
  ) {
    final $$PhaseAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phaseAllocations,
      getReferencedColumn: (t) => t.portfolioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhaseAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.phaseAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PortfoliosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PortfoliosTable,
          Portfolio,
          $$PortfoliosTableFilterComposer,
          $$PortfoliosTableOrderingComposer,
          $$PortfoliosTableAnnotationComposer,
          $$PortfoliosTableCreateCompanionBuilder,
          $$PortfoliosTableUpdateCompanionBuilder,
          (Portfolio, $$PortfoliosTableReferences),
          Portfolio,
          PrefetchHooks Function({
            bool ownerId,
            bool portfolioComponentsRefs,
            bool contributionsRefs,
            bool phaseAllocationsRefs,
          })
        > {
  $$PortfoliosTableTableManager(_$AppDatabase db, $PortfoliosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PortfoliosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PortfoliosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PortfoliosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> platformPreset = const Value.absent(),
                Value<String?> platformName = const Value.absent(),
                Value<int?> fullPrice = const Value.absent(),
                Value<int?> downPayment = const Value.absent(),
                Value<int?> fees = const Value.absent(),
                Value<int?> savedTarget = const Value.absent(),
                Value<String?> targetDate = const Value.absent(),
                Value<int> monthlyPlan = const Value.absent(),
                Value<double> annualReturnPct = const Value.absent(),
                Value<String> calcMode = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PortfoliosCompanion(
                id: id,
                ownerId: ownerId,
                name: name,
                category: category,
                platformPreset: platformPreset,
                platformName: platformName,
                fullPrice: fullPrice,
                downPayment: downPayment,
                fees: fees,
                savedTarget: savedTarget,
                targetDate: targetDate,
                monthlyPlan: monthlyPlan,
                annualReturnPct: annualReturnPct,
                calcMode: calcMode,
                icon: icon,
                color: color,
                note: note,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String name,
                required String category,
                Value<String?> platformPreset = const Value.absent(),
                Value<String?> platformName = const Value.absent(),
                Value<int?> fullPrice = const Value.absent(),
                Value<int?> downPayment = const Value.absent(),
                Value<int?> fees = const Value.absent(),
                Value<int?> savedTarget = const Value.absent(),
                Value<String?> targetDate = const Value.absent(),
                Value<int> monthlyPlan = const Value.absent(),
                Value<double> annualReturnPct = const Value.absent(),
                Value<String> calcMode = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PortfoliosCompanion.insert(
                id: id,
                ownerId: ownerId,
                name: name,
                category: category,
                platformPreset: platformPreset,
                platformName: platformName,
                fullPrice: fullPrice,
                downPayment: downPayment,
                fees: fees,
                savedTarget: savedTarget,
                targetDate: targetDate,
                monthlyPlan: monthlyPlan,
                annualReturnPct: annualReturnPct,
                calcMode: calcMode,
                icon: icon,
                color: color,
                note: note,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PortfoliosTable, Portfolio>(table),
                  $$PortfoliosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ownerId = false,
                portfolioComponentsRefs = false,
                contributionsRefs = false,
                phaseAllocationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (portfolioComponentsRefs) db.portfolioComponents,
                    if (contributionsRefs) db.contributions,
                    if (phaseAllocationsRefs) db.phaseAllocations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ownerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerId,
                            referencedTable: $$PortfoliosTableReferences
                                ._ownerIdTable(db),
                            referencedColumn: $$PortfoliosTableReferences
                                ._ownerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (portfolioComponentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Portfolio,
                          $PortfoliosTable,
                          PortfolioComponent,
                          $PortfolioComponentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PortfoliosTableReferences
                              ._portfolioComponentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PortfoliosTableReferences(
                                db,
                                table,
                                p0,
                              ).portfolioComponentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'portfolio_id',
                          typedResults: items,
                        ),
                      if (contributionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Portfolio,
                          $PortfoliosTable,
                          Contribution,
                          $ContributionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PortfoliosTableReferences
                              ._contributionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PortfoliosTableReferences(
                                db,
                                table,
                                p0,
                              ).contributionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'portfolio_id',
                          typedResults: items,
                        ),
                      if (phaseAllocationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Portfolio,
                          $PortfoliosTable,
                          PhaseAllocation,
                          $PhaseAllocationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PortfoliosTableReferences
                              ._phaseAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PortfoliosTableReferences(
                                db,
                                table,
                                p0,
                              ).phaseAllocationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'portfolio_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PortfoliosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PortfoliosTable,
      Portfolio,
      $$PortfoliosTableFilterComposer,
      $$PortfoliosTableOrderingComposer,
      $$PortfoliosTableAnnotationComposer,
      $$PortfoliosTableCreateCompanionBuilder,
      $$PortfoliosTableUpdateCompanionBuilder,
      (Portfolio, $$PortfoliosTableReferences),
      Portfolio,
      PrefetchHooks Function({
        bool ownerId,
        bool portfolioComponentsRefs,
        bool contributionsRefs,
        bool phaseAllocationsRefs,
      })
    >;
typedef $$PortfolioComponentsTableCreateCompanionBuilder =
    PortfolioComponentsCompanion Function({
      required String id,
      required String portfolioId,
      required String ownerId,
      required String instrumentType,
      Value<String?> name,
      required int amount,
      Value<String?> codeNote,
      Value<int> sortOrder,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$PortfolioComponentsTableUpdateCompanionBuilder =
    PortfolioComponentsCompanion Function({
      Value<String> id,
      Value<String> portfolioId,
      Value<String> ownerId,
      Value<String> instrumentType,
      Value<String?> name,
      Value<int> amount,
      Value<String?> codeNote,
      Value<int> sortOrder,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$PortfolioComponentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PortfolioComponentsTable,
          PortfolioComponent
        > {
  $$PortfolioComponentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PortfoliosTable _portfolioIdTable(_$AppDatabase db) => db.portfolios
      .createAlias('portfolio_components__portfolio_id__portfolios__id');

  $$PortfoliosTableProcessedTableManager get portfolioId {
    final $_column = $_itemColumn<String>('portfolio_id')!;

    final manager = $$PortfoliosTableTableManager(
      $_db,
      $_db.portfolios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_portfolioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('portfolio_components__owner_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PortfolioComponentsTableFilterComposer
    extends Composer<_$AppDatabase, $PortfolioComponentsTable> {
  $$PortfolioComponentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instrumentType => $composableBuilder(
    column: $table.instrumentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codeNote => $composableBuilder(
    column: $table.codeNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PortfoliosTableFilterComposer get portfolioId {
    final $$PortfoliosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableFilterComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableFilterComposer get ownerId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PortfolioComponentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PortfolioComponentsTable> {
  $$PortfolioComponentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instrumentType => $composableBuilder(
    column: $table.instrumentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codeNote => $composableBuilder(
    column: $table.codeNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PortfoliosTableOrderingComposer get portfolioId {
    final $$PortfoliosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableOrderingComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableOrderingComposer get ownerId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PortfolioComponentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PortfolioComponentsTable> {
  $$PortfolioComponentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get instrumentType => $composableBuilder(
    column: $table.instrumentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get codeNote =>
      $composableBuilder(column: $table.codeNote, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$PortfoliosTableAnnotationComposer get portfolioId {
    final $$PortfoliosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableAnnotationComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableAnnotationComposer get ownerId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PortfolioComponentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PortfolioComponentsTable,
          PortfolioComponent,
          $$PortfolioComponentsTableFilterComposer,
          $$PortfolioComponentsTableOrderingComposer,
          $$PortfolioComponentsTableAnnotationComposer,
          $$PortfolioComponentsTableCreateCompanionBuilder,
          $$PortfolioComponentsTableUpdateCompanionBuilder,
          (PortfolioComponent, $$PortfolioComponentsTableReferences),
          PortfolioComponent,
          PrefetchHooks Function({bool portfolioId, bool ownerId})
        > {
  $$PortfolioComponentsTableTableManager(
    _$AppDatabase db,
    $PortfolioComponentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PortfolioComponentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PortfolioComponentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PortfolioComponentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> portfolioId = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> instrumentType = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String?> codeNote = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PortfolioComponentsCompanion(
                id: id,
                portfolioId: portfolioId,
                ownerId: ownerId,
                instrumentType: instrumentType,
                name: name,
                amount: amount,
                codeNote: codeNote,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String portfolioId,
                required String ownerId,
                required String instrumentType,
                Value<String?> name = const Value.absent(),
                required int amount,
                Value<String?> codeNote = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PortfolioComponentsCompanion.insert(
                id: id,
                portfolioId: portfolioId,
                ownerId: ownerId,
                instrumentType: instrumentType,
                name: name,
                amount: amount,
                codeNote: codeNote,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PortfolioComponentsTable, PortfolioComponent>(
                    table,
                  ),
                  $$PortfolioComponentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({portfolioId = false, ownerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (portfolioId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.portfolioId,
                        referencedTable: $$PortfolioComponentsTableReferences
                            ._portfolioIdTable(db),
                        referencedColumn: $$PortfolioComponentsTableReferences
                            ._portfolioIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (ownerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ownerId,
                        referencedTable: $$PortfolioComponentsTableReferences
                            ._ownerIdTable(db),
                        referencedColumn: $$PortfolioComponentsTableReferences
                            ._ownerIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PortfolioComponentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PortfolioComponentsTable,
      PortfolioComponent,
      $$PortfolioComponentsTableFilterComposer,
      $$PortfolioComponentsTableOrderingComposer,
      $$PortfolioComponentsTableAnnotationComposer,
      $$PortfolioComponentsTableCreateCompanionBuilder,
      $$PortfolioComponentsTableUpdateCompanionBuilder,
      (PortfolioComponent, $$PortfolioComponentsTableReferences),
      PortfolioComponent,
      PrefetchHooks Function({bool portfolioId, bool ownerId})
    >;
typedef $$ContributionsTableCreateCompanionBuilder =
    ContributionsCompanion Function({
      required String id,
      required String portfolioId,
      required String ownerId,
      required int amount,
      required String date,
      Value<String?> note,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$ContributionsTableUpdateCompanionBuilder =
    ContributionsCompanion Function({
      Value<String> id,
      Value<String> portfolioId,
      Value<String> ownerId,
      Value<int> amount,
      Value<String> date,
      Value<String?> note,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$ContributionsTableReferences
    extends BaseReferences<_$AppDatabase, $ContributionsTable, Contribution> {
  $$ContributionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PortfoliosTable _portfolioIdTable(_$AppDatabase db) =>
      db.portfolios.createAlias('contributions__portfolio_id__portfolios__id');

  $$PortfoliosTableProcessedTableManager get portfolioId {
    final $_column = $_itemColumn<String>('portfolio_id')!;

    final manager = $$PortfoliosTableTableManager(
      $_db,
      $_db.portfolios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_portfolioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) =>
      db.userProfiles.createAlias('contributions__owner_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $ContributionsTable> {
  $$ContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PortfoliosTableFilterComposer get portfolioId {
    final $$PortfoliosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableFilterComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableFilterComposer get ownerId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContributionsTable> {
  $$ContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PortfoliosTableOrderingComposer get portfolioId {
    final $$PortfoliosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableOrderingComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableOrderingComposer get ownerId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContributionsTable> {
  $$ContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$PortfoliosTableAnnotationComposer get portfolioId {
    final $$PortfoliosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableAnnotationComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableAnnotationComposer get ownerId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContributionsTable,
          Contribution,
          $$ContributionsTableFilterComposer,
          $$ContributionsTableOrderingComposer,
          $$ContributionsTableAnnotationComposer,
          $$ContributionsTableCreateCompanionBuilder,
          $$ContributionsTableUpdateCompanionBuilder,
          (Contribution, $$ContributionsTableReferences),
          Contribution,
          PrefetchHooks Function({bool portfolioId, bool ownerId})
        > {
  $$ContributionsTableTableManager(_$AppDatabase db, $ContributionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContributionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContributionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContributionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> portfolioId = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContributionsCompanion(
                id: id,
                portfolioId: portfolioId,
                ownerId: ownerId,
                amount: amount,
                date: date,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String portfolioId,
                required String ownerId,
                required int amount,
                required String date,
                Value<String?> note = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContributionsCompanion.insert(
                id: id,
                portfolioId: portfolioId,
                ownerId: ownerId,
                amount: amount,
                date: date,
                note: note,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ContributionsTable, Contribution>(table),
                  $$ContributionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({portfolioId = false, ownerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (portfolioId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.portfolioId,
                        referencedTable: $$ContributionsTableReferences
                            ._portfolioIdTable(db),
                        referencedColumn: $$ContributionsTableReferences
                            ._portfolioIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (ownerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ownerId,
                        referencedTable: $$ContributionsTableReferences
                            ._ownerIdTable(db),
                        referencedColumn: $$ContributionsTableReferences
                            ._ownerIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContributionsTable,
      Contribution,
      $$ContributionsTableFilterComposer,
      $$ContributionsTableOrderingComposer,
      $$ContributionsTableAnnotationComposer,
      $$ContributionsTableCreateCompanionBuilder,
      $$ContributionsTableUpdateCompanionBuilder,
      (Contribution, $$ContributionsTableReferences),
      Contribution,
      PrefetchHooks Function({bool portfolioId, bool ownerId})
    >;
typedef $$PhasesTableCreateCompanionBuilder = PhasesCompanion Function({
  required String id,
  required String ownerId,
  required String name,
  Value<String?> description,
  Value<bool> isActive,
  Value<int> sortOrder,
  required String createdAt,
  required String updatedAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<String?> deletedAt,
  Value<int> rowid,
});
typedef $$PhasesTableUpdateCompanionBuilder = PhasesCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> name,
  Value<String?> description,
  Value<bool> isActive,
  Value<int> sortOrder,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<String?> deletedAt,
  Value<int> rowid,
});

final class $$PhasesTableReferences
    extends BaseReferences<_$AppDatabase, $PhasesTable, Phase> {
  $$PhasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) =>
      db.userProfiles.createAlias('phases__owner_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PhaseAllocationsTable, List<PhaseAllocation>>
  _phaseAllocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phaseAllocations,
    aliasName: 'phases__id__phase_allocations__phase_id',
  );

  $$PhaseAllocationsTableProcessedTableManager get phaseAllocationsRefs {
    final manager = $$PhaseAllocationsTableTableManager(
      $_db,
      $_db.phaseAllocations,
    ).filter((f) => f.phaseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _phaseAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PhasesTableFilterComposer
    extends Composer<_$AppDatabase, $PhasesTable> {
  $$PhasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserProfilesTableFilterComposer get ownerId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> phaseAllocationsRefs(
    Expression<bool> Function($$PhaseAllocationsTableFilterComposer f) f,
  ) {
    final $$PhaseAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phaseAllocations,
      getReferencedColumn: (t) => t.phaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhaseAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.phaseAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PhasesTableOrderingComposer
    extends Composer<_$AppDatabase, $PhasesTable> {
  $$PhasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserProfilesTableOrderingComposer get ownerId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhasesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhasesTable> {
  $$PhasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$UserProfilesTableAnnotationComposer get ownerId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> phaseAllocationsRefs<T extends Object>(
    Expression<T> Function($$PhaseAllocationsTableAnnotationComposer a) f,
  ) {
    final $$PhaseAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phaseAllocations,
      getReferencedColumn: (t) => t.phaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhaseAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.phaseAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PhasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhasesTable,
          Phase,
          $$PhasesTableFilterComposer,
          $$PhasesTableOrderingComposer,
          $$PhasesTableAnnotationComposer,
          $$PhasesTableCreateCompanionBuilder,
          $$PhasesTableUpdateCompanionBuilder,
          (Phase, $$PhasesTableReferences),
          Phase,
          PrefetchHooks Function({bool ownerId, bool phaseAllocationsRefs})
        > {
  $$PhasesTableTableManager(_$AppDatabase db, $PhasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhasesCompanion(
                id: id,
                ownerId: ownerId,
                name: name,
                description: description,
                isActive: isActive,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhasesCompanion.insert(
                id: id,
                ownerId: ownerId,
                name: name,
                description: description,
                isActive: isActive,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhasesTable, Phase>(table),
                  $$PhasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ownerId = false, phaseAllocationsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (phaseAllocationsRefs) db.phaseAllocations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (ownerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerId,
                            referencedTable: $$PhasesTableReferences
                                ._ownerIdTable(db),
                            referencedColumn: $$PhasesTableReferences
                                ._ownerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (phaseAllocationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Phase,
                          $PhasesTable,
                          PhaseAllocation,
                          $PhaseAllocationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PhasesTableReferences
                              ._phaseAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PhasesTableReferences(
                                db,
                                table,
                                p0,
                              ).phaseAllocationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'phase_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PhasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhasesTable,
      Phase,
      $$PhasesTableFilterComposer,
      $$PhasesTableOrderingComposer,
      $$PhasesTableAnnotationComposer,
      $$PhasesTableCreateCompanionBuilder,
      $$PhasesTableUpdateCompanionBuilder,
      (Phase, $$PhasesTableReferences),
      Phase,
      PrefetchHooks Function({bool ownerId, bool phaseAllocationsRefs})
    >;
typedef $$PhaseAllocationsTableCreateCompanionBuilder =
    PhaseAllocationsCompanion Function({
      required String id,
      required String phaseId,
      required String portfolioId,
      required String ownerId,
      Value<int> monthlyAmount,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$PhaseAllocationsTableUpdateCompanionBuilder =
    PhaseAllocationsCompanion Function({
      Value<String> id,
      Value<String> phaseId,
      Value<String> portfolioId,
      Value<String> ownerId,
      Value<int> monthlyAmount,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$PhaseAllocationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $PhaseAllocationsTable, PhaseAllocation> {
  $$PhaseAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PhasesTable _phaseIdTable(_$AppDatabase db) =>
      db.phases.createAlias('phase_allocations__phase_id__phases__id');

  $$PhasesTableProcessedTableManager get phaseId {
    final $_column = $_itemColumn<String>('phase_id')!;

    final manager = $$PhasesTableTableManager(
      $_db,
      $_db.phases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_phaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PortfoliosTable _portfolioIdTable(_$AppDatabase db) => db.portfolios
      .createAlias('phase_allocations__portfolio_id__portfolios__id');

  $$PortfoliosTableProcessedTableManager get portfolioId {
    final $_column = $_itemColumn<String>('portfolio_id')!;

    final manager = $$PortfoliosTableTableManager(
      $_db,
      $_db.portfolios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_portfolioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('phase_allocations__owner_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhaseAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $PhaseAllocationsTable> {
  $$PhaseAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthlyAmount => $composableBuilder(
    column: $table.monthlyAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PhasesTableFilterComposer get phaseId {
    final $$PhasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phaseId,
      referencedTable: $db.phases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhasesTableFilterComposer(
            $db: $db,
            $table: $db.phases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PortfoliosTableFilterComposer get portfolioId {
    final $$PortfoliosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableFilterComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableFilterComposer get ownerId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhaseAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PhaseAllocationsTable> {
  $$PhaseAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyAmount => $composableBuilder(
    column: $table.monthlyAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PhasesTableOrderingComposer get phaseId {
    final $$PhasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phaseId,
      referencedTable: $db.phases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhasesTableOrderingComposer(
            $db: $db,
            $table: $db.phases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PortfoliosTableOrderingComposer get portfolioId {
    final $$PortfoliosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableOrderingComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableOrderingComposer get ownerId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhaseAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhaseAllocationsTable> {
  $$PhaseAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get monthlyAmount => $composableBuilder(
    column: $table.monthlyAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$PhasesTableAnnotationComposer get phaseId {
    final $$PhasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.phaseId,
      referencedTable: $db.phases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhasesTableAnnotationComposer(
            $db: $db,
            $table: $db.phases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PortfoliosTableAnnotationComposer get portfolioId {
    final $$PortfoliosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.portfolioId,
      referencedTable: $db.portfolios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PortfoliosTableAnnotationComposer(
            $db: $db,
            $table: $db.portfolios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserProfilesTableAnnotationComposer get ownerId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhaseAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhaseAllocationsTable,
          PhaseAllocation,
          $$PhaseAllocationsTableFilterComposer,
          $$PhaseAllocationsTableOrderingComposer,
          $$PhaseAllocationsTableAnnotationComposer,
          $$PhaseAllocationsTableCreateCompanionBuilder,
          $$PhaseAllocationsTableUpdateCompanionBuilder,
          (PhaseAllocation, $$PhaseAllocationsTableReferences),
          PhaseAllocation,
          PrefetchHooks Function({bool phaseId, bool portfolioId, bool ownerId})
        > {
  $$PhaseAllocationsTableTableManager(
    _$AppDatabase db,
    $PhaseAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhaseAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhaseAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhaseAllocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> phaseId = const Value.absent(),
                Value<String> portfolioId = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<int> monthlyAmount = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhaseAllocationsCompanion(
                id: id,
                phaseId: phaseId,
                portfolioId: portfolioId,
                ownerId: ownerId,
                monthlyAmount: monthlyAmount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String phaseId,
                required String portfolioId,
                required String ownerId,
                Value<int> monthlyAmount = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhaseAllocationsCompanion.insert(
                id: id,
                phaseId: phaseId,
                portfolioId: portfolioId,
                ownerId: ownerId,
                monthlyAmount: monthlyAmount,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhaseAllocationsTable, PhaseAllocation>(table),
                  $$PhaseAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({phaseId = false, portfolioId = false, ownerId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (phaseId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.phaseId,
                            referencedTable: $$PhaseAllocationsTableReferences
                                ._phaseIdTable(db),
                            referencedColumn: $$PhaseAllocationsTableReferences
                                ._phaseIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (portfolioId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.portfolioId,
                            referencedTable: $$PhaseAllocationsTableReferences
                                ._portfolioIdTable(db),
                            referencedColumn: $$PhaseAllocationsTableReferences
                                ._portfolioIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (ownerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerId,
                            referencedTable: $$PhaseAllocationsTableReferences
                                ._ownerIdTable(db),
                            referencedColumn: $$PhaseAllocationsTableReferences
                                ._ownerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PhaseAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhaseAllocationsTable,
      PhaseAllocation,
      $$PhaseAllocationsTableFilterComposer,
      $$PhaseAllocationsTableOrderingComposer,
      $$PhaseAllocationsTableAnnotationComposer,
      $$PhaseAllocationsTableCreateCompanionBuilder,
      $$PhaseAllocationsTableUpdateCompanionBuilder,
      (PhaseAllocation, $$PhaseAllocationsTableReferences),
      PhaseAllocation,
      PrefetchHooks Function({bool phaseId, bool portfolioId, bool ownerId})
    >;
typedef $$PriceReferencesTableCreateCompanionBuilder =
    PriceReferencesCompanion Function({
      required String id,
      required String ownerId,
      required String name,
      required int fullPrice,
      required int downPayment,
      required int fees,
      Value<String?> note,
      Value<int> sortOrder,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$PriceReferencesTableUpdateCompanionBuilder =
    PriceReferencesCompanion Function({
      Value<String> id,
      Value<String> ownerId,
      Value<String> name,
      Value<int> fullPrice,
      Value<int> downPayment,
      Value<int> fees,
      Value<String?> note,
      Value<int> sortOrder,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$PriceReferencesTableReferences
    extends
        BaseReferences<_$AppDatabase, $PriceReferencesTable, PriceReference> {
  $$PriceReferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('price_references__owner_id__user_profiles__id');

  $$UserProfilesTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UserProfilesTableTableManager(
      $_db,
      $_db.userProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PriceReferencesTableFilterComposer
    extends Composer<_$AppDatabase, $PriceReferencesTable> {
  $$PriceReferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fullPrice => $composableBuilder(
    column: $table.fullPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get downPayment => $composableBuilder(
    column: $table.downPayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fees => $composableBuilder(
    column: $table.fees,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserProfilesTableFilterComposer get ownerId {
    final $$UserProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableFilterComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PriceReferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $PriceReferencesTable> {
  $$PriceReferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fullPrice => $composableBuilder(
    column: $table.fullPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get downPayment => $composableBuilder(
    column: $table.downPayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fees => $composableBuilder(
    column: $table.fees,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserProfilesTableOrderingComposer get ownerId {
    final $$UserProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PriceReferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PriceReferencesTable> {
  $$PriceReferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get fullPrice =>
      $composableBuilder(column: $table.fullPrice, builder: (column) => column);

  GeneratedColumn<int> get downPayment => $composableBuilder(
    column: $table.downPayment,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fees =>
      $composableBuilder(column: $table.fees, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$UserProfilesTableAnnotationComposer get ownerId {
    final $$UserProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ownerId,
      referencedTable: $db.userProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.userProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PriceReferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PriceReferencesTable,
          PriceReference,
          $$PriceReferencesTableFilterComposer,
          $$PriceReferencesTableOrderingComposer,
          $$PriceReferencesTableAnnotationComposer,
          $$PriceReferencesTableCreateCompanionBuilder,
          $$PriceReferencesTableUpdateCompanionBuilder,
          (PriceReference, $$PriceReferencesTableReferences),
          PriceReference,
          PrefetchHooks Function({bool ownerId})
        > {
  $$PriceReferencesTableTableManager(
    _$AppDatabase db,
    $PriceReferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PriceReferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PriceReferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PriceReferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> fullPrice = const Value.absent(),
                Value<int> downPayment = const Value.absent(),
                Value<int> fees = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PriceReferencesCompanion(
                id: id,
                ownerId: ownerId,
                name: name,
                fullPrice: fullPrice,
                downPayment: downPayment,
                fees: fees,
                note: note,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerId,
                required String name,
                required int fullPrice,
                required int downPayment,
                required int fees,
                Value<String?> note = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PriceReferencesCompanion.insert(
                id: id,
                ownerId: ownerId,
                name: name,
                fullPrice: fullPrice,
                downPayment: downPayment,
                fees: fees,
                note: note,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                remoteId: remoteId,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PriceReferencesTable, PriceReference>(table),
                  $$PriceReferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ownerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ownerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.ownerId,
                        referencedTable: $$PriceReferencesTableReferences
                            ._ownerIdTable(db),
                        referencedColumn: $$PriceReferencesTableReferences
                            ._ownerIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PriceReferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PriceReferencesTable,
      PriceReference,
      $$PriceReferencesTableFilterComposer,
      $$PriceReferencesTableOrderingComposer,
      $$PriceReferencesTableAnnotationComposer,
      $$PriceReferencesTableCreateCompanionBuilder,
      $$PriceReferencesTableUpdateCompanionBuilder,
      (PriceReference, $$PriceReferencesTableReferences),
      PriceReference,
      PrefetchHooks Function({bool ownerId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$PortfoliosTableTableManager get portfolios =>
      $$PortfoliosTableTableManager(_db, _db.portfolios);
  $$PortfolioComponentsTableTableManager get portfolioComponents =>
      $$PortfolioComponentsTableTableManager(_db, _db.portfolioComponents);
  $$ContributionsTableTableManager get contributions =>
      $$ContributionsTableTableManager(_db, _db.contributions);
  $$PhasesTableTableManager get phases =>
      $$PhasesTableTableManager(_db, _db.phases);
  $$PhaseAllocationsTableTableManager get phaseAllocations =>
      $$PhaseAllocationsTableTableManager(_db, _db.phaseAllocations);
  $$PriceReferencesTableTableManager get priceReferences =>
      $$PriceReferencesTableTableManager(_db, _db.priceReferences);
}
