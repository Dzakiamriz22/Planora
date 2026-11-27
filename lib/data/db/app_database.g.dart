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
  static const VerificationMeta _planLimitEnabledMeta = const VerificationMeta(
    'planLimitEnabled',
  );
  @override
  late final GeneratedColumn<bool> planLimitEnabled = GeneratedColumn<bool>(
    'plan_limit_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("plan_limit_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _planLimitAmountMeta = const VerificationMeta(
    'planLimitAmount',
  );
  @override
  late final GeneratedColumn<int> planLimitAmount = GeneratedColumn<int>(
    'plan_limit_amount',
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
  static const VerificationMeta _componentInputModeMeta =
      const VerificationMeta('componentInputMode');
  @override
  late final GeneratedColumn<String> componentInputMode =
      GeneratedColumn<String>(
        'component_input_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('percent'),
      );
  static const VerificationMeta _quoteCardDismissedMonthMeta =
      const VerificationMeta('quoteCardDismissedMonth');
  @override
  late final GeneratedColumn<String> quoteCardDismissedMonth =
      GeneratedColumn<String>(
        'quote_card_dismissed_month',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reminderMonthlyEnabledMeta =
      const VerificationMeta('reminderMonthlyEnabled');
  @override
  late final GeneratedColumn<bool> reminderMonthlyEnabled =
      GeneratedColumn<bool>(
        'reminder_monthly_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminder_monthly_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _reminderMonthlyDayMeta =
      const VerificationMeta('reminderMonthlyDay');
  @override
  late final GeneratedColumn<int> reminderMonthlyDay = GeneratedColumn<int>(
    'reminder_monthly_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _reminderMonthlyHourMeta =
      const VerificationMeta('reminderMonthlyHour');
  @override
  late final GeneratedColumn<int> reminderMonthlyHour = GeneratedColumn<int>(
    'reminder_monthly_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9),
  );
  static const VerificationMeta _reminderMonthlyMinuteMeta =
      const VerificationMeta('reminderMonthlyMinute');
  @override
  late final GeneratedColumn<int> reminderMonthlyMinute = GeneratedColumn<int>(
    'reminder_monthly_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reminderExpenseEnabledMeta =
      const VerificationMeta('reminderExpenseEnabled');
  @override
  late final GeneratedColumn<bool> reminderExpenseEnabled =
      GeneratedColumn<bool>(
        'reminder_expense_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminder_expense_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _reminderExpenseHourMeta =
      const VerificationMeta('reminderExpenseHour');
  @override
  late final GeneratedColumn<int> reminderExpenseHour = GeneratedColumn<int>(
    'reminder_expense_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9),
  );
  static const VerificationMeta _reminderExpenseMinuteMeta =
      const VerificationMeta('reminderExpenseMinute');
  @override
  late final GeneratedColumn<int> reminderExpenseMinute = GeneratedColumn<int>(
    'reminder_expense_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reminderMilestoneEnabledMeta =
      const VerificationMeta('reminderMilestoneEnabled');
  @override
  late final GeneratedColumn<bool> reminderMilestoneEnabled =
      GeneratedColumn<bool>(
        'reminder_milestone_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("reminder_milestone_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _hideAmountsMeta = const VerificationMeta(
    'hideAmounts',
  );
  @override
  late final GeneratedColumn<bool> hideAmounts = GeneratedColumn<bool>(
    'hide_amounts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("hide_amounts" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    planLimitEnabled,
    planLimitAmount,
    onboardingDone,
    seedVersion,
    componentInputMode,
    quoteCardDismissedMonth,
    reminderMonthlyEnabled,
    reminderMonthlyDay,
    reminderMonthlyHour,
    reminderMonthlyMinute,
    reminderExpenseEnabled,
    reminderExpenseHour,
    reminderExpenseMinute,
    reminderMilestoneEnabled,
    hideAmounts,
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
    if (data.containsKey('plan_limit_enabled')) {
      context.handle(
        _planLimitEnabledMeta,
        planLimitEnabled.isAcceptableOrUnknown(
          data['plan_limit_enabled']!,
          _planLimitEnabledMeta,
        ),
      );
    }
    if (data.containsKey('plan_limit_amount')) {
      context.handle(
        _planLimitAmountMeta,
        planLimitAmount.isAcceptableOrUnknown(
          data['plan_limit_amount']!,
          _planLimitAmountMeta,
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
    if (data.containsKey('component_input_mode')) {
      context.handle(
        _componentInputModeMeta,
        componentInputMode.isAcceptableOrUnknown(
          data['component_input_mode']!,
          _componentInputModeMeta,
        ),
      );
    }
    if (data.containsKey('quote_card_dismissed_month')) {
      context.handle(
        _quoteCardDismissedMonthMeta,
        quoteCardDismissedMonth.isAcceptableOrUnknown(
          data['quote_card_dismissed_month']!,
          _quoteCardDismissedMonthMeta,
        ),
      );
    }
    if (data.containsKey('reminder_monthly_enabled')) {
      context.handle(
        _reminderMonthlyEnabledMeta,
        reminderMonthlyEnabled.isAcceptableOrUnknown(
          data['reminder_monthly_enabled']!,
          _reminderMonthlyEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_monthly_day')) {
      context.handle(
        _reminderMonthlyDayMeta,
        reminderMonthlyDay.isAcceptableOrUnknown(
          data['reminder_monthly_day']!,
          _reminderMonthlyDayMeta,
        ),
      );
    }
    if (data.containsKey('reminder_monthly_hour')) {
      context.handle(
        _reminderMonthlyHourMeta,
        reminderMonthlyHour.isAcceptableOrUnknown(
          data['reminder_monthly_hour']!,
          _reminderMonthlyHourMeta,
        ),
      );
    }
    if (data.containsKey('reminder_monthly_minute')) {
      context.handle(
        _reminderMonthlyMinuteMeta,
        reminderMonthlyMinute.isAcceptableOrUnknown(
          data['reminder_monthly_minute']!,
          _reminderMonthlyMinuteMeta,
        ),
      );
    }
    if (data.containsKey('reminder_expense_enabled')) {
      context.handle(
        _reminderExpenseEnabledMeta,
        reminderExpenseEnabled.isAcceptableOrUnknown(
          data['reminder_expense_enabled']!,
          _reminderExpenseEnabledMeta,
        ),
      );
    }
    if (data.containsKey('reminder_expense_hour')) {
      context.handle(
        _reminderExpenseHourMeta,
        reminderExpenseHour.isAcceptableOrUnknown(
          data['reminder_expense_hour']!,
          _reminderExpenseHourMeta,
        ),
      );
    }
    if (data.containsKey('reminder_expense_minute')) {
      context.handle(
        _reminderExpenseMinuteMeta,
        reminderExpenseMinute.isAcceptableOrUnknown(
          data['reminder_expense_minute']!,
          _reminderExpenseMinuteMeta,
        ),
      );
    }
    if (data.containsKey('reminder_milestone_enabled')) {
      context.handle(
        _reminderMilestoneEnabledMeta,
        reminderMilestoneEnabled.isAcceptableOrUnknown(
          data['reminder_milestone_enabled']!,
          _reminderMilestoneEnabledMeta,
        ),
      );
    }
    if (data.containsKey('hide_amounts')) {
      context.handle(
        _hideAmountsMeta,
        hideAmounts.isAcceptableOrUnknown(
          data['hide_amounts']!,
          _hideAmountsMeta,
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
      planLimitEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}plan_limit_enabled'],
      )!,
      planLimitAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_limit_amount'],
      ),
      onboardingDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_done'],
      )!,
      seedVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seed_version'],
      )!,
      componentInputMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component_input_mode'],
      )!,
      quoteCardDismissedMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quote_card_dismissed_month'],
      ),
      reminderMonthlyEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_monthly_enabled'],
      )!,
      reminderMonthlyDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_monthly_day'],
      )!,
      reminderMonthlyHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_monthly_hour'],
      )!,
      reminderMonthlyMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_monthly_minute'],
      )!,
      reminderExpenseEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_expense_enabled'],
      )!,
      reminderExpenseHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_expense_hour'],
      )!,
      reminderExpenseMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_expense_minute'],
      )!,
      reminderMilestoneEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_milestone_enabled'],
      )!,
      hideAmounts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}hide_amounts'],
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
  final bool planLimitEnabled;
  final int? planLimitAmount;
  final bool onboardingDone;
  final int seedVersion;
  final String componentInputMode;
  final String? quoteCardDismissedMonth;
  final bool reminderMonthlyEnabled;
  final int reminderMonthlyDay;
  final int reminderMonthlyHour;
  final int reminderMonthlyMinute;
  final bool reminderExpenseEnabled;
  final int reminderExpenseHour;
  final int reminderExpenseMinute;
  final bool reminderMilestoneEnabled;
  final bool hideAmounts;
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
    required this.planLimitEnabled,
    this.planLimitAmount,
    required this.onboardingDone,
    required this.seedVersion,
    required this.componentInputMode,
    this.quoteCardDismissedMonth,
    required this.reminderMonthlyEnabled,
    required this.reminderMonthlyDay,
    required this.reminderMonthlyHour,
    required this.reminderMonthlyMinute,
    required this.reminderExpenseEnabled,
    required this.reminderExpenseHour,
    required this.reminderExpenseMinute,
    required this.reminderMilestoneEnabled,
    required this.hideAmounts,
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
    map['plan_limit_enabled'] = Variable<bool>(planLimitEnabled);
    if (!nullToAbsent || planLimitAmount != null) {
      map['plan_limit_amount'] = Variable<int>(planLimitAmount);
    }
    map['onboarding_done'] = Variable<bool>(onboardingDone);
    map['seed_version'] = Variable<int>(seedVersion);
    map['component_input_mode'] = Variable<String>(componentInputMode);
    if (!nullToAbsent || quoteCardDismissedMonth != null) {
      map['quote_card_dismissed_month'] = Variable<String>(
        quoteCardDismissedMonth,
      );
    }
    map['reminder_monthly_enabled'] = Variable<bool>(reminderMonthlyEnabled);
    map['reminder_monthly_day'] = Variable<int>(reminderMonthlyDay);
    map['reminder_monthly_hour'] = Variable<int>(reminderMonthlyHour);
    map['reminder_monthly_minute'] = Variable<int>(reminderMonthlyMinute);
    map['reminder_expense_enabled'] = Variable<bool>(reminderExpenseEnabled);
    map['reminder_expense_hour'] = Variable<int>(reminderExpenseHour);
    map['reminder_expense_minute'] = Variable<int>(reminderExpenseMinute);
    map['reminder_milestone_enabled'] = Variable<bool>(
      reminderMilestoneEnabled,
    );
    map['hide_amounts'] = Variable<bool>(hideAmounts);
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
      planLimitEnabled: Value(planLimitEnabled),
      planLimitAmount: planLimitAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(planLimitAmount),
      onboardingDone: Value(onboardingDone),
      seedVersion: Value(seedVersion),
      componentInputMode: Value(componentInputMode),
      quoteCardDismissedMonth: quoteCardDismissedMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(quoteCardDismissedMonth),
      reminderMonthlyEnabled: Value(reminderMonthlyEnabled),
      reminderMonthlyDay: Value(reminderMonthlyDay),
      reminderMonthlyHour: Value(reminderMonthlyHour),
      reminderMonthlyMinute: Value(reminderMonthlyMinute),
      reminderExpenseEnabled: Value(reminderExpenseEnabled),
      reminderExpenseHour: Value(reminderExpenseHour),
      reminderExpenseMinute: Value(reminderExpenseMinute),
      reminderMilestoneEnabled: Value(reminderMilestoneEnabled),
      hideAmounts: Value(hideAmounts),
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
      planLimitEnabled: serializer.fromJson<bool>(json['planLimitEnabled']),
      planLimitAmount: serializer.fromJson<int?>(json['planLimitAmount']),
      onboardingDone: serializer.fromJson<bool>(json['onboardingDone']),
      seedVersion: serializer.fromJson<int>(json['seedVersion']),
      componentInputMode: serializer.fromJson<String>(
        json['componentInputMode'],
      ),
      quoteCardDismissedMonth: serializer.fromJson<String?>(
        json['quoteCardDismissedMonth'],
      ),
      reminderMonthlyEnabled: serializer.fromJson<bool>(
        json['reminderMonthlyEnabled'],
      ),
      reminderMonthlyDay: serializer.fromJson<int>(json['reminderMonthlyDay']),
      reminderMonthlyHour: serializer.fromJson<int>(
        json['reminderMonthlyHour'],
      ),
      reminderMonthlyMinute: serializer.fromJson<int>(
        json['reminderMonthlyMinute'],
      ),
      reminderExpenseEnabled: serializer.fromJson<bool>(
        json['reminderExpenseEnabled'],
      ),
      reminderExpenseHour: serializer.fromJson<int>(
        json['reminderExpenseHour'],
      ),
      reminderExpenseMinute: serializer.fromJson<int>(
        json['reminderExpenseMinute'],
      ),
      reminderMilestoneEnabled: serializer.fromJson<bool>(
        json['reminderMilestoneEnabled'],
      ),
      hideAmounts: serializer.fromJson<bool>(json['hideAmounts']),
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
      'planLimitEnabled': serializer.toJson<bool>(planLimitEnabled),
      'planLimitAmount': serializer.toJson<int?>(planLimitAmount),
      'onboardingDone': serializer.toJson<bool>(onboardingDone),
      'seedVersion': serializer.toJson<int>(seedVersion),
      'componentInputMode': serializer.toJson<String>(componentInputMode),
      'quoteCardDismissedMonth': serializer.toJson<String?>(
        quoteCardDismissedMonth,
      ),
      'reminderMonthlyEnabled': serializer.toJson<bool>(reminderMonthlyEnabled),
      'reminderMonthlyDay': serializer.toJson<int>(reminderMonthlyDay),
      'reminderMonthlyHour': serializer.toJson<int>(reminderMonthlyHour),
      'reminderMonthlyMinute': serializer.toJson<int>(reminderMonthlyMinute),
      'reminderExpenseEnabled': serializer.toJson<bool>(reminderExpenseEnabled),
      'reminderExpenseHour': serializer.toJson<int>(reminderExpenseHour),
      'reminderExpenseMinute': serializer.toJson<int>(reminderExpenseMinute),
      'reminderMilestoneEnabled': serializer.toJson<bool>(
        reminderMilestoneEnabled,
      ),
      'hideAmounts': serializer.toJson<bool>(hideAmounts),
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
    bool? planLimitEnabled,
    Value<int?> planLimitAmount = const Value.absent(),
    bool? onboardingDone,
    int? seedVersion,
    String? componentInputMode,
    Value<String?> quoteCardDismissedMonth = const Value.absent(),
    bool? reminderMonthlyEnabled,
    int? reminderMonthlyDay,
    int? reminderMonthlyHour,
    int? reminderMonthlyMinute,
    bool? reminderExpenseEnabled,
    int? reminderExpenseHour,
    int? reminderExpenseMinute,
    bool? reminderMilestoneEnabled,
    bool? hideAmounts,
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
    planLimitEnabled: planLimitEnabled ?? this.planLimitEnabled,
    planLimitAmount: planLimitAmount.present
        ? planLimitAmount.value
        : this.planLimitAmount,
    onboardingDone: onboardingDone ?? this.onboardingDone,
    seedVersion: seedVersion ?? this.seedVersion,
    componentInputMode: componentInputMode ?? this.componentInputMode,
    quoteCardDismissedMonth: quoteCardDismissedMonth.present
        ? quoteCardDismissedMonth.value
        : this.quoteCardDismissedMonth,
    reminderMonthlyEnabled:
        reminderMonthlyEnabled ?? this.reminderMonthlyEnabled,
    reminderMonthlyDay: reminderMonthlyDay ?? this.reminderMonthlyDay,
    reminderMonthlyHour: reminderMonthlyHour ?? this.reminderMonthlyHour,
    reminderMonthlyMinute: reminderMonthlyMinute ?? this.reminderMonthlyMinute,
    reminderExpenseEnabled:
        reminderExpenseEnabled ?? this.reminderExpenseEnabled,
    reminderExpenseHour: reminderExpenseHour ?? this.reminderExpenseHour,
    reminderExpenseMinute: reminderExpenseMinute ?? this.reminderExpenseMinute,
    reminderMilestoneEnabled:
        reminderMilestoneEnabled ?? this.reminderMilestoneEnabled,
    hideAmounts: hideAmounts ?? this.hideAmounts,
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
      planLimitEnabled: data.planLimitEnabled.present
          ? data.planLimitEnabled.value
          : this.planLimitEnabled,
      planLimitAmount: data.planLimitAmount.present
          ? data.planLimitAmount.value
          : this.planLimitAmount,
      onboardingDone: data.onboardingDone.present
          ? data.onboardingDone.value
          : this.onboardingDone,
      seedVersion: data.seedVersion.present
          ? data.seedVersion.value
          : this.seedVersion,
      componentInputMode: data.componentInputMode.present
          ? data.componentInputMode.value
          : this.componentInputMode,
      quoteCardDismissedMonth: data.quoteCardDismissedMonth.present
          ? data.quoteCardDismissedMonth.value
          : this.quoteCardDismissedMonth,
      reminderMonthlyEnabled: data.reminderMonthlyEnabled.present
          ? data.reminderMonthlyEnabled.value
          : this.reminderMonthlyEnabled,
      reminderMonthlyDay: data.reminderMonthlyDay.present
          ? data.reminderMonthlyDay.value
          : this.reminderMonthlyDay,
      reminderMonthlyHour: data.reminderMonthlyHour.present
          ? data.reminderMonthlyHour.value
          : this.reminderMonthlyHour,
      reminderMonthlyMinute: data.reminderMonthlyMinute.present
          ? data.reminderMonthlyMinute.value
          : this.reminderMonthlyMinute,
      reminderExpenseEnabled: data.reminderExpenseEnabled.present
          ? data.reminderExpenseEnabled.value
          : this.reminderExpenseEnabled,
      reminderExpenseHour: data.reminderExpenseHour.present
          ? data.reminderExpenseHour.value
          : this.reminderExpenseHour,
      reminderExpenseMinute: data.reminderExpenseMinute.present
          ? data.reminderExpenseMinute.value
          : this.reminderExpenseMinute,
      reminderMilestoneEnabled: data.reminderMilestoneEnabled.present
          ? data.reminderMilestoneEnabled.value
          : this.reminderMilestoneEnabled,
      hideAmounts: data.hideAmounts.present
          ? data.hideAmounts.value
          : this.hideAmounts,
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
          ..write('planLimitEnabled: $planLimitEnabled, ')
          ..write('planLimitAmount: $planLimitAmount, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('seedVersion: $seedVersion, ')
          ..write('componentInputMode: $componentInputMode, ')
          ..write('quoteCardDismissedMonth: $quoteCardDismissedMonth, ')
          ..write('reminderMonthlyEnabled: $reminderMonthlyEnabled, ')
          ..write('reminderMonthlyDay: $reminderMonthlyDay, ')
          ..write('reminderMonthlyHour: $reminderMonthlyHour, ')
          ..write('reminderMonthlyMinute: $reminderMonthlyMinute, ')
          ..write('reminderExpenseEnabled: $reminderExpenseEnabled, ')
          ..write('reminderExpenseHour: $reminderExpenseHour, ')
          ..write('reminderExpenseMinute: $reminderExpenseMinute, ')
          ..write('reminderMilestoneEnabled: $reminderMilestoneEnabled, ')
          ..write('hideAmounts: $hideAmounts, ')
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
    monthlySalary,
    minimumLivingCost,
    currentLivingCost,
    defaultAnnualReturnPct,
    planLimitEnabled,
    planLimitAmount,
    onboardingDone,
    seedVersion,
    componentInputMode,
    quoteCardDismissedMonth,
    reminderMonthlyEnabled,
    reminderMonthlyDay,
    reminderMonthlyHour,
    reminderMonthlyMinute,
    reminderExpenseEnabled,
    reminderExpenseHour,
    reminderExpenseMinute,
    reminderMilestoneEnabled,
    hideAmounts,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  ]);
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
          other.planLimitEnabled == this.planLimitEnabled &&
          other.planLimitAmount == this.planLimitAmount &&
          other.onboardingDone == this.onboardingDone &&
          other.seedVersion == this.seedVersion &&
          other.componentInputMode == this.componentInputMode &&
          other.quoteCardDismissedMonth == this.quoteCardDismissedMonth &&
          other.reminderMonthlyEnabled == this.reminderMonthlyEnabled &&
          other.reminderMonthlyDay == this.reminderMonthlyDay &&
          other.reminderMonthlyHour == this.reminderMonthlyHour &&
          other.reminderMonthlyMinute == this.reminderMonthlyMinute &&
          other.reminderExpenseEnabled == this.reminderExpenseEnabled &&
          other.reminderExpenseHour == this.reminderExpenseHour &&
          other.reminderExpenseMinute == this.reminderExpenseMinute &&
          other.reminderMilestoneEnabled == this.reminderMilestoneEnabled &&
          other.hideAmounts == this.hideAmounts &&
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
  final Value<bool> planLimitEnabled;
  final Value<int?> planLimitAmount;
  final Value<bool> onboardingDone;
  final Value<int> seedVersion;
  final Value<String> componentInputMode;
  final Value<String?> quoteCardDismissedMonth;
  final Value<bool> reminderMonthlyEnabled;
  final Value<int> reminderMonthlyDay;
  final Value<int> reminderMonthlyHour;
  final Value<int> reminderMonthlyMinute;
  final Value<bool> reminderExpenseEnabled;
  final Value<int> reminderExpenseHour;
  final Value<int> reminderExpenseMinute;
  final Value<bool> reminderMilestoneEnabled;
  final Value<bool> hideAmounts;
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
    this.planLimitEnabled = const Value.absent(),
    this.planLimitAmount = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.seedVersion = const Value.absent(),
    this.componentInputMode = const Value.absent(),
    this.quoteCardDismissedMonth = const Value.absent(),
    this.reminderMonthlyEnabled = const Value.absent(),
    this.reminderMonthlyDay = const Value.absent(),
    this.reminderMonthlyHour = const Value.absent(),
    this.reminderMonthlyMinute = const Value.absent(),
    this.reminderExpenseEnabled = const Value.absent(),
    this.reminderExpenseHour = const Value.absent(),
    this.reminderExpenseMinute = const Value.absent(),
    this.reminderMilestoneEnabled = const Value.absent(),
    this.hideAmounts = const Value.absent(),
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
    this.planLimitEnabled = const Value.absent(),
    this.planLimitAmount = const Value.absent(),
    this.onboardingDone = const Value.absent(),
    this.seedVersion = const Value.absent(),
    this.componentInputMode = const Value.absent(),
    this.quoteCardDismissedMonth = const Value.absent(),
    this.reminderMonthlyEnabled = const Value.absent(),
    this.reminderMonthlyDay = const Value.absent(),
    this.reminderMonthlyHour = const Value.absent(),
    this.reminderMonthlyMinute = const Value.absent(),
    this.reminderExpenseEnabled = const Value.absent(),
    this.reminderExpenseHour = const Value.absent(),
    this.reminderExpenseMinute = const Value.absent(),
    this.reminderMilestoneEnabled = const Value.absent(),
    this.hideAmounts = const Value.absent(),
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
    Expression<bool>? planLimitEnabled,
    Expression<int>? planLimitAmount,
    Expression<bool>? onboardingDone,
    Expression<int>? seedVersion,
    Expression<String>? componentInputMode,
    Expression<String>? quoteCardDismissedMonth,
    Expression<bool>? reminderMonthlyEnabled,
    Expression<int>? reminderMonthlyDay,
    Expression<int>? reminderMonthlyHour,
    Expression<int>? reminderMonthlyMinute,
    Expression<bool>? reminderExpenseEnabled,
    Expression<int>? reminderExpenseHour,
    Expression<int>? reminderExpenseMinute,
    Expression<bool>? reminderMilestoneEnabled,
    Expression<bool>? hideAmounts,
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
      if (planLimitEnabled != null) 'plan_limit_enabled': planLimitEnabled,
      if (planLimitAmount != null) 'plan_limit_amount': planLimitAmount,
      if (onboardingDone != null) 'onboarding_done': onboardingDone,
      if (seedVersion != null) 'seed_version': seedVersion,
      if (componentInputMode != null)
        'component_input_mode': componentInputMode,
      if (quoteCardDismissedMonth != null)
        'quote_card_dismissed_month': quoteCardDismissedMonth,
      if (reminderMonthlyEnabled != null)
        'reminder_monthly_enabled': reminderMonthlyEnabled,
      if (reminderMonthlyDay != null)
        'reminder_monthly_day': reminderMonthlyDay,
      if (reminderMonthlyHour != null)
        'reminder_monthly_hour': reminderMonthlyHour,
      if (reminderMonthlyMinute != null)
        'reminder_monthly_minute': reminderMonthlyMinute,
      if (reminderExpenseEnabled != null)
        'reminder_expense_enabled': reminderExpenseEnabled,
      if (reminderExpenseHour != null)
        'reminder_expense_hour': reminderExpenseHour,
      if (reminderExpenseMinute != null)
        'reminder_expense_minute': reminderExpenseMinute,
      if (reminderMilestoneEnabled != null)
        'reminder_milestone_enabled': reminderMilestoneEnabled,
      if (hideAmounts != null) 'hide_amounts': hideAmounts,
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
    Value<bool>? planLimitEnabled,
    Value<int?>? planLimitAmount,
    Value<bool>? onboardingDone,
    Value<int>? seedVersion,
    Value<String>? componentInputMode,
    Value<String?>? quoteCardDismissedMonth,
    Value<bool>? reminderMonthlyEnabled,
    Value<int>? reminderMonthlyDay,
    Value<int>? reminderMonthlyHour,
    Value<int>? reminderMonthlyMinute,
    Value<bool>? reminderExpenseEnabled,
    Value<int>? reminderExpenseHour,
    Value<int>? reminderExpenseMinute,
    Value<bool>? reminderMilestoneEnabled,
    Value<bool>? hideAmounts,
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
      planLimitEnabled: planLimitEnabled ?? this.planLimitEnabled,
      planLimitAmount: planLimitAmount ?? this.planLimitAmount,
      onboardingDone: onboardingDone ?? this.onboardingDone,
      seedVersion: seedVersion ?? this.seedVersion,
      componentInputMode: componentInputMode ?? this.componentInputMode,
      quoteCardDismissedMonth:
          quoteCardDismissedMonth ?? this.quoteCardDismissedMonth,
      reminderMonthlyEnabled:
          reminderMonthlyEnabled ?? this.reminderMonthlyEnabled,
      reminderMonthlyDay: reminderMonthlyDay ?? this.reminderMonthlyDay,
      reminderMonthlyHour: reminderMonthlyHour ?? this.reminderMonthlyHour,
      reminderMonthlyMinute:
          reminderMonthlyMinute ?? this.reminderMonthlyMinute,
      reminderExpenseEnabled:
          reminderExpenseEnabled ?? this.reminderExpenseEnabled,
      reminderExpenseHour: reminderExpenseHour ?? this.reminderExpenseHour,
      reminderExpenseMinute:
          reminderExpenseMinute ?? this.reminderExpenseMinute,
      reminderMilestoneEnabled:
          reminderMilestoneEnabled ?? this.reminderMilestoneEnabled,
      hideAmounts: hideAmounts ?? this.hideAmounts,
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
    if (planLimitEnabled.present) {
      map['plan_limit_enabled'] = Variable<bool>(planLimitEnabled.value);
    }
    if (planLimitAmount.present) {
      map['plan_limit_amount'] = Variable<int>(planLimitAmount.value);
    }
    if (onboardingDone.present) {
      map['onboarding_done'] = Variable<bool>(onboardingDone.value);
    }
    if (seedVersion.present) {
      map['seed_version'] = Variable<int>(seedVersion.value);
    }
    if (componentInputMode.present) {
      map['component_input_mode'] = Variable<String>(componentInputMode.value);
    }
    if (quoteCardDismissedMonth.present) {
      map['quote_card_dismissed_month'] = Variable<String>(
        quoteCardDismissedMonth.value,
      );
    }
    if (reminderMonthlyEnabled.present) {
      map['reminder_monthly_enabled'] = Variable<bool>(
        reminderMonthlyEnabled.value,
      );
    }
    if (reminderMonthlyDay.present) {
      map['reminder_monthly_day'] = Variable<int>(reminderMonthlyDay.value);
    }
    if (reminderMonthlyHour.present) {
      map['reminder_monthly_hour'] = Variable<int>(reminderMonthlyHour.value);
    }
    if (reminderMonthlyMinute.present) {
      map['reminder_monthly_minute'] = Variable<int>(
        reminderMonthlyMinute.value,
      );
    }
    if (reminderExpenseEnabled.present) {
      map['reminder_expense_enabled'] = Variable<bool>(
        reminderExpenseEnabled.value,
      );
    }
    if (reminderExpenseHour.present) {
      map['reminder_expense_hour'] = Variable<int>(reminderExpenseHour.value);
    }
    if (reminderExpenseMinute.present) {
      map['reminder_expense_minute'] = Variable<int>(
        reminderExpenseMinute.value,
      );
    }
    if (reminderMilestoneEnabled.present) {
      map['reminder_milestone_enabled'] = Variable<bool>(
        reminderMilestoneEnabled.value,
      );
    }
    if (hideAmounts.present) {
      map['hide_amounts'] = Variable<bool>(hideAmounts.value);
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
          ..write('planLimitEnabled: $planLimitEnabled, ')
          ..write('planLimitAmount: $planLimitAmount, ')
          ..write('onboardingDone: $onboardingDone, ')
          ..write('seedVersion: $seedVersion, ')
          ..write('componentInputMode: $componentInputMode, ')
          ..write('quoteCardDismissedMonth: $quoteCardDismissedMonth, ')
          ..write('reminderMonthlyEnabled: $reminderMonthlyEnabled, ')
          ..write('reminderMonthlyDay: $reminderMonthlyDay, ')
          ..write('reminderMonthlyHour: $reminderMonthlyHour, ')
          ..write('reminderMonthlyMinute: $reminderMonthlyMinute, ')
          ..write('reminderExpenseEnabled: $reminderExpenseEnabled, ')
          ..write('reminderExpenseHour: $reminderExpenseHour, ')
          ..write('reminderExpenseMinute: $reminderExpenseMinute, ')
          ..write('reminderMilestoneEnabled: $reminderMilestoneEnabled, ')
          ..write('hideAmounts: $hideAmounts, ')
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
  final String category;
  final String? platformPreset;
  final String? platformName;
  final int? fullPrice;
  final int? downPayment;
  final int? fees;
  final int? savedTarget;
  final String? targetDate;
  final int monthlyPlan;
  final double annualReturnPct;
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
  static const VerificationMeta _targetPercentMeta = const VerificationMeta(
    'targetPercent',
  );
  @override
  late final GeneratedColumn<double> targetPercent = GeneratedColumn<double>(
    'target_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _actualAmountMeta = const VerificationMeta(
    'actualAmount',
  );
  @override
  late final GeneratedColumn<int> actualAmount = GeneratedColumn<int>(
    'actual_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _mechanismMeta = const VerificationMeta(
    'mechanism',
  );
  @override
  late final GeneratedColumn<String> mechanism = GeneratedColumn<String>(
    'mechanism',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('nominal'),
  );
  static const VerificationMeta _legacyOpeningAmountMeta =
      const VerificationMeta('legacyOpeningAmount');
  @override
  late final GeneratedColumn<int> legacyOpeningAmount = GeneratedColumn<int>(
    'legacy_opening_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    targetPercent,
    actualAmount,
    mechanism,
    legacyOpeningAmount,
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
    if (data.containsKey('target_percent')) {
      context.handle(
        _targetPercentMeta,
        targetPercent.isAcceptableOrUnknown(
          data['target_percent']!,
          _targetPercentMeta,
        ),
      );
    }
    if (data.containsKey('actual_amount')) {
      context.handle(
        _actualAmountMeta,
        actualAmount.isAcceptableOrUnknown(
          data['actual_amount']!,
          _actualAmountMeta,
        ),
      );
    }
    if (data.containsKey('mechanism')) {
      context.handle(
        _mechanismMeta,
        mechanism.isAcceptableOrUnknown(data['mechanism']!, _mechanismMeta),
      );
    }
    if (data.containsKey('legacy_opening_amount')) {
      context.handle(
        _legacyOpeningAmountMeta,
        legacyOpeningAmount.isAcceptableOrUnknown(
          data['legacy_opening_amount']!,
          _legacyOpeningAmountMeta,
        ),
      );
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
      targetPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_percent'],
      )!,
      actualAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_amount'],
      )!,
      mechanism: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mechanism'],
      )!,
      legacyOpeningAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}legacy_opening_amount'],
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
  final double targetPercent;
  final int actualAmount;
  final String mechanism;
  final int legacyOpeningAmount;
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
    required this.targetPercent,
    required this.actualAmount,
    required this.mechanism,
    required this.legacyOpeningAmount,
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
    map['target_percent'] = Variable<double>(targetPercent);
    map['actual_amount'] = Variable<int>(actualAmount);
    map['mechanism'] = Variable<String>(mechanism);
    map['legacy_opening_amount'] = Variable<int>(legacyOpeningAmount);
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
      targetPercent: Value(targetPercent),
      actualAmount: Value(actualAmount),
      mechanism: Value(mechanism),
      legacyOpeningAmount: Value(legacyOpeningAmount),
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
      targetPercent: serializer.fromJson<double>(json['targetPercent']),
      actualAmount: serializer.fromJson<int>(json['actualAmount']),
      mechanism: serializer.fromJson<String>(json['mechanism']),
      legacyOpeningAmount: serializer.fromJson<int>(
        json['legacyOpeningAmount'],
      ),
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
      'targetPercent': serializer.toJson<double>(targetPercent),
      'actualAmount': serializer.toJson<int>(actualAmount),
      'mechanism': serializer.toJson<String>(mechanism),
      'legacyOpeningAmount': serializer.toJson<int>(legacyOpeningAmount),
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
    double? targetPercent,
    int? actualAmount,
    String? mechanism,
    int? legacyOpeningAmount,
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
    targetPercent: targetPercent ?? this.targetPercent,
    actualAmount: actualAmount ?? this.actualAmount,
    mechanism: mechanism ?? this.mechanism,
    legacyOpeningAmount: legacyOpeningAmount ?? this.legacyOpeningAmount,
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
      targetPercent: data.targetPercent.present
          ? data.targetPercent.value
          : this.targetPercent,
      actualAmount: data.actualAmount.present
          ? data.actualAmount.value
          : this.actualAmount,
      mechanism: data.mechanism.present ? data.mechanism.value : this.mechanism,
      legacyOpeningAmount: data.legacyOpeningAmount.present
          ? data.legacyOpeningAmount.value
          : this.legacyOpeningAmount,
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
          ..write('targetPercent: $targetPercent, ')
          ..write('actualAmount: $actualAmount, ')
          ..write('mechanism: $mechanism, ')
          ..write('legacyOpeningAmount: $legacyOpeningAmount, ')
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
    targetPercent,
    actualAmount,
    mechanism,
    legacyOpeningAmount,
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
          other.targetPercent == this.targetPercent &&
          other.actualAmount == this.actualAmount &&
          other.mechanism == this.mechanism &&
          other.legacyOpeningAmount == this.legacyOpeningAmount &&
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
  final Value<double> targetPercent;
  final Value<int> actualAmount;
  final Value<String> mechanism;
  final Value<int> legacyOpeningAmount;
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
    this.targetPercent = const Value.absent(),
    this.actualAmount = const Value.absent(),
    this.mechanism = const Value.absent(),
    this.legacyOpeningAmount = const Value.absent(),
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
    this.targetPercent = const Value.absent(),
    this.actualAmount = const Value.absent(),
    this.mechanism = const Value.absent(),
    this.legacyOpeningAmount = const Value.absent(),
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
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PortfolioComponent> custom({
    Expression<String>? id,
    Expression<String>? portfolioId,
    Expression<String>? ownerId,
    Expression<String>? instrumentType,
    Expression<String>? name,
    Expression<double>? targetPercent,
    Expression<int>? actualAmount,
    Expression<String>? mechanism,
    Expression<int>? legacyOpeningAmount,
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
      if (targetPercent != null) 'target_percent': targetPercent,
      if (actualAmount != null) 'actual_amount': actualAmount,
      if (mechanism != null) 'mechanism': mechanism,
      if (legacyOpeningAmount != null)
        'legacy_opening_amount': legacyOpeningAmount,
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
    Value<double>? targetPercent,
    Value<int>? actualAmount,
    Value<String>? mechanism,
    Value<int>? legacyOpeningAmount,
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
      targetPercent: targetPercent ?? this.targetPercent,
      actualAmount: actualAmount ?? this.actualAmount,
      mechanism: mechanism ?? this.mechanism,
      legacyOpeningAmount: legacyOpeningAmount ?? this.legacyOpeningAmount,
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
    if (targetPercent.present) {
      map['target_percent'] = Variable<double>(targetPercent.value);
    }
    if (actualAmount.present) {
      map['actual_amount'] = Variable<int>(actualAmount.value);
    }
    if (mechanism.present) {
      map['mechanism'] = Variable<String>(mechanism.value);
    }
    if (legacyOpeningAmount.present) {
      map['legacy_opening_amount'] = Variable<int>(legacyOpeningAmount.value);
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
          ..write('targetPercent: $targetPercent, ')
          ..write('actualAmount: $actualAmount, ')
          ..write('mechanism: $mechanism, ')
          ..write('legacyOpeningAmount: $legacyOpeningAmount, ')
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
  static const VerificationMeta _componentIdMeta = const VerificationMeta(
    'componentId',
  );
  @override
  late final GeneratedColumn<String> componentId = GeneratedColumn<String>(
    'component_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockTransactionIdMeta =
      const VerificationMeta('stockTransactionId');
  @override
  late final GeneratedColumn<String> stockTransactionId =
      GeneratedColumn<String>(
        'stock_transaction_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
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
    componentId,
    stockTransactionId,
    source,
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
    if (data.containsKey('component_id')) {
      context.handle(
        _componentIdMeta,
        componentId.isAcceptableOrUnknown(
          data['component_id']!,
          _componentIdMeta,
        ),
      );
    }
    if (data.containsKey('stock_transaction_id')) {
      context.handle(
        _stockTransactionIdMeta,
        stockTransactionId.isAcceptableOrUnknown(
          data['stock_transaction_id']!,
          _stockTransactionIdMeta,
        ),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
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
      componentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component_id'],
      ),
      stockTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stock_transaction_id'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
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
  final String? componentId;
  final String? stockTransactionId;
  final String source;
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
    this.componentId,
    this.stockTransactionId,
    required this.source,
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
    if (!nullToAbsent || componentId != null) {
      map['component_id'] = Variable<String>(componentId);
    }
    if (!nullToAbsent || stockTransactionId != null) {
      map['stock_transaction_id'] = Variable<String>(stockTransactionId);
    }
    map['source'] = Variable<String>(source);
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
      componentId: componentId == null && nullToAbsent
          ? const Value.absent()
          : Value(componentId),
      stockTransactionId: stockTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(stockTransactionId),
      source: Value(source),
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
      componentId: serializer.fromJson<String?>(json['componentId']),
      stockTransactionId: serializer.fromJson<String?>(
        json['stockTransactionId'],
      ),
      source: serializer.fromJson<String>(json['source']),
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
      'componentId': serializer.toJson<String?>(componentId),
      'stockTransactionId': serializer.toJson<String?>(stockTransactionId),
      'source': serializer.toJson<String>(source),
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
    Value<String?> componentId = const Value.absent(),
    Value<String?> stockTransactionId = const Value.absent(),
    String? source,
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
    componentId: componentId.present ? componentId.value : this.componentId,
    stockTransactionId: stockTransactionId.present
        ? stockTransactionId.value
        : this.stockTransactionId,
    source: source ?? this.source,
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
      componentId: data.componentId.present
          ? data.componentId.value
          : this.componentId,
      stockTransactionId: data.stockTransactionId.present
          ? data.stockTransactionId.value
          : this.stockTransactionId,
      source: data.source.present ? data.source.value : this.source,
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
          ..write('componentId: $componentId, ')
          ..write('stockTransactionId: $stockTransactionId, ')
          ..write('source: $source, ')
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
    componentId,
    stockTransactionId,
    source,
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
          other.componentId == this.componentId &&
          other.stockTransactionId == this.stockTransactionId &&
          other.source == this.source &&
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
  final Value<String?> componentId;
  final Value<String?> stockTransactionId;
  final Value<String> source;
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
    this.componentId = const Value.absent(),
    this.stockTransactionId = const Value.absent(),
    this.source = const Value.absent(),
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
    this.componentId = const Value.absent(),
    this.stockTransactionId = const Value.absent(),
    this.source = const Value.absent(),
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
    Expression<String>? componentId,
    Expression<String>? stockTransactionId,
    Expression<String>? source,
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
      if (componentId != null) 'component_id': componentId,
      if (stockTransactionId != null)
        'stock_transaction_id': stockTransactionId,
      if (source != null) 'source': source,
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
    Value<String?>? componentId,
    Value<String?>? stockTransactionId,
    Value<String>? source,
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
      componentId: componentId ?? this.componentId,
      stockTransactionId: stockTransactionId ?? this.stockTransactionId,
      source: source ?? this.source,
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
    if (componentId.present) {
      map['component_id'] = Variable<String>(componentId.value);
    }
    if (stockTransactionId.present) {
      map['stock_transaction_id'] = Variable<String>(stockTransactionId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
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
          ..write('componentId: $componentId, ')
          ..write('stockTransactionId: $stockTransactionId, ')
          ..write('source: $source, ')
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

class $PlansTable extends Plans with TableInfo<$PlansTable, Plan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<int> totalAmount = GeneratedColumn<int>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    totalAmount,
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
  static const String $name = 'plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<Plan> instance, {
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
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
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
  Plan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plan(
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
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_amount'],
      )!,
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
  $PlansTable createAlias(String alias) {
    return $PlansTable(attachedDatabase, alias);
  }
}

class Plan extends DataClass implements Insertable<Plan> {
  final String id;
  final String ownerId;
  final String name;
  final String? description;
  final int totalAmount;
  final bool isActive;
  final int sortOrder;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const Plan({
    required this.id,
    required this.ownerId,
    required this.name,
    this.description,
    required this.totalAmount,
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
    map['total_amount'] = Variable<int>(totalAmount);
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

  PlansCompanion toCompanion(bool nullToAbsent) {
    return PlansCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      totalAmount: Value(totalAmount),
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

  factory Plan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plan(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      totalAmount: serializer.fromJson<int>(json['totalAmount']),
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
      'totalAmount': serializer.toJson<int>(totalAmount),
      'isActive': serializer.toJson<bool>(isActive),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  Plan copyWith({
    String? id,
    String? ownerId,
    String? name,
    Value<String?> description = const Value.absent(),
    int? totalAmount,
    bool? isActive,
    int? sortOrder,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => Plan(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    totalAmount: totalAmount ?? this.totalAmount,
    isActive: isActive ?? this.isActive,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Plan copyWithCompanion(PlansCompanion data) {
    return Plan(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
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
    return (StringBuffer('Plan(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('totalAmount: $totalAmount, ')
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
    totalAmount,
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
      (other is Plan &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.name == this.name &&
          other.description == this.description &&
          other.totalAmount == this.totalAmount &&
          other.isActive == this.isActive &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class PlansCompanion extends UpdateCompanion<Plan> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> totalAmount;
  final Value<bool> isActive;
  final Value<int> sortOrder;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const PlansCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.isActive = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlansCompanion.insert({
    required String id,
    required String ownerId,
    required String name,
    this.description = const Value.absent(),
    this.totalAmount = const Value.absent(),
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
  static Insertable<Plan> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? totalAmount,
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
      if (totalAmount != null) 'total_amount': totalAmount,
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

  PlansCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? totalAmount,
    Value<bool>? isActive,
    Value<int>? sortOrder,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PlansCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      description: description ?? this.description,
      totalAmount: totalAmount ?? this.totalAmount,
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
    if (totalAmount.present) {
      map['total_amount'] = Variable<int>(totalAmount.value);
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
    return (StringBuffer('PlansCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('totalAmount: $totalAmount, ')
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

class $PlanAllocationsTable extends PlanAllocations
    with TableInfo<$PlanAllocationsTable, PlanAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plans (id) ON DELETE CASCADE',
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
  static const VerificationMeta _sharePercentX100Meta = const VerificationMeta(
    'sharePercentX100',
  );
  @override
  late final GeneratedColumn<int> sharePercentX100 = GeneratedColumn<int>(
    'share_percent_x100',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fixedAmountMeta = const VerificationMeta(
    'fixedAmount',
  );
  @override
  late final GeneratedColumn<int> fixedAmount = GeneratedColumn<int>(
    'fixed_amount',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
    planId,
    portfolioId,
    ownerId,
    sharePercentX100,
    fixedAmount,
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
  static const String $name = 'plan_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
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
    if (data.containsKey('share_percent_x100')) {
      context.handle(
        _sharePercentX100Meta,
        sharePercentX100.isAcceptableOrUnknown(
          data['share_percent_x100']!,
          _sharePercentX100Meta,
        ),
      );
    }
    if (data.containsKey('fixed_amount')) {
      context.handle(
        _fixedAmountMeta,
        fixedAmount.isAcceptableOrUnknown(
          data['fixed_amount']!,
          _fixedAmountMeta,
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
    {planId, portfolioId},
  ];
  @override
  PlanAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      portfolioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portfolio_id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      sharePercentX100: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}share_percent_x100'],
      )!,
      fixedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixed_amount'],
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
  $PlanAllocationsTable createAlias(String alias) {
    return $PlanAllocationsTable(attachedDatabase, alias);
  }
}

class PlanAllocation extends DataClass implements Insertable<PlanAllocation> {
  final String id;
  final String planId;
  final String portfolioId;
  final String ownerId;
  final int sharePercentX100;
  final int? fixedAmount;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const PlanAllocation({
    required this.id,
    required this.planId,
    required this.portfolioId,
    required this.ownerId,
    required this.sharePercentX100,
    this.fixedAmount,
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
    map['plan_id'] = Variable<String>(planId);
    map['portfolio_id'] = Variable<String>(portfolioId);
    map['owner_id'] = Variable<String>(ownerId);
    map['share_percent_x100'] = Variable<int>(sharePercentX100);
    if (!nullToAbsent || fixedAmount != null) {
      map['fixed_amount'] = Variable<int>(fixedAmount);
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

  PlanAllocationsCompanion toCompanion(bool nullToAbsent) {
    return PlanAllocationsCompanion(
      id: Value(id),
      planId: Value(planId),
      portfolioId: Value(portfolioId),
      ownerId: Value(ownerId),
      sharePercentX100: Value(sharePercentX100),
      fixedAmount: fixedAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(fixedAmount),
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

  factory PlanAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanAllocation(
      id: serializer.fromJson<String>(json['id']),
      planId: serializer.fromJson<String>(json['planId']),
      portfolioId: serializer.fromJson<String>(json['portfolioId']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      sharePercentX100: serializer.fromJson<int>(json['sharePercentX100']),
      fixedAmount: serializer.fromJson<int?>(json['fixedAmount']),
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
      'planId': serializer.toJson<String>(planId),
      'portfolioId': serializer.toJson<String>(portfolioId),
      'ownerId': serializer.toJson<String>(ownerId),
      'sharePercentX100': serializer.toJson<int>(sharePercentX100),
      'fixedAmount': serializer.toJson<int?>(fixedAmount),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  PlanAllocation copyWith({
    String? id,
    String? planId,
    String? portfolioId,
    String? ownerId,
    int? sharePercentX100,
    Value<int?> fixedAmount = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => PlanAllocation(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    portfolioId: portfolioId ?? this.portfolioId,
    ownerId: ownerId ?? this.ownerId,
    sharePercentX100: sharePercentX100 ?? this.sharePercentX100,
    fixedAmount: fixedAmount.present ? fixedAmount.value : this.fixedAmount,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  PlanAllocation copyWithCompanion(PlanAllocationsCompanion data) {
    return PlanAllocation(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      portfolioId: data.portfolioId.present
          ? data.portfolioId.value
          : this.portfolioId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      sharePercentX100: data.sharePercentX100.present
          ? data.sharePercentX100.value
          : this.sharePercentX100,
      fixedAmount: data.fixedAmount.present
          ? data.fixedAmount.value
          : this.fixedAmount,
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
    return (StringBuffer('PlanAllocation(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ownerId: $ownerId, ')
          ..write('sharePercentX100: $sharePercentX100, ')
          ..write('fixedAmount: $fixedAmount, ')
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
    planId,
    portfolioId,
    ownerId,
    sharePercentX100,
    fixedAmount,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanAllocation &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.portfolioId == this.portfolioId &&
          other.ownerId == this.ownerId &&
          other.sharePercentX100 == this.sharePercentX100 &&
          other.fixedAmount == this.fixedAmount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class PlanAllocationsCompanion extends UpdateCompanion<PlanAllocation> {
  final Value<String> id;
  final Value<String> planId;
  final Value<String> portfolioId;
  final Value<String> ownerId;
  final Value<int> sharePercentX100;
  final Value<int?> fixedAmount;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const PlanAllocationsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.portfolioId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.sharePercentX100 = const Value.absent(),
    this.fixedAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlanAllocationsCompanion.insert({
    required String id,
    required String planId,
    required String portfolioId,
    required String ownerId,
    this.sharePercentX100 = const Value.absent(),
    this.fixedAmount = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       planId = Value(planId),
       portfolioId = Value(portfolioId),
       ownerId = Value(ownerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PlanAllocation> custom({
    Expression<String>? id,
    Expression<String>? planId,
    Expression<String>? portfolioId,
    Expression<String>? ownerId,
    Expression<int>? sharePercentX100,
    Expression<int>? fixedAmount,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (portfolioId != null) 'portfolio_id': portfolioId,
      if (ownerId != null) 'owner_id': ownerId,
      if (sharePercentX100 != null) 'share_percent_x100': sharePercentX100,
      if (fixedAmount != null) 'fixed_amount': fixedAmount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlanAllocationsCompanion copyWith({
    Value<String>? id,
    Value<String>? planId,
    Value<String>? portfolioId,
    Value<String>? ownerId,
    Value<int>? sharePercentX100,
    Value<int?>? fixedAmount,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return PlanAllocationsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      portfolioId: portfolioId ?? this.portfolioId,
      ownerId: ownerId ?? this.ownerId,
      sharePercentX100: sharePercentX100 ?? this.sharePercentX100,
      fixedAmount: fixedAmount ?? this.fixedAmount,
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
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (portfolioId.present) {
      map['portfolio_id'] = Variable<String>(portfolioId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (sharePercentX100.present) {
      map['share_percent_x100'] = Variable<int>(sharePercentX100.value);
    }
    if (fixedAmount.present) {
      map['fixed_amount'] = Variable<int>(fixedAmount.value);
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
    return (StringBuffer('PlanAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ownerId: $ownerId, ')
          ..write('sharePercentX100: $sharePercentX100, ')
          ..write('fixedAmount: $fixedAmount, ')
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

class $StockTransactionsTable extends StockTransactions
    with TableInfo<$StockTransactionsTable, StockTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockTransactionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _componentIdMeta = const VerificationMeta(
    'componentId',
  );
  @override
  late final GeneratedColumn<String> componentId = GeneratedColumn<String>(
    'component_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES portfolio_components (id) ON DELETE CASCADE',
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
  static const VerificationMeta _tickerMeta = const VerificationMeta('ticker');
  @override
  late final GeneratedColumn<String> ticker = GeneratedColumn<String>(
    'ticker',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sideMeta = const VerificationMeta('side');
  @override
  late final GeneratedColumn<String> side = GeneratedColumn<String>(
    'side',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lotsMeta = const VerificationMeta('lots');
  @override
  late final GeneratedColumn<int> lots = GeneratedColumn<int>(
    'lots',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sharesMeta = const VerificationMeta('shares');
  @override
  late final GeneratedColumn<int> shares = GeneratedColumn<int>(
    'shares',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pricePerShareMeta = const VerificationMeta(
    'pricePerShare',
  );
  @override
  late final GeneratedColumn<int> pricePerShare = GeneratedColumn<int>(
    'price_per_share',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<int> totalAmount = GeneratedColumn<int>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<String> transactionDate = GeneratedColumn<String>(
    'transaction_date',
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
    defaultValue: const Constant('local_only'),
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
    componentId,
    portfolioId,
    ticker,
    side,
    lots,
    shares,
    pricePerShare,
    totalAmount,
    transactionDate,
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
  static const String $name = 'stock_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<StockTransaction> instance, {
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
    if (data.containsKey('component_id')) {
      context.handle(
        _componentIdMeta,
        componentId.isAcceptableOrUnknown(
          data['component_id']!,
          _componentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_componentIdMeta);
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
    if (data.containsKey('ticker')) {
      context.handle(
        _tickerMeta,
        ticker.isAcceptableOrUnknown(data['ticker']!, _tickerMeta),
      );
    } else if (isInserting) {
      context.missing(_tickerMeta);
    }
    if (data.containsKey('side')) {
      context.handle(
        _sideMeta,
        side.isAcceptableOrUnknown(data['side']!, _sideMeta),
      );
    } else if (isInserting) {
      context.missing(_sideMeta);
    }
    if (data.containsKey('lots')) {
      context.handle(
        _lotsMeta,
        lots.isAcceptableOrUnknown(data['lots']!, _lotsMeta),
      );
    } else if (isInserting) {
      context.missing(_lotsMeta);
    }
    if (data.containsKey('shares')) {
      context.handle(
        _sharesMeta,
        shares.isAcceptableOrUnknown(data['shares']!, _sharesMeta),
      );
    } else if (isInserting) {
      context.missing(_sharesMeta);
    }
    if (data.containsKey('price_per_share')) {
      context.handle(
        _pricePerShareMeta,
        pricePerShare.isAcceptableOrUnknown(
          data['price_per_share']!,
          _pricePerShareMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerShareMeta);
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAmountMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
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
  StockTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      componentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}component_id'],
      )!,
      portfolioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portfolio_id'],
      )!,
      ticker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticker'],
      )!,
      side: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}side'],
      )!,
      lots: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lots'],
      )!,
      shares: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}shares'],
      )!,
      pricePerShare: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}price_per_share'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_amount'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_date'],
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
  $StockTransactionsTable createAlias(String alias) {
    return $StockTransactionsTable(attachedDatabase, alias);
  }
}

class StockTransaction extends DataClass
    implements Insertable<StockTransaction> {
  final String id;
  final String ownerId;
  final String componentId;
  final String portfolioId;
  final String ticker;
  final String side;
  final int lots;
  final int shares;
  final int pricePerShare;
  final int totalAmount;
  final String transactionDate;
  final String? note;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const StockTransaction({
    required this.id,
    required this.ownerId,
    required this.componentId,
    required this.portfolioId,
    required this.ticker,
    required this.side,
    required this.lots,
    required this.shares,
    required this.pricePerShare,
    required this.totalAmount,
    required this.transactionDate,
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
    map['owner_id'] = Variable<String>(ownerId);
    map['component_id'] = Variable<String>(componentId);
    map['portfolio_id'] = Variable<String>(portfolioId);
    map['ticker'] = Variable<String>(ticker);
    map['side'] = Variable<String>(side);
    map['lots'] = Variable<int>(lots);
    map['shares'] = Variable<int>(shares);
    map['price_per_share'] = Variable<int>(pricePerShare);
    map['total_amount'] = Variable<int>(totalAmount);
    map['transaction_date'] = Variable<String>(transactionDate);
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

  StockTransactionsCompanion toCompanion(bool nullToAbsent) {
    return StockTransactionsCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      componentId: Value(componentId),
      portfolioId: Value(portfolioId),
      ticker: Value(ticker),
      side: Value(side),
      lots: Value(lots),
      shares: Value(shares),
      pricePerShare: Value(pricePerShare),
      totalAmount: Value(totalAmount),
      transactionDate: Value(transactionDate),
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

  factory StockTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockTransaction(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      componentId: serializer.fromJson<String>(json['componentId']),
      portfolioId: serializer.fromJson<String>(json['portfolioId']),
      ticker: serializer.fromJson<String>(json['ticker']),
      side: serializer.fromJson<String>(json['side']),
      lots: serializer.fromJson<int>(json['lots']),
      shares: serializer.fromJson<int>(json['shares']),
      pricePerShare: serializer.fromJson<int>(json['pricePerShare']),
      totalAmount: serializer.fromJson<int>(json['totalAmount']),
      transactionDate: serializer.fromJson<String>(json['transactionDate']),
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
      'ownerId': serializer.toJson<String>(ownerId),
      'componentId': serializer.toJson<String>(componentId),
      'portfolioId': serializer.toJson<String>(portfolioId),
      'ticker': serializer.toJson<String>(ticker),
      'side': serializer.toJson<String>(side),
      'lots': serializer.toJson<int>(lots),
      'shares': serializer.toJson<int>(shares),
      'pricePerShare': serializer.toJson<int>(pricePerShare),
      'totalAmount': serializer.toJson<int>(totalAmount),
      'transactionDate': serializer.toJson<String>(transactionDate),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  StockTransaction copyWith({
    String? id,
    String? ownerId,
    String? componentId,
    String? portfolioId,
    String? ticker,
    String? side,
    int? lots,
    int? shares,
    int? pricePerShare,
    int? totalAmount,
    String? transactionDate,
    Value<String?> note = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => StockTransaction(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    componentId: componentId ?? this.componentId,
    portfolioId: portfolioId ?? this.portfolioId,
    ticker: ticker ?? this.ticker,
    side: side ?? this.side,
    lots: lots ?? this.lots,
    shares: shares ?? this.shares,
    pricePerShare: pricePerShare ?? this.pricePerShare,
    totalAmount: totalAmount ?? this.totalAmount,
    transactionDate: transactionDate ?? this.transactionDate,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  StockTransaction copyWithCompanion(StockTransactionsCompanion data) {
    return StockTransaction(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      componentId: data.componentId.present
          ? data.componentId.value
          : this.componentId,
      portfolioId: data.portfolioId.present
          ? data.portfolioId.value
          : this.portfolioId,
      ticker: data.ticker.present ? data.ticker.value : this.ticker,
      side: data.side.present ? data.side.value : this.side,
      lots: data.lots.present ? data.lots.value : this.lots,
      shares: data.shares.present ? data.shares.value : this.shares,
      pricePerShare: data.pricePerShare.present
          ? data.pricePerShare.value
          : this.pricePerShare,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
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
    return (StringBuffer('StockTransaction(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('componentId: $componentId, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ticker: $ticker, ')
          ..write('side: $side, ')
          ..write('lots: $lots, ')
          ..write('shares: $shares, ')
          ..write('pricePerShare: $pricePerShare, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('transactionDate: $transactionDate, ')
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
    ownerId,
    componentId,
    portfolioId,
    ticker,
    side,
    lots,
    shares,
    pricePerShare,
    totalAmount,
    transactionDate,
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
      (other is StockTransaction &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.componentId == this.componentId &&
          other.portfolioId == this.portfolioId &&
          other.ticker == this.ticker &&
          other.side == this.side &&
          other.lots == this.lots &&
          other.shares == this.shares &&
          other.pricePerShare == this.pricePerShare &&
          other.totalAmount == this.totalAmount &&
          other.transactionDate == this.transactionDate &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class StockTransactionsCompanion extends UpdateCompanion<StockTransaction> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> componentId;
  final Value<String> portfolioId;
  final Value<String> ticker;
  final Value<String> side;
  final Value<int> lots;
  final Value<int> shares;
  final Value<int> pricePerShare;
  final Value<int> totalAmount;
  final Value<String> transactionDate;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const StockTransactionsCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.componentId = const Value.absent(),
    this.portfolioId = const Value.absent(),
    this.ticker = const Value.absent(),
    this.side = const Value.absent(),
    this.lots = const Value.absent(),
    this.shares = const Value.absent(),
    this.pricePerShare = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StockTransactionsCompanion.insert({
    required String id,
    required String ownerId,
    required String componentId,
    required String portfolioId,
    required String ticker,
    required String side,
    required int lots,
    required int shares,
    required int pricePerShare,
    required int totalAmount,
    required String transactionDate,
    this.note = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       componentId = Value(componentId),
       portfolioId = Value(portfolioId),
       ticker = Value(ticker),
       side = Value(side),
       lots = Value(lots),
       shares = Value(shares),
       pricePerShare = Value(pricePerShare),
       totalAmount = Value(totalAmount),
       transactionDate = Value(transactionDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StockTransaction> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? componentId,
    Expression<String>? portfolioId,
    Expression<String>? ticker,
    Expression<String>? side,
    Expression<int>? lots,
    Expression<int>? shares,
    Expression<int>? pricePerShare,
    Expression<int>? totalAmount,
    Expression<String>? transactionDate,
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
      if (ownerId != null) 'owner_id': ownerId,
      if (componentId != null) 'component_id': componentId,
      if (portfolioId != null) 'portfolio_id': portfolioId,
      if (ticker != null) 'ticker': ticker,
      if (side != null) 'side': side,
      if (lots != null) 'lots': lots,
      if (shares != null) 'shares': shares,
      if (pricePerShare != null) 'price_per_share': pricePerShare,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StockTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? componentId,
    Value<String>? portfolioId,
    Value<String>? ticker,
    Value<String>? side,
    Value<int>? lots,
    Value<int>? shares,
    Value<int>? pricePerShare,
    Value<int>? totalAmount,
    Value<String>? transactionDate,
    Value<String?>? note,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return StockTransactionsCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      componentId: componentId ?? this.componentId,
      portfolioId: portfolioId ?? this.portfolioId,
      ticker: ticker ?? this.ticker,
      side: side ?? this.side,
      lots: lots ?? this.lots,
      shares: shares ?? this.shares,
      pricePerShare: pricePerShare ?? this.pricePerShare,
      totalAmount: totalAmount ?? this.totalAmount,
      transactionDate: transactionDate ?? this.transactionDate,
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
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (componentId.present) {
      map['component_id'] = Variable<String>(componentId.value);
    }
    if (portfolioId.present) {
      map['portfolio_id'] = Variable<String>(portfolioId.value);
    }
    if (ticker.present) {
      map['ticker'] = Variable<String>(ticker.value);
    }
    if (side.present) {
      map['side'] = Variable<String>(side.value);
    }
    if (lots.present) {
      map['lots'] = Variable<int>(lots.value);
    }
    if (shares.present) {
      map['shares'] = Variable<int>(shares.value);
    }
    if (pricePerShare.present) {
      map['price_per_share'] = Variable<int>(pricePerShare.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<int>(totalAmount.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<String>(transactionDate.value);
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
    return (StringBuffer('StockTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('componentId: $componentId, ')
          ..write('portfolioId: $portfolioId, ')
          ..write('ticker: $ticker, ')
          ..write('side: $side, ')
          ..write('lots: $lots, ')
          ..write('shares: $shares, ')
          ..write('pricePerShare: $pricePerShare, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('transactionDate: $transactionDate, ')
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

class $CashFlowCategoriesTable extends CashFlowCategories
    with TableInfo<$CashFlowCategoriesTable, CashFlowCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashFlowCategoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('category'),
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
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
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
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    type,
    name,
    icon,
    color,
    isDefault,
    sortOrder,
    isHidden,
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
  static const String $name = 'cash_flow_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashFlowCategory> instance, {
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
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
  CashFlowCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashFlowCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isHidden: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_hidden'],
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
  $CashFlowCategoriesTable createAlias(String alias) {
    return $CashFlowCategoriesTable(attachedDatabase, alias);
  }
}

class CashFlowCategory extends DataClass
    implements Insertable<CashFlowCategory> {
  final String id;
  final String ownerId;
  final String type;
  final String name;
  final String icon;
  final int color;
  final bool isDefault;
  final int sortOrder;
  final bool isHidden;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const CashFlowCategory({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.name,
    required this.icon,
    required this.color,
    required this.isDefault,
    required this.sortOrder,
    required this.isHidden,
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
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<int>(color);
    map['is_default'] = Variable<bool>(isDefault);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_hidden'] = Variable<bool>(isHidden);
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

  CashFlowCategoriesCompanion toCompanion(bool nullToAbsent) {
    return CashFlowCategoriesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      type: Value(type),
      name: Value(name),
      icon: Value(icon),
      color: Value(color),
      isDefault: Value(isDefault),
      sortOrder: Value(sortOrder),
      isHidden: Value(isHidden),
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

  factory CashFlowCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashFlowCategory(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
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
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<int>(color),
      'isDefault': serializer.toJson<bool>(isDefault),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isHidden': serializer.toJson<bool>(isHidden),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  CashFlowCategory copyWith({
    String? id,
    String? ownerId,
    String? type,
    String? name,
    String? icon,
    int? color,
    bool? isDefault,
    int? sortOrder,
    bool? isHidden,
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => CashFlowCategory(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    type: type ?? this.type,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    isDefault: isDefault ?? this.isDefault,
    sortOrder: sortOrder ?? this.sortOrder,
    isHidden: isHidden ?? this.isHidden,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  CashFlowCategory copyWithCompanion(CashFlowCategoriesCompanion data) {
    return CashFlowCategory(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
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
    return (StringBuffer('CashFlowCategory(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('isDefault: $isDefault, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isHidden: $isHidden, ')
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
    type,
    name,
    icon,
    color,
    isDefault,
    sortOrder,
    isHidden,
    createdAt,
    updatedAt,
    syncStatus,
    remoteId,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashFlowCategory &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.type == this.type &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.isDefault == this.isDefault &&
          other.sortOrder == this.sortOrder &&
          other.isHidden == this.isHidden &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class CashFlowCategoriesCompanion extends UpdateCompanion<CashFlowCategory> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> type;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> color;
  final Value<bool> isDefault;
  final Value<int> sortOrder;
  final Value<bool> isHidden;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const CashFlowCategoriesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isHidden = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashFlowCategoriesCompanion.insert({
    required String id,
    required String ownerId,
    required String type,
    required String name,
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isHidden = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       type = Value(type),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CashFlowCategory> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? color,
    Expression<bool>? isDefault,
    Expression<int>? sortOrder,
    Expression<bool>? isHidden,
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
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (isDefault != null) 'is_default': isDefault,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isHidden != null) 'is_hidden': isHidden,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashFlowCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? type,
    Value<String>? name,
    Value<String>? icon,
    Value<int>? color,
    Value<bool>? isDefault,
    Value<int>? sortOrder,
    Value<bool>? isHidden,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CashFlowCategoriesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      type: type ?? this.type,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
      sortOrder: sortOrder ?? this.sortOrder,
      isHidden: isHidden ?? this.isHidden,
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
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
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
    return (StringBuffer('CashFlowCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('isDefault: $isDefault, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isHidden: $isHidden, ')
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

class $CashFlowTransactionsTable extends CashFlowTransactions
    with TableInfo<$CashFlowTransactionsTable, CashFlowTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashFlowTransactionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<String> transactionDate = GeneratedColumn<String>(
    'transaction_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cash_flow_categories (id)',
    ),
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
    ownerId,
    type,
    transactionDate,
    amount,
    categoryId,
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
  static const String $name = 'cash_flow_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CashFlowTransaction> instance, {
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
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
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
  CashFlowTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashFlowTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
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
  $CashFlowTransactionsTable createAlias(String alias) {
    return $CashFlowTransactionsTable(attachedDatabase, alias);
  }
}

class CashFlowTransaction extends DataClass
    implements Insertable<CashFlowTransaction> {
  final String id;
  final String ownerId;
  final String type;
  final String transactionDate;
  final int amount;
  final String categoryId;
  final String? note;
  final String createdAt;
  final String updatedAt;
  final String syncStatus;
  final String? remoteId;
  final String? deletedAt;
  const CashFlowTransaction({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.transactionDate,
    required this.amount,
    required this.categoryId,
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
    map['owner_id'] = Variable<String>(ownerId);
    map['type'] = Variable<String>(type);
    map['transaction_date'] = Variable<String>(transactionDate);
    map['amount'] = Variable<int>(amount);
    map['category_id'] = Variable<String>(categoryId);
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

  CashFlowTransactionsCompanion toCompanion(bool nullToAbsent) {
    return CashFlowTransactionsCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      type: Value(type),
      transactionDate: Value(transactionDate),
      amount: Value(amount),
      categoryId: Value(categoryId),
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

  factory CashFlowTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashFlowTransaction(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      type: serializer.fromJson<String>(json['type']),
      transactionDate: serializer.fromJson<String>(json['transactionDate']),
      amount: serializer.fromJson<int>(json['amount']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
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
      'ownerId': serializer.toJson<String>(ownerId),
      'type': serializer.toJson<String>(type),
      'transactionDate': serializer.toJson<String>(transactionDate),
      'amount': serializer.toJson<int>(amount),
      'categoryId': serializer.toJson<String>(categoryId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  CashFlowTransaction copyWith({
    String? id,
    String? ownerId,
    String? type,
    String? transactionDate,
    int? amount,
    String? categoryId,
    Value<String?> note = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    String? syncStatus,
    Value<String?> remoteId = const Value.absent(),
    Value<String?> deletedAt = const Value.absent(),
  }) => CashFlowTransaction(
    id: id ?? this.id,
    ownerId: ownerId ?? this.ownerId,
    type: type ?? this.type,
    transactionDate: transactionDate ?? this.transactionDate,
    amount: amount ?? this.amount,
    categoryId: categoryId ?? this.categoryId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  CashFlowTransaction copyWithCompanion(CashFlowTransactionsCompanion data) {
    return CashFlowTransaction(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      type: data.type.present ? data.type.value : this.type,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      amount: data.amount.present ? data.amount.value : this.amount,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
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
    return (StringBuffer('CashFlowTransaction(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('type: $type, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
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
    ownerId,
    type,
    transactionDate,
    amount,
    categoryId,
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
      (other is CashFlowTransaction &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.type == this.type &&
          other.transactionDate == this.transactionDate &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.deletedAt == this.deletedAt);
}

class CashFlowTransactionsCompanion
    extends UpdateCompanion<CashFlowTransaction> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> type;
  final Value<String> transactionDate;
  final Value<int> amount;
  final Value<String> categoryId;
  final Value<String?> note;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const CashFlowTransactionsCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.type = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CashFlowTransactionsCompanion.insert({
    required String id,
    required String ownerId,
    required String type,
    required String transactionDate,
    required int amount,
    required String categoryId,
    this.note = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerId = Value(ownerId),
       type = Value(type),
       transactionDate = Value(transactionDate),
       amount = Value(amount),
       categoryId = Value(categoryId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CashFlowTransaction> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? type,
    Expression<String>? transactionDate,
    Expression<int>? amount,
    Expression<String>? categoryId,
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
      if (ownerId != null) 'owner_id': ownerId,
      if (type != null) 'type': type,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CashFlowTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerId,
    Value<String>? type,
    Value<String>? transactionDate,
    Value<int>? amount,
    Value<String>? categoryId,
    Value<String?>? note,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String>? syncStatus,
    Value<String?>? remoteId,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return CashFlowTransactionsCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      type: type ?? this.type,
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
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
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<String>(transactionDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
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
    return (StringBuffer('CashFlowTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('type: $type, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $PortfoliosTable portfolios = $PortfoliosTable(this);
  late final $PortfolioComponentsTable portfolioComponents =
      $PortfolioComponentsTable(this);
  late final $ContributionsTable contributions = $ContributionsTable(this);
  late final $PlansTable plans = $PlansTable(this);
  late final $PlanAllocationsTable planAllocations = $PlanAllocationsTable(
    this,
  );
  late final $PriceReferencesTable priceReferences = $PriceReferencesTable(
    this,
  );
  late final $StockTransactionsTable stockTransactions =
      $StockTransactionsTable(this);
  late final $CashFlowCategoriesTable cashFlowCategories =
      $CashFlowCategoriesTable(this);
  late final $CashFlowTransactionsTable cashFlowTransactions =
      $CashFlowTransactionsTable(this);
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
    plans,
    planAllocations,
    priceReferences,
    stockTransactions,
    cashFlowCategories,
    cashFlowTransactions,
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
        'plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('plan_allocations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'portfolios',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('plan_allocations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'portfolio_components',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('stock_transactions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'portfolios',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('stock_transactions', kind: UpdateKind.delete)],
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

  static MultiTypedResultKey<$PlansTable, List<Plan>> _plansRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.plans,
    aliasName: 'user_profiles__id__plans__owner_id',
  );

  $$PlansTableProcessedTableManager get plansRefs {
    final manager = $$PlansTableTableManager(
      $_db,
      $_db.plans,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_plansRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PlanAllocationsTable, List<PlanAllocation>>
  _planAllocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.planAllocations,
    aliasName: 'user_profiles__id__plan_allocations__owner_id',
  );

  $$PlanAllocationsTableProcessedTableManager get planAllocationsRefs {
    final manager = $$PlanAllocationsTableTableManager(
      $_db,
      $_db.planAllocations,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _planAllocationsRefsTable($_db),
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

  static MultiTypedResultKey<$StockTransactionsTable, List<StockTransaction>>
  _stockTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.stockTransactions,
        aliasName: 'user_profiles__id__stock_transactions__owner_id',
      );

  $$StockTransactionsTableProcessedTableManager get stockTransactionsRefs {
    final manager = $$StockTransactionsTableTableManager(
      $_db,
      $_db.stockTransactions,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _stockTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CashFlowCategoriesTable, List<CashFlowCategory>>
  _cashFlowCategoriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cashFlowCategories,
        aliasName: 'user_profiles__id__cash_flow_categories__owner_id',
      );

  $$CashFlowCategoriesTableProcessedTableManager get cashFlowCategoriesRefs {
    final manager = $$CashFlowCategoriesTableTableManager(
      $_db,
      $_db.cashFlowCategories,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cashFlowCategoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CashFlowTransactionsTable,
    List<CashFlowTransaction>
  >
  _cashFlowTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cashFlowTransactions,
        aliasName: 'user_profiles__id__cash_flow_transactions__owner_id',
      );

  $$CashFlowTransactionsTableProcessedTableManager
  get cashFlowTransactionsRefs {
    final manager = $$CashFlowTransactionsTableTableManager(
      $_db,
      $_db.cashFlowTransactions,
    ).filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cashFlowTransactionsRefsTable($_db),
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

  Expression<bool> plansRefs(
    Expression<bool> Function($$PlansTableFilterComposer f) f,
  ) {
    final $$PlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableFilterComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> planAllocationsRefs(
    Expression<bool> Function($$PlanAllocationsTableFilterComposer f) f,
  ) {
    final $$PlanAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planAllocations,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.planAllocations,
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

  Expression<bool> stockTransactionsRefs(
    Expression<bool> Function($$StockTransactionsTableFilterComposer f) f,
  ) {
    final $$StockTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockTransactions,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.stockTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cashFlowCategoriesRefs(
    Expression<bool> Function($$CashFlowCategoriesTableFilterComposer f) f,
  ) {
    final $$CashFlowCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashFlowCategories,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.cashFlowCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cashFlowTransactionsRefs(
    Expression<bool> Function($$CashFlowTransactionsTableFilterComposer f) f,
  ) {
    final $$CashFlowTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashFlowTransactions,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.cashFlowTransactions,
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

  Expression<T> plansRefs<T extends Object>(
    Expression<T> Function($$PlansTableAnnotationComposer a) f,
  ) {
    final $$PlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableAnnotationComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> planAllocationsRefs<T extends Object>(
    Expression<T> Function($$PlanAllocationsTableAnnotationComposer a) f,
  ) {
    final $$PlanAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planAllocations,
      getReferencedColumn: (t) => t.ownerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.planAllocations,
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

  Expression<T> stockTransactionsRefs<T extends Object>(
    Expression<T> Function($$StockTransactionsTableAnnotationComposer a) f,
  ) {
    final $$StockTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.stockTransactions,
          getReferencedColumn: (t) => t.ownerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StockTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.stockTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> cashFlowCategoriesRefs<T extends Object>(
    Expression<T> Function($$CashFlowCategoriesTableAnnotationComposer a) f,
  ) {
    final $$CashFlowCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cashFlowCategories,
          getReferencedColumn: (t) => t.ownerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashFlowCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.cashFlowCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> cashFlowTransactionsRefs<T extends Object>(
    Expression<T> Function($$CashFlowTransactionsTableAnnotationComposer a) f,
  ) {
    final $$CashFlowTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cashFlowTransactions,
          getReferencedColumn: (t) => t.ownerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashFlowTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.cashFlowTransactions,
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
            bool plansRefs,
            bool planAllocationsRefs,
            bool priceReferencesRefs,
            bool stockTransactionsRefs,
            bool cashFlowCategoriesRefs,
            bool cashFlowTransactionsRefs,
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
                plansRefs = false,
                planAllocationsRefs = false,
                priceReferencesRefs = false,
                stockTransactionsRefs = false,
                cashFlowCategoriesRefs = false,
                cashFlowTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (settingsRefs) db.settings,
                    if (portfoliosRefs) db.portfolios,
                    if (portfolioComponentsRefs) db.portfolioComponents,
                    if (contributionsRefs) db.contributions,
                    if (plansRefs) db.plans,
                    if (planAllocationsRefs) db.planAllocations,
                    if (priceReferencesRefs) db.priceReferences,
                    if (stockTransactionsRefs) db.stockTransactions,
                    if (cashFlowCategoriesRefs) db.cashFlowCategories,
                    if (cashFlowTransactionsRefs) db.cashFlowTransactions,
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
                      if (plansRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          Plan,
                          $PlansTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._plansRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).plansRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (planAllocationsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          PlanAllocation,
                          $PlanAllocationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._planAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).planAllocationsRefs,
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
                      if (stockTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          StockTransaction,
                          $StockTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._stockTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).stockTransactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (cashFlowCategoriesRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          CashFlowCategory,
                          $CashFlowCategoriesTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._cashFlowCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).cashFlowCategoriesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'owner_id',
                          typedResults: items,
                        ),
                      if (cashFlowTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          UserProfile,
                          $UserProfilesTable,
                          CashFlowTransaction,
                          $CashFlowTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$UserProfilesTableReferences
                              ._cashFlowTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).cashFlowTransactionsRefs,
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
        bool plansRefs,
        bool planAllocationsRefs,
        bool priceReferencesRefs,
        bool stockTransactionsRefs,
        bool cashFlowCategoriesRefs,
        bool cashFlowTransactionsRefs,
      })
    >;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String id,
  required String ownerId,
  Value<int?> monthlySalary,
  Value<int?> minimumLivingCost,
  Value<int?> currentLivingCost,
  Value<double> defaultAnnualReturnPct,
  Value<bool> planLimitEnabled,
  Value<int?> planLimitAmount,
  Value<bool> onboardingDone,
  Value<int> seedVersion,
  Value<String> componentInputMode,
  Value<String?> quoteCardDismissedMonth,
  Value<bool> reminderMonthlyEnabled,
  Value<int> reminderMonthlyDay,
  Value<int> reminderMonthlyHour,
  Value<int> reminderMonthlyMinute,
  Value<bool> reminderExpenseEnabled,
  Value<int> reminderExpenseHour,
  Value<int> reminderExpenseMinute,
  Value<bool> reminderMilestoneEnabled,
  Value<bool> hideAmounts,
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
  Value<bool> planLimitEnabled,
  Value<int?> planLimitAmount,
  Value<bool> onboardingDone,
  Value<int> seedVersion,
  Value<String> componentInputMode,
  Value<String?> quoteCardDismissedMonth,
  Value<bool> reminderMonthlyEnabled,
  Value<int> reminderMonthlyDay,
  Value<int> reminderMonthlyHour,
  Value<int> reminderMonthlyMinute,
  Value<bool> reminderExpenseEnabled,
  Value<int> reminderExpenseHour,
  Value<int> reminderExpenseMinute,
  Value<bool> reminderMilestoneEnabled,
  Value<bool> hideAmounts,
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

  ColumnFilters<bool> get planLimitEnabled => $composableBuilder(
    column: $table.planLimitEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get planLimitAmount => $composableBuilder(
    column: $table.planLimitAmount,
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

  ColumnFilters<String> get componentInputMode => $composableBuilder(
    column: $table.componentInputMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteCardDismissedMonth => $composableBuilder(
    column: $table.quoteCardDismissedMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderMonthlyEnabled => $composableBuilder(
    column: $table.reminderMonthlyEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMonthlyDay => $composableBuilder(
    column: $table.reminderMonthlyDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMonthlyHour => $composableBuilder(
    column: $table.reminderMonthlyHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMonthlyMinute => $composableBuilder(
    column: $table.reminderMonthlyMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderExpenseEnabled => $composableBuilder(
    column: $table.reminderExpenseEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderExpenseHour => $composableBuilder(
    column: $table.reminderExpenseHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderExpenseMinute => $composableBuilder(
    column: $table.reminderExpenseMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderMilestoneEnabled => $composableBuilder(
    column: $table.reminderMilestoneEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
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

  ColumnOrderings<bool> get planLimitEnabled => $composableBuilder(
    column: $table.planLimitEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get planLimitAmount => $composableBuilder(
    column: $table.planLimitAmount,
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

  ColumnOrderings<String> get componentInputMode => $composableBuilder(
    column: $table.componentInputMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteCardDismissedMonth => $composableBuilder(
    column: $table.quoteCardDismissedMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderMonthlyEnabled => $composableBuilder(
    column: $table.reminderMonthlyEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMonthlyDay => $composableBuilder(
    column: $table.reminderMonthlyDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMonthlyHour => $composableBuilder(
    column: $table.reminderMonthlyHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMonthlyMinute => $composableBuilder(
    column: $table.reminderMonthlyMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderExpenseEnabled => $composableBuilder(
    column: $table.reminderExpenseEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderExpenseHour => $composableBuilder(
    column: $table.reminderExpenseHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderExpenseMinute => $composableBuilder(
    column: $table.reminderExpenseMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderMilestoneEnabled => $composableBuilder(
    column: $table.reminderMilestoneEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
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

  GeneratedColumn<bool> get planLimitEnabled => $composableBuilder(
    column: $table.planLimitEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get planLimitAmount => $composableBuilder(
    column: $table.planLimitAmount,
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

  GeneratedColumn<String> get componentInputMode => $composableBuilder(
    column: $table.componentInputMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quoteCardDismissedMonth => $composableBuilder(
    column: $table.quoteCardDismissedMonth,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderMonthlyEnabled => $composableBuilder(
    column: $table.reminderMonthlyEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMonthlyDay => $composableBuilder(
    column: $table.reminderMonthlyDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMonthlyHour => $composableBuilder(
    column: $table.reminderMonthlyHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMonthlyMinute => $composableBuilder(
    column: $table.reminderMonthlyMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderExpenseEnabled => $composableBuilder(
    column: $table.reminderExpenseEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderExpenseHour => $composableBuilder(
    column: $table.reminderExpenseHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderExpenseMinute => $composableBuilder(
    column: $table.reminderExpenseMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderMilestoneEnabled => $composableBuilder(
    column: $table.reminderMilestoneEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hideAmounts => $composableBuilder(
    column: $table.hideAmounts,
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
                Value<bool> planLimitEnabled = const Value.absent(),
                Value<int?> planLimitAmount = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<int> seedVersion = const Value.absent(),
                Value<String> componentInputMode = const Value.absent(),
                Value<String?> quoteCardDismissedMonth = const Value.absent(),
                Value<bool> reminderMonthlyEnabled = const Value.absent(),
                Value<int> reminderMonthlyDay = const Value.absent(),
                Value<int> reminderMonthlyHour = const Value.absent(),
                Value<int> reminderMonthlyMinute = const Value.absent(),
                Value<bool> reminderExpenseEnabled = const Value.absent(),
                Value<int> reminderExpenseHour = const Value.absent(),
                Value<int> reminderExpenseMinute = const Value.absent(),
                Value<bool> reminderMilestoneEnabled = const Value.absent(),
                Value<bool> hideAmounts = const Value.absent(),
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
                planLimitEnabled: planLimitEnabled,
                planLimitAmount: planLimitAmount,
                onboardingDone: onboardingDone,
                seedVersion: seedVersion,
                componentInputMode: componentInputMode,
                quoteCardDismissedMonth: quoteCardDismissedMonth,
                reminderMonthlyEnabled: reminderMonthlyEnabled,
                reminderMonthlyDay: reminderMonthlyDay,
                reminderMonthlyHour: reminderMonthlyHour,
                reminderMonthlyMinute: reminderMonthlyMinute,
                reminderExpenseEnabled: reminderExpenseEnabled,
                reminderExpenseHour: reminderExpenseHour,
                reminderExpenseMinute: reminderExpenseMinute,
                reminderMilestoneEnabled: reminderMilestoneEnabled,
                hideAmounts: hideAmounts,
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
                Value<bool> planLimitEnabled = const Value.absent(),
                Value<int?> planLimitAmount = const Value.absent(),
                Value<bool> onboardingDone = const Value.absent(),
                Value<int> seedVersion = const Value.absent(),
                Value<String> componentInputMode = const Value.absent(),
                Value<String?> quoteCardDismissedMonth = const Value.absent(),
                Value<bool> reminderMonthlyEnabled = const Value.absent(),
                Value<int> reminderMonthlyDay = const Value.absent(),
                Value<int> reminderMonthlyHour = const Value.absent(),
                Value<int> reminderMonthlyMinute = const Value.absent(),
                Value<bool> reminderExpenseEnabled = const Value.absent(),
                Value<int> reminderExpenseHour = const Value.absent(),
                Value<int> reminderExpenseMinute = const Value.absent(),
                Value<bool> reminderMilestoneEnabled = const Value.absent(),
                Value<bool> hideAmounts = const Value.absent(),
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
                planLimitEnabled: planLimitEnabled,
                planLimitAmount: planLimitAmount,
                onboardingDone: onboardingDone,
                seedVersion: seedVersion,
                componentInputMode: componentInputMode,
                quoteCardDismissedMonth: quoteCardDismissedMonth,
                reminderMonthlyEnabled: reminderMonthlyEnabled,
                reminderMonthlyDay: reminderMonthlyDay,
                reminderMonthlyHour: reminderMonthlyHour,
                reminderMonthlyMinute: reminderMonthlyMinute,
                reminderExpenseEnabled: reminderExpenseEnabled,
                reminderExpenseHour: reminderExpenseHour,
                reminderExpenseMinute: reminderExpenseMinute,
                reminderMilestoneEnabled: reminderMilestoneEnabled,
                hideAmounts: hideAmounts,
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

  static MultiTypedResultKey<$PlanAllocationsTable, List<PlanAllocation>>
  _planAllocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.planAllocations,
    aliasName: 'portfolios__id__plan_allocations__portfolio_id',
  );

  $$PlanAllocationsTableProcessedTableManager get planAllocationsRefs {
    final manager = $$PlanAllocationsTableTableManager(
      $_db,
      $_db.planAllocations,
    ).filter((f) => f.portfolioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _planAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StockTransactionsTable, List<StockTransaction>>
  _stockTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.stockTransactions,
        aliasName: 'portfolios__id__stock_transactions__portfolio_id',
      );

  $$StockTransactionsTableProcessedTableManager get stockTransactionsRefs {
    final manager = $$StockTransactionsTableTableManager(
      $_db,
      $_db.stockTransactions,
    ).filter((f) => f.portfolioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _stockTransactionsRefsTable($_db),
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

  Expression<bool> planAllocationsRefs(
    Expression<bool> Function($$PlanAllocationsTableFilterComposer f) f,
  ) {
    final $$PlanAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planAllocations,
      getReferencedColumn: (t) => t.portfolioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.planAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockTransactionsRefs(
    Expression<bool> Function($$StockTransactionsTableFilterComposer f) f,
  ) {
    final $$StockTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockTransactions,
      getReferencedColumn: (t) => t.portfolioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.stockTransactions,
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

  Expression<T> planAllocationsRefs<T extends Object>(
    Expression<T> Function($$PlanAllocationsTableAnnotationComposer a) f,
  ) {
    final $$PlanAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planAllocations,
      getReferencedColumn: (t) => t.portfolioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.planAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockTransactionsRefs<T extends Object>(
    Expression<T> Function($$StockTransactionsTableAnnotationComposer a) f,
  ) {
    final $$StockTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.stockTransactions,
          getReferencedColumn: (t) => t.portfolioId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StockTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.stockTransactions,
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
            bool planAllocationsRefs,
            bool stockTransactionsRefs,
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
                planAllocationsRefs = false,
                stockTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (portfolioComponentsRefs) db.portfolioComponents,
                    if (contributionsRefs) db.contributions,
                    if (planAllocationsRefs) db.planAllocations,
                    if (stockTransactionsRefs) db.stockTransactions,
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
                      if (planAllocationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Portfolio,
                          $PortfoliosTable,
                          PlanAllocation,
                          $PlanAllocationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PortfoliosTableReferences
                              ._planAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PortfoliosTableReferences(
                                db,
                                table,
                                p0,
                              ).planAllocationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'portfolio_id',
                          typedResults: items,
                        ),
                      if (stockTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Portfolio,
                          $PortfoliosTable,
                          StockTransaction,
                          $StockTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PortfoliosTableReferences
                              ._stockTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PortfoliosTableReferences(
                                db,
                                table,
                                p0,
                              ).stockTransactionsRefs,
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
        bool planAllocationsRefs,
        bool stockTransactionsRefs,
      })
    >;
typedef $$PortfolioComponentsTableCreateCompanionBuilder =
    PortfolioComponentsCompanion Function({
      required String id,
      required String portfolioId,
      required String ownerId,
      required String instrumentType,
      Value<String?> name,
      Value<double> targetPercent,
      Value<int> actualAmount,
      Value<String> mechanism,
      Value<int> legacyOpeningAmount,
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
      Value<double> targetPercent,
      Value<int> actualAmount,
      Value<String> mechanism,
      Value<int> legacyOpeningAmount,
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

  static MultiTypedResultKey<$StockTransactionsTable, List<StockTransaction>>
  _stockTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.stockTransactions,
        aliasName: 'portfolio_components__id__stock_transactions__component_id',
      );

  $$StockTransactionsTableProcessedTableManager get stockTransactionsRefs {
    final manager = $$StockTransactionsTableTableManager(
      $_db,
      $_db.stockTransactions,
    ).filter((f) => f.componentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _stockTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
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

  ColumnFilters<double> get targetPercent => $composableBuilder(
    column: $table.targetPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualAmount => $composableBuilder(
    column: $table.actualAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mechanism => $composableBuilder(
    column: $table.mechanism,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get legacyOpeningAmount => $composableBuilder(
    column: $table.legacyOpeningAmount,
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

  Expression<bool> stockTransactionsRefs(
    Expression<bool> Function($$StockTransactionsTableFilterComposer f) f,
  ) {
    final $$StockTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockTransactions,
      getReferencedColumn: (t) => t.componentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StockTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.stockTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
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

  ColumnOrderings<double> get targetPercent => $composableBuilder(
    column: $table.targetPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualAmount => $composableBuilder(
    column: $table.actualAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mechanism => $composableBuilder(
    column: $table.mechanism,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get legacyOpeningAmount => $composableBuilder(
    column: $table.legacyOpeningAmount,
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

  GeneratedColumn<double> get targetPercent => $composableBuilder(
    column: $table.targetPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualAmount => $composableBuilder(
    column: $table.actualAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mechanism =>
      $composableBuilder(column: $table.mechanism, builder: (column) => column);

  GeneratedColumn<int> get legacyOpeningAmount => $composableBuilder(
    column: $table.legacyOpeningAmount,
    builder: (column) => column,
  );

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

  Expression<T> stockTransactionsRefs<T extends Object>(
    Expression<T> Function($$StockTransactionsTableAnnotationComposer a) f,
  ) {
    final $$StockTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.stockTransactions,
          getReferencedColumn: (t) => t.componentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$StockTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.stockTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
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
          PrefetchHooks Function({
            bool portfolioId,
            bool ownerId,
            bool stockTransactionsRefs,
          })
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
                Value<double> targetPercent = const Value.absent(),
                Value<int> actualAmount = const Value.absent(),
                Value<String> mechanism = const Value.absent(),
                Value<int> legacyOpeningAmount = const Value.absent(),
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
                targetPercent: targetPercent,
                actualAmount: actualAmount,
                mechanism: mechanism,
                legacyOpeningAmount: legacyOpeningAmount,
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
                Value<double> targetPercent = const Value.absent(),
                Value<int> actualAmount = const Value.absent(),
                Value<String> mechanism = const Value.absent(),
                Value<int> legacyOpeningAmount = const Value.absent(),
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
                targetPercent: targetPercent,
                actualAmount: actualAmount,
                mechanism: mechanism,
                legacyOpeningAmount: legacyOpeningAmount,
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
          prefetchHooksCallback:
              ({
                portfolioId = false,
                ownerId = false,
                stockTransactionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (stockTransactionsRefs) db.stockTransactions,
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
                        if (portfolioId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.portfolioId,
                            referencedTable:
                                $$PortfolioComponentsTableReferences
                                    ._portfolioIdTable(db),
                            referencedColumn:
                                $$PortfolioComponentsTableReferences
                                    ._portfolioIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (ownerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerId,
                            referencedTable:
                                $$PortfolioComponentsTableReferences
                                    ._ownerIdTable(db),
                            referencedColumn:
                                $$PortfolioComponentsTableReferences
                                    ._ownerIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (stockTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          PortfolioComponent,
                          $PortfolioComponentsTable,
                          StockTransaction,
                          $StockTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PortfolioComponentsTableReferences
                              ._stockTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PortfolioComponentsTableReferences(
                                db,
                                table,
                                p0,
                              ).stockTransactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'component_id',
                          typedResults: items,
                        ),
                    ];
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
      PrefetchHooks Function({
        bool portfolioId,
        bool ownerId,
        bool stockTransactionsRefs,
      })
    >;
typedef $$ContributionsTableCreateCompanionBuilder =
    ContributionsCompanion Function({
      required String id,
      required String portfolioId,
      required String ownerId,
      required int amount,
      required String date,
      Value<String?> note,
      Value<String?> componentId,
      Value<String?> stockTransactionId,
      Value<String> source,
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
      Value<String?> componentId,
      Value<String?> stockTransactionId,
      Value<String> source,
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

  ColumnFilters<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stockTransactionId => $composableBuilder(
    column: $table.stockTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
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

  ColumnOrderings<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stockTransactionId => $composableBuilder(
    column: $table.stockTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
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

  GeneratedColumn<String> get componentId => $composableBuilder(
    column: $table.componentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stockTransactionId => $composableBuilder(
    column: $table.stockTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

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
                Value<String?> componentId = const Value.absent(),
                Value<String?> stockTransactionId = const Value.absent(),
                Value<String> source = const Value.absent(),
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
                componentId: componentId,
                stockTransactionId: stockTransactionId,
                source: source,
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
                Value<String?> componentId = const Value.absent(),
                Value<String?> stockTransactionId = const Value.absent(),
                Value<String> source = const Value.absent(),
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
                componentId: componentId,
                stockTransactionId: stockTransactionId,
                source: source,
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
typedef $$PlansTableCreateCompanionBuilder = PlansCompanion Function({
  required String id,
  required String ownerId,
  required String name,
  Value<String?> description,
  Value<int> totalAmount,
  Value<bool> isActive,
  Value<int> sortOrder,
  required String createdAt,
  required String updatedAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<String?> deletedAt,
  Value<int> rowid,
});
typedef $$PlansTableUpdateCompanionBuilder = PlansCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> name,
  Value<String?> description,
  Value<int> totalAmount,
  Value<bool> isActive,
  Value<int> sortOrder,
  Value<String> createdAt,
  Value<String> updatedAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<String?> deletedAt,
  Value<int> rowid,
});

final class $$PlansTableReferences
    extends BaseReferences<_$AppDatabase, $PlansTable, Plan> {
  $$PlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) =>
      db.userProfiles.createAlias('plans__owner_id__user_profiles__id');

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

  static MultiTypedResultKey<$PlanAllocationsTable, List<PlanAllocation>>
  _planAllocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.planAllocations,
    aliasName: 'plans__id__plan_allocations__plan_id',
  );

  $$PlanAllocationsTableProcessedTableManager get planAllocationsRefs {
    final manager = $$PlanAllocationsTableTableManager(
      $_db,
      $_db.planAllocations,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _planAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlansTableFilterComposer extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableFilterComposer({
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

  ColumnFilters<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
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

  Expression<bool> planAllocationsRefs(
    Expression<bool> Function($$PlanAllocationsTableFilterComposer f) f,
  ) {
    final $$PlanAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planAllocations,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.planAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlansTableOrderingComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableOrderingComposer({
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

  ColumnOrderings<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
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

class $$PlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableAnnotationComposer({
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

  GeneratedColumn<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
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

  Expression<T> planAllocationsRefs<T extends Object>(
    Expression<T> Function($$PlanAllocationsTableAnnotationComposer a) f,
  ) {
    final $$PlanAllocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planAllocations,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanAllocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.planAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlansTable,
          Plan,
          $$PlansTableFilterComposer,
          $$PlansTableOrderingComposer,
          $$PlansTableAnnotationComposer,
          $$PlansTableCreateCompanionBuilder,
          $$PlansTableUpdateCompanionBuilder,
          (Plan, $$PlansTableReferences),
          Plan,
          PrefetchHooks Function({bool ownerId, bool planAllocationsRefs})
        > {
  $$PlansTableTableManager(_$AppDatabase db, $PlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> totalAmount = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlansCompanion(
                id: id,
                ownerId: ownerId,
                name: name,
                description: description,
                totalAmount: totalAmount,
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
                Value<int> totalAmount = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlansCompanion.insert(
                id: id,
                ownerId: ownerId,
                name: name,
                description: description,
                totalAmount: totalAmount,
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
                  e.readTable<$PlansTable, Plan>(table),
                  $$PlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ownerId = false, planAllocationsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (planAllocationsRefs) db.planAllocations,
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
                            referencedTable: $$PlansTableReferences
                                ._ownerIdTable(db),
                            referencedColumn: $$PlansTableReferences
                                ._ownerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (planAllocationsRefs)
                        await $_getPrefetchedDataByColumns<
                          Plan,
                          $PlansTable,
                          PlanAllocation,
                          $PlanAllocationsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PlansTableReferences
                              ._planAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlansTableReferences(
                                db,
                                table,
                                p0,
                              ).planAllocationsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'plan_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlansTable,
      Plan,
      $$PlansTableFilterComposer,
      $$PlansTableOrderingComposer,
      $$PlansTableAnnotationComposer,
      $$PlansTableCreateCompanionBuilder,
      $$PlansTableUpdateCompanionBuilder,
      (Plan, $$PlansTableReferences),
      Plan,
      PrefetchHooks Function({bool ownerId, bool planAllocationsRefs})
    >;
typedef $$PlanAllocationsTableCreateCompanionBuilder =
    PlanAllocationsCompanion Function({
      required String id,
      required String planId,
      required String portfolioId,
      required String ownerId,
      Value<int> sharePercentX100,
      Value<int?> fixedAmount,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$PlanAllocationsTableUpdateCompanionBuilder =
    PlanAllocationsCompanion Function({
      Value<String> id,
      Value<String> planId,
      Value<String> portfolioId,
      Value<String> ownerId,
      Value<int> sharePercentX100,
      Value<int?> fixedAmount,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$PlanAllocationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $PlanAllocationsTable, PlanAllocation> {
  $$PlanAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlansTable _planIdTable(_$AppDatabase db) =>
      db.plans.createAlias('plan_allocations__plan_id__plans__id');

  $$PlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$PlansTableTableManager(
      $_db,
      $_db.plans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PortfoliosTable _portfolioIdTable(_$AppDatabase db) => db.portfolios
      .createAlias('plan_allocations__portfolio_id__portfolios__id');

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
      .createAlias('plan_allocations__owner_id__user_profiles__id');

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

class $$PlanAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $PlanAllocationsTable> {
  $$PlanAllocationsTableFilterComposer({
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

  ColumnFilters<int> get sharePercentX100 => $composableBuilder(
    column: $table.sharePercentX100,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fixedAmount => $composableBuilder(
    column: $table.fixedAmount,
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

  $$PlansTableFilterComposer get planId {
    final $$PlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableFilterComposer(
            $db: $db,
            $table: $db.plans,
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

class $$PlanAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanAllocationsTable> {
  $$PlanAllocationsTableOrderingComposer({
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

  ColumnOrderings<int> get sharePercentX100 => $composableBuilder(
    column: $table.sharePercentX100,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fixedAmount => $composableBuilder(
    column: $table.fixedAmount,
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

  $$PlansTableOrderingComposer get planId {
    final $$PlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableOrderingComposer(
            $db: $db,
            $table: $db.plans,
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

class $$PlanAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanAllocationsTable> {
  $$PlanAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sharePercentX100 => $composableBuilder(
    column: $table.sharePercentX100,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fixedAmount => $composableBuilder(
    column: $table.fixedAmount,
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

  $$PlansTableAnnotationComposer get planId {
    final $$PlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableAnnotationComposer(
            $db: $db,
            $table: $db.plans,
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

class $$PlanAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanAllocationsTable,
          PlanAllocation,
          $$PlanAllocationsTableFilterComposer,
          $$PlanAllocationsTableOrderingComposer,
          $$PlanAllocationsTableAnnotationComposer,
          $$PlanAllocationsTableCreateCompanionBuilder,
          $$PlanAllocationsTableUpdateCompanionBuilder,
          (PlanAllocation, $$PlanAllocationsTableReferences),
          PlanAllocation,
          PrefetchHooks Function({bool planId, bool portfolioId, bool ownerId})
        > {
  $$PlanAllocationsTableTableManager(
    _$AppDatabase db,
    $PlanAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanAllocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String> portfolioId = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<int> sharePercentX100 = const Value.absent(),
                Value<int?> fixedAmount = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanAllocationsCompanion(
                id: id,
                planId: planId,
                portfolioId: portfolioId,
                ownerId: ownerId,
                sharePercentX100: sharePercentX100,
                fixedAmount: fixedAmount,
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
                required String planId,
                required String portfolioId,
                required String ownerId,
                Value<int> sharePercentX100 = const Value.absent(),
                Value<int?> fixedAmount = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlanAllocationsCompanion.insert(
                id: id,
                planId: planId,
                portfolioId: portfolioId,
                ownerId: ownerId,
                sharePercentX100: sharePercentX100,
                fixedAmount: fixedAmount,
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
                  e.readTable<$PlanAllocationsTable, PlanAllocation>(table),
                  $$PlanAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({planId = false, portfolioId = false, ownerId = false}) {
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
                        if (planId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.planId,
                            referencedTable: $$PlanAllocationsTableReferences
                                ._planIdTable(db),
                            referencedColumn: $$PlanAllocationsTableReferences
                                ._planIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (portfolioId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.portfolioId,
                            referencedTable: $$PlanAllocationsTableReferences
                                ._portfolioIdTable(db),
                            referencedColumn: $$PlanAllocationsTableReferences
                                ._portfolioIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (ownerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.ownerId,
                            referencedTable: $$PlanAllocationsTableReferences
                                ._ownerIdTable(db),
                            referencedColumn: $$PlanAllocationsTableReferences
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

typedef $$PlanAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanAllocationsTable,
      PlanAllocation,
      $$PlanAllocationsTableFilterComposer,
      $$PlanAllocationsTableOrderingComposer,
      $$PlanAllocationsTableAnnotationComposer,
      $$PlanAllocationsTableCreateCompanionBuilder,
      $$PlanAllocationsTableUpdateCompanionBuilder,
      (PlanAllocation, $$PlanAllocationsTableReferences),
      PlanAllocation,
      PrefetchHooks Function({bool planId, bool portfolioId, bool ownerId})
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
typedef $$StockTransactionsTableCreateCompanionBuilder =
    StockTransactionsCompanion Function({
      required String id,
      required String ownerId,
      required String componentId,
      required String portfolioId,
      required String ticker,
      required String side,
      required int lots,
      required int shares,
      required int pricePerShare,
      required int totalAmount,
      required String transactionDate,
      Value<String?> note,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$StockTransactionsTableUpdateCompanionBuilder =
    StockTransactionsCompanion Function({
      Value<String> id,
      Value<String> ownerId,
      Value<String> componentId,
      Value<String> portfolioId,
      Value<String> ticker,
      Value<String> side,
      Value<int> lots,
      Value<int> shares,
      Value<int> pricePerShare,
      Value<int> totalAmount,
      Value<String> transactionDate,
      Value<String?> note,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$StockTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $StockTransactionsTable,
          StockTransaction
        > {
  $$StockTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('stock_transactions__owner_id__user_profiles__id');

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

  static $PortfolioComponentsTable _componentIdTable(_$AppDatabase db) =>
      db.portfolioComponents.createAlias(
        'stock_transactions__component_id__portfolio_components__id',
      );

  $$PortfolioComponentsTableProcessedTableManager get componentId {
    final $_column = $_itemColumn<String>('component_id')!;

    final manager = $$PortfolioComponentsTableTableManager(
      $_db,
      $_db.portfolioComponents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_componentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PortfoliosTable _portfolioIdTable(_$AppDatabase db) => db.portfolios
      .createAlias('stock_transactions__portfolio_id__portfolios__id');

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
}

class $$StockTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $StockTransactionsTable> {
  $$StockTransactionsTableFilterComposer({
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

  ColumnFilters<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lots => $composableBuilder(
    column: $table.lots,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pricePerShare => $composableBuilder(
    column: $table.pricePerShare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
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

  $$PortfolioComponentsTableFilterComposer get componentId {
    final $$PortfolioComponentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.componentId,
      referencedTable: $db.portfolioComponents,
      getReferencedColumn: (t) => t.id,
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
}

class $$StockTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $StockTransactionsTable> {
  $$StockTransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get ticker => $composableBuilder(
    column: $table.ticker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lots => $composableBuilder(
    column: $table.lots,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shares => $composableBuilder(
    column: $table.shares,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pricePerShare => $composableBuilder(
    column: $table.pricePerShare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
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

  $$PortfolioComponentsTableOrderingComposer get componentId {
    final $$PortfolioComponentsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.componentId,
          referencedTable: $db.portfolioComponents,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PortfolioComponentsTableOrderingComposer(
                $db: $db,
                $table: $db.portfolioComponents,
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
}

class $$StockTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StockTransactionsTable> {
  $$StockTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ticker =>
      $composableBuilder(column: $table.ticker, builder: (column) => column);

  GeneratedColumn<String> get side =>
      $composableBuilder(column: $table.side, builder: (column) => column);

  GeneratedColumn<int> get lots =>
      $composableBuilder(column: $table.lots, builder: (column) => column);

  GeneratedColumn<int> get shares =>
      $composableBuilder(column: $table.shares, builder: (column) => column);

  GeneratedColumn<int> get pricePerShare => $composableBuilder(
    column: $table.pricePerShare,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

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

  $$PortfolioComponentsTableAnnotationComposer get componentId {
    final $$PortfolioComponentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.componentId,
          referencedTable: $db.portfolioComponents,
          getReferencedColumn: (t) => t.id,
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
}

class $$StockTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockTransactionsTable,
          StockTransaction,
          $$StockTransactionsTableFilterComposer,
          $$StockTransactionsTableOrderingComposer,
          $$StockTransactionsTableAnnotationComposer,
          $$StockTransactionsTableCreateCompanionBuilder,
          $$StockTransactionsTableUpdateCompanionBuilder,
          (StockTransaction, $$StockTransactionsTableReferences),
          StockTransaction,
          PrefetchHooks Function({
            bool ownerId,
            bool componentId,
            bool portfolioId,
          })
        > {
  $$StockTransactionsTableTableManager(
    _$AppDatabase db,
    $StockTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StockTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StockTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StockTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> componentId = const Value.absent(),
                Value<String> portfolioId = const Value.absent(),
                Value<String> ticker = const Value.absent(),
                Value<String> side = const Value.absent(),
                Value<int> lots = const Value.absent(),
                Value<int> shares = const Value.absent(),
                Value<int> pricePerShare = const Value.absent(),
                Value<int> totalAmount = const Value.absent(),
                Value<String> transactionDate = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockTransactionsCompanion(
                id: id,
                ownerId: ownerId,
                componentId: componentId,
                portfolioId: portfolioId,
                ticker: ticker,
                side: side,
                lots: lots,
                shares: shares,
                pricePerShare: pricePerShare,
                totalAmount: totalAmount,
                transactionDate: transactionDate,
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
                required String ownerId,
                required String componentId,
                required String portfolioId,
                required String ticker,
                required String side,
                required int lots,
                required int shares,
                required int pricePerShare,
                required int totalAmount,
                required String transactionDate,
                Value<String?> note = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StockTransactionsCompanion.insert(
                id: id,
                ownerId: ownerId,
                componentId: componentId,
                portfolioId: portfolioId,
                ticker: ticker,
                side: side,
                lots: lots,
                shares: shares,
                pricePerShare: pricePerShare,
                totalAmount: totalAmount,
                transactionDate: transactionDate,
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
                  e.readTable<$StockTransactionsTable, StockTransaction>(table),
                  $$StockTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ownerId = false, componentId = false, portfolioId = false}) {
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
                            referencedTable: $$StockTransactionsTableReferences
                                ._ownerIdTable(db),
                            referencedColumn: $$StockTransactionsTableReferences
                                ._ownerIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (componentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.componentId,
                            referencedTable: $$StockTransactionsTableReferences
                                ._componentIdTable(db),
                            referencedColumn: $$StockTransactionsTableReferences
                                ._componentIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (portfolioId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.portfolioId,
                            referencedTable: $$StockTransactionsTableReferences
                                ._portfolioIdTable(db),
                            referencedColumn: $$StockTransactionsTableReferences
                                ._portfolioIdTable(db)
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

typedef $$StockTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockTransactionsTable,
      StockTransaction,
      $$StockTransactionsTableFilterComposer,
      $$StockTransactionsTableOrderingComposer,
      $$StockTransactionsTableAnnotationComposer,
      $$StockTransactionsTableCreateCompanionBuilder,
      $$StockTransactionsTableUpdateCompanionBuilder,
      (StockTransaction, $$StockTransactionsTableReferences),
      StockTransaction,
      PrefetchHooks Function({bool ownerId, bool componentId, bool portfolioId})
    >;
typedef $$CashFlowCategoriesTableCreateCompanionBuilder =
    CashFlowCategoriesCompanion Function({
      required String id,
      required String ownerId,
      required String type,
      required String name,
      Value<String> icon,
      Value<int> color,
      Value<bool> isDefault,
      Value<int> sortOrder,
      Value<bool> isHidden,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$CashFlowCategoriesTableUpdateCompanionBuilder =
    CashFlowCategoriesCompanion Function({
      Value<String> id,
      Value<String> ownerId,
      Value<String> type,
      Value<String> name,
      Value<String> icon,
      Value<int> color,
      Value<bool> isDefault,
      Value<int> sortOrder,
      Value<bool> isHidden,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$CashFlowCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CashFlowCategoriesTable,
          CashFlowCategory
        > {
  $$CashFlowCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('cash_flow_categories__owner_id__user_profiles__id');

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
    $CashFlowTransactionsTable,
    List<CashFlowTransaction>
  >
  _cashFlowTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cashFlowTransactions,
        aliasName:
            'cash_flow_categories__id__cash_flow_transactions__category_id',
      );

  $$CashFlowTransactionsTableProcessedTableManager
  get cashFlowTransactionsRefs {
    final manager = $$CashFlowTransactionsTableTableManager(
      $_db,
      $_db.cashFlowTransactions,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cashFlowTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CashFlowCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CashFlowCategoriesTable> {
  $$CashFlowCategoriesTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
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

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
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

  Expression<bool> cashFlowTransactionsRefs(
    Expression<bool> Function($$CashFlowTransactionsTableFilterComposer f) f,
  ) {
    final $$CashFlowTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashFlowTransactions,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.cashFlowTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CashFlowCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CashFlowCategoriesTable> {
  $$CashFlowCategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
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

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
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

class $$CashFlowCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashFlowCategoriesTable> {
  $$CashFlowCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);

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

  Expression<T> cashFlowTransactionsRefs<T extends Object>(
    Expression<T> Function($$CashFlowTransactionsTableAnnotationComposer a) f,
  ) {
    final $$CashFlowTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cashFlowTransactions,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashFlowTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.cashFlowTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CashFlowCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashFlowCategoriesTable,
          CashFlowCategory,
          $$CashFlowCategoriesTableFilterComposer,
          $$CashFlowCategoriesTableOrderingComposer,
          $$CashFlowCategoriesTableAnnotationComposer,
          $$CashFlowCategoriesTableCreateCompanionBuilder,
          $$CashFlowCategoriesTableUpdateCompanionBuilder,
          (CashFlowCategory, $$CashFlowCategoriesTableReferences),
          CashFlowCategory,
          PrefetchHooks Function({bool ownerId, bool cashFlowTransactionsRefs})
        > {
  $$CashFlowCategoriesTableTableManager(
    _$AppDatabase db,
    $CashFlowCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashFlowCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashFlowCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CashFlowCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashFlowCategoriesCompanion(
                id: id,
                ownerId: ownerId,
                type: type,
                name: name,
                icon: icon,
                color: color,
                isDefault: isDefault,
                sortOrder: sortOrder,
                isHidden: isHidden,
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
                required String type,
                required String name,
                Value<String> icon = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isHidden = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashFlowCategoriesCompanion.insert(
                id: id,
                ownerId: ownerId,
                type: type,
                name: name,
                icon: icon,
                color: color,
                isDefault: isDefault,
                sortOrder: sortOrder,
                isHidden: isHidden,
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
                  e.readTable<$CashFlowCategoriesTable, CashFlowCategory>(
                    table,
                  ),
                  $$CashFlowCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({ownerId = false, cashFlowTransactionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cashFlowTransactionsRefs) db.cashFlowTransactions,
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
                            referencedTable: $$CashFlowCategoriesTableReferences
                                ._ownerIdTable(db),
                            referencedColumn:
                                $$CashFlowCategoriesTableReferences
                                    ._ownerIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cashFlowTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          CashFlowCategory,
                          $CashFlowCategoriesTable,
                          CashFlowTransaction,
                          $CashFlowTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$CashFlowCategoriesTableReferences
                              ._cashFlowTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CashFlowCategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).cashFlowTransactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'category_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CashFlowCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashFlowCategoriesTable,
      CashFlowCategory,
      $$CashFlowCategoriesTableFilterComposer,
      $$CashFlowCategoriesTableOrderingComposer,
      $$CashFlowCategoriesTableAnnotationComposer,
      $$CashFlowCategoriesTableCreateCompanionBuilder,
      $$CashFlowCategoriesTableUpdateCompanionBuilder,
      (CashFlowCategory, $$CashFlowCategoriesTableReferences),
      CashFlowCategory,
      PrefetchHooks Function({bool ownerId, bool cashFlowTransactionsRefs})
    >;
typedef $$CashFlowTransactionsTableCreateCompanionBuilder =
    CashFlowTransactionsCompanion Function({
      required String id,
      required String ownerId,
      required String type,
      required String transactionDate,
      required int amount,
      required String categoryId,
      Value<String?> note,
      required String createdAt,
      required String updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$CashFlowTransactionsTableUpdateCompanionBuilder =
    CashFlowTransactionsCompanion Function({
      Value<String> id,
      Value<String> ownerId,
      Value<String> type,
      Value<String> transactionDate,
      Value<int> amount,
      Value<String> categoryId,
      Value<String?> note,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String> syncStatus,
      Value<String?> remoteId,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$CashFlowTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CashFlowTransactionsTable,
          CashFlowTransaction
        > {
  $$CashFlowTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserProfilesTable _ownerIdTable(_$AppDatabase db) => db.userProfiles
      .createAlias('cash_flow_transactions__owner_id__user_profiles__id');

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

  static $CashFlowCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.cashFlowCategories.createAlias(
        'cash_flow_transactions__category_id__cash_flow_categories__id',
      );

  $$CashFlowCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CashFlowCategoriesTableTableManager(
      $_db,
      $_db.cashFlowCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CashFlowTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $CashFlowTransactionsTable> {
  $$CashFlowTransactionsTableFilterComposer({
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

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
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

  $$CashFlowCategoriesTableFilterComposer get categoryId {
    final $$CashFlowCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.cashFlowCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.cashFlowCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashFlowTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CashFlowTransactionsTable> {
  $$CashFlowTransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
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

  $$CashFlowCategoriesTableOrderingComposer get categoryId {
    final $$CashFlowCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.cashFlowCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CashFlowCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.cashFlowCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashFlowTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CashFlowTransactionsTable> {
  $$CashFlowTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

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

  $$CashFlowCategoriesTableAnnotationComposer get categoryId {
    final $$CashFlowCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.cashFlowCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CashFlowCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.cashFlowCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CashFlowTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashFlowTransactionsTable,
          CashFlowTransaction,
          $$CashFlowTransactionsTableFilterComposer,
          $$CashFlowTransactionsTableOrderingComposer,
          $$CashFlowTransactionsTableAnnotationComposer,
          $$CashFlowTransactionsTableCreateCompanionBuilder,
          $$CashFlowTransactionsTableUpdateCompanionBuilder,
          (CashFlowTransaction, $$CashFlowTransactionsTableReferences),
          CashFlowTransaction,
          PrefetchHooks Function({bool ownerId, bool categoryId})
        > {
  $$CashFlowTransactionsTableTableManager(
    _$AppDatabase db,
    $CashFlowTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CashFlowTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CashFlowTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CashFlowTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> transactionDate = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashFlowTransactionsCompanion(
                id: id,
                ownerId: ownerId,
                type: type,
                transactionDate: transactionDate,
                amount: amount,
                categoryId: categoryId,
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
                required String ownerId,
                required String type,
                required String transactionDate,
                required int amount,
                required String categoryId,
                Value<String?> note = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CashFlowTransactionsCompanion.insert(
                id: id,
                ownerId: ownerId,
                type: type,
                transactionDate: transactionDate,
                amount: amount,
                categoryId: categoryId,
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
                  e.readTable<$CashFlowTransactionsTable, CashFlowTransaction>(
                    table,
                  ),
                  $$CashFlowTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ownerId = false, categoryId = false}) {
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
                        referencedTable: $$CashFlowTransactionsTableReferences
                            ._ownerIdTable(db),
                        referencedColumn: $$CashFlowTransactionsTableReferences
                            ._ownerIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$CashFlowTransactionsTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$CashFlowTransactionsTableReferences
                            ._categoryIdTable(db)
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

typedef $$CashFlowTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashFlowTransactionsTable,
      CashFlowTransaction,
      $$CashFlowTransactionsTableFilterComposer,
      $$CashFlowTransactionsTableOrderingComposer,
      $$CashFlowTransactionsTableAnnotationComposer,
      $$CashFlowTransactionsTableCreateCompanionBuilder,
      $$CashFlowTransactionsTableUpdateCompanionBuilder,
      (CashFlowTransaction, $$CashFlowTransactionsTableReferences),
      CashFlowTransaction,
      PrefetchHooks Function({bool ownerId, bool categoryId})
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
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
  $$PlanAllocationsTableTableManager get planAllocations =>
      $$PlanAllocationsTableTableManager(_db, _db.planAllocations);
  $$PriceReferencesTableTableManager get priceReferences =>
      $$PriceReferencesTableTableManager(_db, _db.priceReferences);
  $$StockTransactionsTableTableManager get stockTransactions =>
      $$StockTransactionsTableTableManager(_db, _db.stockTransactions);
  $$CashFlowCategoriesTableTableManager get cashFlowCategories =>
      $$CashFlowCategoriesTableTableManager(_db, _db.cashFlowCategories);
  $$CashFlowTransactionsTableTableManager get cashFlowTransactions =>
      $$CashFlowTransactionsTableTableManager(_db, _db.cashFlowTransactions);
}
