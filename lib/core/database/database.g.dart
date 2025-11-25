// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _passwordHashMeta =
      const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
      'password_hash', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fullNameArMeta =
      const VerificationMeta('fullNameAr');
  @override
  late final GeneratedColumn<String> fullNameAr = GeneratedColumn<String>(
      'full_name_ar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nationalIdMeta =
      const VerificationMeta('nationalId');
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
      'national_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _logoUrlMeta =
      const VerificationMeta('logoUrl');
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
      'logo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        username,
        passwordHash,
        email,
        fullName,
        fullNameAr,
        phone,
        nationalId,
        role,
        logoUrl,
        address,
        createdAt,
        updatedAt,
        isActive,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
          _passwordHashMeta,
          passwordHash.isAcceptableOrUnknown(
              data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('full_name_ar')) {
      context.handle(
          _fullNameArMeta,
          fullNameAr.isAcceptableOrUnknown(
              data['full_name_ar']!, _fullNameArMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('national_id')) {
      context.handle(
          _nationalIdMeta,
          nationalId.isAcceptableOrUnknown(
              data['national_id']!, _nationalIdMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('logo_url')) {
      context.handle(_logoUrlMeta,
          logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      passwordHash: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      fullNameAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name_ar']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      nationalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}national_id']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      logoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_url']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String username;
  final String passwordHash;
  final String email;
  final String fullName;
  final String? fullNameAr;
  final String? phone;
  final String? nationalId;
  final String role;
  final String? logoUrl;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final String syncStatus;
  const User(
      {required this.id,
      required this.username,
      required this.passwordHash,
      required this.email,
      required this.fullName,
      this.fullNameAr,
      this.phone,
      this.nationalId,
      required this.role,
      this.logoUrl,
      this.address,
      required this.createdAt,
      required this.updatedAt,
      required this.isActive,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['password_hash'] = Variable<String>(passwordHash);
    map['email'] = Variable<String>(email);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || fullNameAr != null) {
      map['full_name_ar'] = Variable<String>(fullNameAr);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || nationalId != null) {
      map['national_id'] = Variable<String>(nationalId);
    }
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_active'] = Variable<bool>(isActive);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      passwordHash: Value(passwordHash),
      email: Value(email),
      fullName: Value(fullName),
      fullNameAr: fullNameAr == null && nullToAbsent
          ? const Value.absent()
          : Value(fullNameAr),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      nationalId: nationalId == null && nullToAbsent
          ? const Value.absent()
          : Value(nationalId),
      role: Value(role),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      isActive: Value(isActive),
      syncStatus: Value(syncStatus),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      email: serializer.fromJson<String>(json['email']),
      fullName: serializer.fromJson<String>(json['fullName']),
      fullNameAr: serializer.fromJson<String?>(json['fullNameAr']),
      phone: serializer.fromJson<String?>(json['phone']),
      nationalId: serializer.fromJson<String?>(json['nationalId']),
      role: serializer.fromJson<String>(json['role']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'email': serializer.toJson<String>(email),
      'fullName': serializer.toJson<String>(fullName),
      'fullNameAr': serializer.toJson<String?>(fullNameAr),
      'phone': serializer.toJson<String?>(phone),
      'nationalId': serializer.toJson<String?>(nationalId),
      'role': serializer.toJson<String>(role),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isActive': serializer.toJson<bool>(isActive),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  User copyWith(
          {String? id,
          String? username,
          String? passwordHash,
          String? email,
          String? fullName,
          Value<String?> fullNameAr = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> nationalId = const Value.absent(),
          String? role,
          Value<String?> logoUrl = const Value.absent(),
          Value<String?> address = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          bool? isActive,
          String? syncStatus}) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        passwordHash: passwordHash ?? this.passwordHash,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        fullNameAr: fullNameAr.present ? fullNameAr.value : this.fullNameAr,
        phone: phone.present ? phone.value : this.phone,
        nationalId: nationalId.present ? nationalId.value : this.nationalId,
        role: role ?? this.role,
        logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
        address: address.present ? address.value : this.address,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isActive: isActive ?? this.isActive,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      email: data.email.present ? data.email.value : this.email,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      fullNameAr:
          data.fullNameAr.present ? data.fullNameAr.value : this.fullNameAr,
      phone: data.phone.present ? data.phone.value : this.phone,
      nationalId:
          data.nationalId.present ? data.nationalId.value : this.nationalId,
      role: data.role.present ? data.role.value : this.role,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('email: $email, ')
          ..write('fullName: $fullName, ')
          ..write('fullNameAr: $fullNameAr, ')
          ..write('phone: $phone, ')
          ..write('nationalId: $nationalId, ')
          ..write('role: $role, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      username,
      passwordHash,
      email,
      fullName,
      fullNameAr,
      phone,
      nationalId,
      role,
      logoUrl,
      address,
      createdAt,
      updatedAt,
      isActive,
      syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.passwordHash == this.passwordHash &&
          other.email == this.email &&
          other.fullName == this.fullName &&
          other.fullNameAr == this.fullNameAr &&
          other.phone == this.phone &&
          other.nationalId == this.nationalId &&
          other.role == this.role &&
          other.logoUrl == this.logoUrl &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isActive == this.isActive &&
          other.syncStatus == this.syncStatus);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> username;
  final Value<String> passwordHash;
  final Value<String> email;
  final Value<String> fullName;
  final Value<String?> fullNameAr;
  final Value<String?> phone;
  final Value<String?> nationalId;
  final Value<String> role;
  final Value<String?> logoUrl;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> isActive;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.email = const Value.absent(),
    this.fullName = const Value.absent(),
    this.fullNameAr = const Value.absent(),
    this.phone = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.role = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String username,
    required String passwordHash,
    required String email,
    required String fullName,
    this.fullNameAr = const Value.absent(),
    this.phone = const Value.absent(),
    this.nationalId = const Value.absent(),
    required String role,
    this.logoUrl = const Value.absent(),
    this.address = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.isActive = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        username = Value(username),
        passwordHash = Value(passwordHash),
        email = Value(email),
        fullName = Value(fullName),
        role = Value(role),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<String>? passwordHash,
    Expression<String>? email,
    Expression<String>? fullName,
    Expression<String>? fullNameAr,
    Expression<String>? phone,
    Expression<String>? nationalId,
    Expression<String>? role,
    Expression<String>? logoUrl,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isActive,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (email != null) 'email': email,
      if (fullName != null) 'full_name': fullName,
      if (fullNameAr != null) 'full_name_ar': fullNameAr,
      if (phone != null) 'phone': phone,
      if (nationalId != null) 'national_id': nationalId,
      if (role != null) 'role': role,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isActive != null) 'is_active': isActive,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? username,
      Value<String>? passwordHash,
      Value<String>? email,
      Value<String>? fullName,
      Value<String?>? fullNameAr,
      Value<String?>? phone,
      Value<String?>? nationalId,
      Value<String>? role,
      Value<String?>? logoUrl,
      Value<String?>? address,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<bool>? isActive,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      fullNameAr: fullNameAr ?? this.fullNameAr,
      phone: phone ?? this.phone,
      nationalId: nationalId ?? this.nationalId,
      role: role ?? this.role,
      logoUrl: logoUrl ?? this.logoUrl,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (fullNameAr.present) {
      map['full_name_ar'] = Variable<String>(fullNameAr.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('email: $email, ')
          ..write('fullName: $fullName, ')
          ..write('fullNameAr: $fullNameAr, ')
          ..write('phone: $phone, ')
          ..write('nationalId: $nationalId, ')
          ..write('role: $role, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PropertiesTable extends Properties
    with TableInfo<$PropertiesTable, Property> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleArMeta =
      const VerificationMeta('titleAr');
  @override
  late final GeneratedColumn<String> titleAr = GeneratedColumn<String>(
      'title_ar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionArMeta =
      const VerificationMeta('descriptionAr');
  @override
  late final GeneratedColumn<String> descriptionAr = GeneratedColumn<String>(
      'description_ar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _propertyTypeMeta =
      const VerificationMeta('propertyType');
  @override
  late final GeneratedColumn<String> propertyType = GeneratedColumn<String>(
      'property_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _propertyCategoryMeta =
      const VerificationMeta('propertyCategory');
  @override
  late final GeneratedColumn<String> propertyCategory = GeneratedColumn<String>(
      'property_category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _listingTypeMeta =
      const VerificationMeta('listingType');
  @override
  late final GeneratedColumn<String> listingType = GeneratedColumn<String>(
      'listing_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<double> area = GeneratedColumn<double>(
      'area', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _bedroomsMeta =
      const VerificationMeta('bedrooms');
  @override
  late final GeneratedColumn<int> bedrooms = GeneratedColumn<int>(
      'bedrooms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _bathroomsMeta =
      const VerificationMeta('bathrooms');
  @override
  late final GeneratedColumn<int> bathrooms = GeneratedColumn<int>(
      'bathrooms', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryMeta =
      const VerificationMeta('country');
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
      'country', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('available'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        ownerId,
        title,
        titleAr,
        description,
        descriptionAr,
        propertyType,
        propertyCategory,
        listingType,
        price,
        area,
        bedrooms,
        bathrooms,
        address,
        city,
        country,
        latitude,
        longitude,
        status,
        createdAt,
        updatedAt,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'properties';
  @override
  VerificationContext validateIntegrity(Insertable<Property> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('title_ar')) {
      context.handle(_titleArMeta,
          titleAr.isAcceptableOrUnknown(data['title_ar']!, _titleArMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('description_ar')) {
      context.handle(
          _descriptionArMeta,
          descriptionAr.isAcceptableOrUnknown(
              data['description_ar']!, _descriptionArMeta));
    }
    if (data.containsKey('property_type')) {
      context.handle(
          _propertyTypeMeta,
          propertyType.isAcceptableOrUnknown(
              data['property_type']!, _propertyTypeMeta));
    } else if (isInserting) {
      context.missing(_propertyTypeMeta);
    }
    if (data.containsKey('property_category')) {
      context.handle(
          _propertyCategoryMeta,
          propertyCategory.isAcceptableOrUnknown(
              data['property_category']!, _propertyCategoryMeta));
    }
    if (data.containsKey('listing_type')) {
      context.handle(
          _listingTypeMeta,
          listingType.isAcceptableOrUnknown(
              data['listing_type']!, _listingTypeMeta));
    } else if (isInserting) {
      context.missing(_listingTypeMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
          _areaMeta, area.isAcceptableOrUnknown(data['area']!, _areaMeta));
    } else if (isInserting) {
      context.missing(_areaMeta);
    }
    if (data.containsKey('bedrooms')) {
      context.handle(_bedroomsMeta,
          bedrooms.isAcceptableOrUnknown(data['bedrooms']!, _bedroomsMeta));
    }
    if (data.containsKey('bathrooms')) {
      context.handle(_bathroomsMeta,
          bathrooms.isAcceptableOrUnknown(data['bathrooms']!, _bathroomsMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('country')) {
      context.handle(_countryMeta,
          country.isAcceptableOrUnknown(data['country']!, _countryMeta));
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Property map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Property(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      titleAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title_ar']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      descriptionAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description_ar']),
      propertyType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}property_type'])!,
      propertyCategory: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}property_category']),
      listingType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}listing_type'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      area: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}area'])!,
      bedrooms: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bedrooms']),
      bathrooms: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}bathrooms']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      country: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $PropertiesTable createAlias(String alias) {
    return $PropertiesTable(attachedDatabase, alias);
  }
}

class Property extends DataClass implements Insertable<Property> {
  final String id;
  final String ownerId;
  final String title;
  final String? titleAr;
  final String? description;
  final String? descriptionAr;
  final String propertyType;
  final String? propertyCategory;
  final String listingType;
  final double price;
  final double area;
  final int? bedrooms;
  final int? bathrooms;
  final String address;
  final String city;
  final String country;
  final double? latitude;
  final double? longitude;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const Property(
      {required this.id,
      required this.ownerId,
      required this.title,
      this.titleAr,
      this.description,
      this.descriptionAr,
      required this.propertyType,
      this.propertyCategory,
      required this.listingType,
      required this.price,
      required this.area,
      this.bedrooms,
      this.bathrooms,
      required this.address,
      required this.city,
      required this.country,
      this.latitude,
      this.longitude,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_id'] = Variable<String>(ownerId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || titleAr != null) {
      map['title_ar'] = Variable<String>(titleAr);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || descriptionAr != null) {
      map['description_ar'] = Variable<String>(descriptionAr);
    }
    map['property_type'] = Variable<String>(propertyType);
    if (!nullToAbsent || propertyCategory != null) {
      map['property_category'] = Variable<String>(propertyCategory);
    }
    map['listing_type'] = Variable<String>(listingType);
    map['price'] = Variable<double>(price);
    map['area'] = Variable<double>(area);
    if (!nullToAbsent || bedrooms != null) {
      map['bedrooms'] = Variable<int>(bedrooms);
    }
    if (!nullToAbsent || bathrooms != null) {
      map['bathrooms'] = Variable<int>(bathrooms);
    }
    map['address'] = Variable<String>(address);
    map['city'] = Variable<String>(city);
    map['country'] = Variable<String>(country);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  PropertiesCompanion toCompanion(bool nullToAbsent) {
    return PropertiesCompanion(
      id: Value(id),
      ownerId: Value(ownerId),
      title: Value(title),
      titleAr: titleAr == null && nullToAbsent
          ? const Value.absent()
          : Value(titleAr),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      descriptionAr: descriptionAr == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionAr),
      propertyType: Value(propertyType),
      propertyCategory: propertyCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(propertyCategory),
      listingType: Value(listingType),
      price: Value(price),
      area: Value(area),
      bedrooms: bedrooms == null && nullToAbsent
          ? const Value.absent()
          : Value(bedrooms),
      bathrooms: bathrooms == null && nullToAbsent
          ? const Value.absent()
          : Value(bathrooms),
      address: Value(address),
      city: Value(city),
      country: Value(country),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Property.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Property(
      id: serializer.fromJson<String>(json['id']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      title: serializer.fromJson<String>(json['title']),
      titleAr: serializer.fromJson<String?>(json['titleAr']),
      description: serializer.fromJson<String?>(json['description']),
      descriptionAr: serializer.fromJson<String?>(json['descriptionAr']),
      propertyType: serializer.fromJson<String>(json['propertyType']),
      propertyCategory: serializer.fromJson<String?>(json['propertyCategory']),
      listingType: serializer.fromJson<String>(json['listingType']),
      price: serializer.fromJson<double>(json['price']),
      area: serializer.fromJson<double>(json['area']),
      bedrooms: serializer.fromJson<int?>(json['bedrooms']),
      bathrooms: serializer.fromJson<int?>(json['bathrooms']),
      address: serializer.fromJson<String>(json['address']),
      city: serializer.fromJson<String>(json['city']),
      country: serializer.fromJson<String>(json['country']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerId': serializer.toJson<String>(ownerId),
      'title': serializer.toJson<String>(title),
      'titleAr': serializer.toJson<String?>(titleAr),
      'description': serializer.toJson<String?>(description),
      'descriptionAr': serializer.toJson<String?>(descriptionAr),
      'propertyType': serializer.toJson<String>(propertyType),
      'propertyCategory': serializer.toJson<String?>(propertyCategory),
      'listingType': serializer.toJson<String>(listingType),
      'price': serializer.toJson<double>(price),
      'area': serializer.toJson<double>(area),
      'bedrooms': serializer.toJson<int?>(bedrooms),
      'bathrooms': serializer.toJson<int?>(bathrooms),
      'address': serializer.toJson<String>(address),
      'city': serializer.toJson<String>(city),
      'country': serializer.toJson<String>(country),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Property copyWith(
          {String? id,
          String? ownerId,
          String? title,
          Value<String?> titleAr = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> descriptionAr = const Value.absent(),
          String? propertyType,
          Value<String?> propertyCategory = const Value.absent(),
          String? listingType,
          double? price,
          double? area,
          Value<int?> bedrooms = const Value.absent(),
          Value<int?> bathrooms = const Value.absent(),
          String? address,
          String? city,
          String? country,
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncStatus}) =>
      Property(
        id: id ?? this.id,
        ownerId: ownerId ?? this.ownerId,
        title: title ?? this.title,
        titleAr: titleAr.present ? titleAr.value : this.titleAr,
        description: description.present ? description.value : this.description,
        descriptionAr:
            descriptionAr.present ? descriptionAr.value : this.descriptionAr,
        propertyType: propertyType ?? this.propertyType,
        propertyCategory: propertyCategory.present
            ? propertyCategory.value
            : this.propertyCategory,
        listingType: listingType ?? this.listingType,
        price: price ?? this.price,
        area: area ?? this.area,
        bedrooms: bedrooms.present ? bedrooms.value : this.bedrooms,
        bathrooms: bathrooms.present ? bathrooms.value : this.bathrooms,
        address: address ?? this.address,
        city: city ?? this.city,
        country: country ?? this.country,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  Property copyWithCompanion(PropertiesCompanion data) {
    return Property(
      id: data.id.present ? data.id.value : this.id,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      title: data.title.present ? data.title.value : this.title,
      titleAr: data.titleAr.present ? data.titleAr.value : this.titleAr,
      description:
          data.description.present ? data.description.value : this.description,
      descriptionAr: data.descriptionAr.present
          ? data.descriptionAr.value
          : this.descriptionAr,
      propertyType: data.propertyType.present
          ? data.propertyType.value
          : this.propertyType,
      propertyCategory: data.propertyCategory.present
          ? data.propertyCategory.value
          : this.propertyCategory,
      listingType:
          data.listingType.present ? data.listingType.value : this.listingType,
      price: data.price.present ? data.price.value : this.price,
      area: data.area.present ? data.area.value : this.area,
      bedrooms: data.bedrooms.present ? data.bedrooms.value : this.bedrooms,
      bathrooms: data.bathrooms.present ? data.bathrooms.value : this.bathrooms,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      country: data.country.present ? data.country.value : this.country,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Property(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('title: $title, ')
          ..write('titleAr: $titleAr, ')
          ..write('description: $description, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('propertyType: $propertyType, ')
          ..write('propertyCategory: $propertyCategory, ')
          ..write('listingType: $listingType, ')
          ..write('price: $price, ')
          ..write('area: $area, ')
          ..write('bedrooms: $bedrooms, ')
          ..write('bathrooms: $bathrooms, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        ownerId,
        title,
        titleAr,
        description,
        descriptionAr,
        propertyType,
        propertyCategory,
        listingType,
        price,
        area,
        bedrooms,
        bathrooms,
        address,
        city,
        country,
        latitude,
        longitude,
        status,
        createdAt,
        updatedAt,
        syncStatus
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Property &&
          other.id == this.id &&
          other.ownerId == this.ownerId &&
          other.title == this.title &&
          other.titleAr == this.titleAr &&
          other.description == this.description &&
          other.descriptionAr == this.descriptionAr &&
          other.propertyType == this.propertyType &&
          other.propertyCategory == this.propertyCategory &&
          other.listingType == this.listingType &&
          other.price == this.price &&
          other.area == this.area &&
          other.bedrooms == this.bedrooms &&
          other.bathrooms == this.bathrooms &&
          other.address == this.address &&
          other.city == this.city &&
          other.country == this.country &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class PropertiesCompanion extends UpdateCompanion<Property> {
  final Value<String> id;
  final Value<String> ownerId;
  final Value<String> title;
  final Value<String?> titleAr;
  final Value<String?> description;
  final Value<String?> descriptionAr;
  final Value<String> propertyType;
  final Value<String?> propertyCategory;
  final Value<String> listingType;
  final Value<double> price;
  final Value<double> area;
  final Value<int?> bedrooms;
  final Value<int?> bathrooms;
  final Value<String> address;
  final Value<String> city;
  final Value<String> country;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const PropertiesCompanion({
    this.id = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.title = const Value.absent(),
    this.titleAr = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionAr = const Value.absent(),
    this.propertyType = const Value.absent(),
    this.propertyCategory = const Value.absent(),
    this.listingType = const Value.absent(),
    this.price = const Value.absent(),
    this.area = const Value.absent(),
    this.bedrooms = const Value.absent(),
    this.bathrooms = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.country = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PropertiesCompanion.insert({
    required String id,
    required String ownerId,
    required String title,
    this.titleAr = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionAr = const Value.absent(),
    required String propertyType,
    this.propertyCategory = const Value.absent(),
    required String listingType,
    required double price,
    required double area,
    this.bedrooms = const Value.absent(),
    this.bathrooms = const Value.absent(),
    required String address,
    required String city,
    required String country,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        ownerId = Value(ownerId),
        title = Value(title),
        propertyType = Value(propertyType),
        listingType = Value(listingType),
        price = Value(price),
        area = Value(area),
        address = Value(address),
        city = Value(city),
        country = Value(country),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Property> custom({
    Expression<String>? id,
    Expression<String>? ownerId,
    Expression<String>? title,
    Expression<String>? titleAr,
    Expression<String>? description,
    Expression<String>? descriptionAr,
    Expression<String>? propertyType,
    Expression<String>? propertyCategory,
    Expression<String>? listingType,
    Expression<double>? price,
    Expression<double>? area,
    Expression<int>? bedrooms,
    Expression<int>? bathrooms,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? country,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerId != null) 'owner_id': ownerId,
      if (title != null) 'title': title,
      if (titleAr != null) 'title_ar': titleAr,
      if (description != null) 'description': description,
      if (descriptionAr != null) 'description_ar': descriptionAr,
      if (propertyType != null) 'property_type': propertyType,
      if (propertyCategory != null) 'property_category': propertyCategory,
      if (listingType != null) 'listing_type': listingType,
      if (price != null) 'price': price,
      if (area != null) 'area': area,
      if (bedrooms != null) 'bedrooms': bedrooms,
      if (bathrooms != null) 'bathrooms': bathrooms,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PropertiesCompanion copyWith(
      {Value<String>? id,
      Value<String>? ownerId,
      Value<String>? title,
      Value<String?>? titleAr,
      Value<String?>? description,
      Value<String?>? descriptionAr,
      Value<String>? propertyType,
      Value<String?>? propertyCategory,
      Value<String>? listingType,
      Value<double>? price,
      Value<double>? area,
      Value<int?>? bedrooms,
      Value<int?>? bathrooms,
      Value<String>? address,
      Value<String>? city,
      Value<String>? country,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return PropertiesCompanion(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      propertyType: propertyType ?? this.propertyType,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      listingType: listingType ?? this.listingType,
      price: price ?? this.price,
      area: area ?? this.area,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (titleAr.present) {
      map['title_ar'] = Variable<String>(titleAr.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (descriptionAr.present) {
      map['description_ar'] = Variable<String>(descriptionAr.value);
    }
    if (propertyType.present) {
      map['property_type'] = Variable<String>(propertyType.value);
    }
    if (propertyCategory.present) {
      map['property_category'] = Variable<String>(propertyCategory.value);
    }
    if (listingType.present) {
      map['listing_type'] = Variable<String>(listingType.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (area.present) {
      map['area'] = Variable<double>(area.value);
    }
    if (bedrooms.present) {
      map['bedrooms'] = Variable<int>(bedrooms.value);
    }
    if (bathrooms.present) {
      map['bathrooms'] = Variable<int>(bathrooms.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertiesCompanion(')
          ..write('id: $id, ')
          ..write('ownerId: $ownerId, ')
          ..write('title: $title, ')
          ..write('titleAr: $titleAr, ')
          ..write('description: $description, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('propertyType: $propertyType, ')
          ..write('propertyCategory: $propertyCategory, ')
          ..write('listingType: $listingType, ')
          ..write('price: $price, ')
          ..write('area: $area, ')
          ..write('bedrooms: $bedrooms, ')
          ..write('bathrooms: $bathrooms, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('country: $country, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PropertyImagesTable extends PropertyImages
    with TableInfo<$PropertyImagesTable, PropertyImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertyImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _propertyIdMeta =
      const VerificationMeta('propertyId');
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
      'property_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES properties (id) ON DELETE CASCADE'));
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbnailUrlMeta =
      const VerificationMeta('thumbnailUrl');
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
      'thumbnail_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isPrimaryMeta =
      const VerificationMeta('isPrimary');
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
      'is_primary', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_primary" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _displayOrderMeta =
      const VerificationMeta('displayOrder');
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
      'display_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        propertyId,
        imageUrl,
        thumbnailUrl,
        isPrimary,
        displayOrder,
        createdAt,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'property_images';
  @override
  VerificationContext validateIntegrity(Insertable<PropertyImage> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
          _propertyIdMeta,
          propertyId.isAcceptableOrUnknown(
              data['property_id']!, _propertyIdMeta));
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
          _thumbnailUrlMeta,
          thumbnailUrl.isAcceptableOrUnknown(
              data['thumbnail_url']!, _thumbnailUrlMeta));
    }
    if (data.containsKey('is_primary')) {
      context.handle(_isPrimaryMeta,
          isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta));
    }
    if (data.containsKey('display_order')) {
      context.handle(
          _displayOrderMeta,
          displayOrder.isAcceptableOrUnknown(
              data['display_order']!, _displayOrderMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PropertyImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PropertyImage(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      propertyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}property_id'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      thumbnailUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}thumbnail_url']),
      isPrimary: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_primary'])!,
      displayOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_order'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $PropertyImagesTable createAlias(String alias) {
    return $PropertyImagesTable(attachedDatabase, alias);
  }
}

class PropertyImage extends DataClass implements Insertable<PropertyImage> {
  final String id;
  final String propertyId;
  final String imageUrl;
  final String? thumbnailUrl;
  final bool isPrimary;
  final int displayOrder;
  final DateTime createdAt;
  final String syncStatus;
  const PropertyImage(
      {required this.id,
      required this.propertyId,
      required this.imageUrl,
      this.thumbnailUrl,
      required this.isPrimary,
      required this.displayOrder,
      required this.createdAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['image_url'] = Variable<String>(imageUrl);
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl);
    }
    map['is_primary'] = Variable<bool>(isPrimary);
    map['display_order'] = Variable<int>(displayOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  PropertyImagesCompanion toCompanion(bool nullToAbsent) {
    return PropertyImagesCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      imageUrl: Value(imageUrl),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      isPrimary: Value(isPrimary),
      displayOrder: Value(displayOrder),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory PropertyImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PropertyImage(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  PropertyImage copyWith(
          {String? id,
          String? propertyId,
          String? imageUrl,
          Value<String?> thumbnailUrl = const Value.absent(),
          bool? isPrimary,
          int? displayOrder,
          DateTime? createdAt,
          String? syncStatus}) =>
      PropertyImage(
        id: id ?? this.id,
        propertyId: propertyId ?? this.propertyId,
        imageUrl: imageUrl ?? this.imageUrl,
        thumbnailUrl:
            thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
        isPrimary: isPrimary ?? this.isPrimary,
        displayOrder: displayOrder ?? this.displayOrder,
        createdAt: createdAt ?? this.createdAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  PropertyImage copyWithCompanion(PropertyImagesCompanion data) {
    return PropertyImage(
      id: data.id.present ? data.id.value : this.id,
      propertyId:
          data.propertyId.present ? data.propertyId.value : this.propertyId,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PropertyImage(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, propertyId, imageUrl, thumbnailUrl,
      isPrimary, displayOrder, createdAt, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PropertyImage &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.imageUrl == this.imageUrl &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.isPrimary == this.isPrimary &&
          other.displayOrder == this.displayOrder &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class PropertyImagesCompanion extends UpdateCompanion<PropertyImage> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> imageUrl;
  final Value<String?> thumbnailUrl;
  final Value<bool> isPrimary;
  final Value<int> displayOrder;
  final Value<DateTime> createdAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const PropertyImagesCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PropertyImagesCompanion.insert({
    required String id,
    required String propertyId,
    required String imageUrl,
    this.thumbnailUrl = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.displayOrder = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        propertyId = Value(propertyId),
        imageUrl = Value(imageUrl),
        createdAt = Value(createdAt);
  static Insertable<PropertyImage> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? imageUrl,
    Expression<String>? thumbnailUrl,
    Expression<bool>? isPrimary,
    Expression<int>? displayOrder,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (imageUrl != null) 'image_url': imageUrl,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (displayOrder != null) 'display_order': displayOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PropertyImagesCompanion copyWith(
      {Value<String>? id,
      Value<String>? propertyId,
      Value<String>? imageUrl,
      Value<String?>? thumbnailUrl,
      Value<bool>? isPrimary,
      Value<int>? displayOrder,
      Value<DateTime>? createdAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return PropertyImagesCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isPrimary: isPrimary ?? this.isPrimary,
      displayOrder: displayOrder ?? this.displayOrder,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertyImagesCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContractsTable extends Contracts
    with TableInfo<$ContractsTable, Contract> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContractsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _propertyIdMeta =
      const VerificationMeta('propertyId');
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
      'property_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES properties (id)'));
  static const VerificationMeta _ownerIdMeta =
      const VerificationMeta('ownerId');
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
      'owner_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _tenantBuyerIdMeta =
      const VerificationMeta('tenantBuyerId');
  @override
  late final GeneratedColumn<String> tenantBuyerId = GeneratedColumn<String>(
      'tenant_buyer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _contractTypeMeta =
      const VerificationMeta('contractType');
  @override
  late final GeneratedColumn<String> contractType = GeneratedColumn<String>(
      'contract_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _monthlyRentMeta =
      const VerificationMeta('monthlyRent');
  @override
  late final GeneratedColumn<double> monthlyRent = GeneratedColumn<double>(
      'monthly_rent', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _salePriceMeta =
      const VerificationMeta('salePrice');
  @override
  late final GeneratedColumn<double> salePrice = GeneratedColumn<double>(
      'sale_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _depositAmountMeta =
      const VerificationMeta('depositAmount');
  @override
  late final GeneratedColumn<double> depositAmount = GeneratedColumn<double>(
      'deposit_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _termsMeta = const VerificationMeta('terms');
  @override
  late final GeneratedColumn<String> terms = GeneratedColumn<String>(
      'terms', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionArMeta =
      const VerificationMeta('descriptionAr');
  @override
  late final GeneratedColumn<String> descriptionAr = GeneratedColumn<String>(
      'description_ar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _concessionsMeta =
      const VerificationMeta('concessions');
  @override
  late final GeneratedColumn<String> concessions = GeneratedColumn<String>(
      'concessions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileUrlMeta =
      const VerificationMeta('fileUrl');
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
      'file_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paymentFrequencyMeta =
      const VerificationMeta('paymentFrequency');
  @override
  late final GeneratedColumn<String> paymentFrequency = GeneratedColumn<String>(
      'payment_frequency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('monthly'));
  static const VerificationMeta _customFrequencyDaysMeta =
      const VerificationMeta('customFrequencyDays');
  @override
  late final GeneratedColumn<int> customFrequencyDays = GeneratedColumn<int>(
      'custom_frequency_days', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        propertyId,
        ownerId,
        tenantBuyerId,
        contractType,
        startDate,
        endDate,
        monthlyRent,
        salePrice,
        depositAmount,
        terms,
        description,
        descriptionAr,
        concessions,
        fileUrl,
        paymentFrequency,
        customFrequencyDays,
        status,
        createdAt,
        updatedAt,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contracts';
  @override
  VerificationContext validateIntegrity(Insertable<Contract> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
          _propertyIdMeta,
          propertyId.isAcceptableOrUnknown(
              data['property_id']!, _propertyIdMeta));
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(_ownerIdMeta,
          ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta));
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('tenant_buyer_id')) {
      context.handle(
          _tenantBuyerIdMeta,
          tenantBuyerId.isAcceptableOrUnknown(
              data['tenant_buyer_id']!, _tenantBuyerIdMeta));
    } else if (isInserting) {
      context.missing(_tenantBuyerIdMeta);
    }
    if (data.containsKey('contract_type')) {
      context.handle(
          _contractTypeMeta,
          contractType.isAcceptableOrUnknown(
              data['contract_type']!, _contractTypeMeta));
    } else if (isInserting) {
      context.missing(_contractTypeMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('monthly_rent')) {
      context.handle(
          _monthlyRentMeta,
          monthlyRent.isAcceptableOrUnknown(
              data['monthly_rent']!, _monthlyRentMeta));
    }
    if (data.containsKey('sale_price')) {
      context.handle(_salePriceMeta,
          salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta));
    }
    if (data.containsKey('deposit_amount')) {
      context.handle(
          _depositAmountMeta,
          depositAmount.isAcceptableOrUnknown(
              data['deposit_amount']!, _depositAmountMeta));
    }
    if (data.containsKey('terms')) {
      context.handle(
          _termsMeta, terms.isAcceptableOrUnknown(data['terms']!, _termsMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('description_ar')) {
      context.handle(
          _descriptionArMeta,
          descriptionAr.isAcceptableOrUnknown(
              data['description_ar']!, _descriptionArMeta));
    }
    if (data.containsKey('concessions')) {
      context.handle(
          _concessionsMeta,
          concessions.isAcceptableOrUnknown(
              data['concessions']!, _concessionsMeta));
    }
    if (data.containsKey('file_url')) {
      context.handle(_fileUrlMeta,
          fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta));
    }
    if (data.containsKey('payment_frequency')) {
      context.handle(
          _paymentFrequencyMeta,
          paymentFrequency.isAcceptableOrUnknown(
              data['payment_frequency']!, _paymentFrequencyMeta));
    }
    if (data.containsKey('custom_frequency_days')) {
      context.handle(
          _customFrequencyDaysMeta,
          customFrequencyDays.isAcceptableOrUnknown(
              data['custom_frequency_days']!, _customFrequencyDaysMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contract map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contract(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      propertyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}property_id'])!,
      ownerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner_id'])!,
      tenantBuyerId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}tenant_buyer_id'])!,
      contractType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract_type'])!,
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      monthlyRent: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}monthly_rent']),
      salePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sale_price']),
      depositAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}deposit_amount']),
      terms: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}terms']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      descriptionAr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description_ar']),
      concessions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}concessions']),
      fileUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_url']),
      paymentFrequency: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}payment_frequency'])!,
      customFrequencyDays: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}custom_frequency_days']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $ContractsTable createAlias(String alias) {
    return $ContractsTable(attachedDatabase, alias);
  }
}

class Contract extends DataClass implements Insertable<Contract> {
  final String id;
  final String propertyId;
  final String ownerId;
  final String tenantBuyerId;
  final String contractType;
  final DateTime startDate;
  final DateTime? endDate;
  final double? monthlyRent;
  final double? salePrice;
  final double? depositAmount;
  final String? terms;
  final String? description;
  final String? descriptionAr;
  final String? concessions;
  final String? fileUrl;
  final String paymentFrequency;
  final int? customFrequencyDays;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const Contract(
      {required this.id,
      required this.propertyId,
      required this.ownerId,
      required this.tenantBuyerId,
      required this.contractType,
      required this.startDate,
      this.endDate,
      this.monthlyRent,
      this.salePrice,
      this.depositAmount,
      this.terms,
      this.description,
      this.descriptionAr,
      this.concessions,
      this.fileUrl,
      required this.paymentFrequency,
      this.customFrequencyDays,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['owner_id'] = Variable<String>(ownerId);
    map['tenant_buyer_id'] = Variable<String>(tenantBuyerId);
    map['contract_type'] = Variable<String>(contractType);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || monthlyRent != null) {
      map['monthly_rent'] = Variable<double>(monthlyRent);
    }
    if (!nullToAbsent || salePrice != null) {
      map['sale_price'] = Variable<double>(salePrice);
    }
    if (!nullToAbsent || depositAmount != null) {
      map['deposit_amount'] = Variable<double>(depositAmount);
    }
    if (!nullToAbsent || terms != null) {
      map['terms'] = Variable<String>(terms);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || descriptionAr != null) {
      map['description_ar'] = Variable<String>(descriptionAr);
    }
    if (!nullToAbsent || concessions != null) {
      map['concessions'] = Variable<String>(concessions);
    }
    if (!nullToAbsent || fileUrl != null) {
      map['file_url'] = Variable<String>(fileUrl);
    }
    map['payment_frequency'] = Variable<String>(paymentFrequency);
    if (!nullToAbsent || customFrequencyDays != null) {
      map['custom_frequency_days'] = Variable<int>(customFrequencyDays);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  ContractsCompanion toCompanion(bool nullToAbsent) {
    return ContractsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      ownerId: Value(ownerId),
      tenantBuyerId: Value(tenantBuyerId),
      contractType: Value(contractType),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      monthlyRent: monthlyRent == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyRent),
      salePrice: salePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(salePrice),
      depositAmount: depositAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(depositAmount),
      terms:
          terms == null && nullToAbsent ? const Value.absent() : Value(terms),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      descriptionAr: descriptionAr == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionAr),
      concessions: concessions == null && nullToAbsent
          ? const Value.absent()
          : Value(concessions),
      fileUrl: fileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUrl),
      paymentFrequency: Value(paymentFrequency),
      customFrequencyDays: customFrequencyDays == null && nullToAbsent
          ? const Value.absent()
          : Value(customFrequencyDays),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Contract.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contract(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      tenantBuyerId: serializer.fromJson<String>(json['tenantBuyerId']),
      contractType: serializer.fromJson<String>(json['contractType']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      monthlyRent: serializer.fromJson<double?>(json['monthlyRent']),
      salePrice: serializer.fromJson<double?>(json['salePrice']),
      depositAmount: serializer.fromJson<double?>(json['depositAmount']),
      terms: serializer.fromJson<String?>(json['terms']),
      description: serializer.fromJson<String?>(json['description']),
      descriptionAr: serializer.fromJson<String?>(json['descriptionAr']),
      concessions: serializer.fromJson<String?>(json['concessions']),
      fileUrl: serializer.fromJson<String?>(json['fileUrl']),
      paymentFrequency: serializer.fromJson<String>(json['paymentFrequency']),
      customFrequencyDays:
          serializer.fromJson<int?>(json['customFrequencyDays']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'ownerId': serializer.toJson<String>(ownerId),
      'tenantBuyerId': serializer.toJson<String>(tenantBuyerId),
      'contractType': serializer.toJson<String>(contractType),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'monthlyRent': serializer.toJson<double?>(monthlyRent),
      'salePrice': serializer.toJson<double?>(salePrice),
      'depositAmount': serializer.toJson<double?>(depositAmount),
      'terms': serializer.toJson<String?>(terms),
      'description': serializer.toJson<String?>(description),
      'descriptionAr': serializer.toJson<String?>(descriptionAr),
      'concessions': serializer.toJson<String?>(concessions),
      'fileUrl': serializer.toJson<String?>(fileUrl),
      'paymentFrequency': serializer.toJson<String>(paymentFrequency),
      'customFrequencyDays': serializer.toJson<int?>(customFrequencyDays),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Contract copyWith(
          {String? id,
          String? propertyId,
          String? ownerId,
          String? tenantBuyerId,
          String? contractType,
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          Value<double?> monthlyRent = const Value.absent(),
          Value<double?> salePrice = const Value.absent(),
          Value<double?> depositAmount = const Value.absent(),
          Value<String?> terms = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> descriptionAr = const Value.absent(),
          Value<String?> concessions = const Value.absent(),
          Value<String?> fileUrl = const Value.absent(),
          String? paymentFrequency,
          Value<int?> customFrequencyDays = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncStatus}) =>
      Contract(
        id: id ?? this.id,
        propertyId: propertyId ?? this.propertyId,
        ownerId: ownerId ?? this.ownerId,
        tenantBuyerId: tenantBuyerId ?? this.tenantBuyerId,
        contractType: contractType ?? this.contractType,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        monthlyRent: monthlyRent.present ? monthlyRent.value : this.monthlyRent,
        salePrice: salePrice.present ? salePrice.value : this.salePrice,
        depositAmount:
            depositAmount.present ? depositAmount.value : this.depositAmount,
        terms: terms.present ? terms.value : this.terms,
        description: description.present ? description.value : this.description,
        descriptionAr:
            descriptionAr.present ? descriptionAr.value : this.descriptionAr,
        concessions: concessions.present ? concessions.value : this.concessions,
        fileUrl: fileUrl.present ? fileUrl.value : this.fileUrl,
        paymentFrequency: paymentFrequency ?? this.paymentFrequency,
        customFrequencyDays: customFrequencyDays.present
            ? customFrequencyDays.value
            : this.customFrequencyDays,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  Contract copyWithCompanion(ContractsCompanion data) {
    return Contract(
      id: data.id.present ? data.id.value : this.id,
      propertyId:
          data.propertyId.present ? data.propertyId.value : this.propertyId,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      tenantBuyerId: data.tenantBuyerId.present
          ? data.tenantBuyerId.value
          : this.tenantBuyerId,
      contractType: data.contractType.present
          ? data.contractType.value
          : this.contractType,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      monthlyRent:
          data.monthlyRent.present ? data.monthlyRent.value : this.monthlyRent,
      salePrice: data.salePrice.present ? data.salePrice.value : this.salePrice,
      depositAmount: data.depositAmount.present
          ? data.depositAmount.value
          : this.depositAmount,
      terms: data.terms.present ? data.terms.value : this.terms,
      description:
          data.description.present ? data.description.value : this.description,
      descriptionAr: data.descriptionAr.present
          ? data.descriptionAr.value
          : this.descriptionAr,
      concessions:
          data.concessions.present ? data.concessions.value : this.concessions,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
      paymentFrequency: data.paymentFrequency.present
          ? data.paymentFrequency.value
          : this.paymentFrequency,
      customFrequencyDays: data.customFrequencyDays.present
          ? data.customFrequencyDays.value
          : this.customFrequencyDays,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contract(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('ownerId: $ownerId, ')
          ..write('tenantBuyerId: $tenantBuyerId, ')
          ..write('contractType: $contractType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('monthlyRent: $monthlyRent, ')
          ..write('salePrice: $salePrice, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('terms: $terms, ')
          ..write('description: $description, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('concessions: $concessions, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('paymentFrequency: $paymentFrequency, ')
          ..write('customFrequencyDays: $customFrequencyDays, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        propertyId,
        ownerId,
        tenantBuyerId,
        contractType,
        startDate,
        endDate,
        monthlyRent,
        salePrice,
        depositAmount,
        terms,
        description,
        descriptionAr,
        concessions,
        fileUrl,
        paymentFrequency,
        customFrequencyDays,
        status,
        createdAt,
        updatedAt,
        syncStatus
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contract &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.ownerId == this.ownerId &&
          other.tenantBuyerId == this.tenantBuyerId &&
          other.contractType == this.contractType &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.monthlyRent == this.monthlyRent &&
          other.salePrice == this.salePrice &&
          other.depositAmount == this.depositAmount &&
          other.terms == this.terms &&
          other.description == this.description &&
          other.descriptionAr == this.descriptionAr &&
          other.concessions == this.concessions &&
          other.fileUrl == this.fileUrl &&
          other.paymentFrequency == this.paymentFrequency &&
          other.customFrequencyDays == this.customFrequencyDays &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class ContractsCompanion extends UpdateCompanion<Contract> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> ownerId;
  final Value<String> tenantBuyerId;
  final Value<String> contractType;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<double?> monthlyRent;
  final Value<double?> salePrice;
  final Value<double?> depositAmount;
  final Value<String?> terms;
  final Value<String?> description;
  final Value<String?> descriptionAr;
  final Value<String?> concessions;
  final Value<String?> fileUrl;
  final Value<String> paymentFrequency;
  final Value<int?> customFrequencyDays;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const ContractsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.tenantBuyerId = const Value.absent(),
    this.contractType = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.monthlyRent = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.depositAmount = const Value.absent(),
    this.terms = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionAr = const Value.absent(),
    this.concessions = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.paymentFrequency = const Value.absent(),
    this.customFrequencyDays = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContractsCompanion.insert({
    required String id,
    required String propertyId,
    required String ownerId,
    required String tenantBuyerId,
    required String contractType,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.monthlyRent = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.depositAmount = const Value.absent(),
    this.terms = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionAr = const Value.absent(),
    this.concessions = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.paymentFrequency = const Value.absent(),
    this.customFrequencyDays = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        propertyId = Value(propertyId),
        ownerId = Value(ownerId),
        tenantBuyerId = Value(tenantBuyerId),
        contractType = Value(contractType),
        startDate = Value(startDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Contract> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? ownerId,
    Expression<String>? tenantBuyerId,
    Expression<String>? contractType,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<double>? monthlyRent,
    Expression<double>? salePrice,
    Expression<double>? depositAmount,
    Expression<String>? terms,
    Expression<String>? description,
    Expression<String>? descriptionAr,
    Expression<String>? concessions,
    Expression<String>? fileUrl,
    Expression<String>? paymentFrequency,
    Expression<int>? customFrequencyDays,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (ownerId != null) 'owner_id': ownerId,
      if (tenantBuyerId != null) 'tenant_buyer_id': tenantBuyerId,
      if (contractType != null) 'contract_type': contractType,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (monthlyRent != null) 'monthly_rent': monthlyRent,
      if (salePrice != null) 'sale_price': salePrice,
      if (depositAmount != null) 'deposit_amount': depositAmount,
      if (terms != null) 'terms': terms,
      if (description != null) 'description': description,
      if (descriptionAr != null) 'description_ar': descriptionAr,
      if (concessions != null) 'concessions': concessions,
      if (fileUrl != null) 'file_url': fileUrl,
      if (paymentFrequency != null) 'payment_frequency': paymentFrequency,
      if (customFrequencyDays != null)
        'custom_frequency_days': customFrequencyDays,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContractsCompanion copyWith(
      {Value<String>? id,
      Value<String>? propertyId,
      Value<String>? ownerId,
      Value<String>? tenantBuyerId,
      Value<String>? contractType,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<double?>? monthlyRent,
      Value<double?>? salePrice,
      Value<double?>? depositAmount,
      Value<String?>? terms,
      Value<String?>? description,
      Value<String?>? descriptionAr,
      Value<String?>? concessions,
      Value<String?>? fileUrl,
      Value<String>? paymentFrequency,
      Value<int?>? customFrequencyDays,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return ContractsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      ownerId: ownerId ?? this.ownerId,
      tenantBuyerId: tenantBuyerId ?? this.tenantBuyerId,
      contractType: contractType ?? this.contractType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      monthlyRent: monthlyRent ?? this.monthlyRent,
      salePrice: salePrice ?? this.salePrice,
      depositAmount: depositAmount ?? this.depositAmount,
      terms: terms ?? this.terms,
      description: description ?? this.description,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      concessions: concessions ?? this.concessions,
      fileUrl: fileUrl ?? this.fileUrl,
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
      customFrequencyDays: customFrequencyDays ?? this.customFrequencyDays,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (tenantBuyerId.present) {
      map['tenant_buyer_id'] = Variable<String>(tenantBuyerId.value);
    }
    if (contractType.present) {
      map['contract_type'] = Variable<String>(contractType.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (monthlyRent.present) {
      map['monthly_rent'] = Variable<double>(monthlyRent.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (depositAmount.present) {
      map['deposit_amount'] = Variable<double>(depositAmount.value);
    }
    if (terms.present) {
      map['terms'] = Variable<String>(terms.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (descriptionAr.present) {
      map['description_ar'] = Variable<String>(descriptionAr.value);
    }
    if (concessions.present) {
      map['concessions'] = Variable<String>(concessions.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (paymentFrequency.present) {
      map['payment_frequency'] = Variable<String>(paymentFrequency.value);
    }
    if (customFrequencyDays.present) {
      map['custom_frequency_days'] = Variable<int>(customFrequencyDays.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContractsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('ownerId: $ownerId, ')
          ..write('tenantBuyerId: $tenantBuyerId, ')
          ..write('contractType: $contractType, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('monthlyRent: $monthlyRent, ')
          ..write('salePrice: $salePrice, ')
          ..write('depositAmount: $depositAmount, ')
          ..write('terms: $terms, ')
          ..write('description: $description, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('concessions: $concessions, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('paymentFrequency: $paymentFrequency, ')
          ..write('customFrequencyDays: $customFrequencyDays, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contractIdMeta =
      const VerificationMeta('contractId');
  @override
  late final GeneratedColumn<String> contractId = GeneratedColumn<String>(
      'contract_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES contracts (id)'));
  static const VerificationMeta _payerIdMeta =
      const VerificationMeta('payerId');
  @override
  late final GeneratedColumn<String> payerId = GeneratedColumn<String>(
      'payer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime> paymentDate = GeneratedColumn<DateTime>(
      'payment_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumn<String> paymentType = GeneratedColumn<String>(
      'payment_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        contractId,
        payerId,
        amount,
        paymentDate,
        dueDate,
        paymentType,
        paymentMethod,
        status,
        notes,
        createdAt,
        updatedAt,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<Payment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('contract_id')) {
      context.handle(
          _contractIdMeta,
          contractId.isAcceptableOrUnknown(
              data['contract_id']!, _contractIdMeta));
    } else if (isInserting) {
      context.missing(_contractIdMeta);
    }
    if (data.containsKey('payer_id')) {
      context.handle(_payerIdMeta,
          payerId.isAcceptableOrUnknown(data['payer_id']!, _payerIdMeta));
    } else if (isInserting) {
      context.missing(_payerIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('payment_type')) {
      context.handle(
          _paymentTypeMeta,
          paymentType.isAcceptableOrUnknown(
              data['payment_type']!, _paymentTypeMeta));
    } else if (isInserting) {
      context.missing(_paymentTypeMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      contractId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contract_id'])!,
      payerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payer_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      paymentDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}payment_date'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      paymentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_type'])!,
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final String id;
  final String contractId;
  final String payerId;
  final double amount;
  final DateTime paymentDate;
  final DateTime? dueDate;
  final String paymentType;
  final String? paymentMethod;
  final String status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const Payment(
      {required this.id,
      required this.contractId,
      required this.payerId,
      required this.amount,
      required this.paymentDate,
      this.dueDate,
      required this.paymentType,
      this.paymentMethod,
      required this.status,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['contract_id'] = Variable<String>(contractId);
    map['payer_id'] = Variable<String>(payerId);
    map['amount'] = Variable<double>(amount);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['payment_type'] = Variable<String>(paymentType);
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      contractId: Value(contractId),
      payerId: Value(payerId),
      amount: Value(amount),
      paymentDate: Value(paymentDate),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      paymentType: Value(paymentType),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<String>(json['id']),
      contractId: serializer.fromJson<String>(json['contractId']),
      payerId: serializer.fromJson<String>(json['payerId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'contractId': serializer.toJson<String>(contractId),
      'payerId': serializer.toJson<String>(payerId),
      'amount': serializer.toJson<double>(amount),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'paymentType': serializer.toJson<String>(paymentType),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Payment copyWith(
          {String? id,
          String? contractId,
          String? payerId,
          double? amount,
          DateTime? paymentDate,
          Value<DateTime?> dueDate = const Value.absent(),
          String? paymentType,
          Value<String?> paymentMethod = const Value.absent(),
          String? status,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncStatus}) =>
      Payment(
        id: id ?? this.id,
        contractId: contractId ?? this.contractId,
        payerId: payerId ?? this.payerId,
        amount: amount ?? this.amount,
        paymentDate: paymentDate ?? this.paymentDate,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        paymentType: paymentType ?? this.paymentType,
        paymentMethod:
            paymentMethod.present ? paymentMethod.value : this.paymentMethod,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      contractId:
          data.contractId.present ? data.contractId.value : this.contractId,
      payerId: data.payerId.present ? data.payerId.value : this.payerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paymentDate:
          data.paymentDate.present ? data.paymentDate.value : this.paymentDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      paymentType:
          data.paymentType.present ? data.paymentType.value : this.paymentType,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('contractId: $contractId, ')
          ..write('payerId: $payerId, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('paymentType: $paymentType, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      contractId,
      payerId,
      amount,
      paymentDate,
      dueDate,
      paymentType,
      paymentMethod,
      status,
      notes,
      createdAt,
      updatedAt,
      syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.contractId == this.contractId &&
          other.payerId == this.payerId &&
          other.amount == this.amount &&
          other.paymentDate == this.paymentDate &&
          other.dueDate == this.dueDate &&
          other.paymentType == this.paymentType &&
          other.paymentMethod == this.paymentMethod &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<String> id;
  final Value<String> contractId;
  final Value<String> payerId;
  final Value<double> amount;
  final Value<DateTime> paymentDate;
  final Value<DateTime?> dueDate;
  final Value<String> paymentType;
  final Value<String?> paymentMethod;
  final Value<String> status;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.contractId = const Value.absent(),
    this.payerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String id,
    required String contractId,
    required String payerId,
    required double amount,
    required DateTime paymentDate,
    this.dueDate = const Value.absent(),
    required String paymentType,
    this.paymentMethod = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        contractId = Value(contractId),
        payerId = Value(payerId),
        amount = Value(amount),
        paymentDate = Value(paymentDate),
        paymentType = Value(paymentType),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Payment> custom({
    Expression<String>? id,
    Expression<String>? contractId,
    Expression<String>? payerId,
    Expression<double>? amount,
    Expression<DateTime>? paymentDate,
    Expression<DateTime>? dueDate,
    Expression<String>? paymentType,
    Expression<String>? paymentMethod,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contractId != null) 'contract_id': contractId,
      if (payerId != null) 'payer_id': payerId,
      if (amount != null) 'amount': amount,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (dueDate != null) 'due_date': dueDate,
      if (paymentType != null) 'payment_type': paymentType,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? contractId,
      Value<String>? payerId,
      Value<double>? amount,
      Value<DateTime>? paymentDate,
      Value<DateTime?>? dueDate,
      Value<String>? paymentType,
      Value<String?>? paymentMethod,
      Value<String>? status,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      contractId: contractId ?? this.contractId,
      payerId: payerId ?? this.payerId,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      dueDate: dueDate ?? this.dueDate,
      paymentType: paymentType ?? this.paymentType,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contractId.present) {
      map['contract_id'] = Variable<String>(contractId.value);
    }
    if (payerId.present) {
      map['payer_id'] = Variable<String>(payerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('contractId: $contractId, ')
          ..write('payerId: $payerId, ')
          ..write('amount: $amount, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('paymentType: $paymentType, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PurchaseRequestsTable extends PurchaseRequests
    with TableInfo<$PurchaseRequestsTable, PurchaseRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseRequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _propertyIdMeta =
      const VerificationMeta('propertyId');
  @override
  late final GeneratedColumn<String> propertyId = GeneratedColumn<String>(
      'property_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES properties (id)'));
  static const VerificationMeta _buyerIdMeta =
      const VerificationMeta('buyerId');
  @override
  late final GeneratedColumn<String> buyerId = GeneratedColumn<String>(
      'buyer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _offeredPriceMeta =
      const VerificationMeta('offeredPrice');
  @override
  late final GeneratedColumn<double> offeredPrice = GeneratedColumn<double>(
      'offered_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        propertyId,
        buyerId,
        offeredPrice,
        message,
        status,
        createdAt,
        updatedAt,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_requests';
  @override
  VerificationContext validateIntegrity(Insertable<PurchaseRequest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('property_id')) {
      context.handle(
          _propertyIdMeta,
          propertyId.isAcceptableOrUnknown(
              data['property_id']!, _propertyIdMeta));
    } else if (isInserting) {
      context.missing(_propertyIdMeta);
    }
    if (data.containsKey('buyer_id')) {
      context.handle(_buyerIdMeta,
          buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta));
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('offered_price')) {
      context.handle(
          _offeredPriceMeta,
          offeredPrice.isAcceptableOrUnknown(
              data['offered_price']!, _offeredPriceMeta));
    } else if (isInserting) {
      context.missing(_offeredPriceMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseRequest(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      propertyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}property_id'])!,
      buyerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}buyer_id'])!,
      offeredPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}offered_price'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $PurchaseRequestsTable createAlias(String alias) {
    return $PurchaseRequestsTable(attachedDatabase, alias);
  }
}

class PurchaseRequest extends DataClass implements Insertable<PurchaseRequest> {
  final String id;
  final String propertyId;
  final String buyerId;
  final double offeredPrice;
  final String? message;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const PurchaseRequest(
      {required this.id,
      required this.propertyId,
      required this.buyerId,
      required this.offeredPrice,
      this.message,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['property_id'] = Variable<String>(propertyId);
    map['buyer_id'] = Variable<String>(buyerId);
    map['offered_price'] = Variable<double>(offeredPrice);
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  PurchaseRequestsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseRequestsCompanion(
      id: Value(id),
      propertyId: Value(propertyId),
      buyerId: Value(buyerId),
      offeredPrice: Value(offeredPrice),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory PurchaseRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseRequest(
      id: serializer.fromJson<String>(json['id']),
      propertyId: serializer.fromJson<String>(json['propertyId']),
      buyerId: serializer.fromJson<String>(json['buyerId']),
      offeredPrice: serializer.fromJson<double>(json['offeredPrice']),
      message: serializer.fromJson<String?>(json['message']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'propertyId': serializer.toJson<String>(propertyId),
      'buyerId': serializer.toJson<String>(buyerId),
      'offeredPrice': serializer.toJson<double>(offeredPrice),
      'message': serializer.toJson<String?>(message),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  PurchaseRequest copyWith(
          {String? id,
          String? propertyId,
          String? buyerId,
          double? offeredPrice,
          Value<String?> message = const Value.absent(),
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncStatus}) =>
      PurchaseRequest(
        id: id ?? this.id,
        propertyId: propertyId ?? this.propertyId,
        buyerId: buyerId ?? this.buyerId,
        offeredPrice: offeredPrice ?? this.offeredPrice,
        message: message.present ? message.value : this.message,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  PurchaseRequest copyWithCompanion(PurchaseRequestsCompanion data) {
    return PurchaseRequest(
      id: data.id.present ? data.id.value : this.id,
      propertyId:
          data.propertyId.present ? data.propertyId.value : this.propertyId,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      offeredPrice: data.offeredPrice.present
          ? data.offeredPrice.value
          : this.offeredPrice,
      message: data.message.present ? data.message.value : this.message,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseRequest(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('buyerId: $buyerId, ')
          ..write('offeredPrice: $offeredPrice, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, propertyId, buyerId, offeredPrice,
      message, status, createdAt, updatedAt, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseRequest &&
          other.id == this.id &&
          other.propertyId == this.propertyId &&
          other.buyerId == this.buyerId &&
          other.offeredPrice == this.offeredPrice &&
          other.message == this.message &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class PurchaseRequestsCompanion extends UpdateCompanion<PurchaseRequest> {
  final Value<String> id;
  final Value<String> propertyId;
  final Value<String> buyerId;
  final Value<double> offeredPrice;
  final Value<String?> message;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const PurchaseRequestsCompanion({
    this.id = const Value.absent(),
    this.propertyId = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.offeredPrice = const Value.absent(),
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PurchaseRequestsCompanion.insert({
    required String id,
    required String propertyId,
    required String buyerId,
    required double offeredPrice,
    this.message = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        propertyId = Value(propertyId),
        buyerId = Value(buyerId),
        offeredPrice = Value(offeredPrice),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PurchaseRequest> custom({
    Expression<String>? id,
    Expression<String>? propertyId,
    Expression<String>? buyerId,
    Expression<double>? offeredPrice,
    Expression<String>? message,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (propertyId != null) 'property_id': propertyId,
      if (buyerId != null) 'buyer_id': buyerId,
      if (offeredPrice != null) 'offered_price': offeredPrice,
      if (message != null) 'message': message,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PurchaseRequestsCompanion copyWith(
      {Value<String>? id,
      Value<String>? propertyId,
      Value<String>? buyerId,
      Value<double>? offeredPrice,
      Value<String?>? message,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return PurchaseRequestsCompanion(
      id: id ?? this.id,
      propertyId: propertyId ?? this.propertyId,
      buyerId: buyerId ?? this.buyerId,
      offeredPrice: offeredPrice ?? this.offeredPrice,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (propertyId.present) {
      map['property_id'] = Variable<String>(propertyId.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<String>(buyerId.value);
    }
    if (offeredPrice.present) {
      map['offered_price'] = Variable<double>(offeredPrice.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseRequestsCompanion(')
          ..write('id: $id, ')
          ..write('propertyId: $propertyId, ')
          ..write('buyerId: $buyerId, ')
          ..write('offeredPrice: $offeredPrice, ')
          ..write('message: $message, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
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
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const Setting(
      {required this.key, required this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Setting copyWith({String? key, String? value, DateTime? updatedAt}) =>
      Setting(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        updatedAt = Value(updatedAt);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PropertyRequestsTable extends PropertyRequests
    with TableInfo<$PropertyRequestsTable, PropertyRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PropertyRequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _buyerIdMeta =
      const VerificationMeta('buyerId');
  @override
  late final GeneratedColumn<String> buyerId = GeneratedColumn<String>(
      'buyer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _propertyCategoryMeta =
      const VerificationMeta('propertyCategory');
  @override
  late final GeneratedColumn<String> propertyCategory = GeneratedColumn<String>(
      'property_category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _propertyTypeMeta =
      const VerificationMeta('propertyType');
  @override
  late final GeneratedColumn<String> propertyType = GeneratedColumn<String>(
      'property_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _minPriceMeta =
      const VerificationMeta('minPrice');
  @override
  late final GeneratedColumn<double> minPrice = GeneratedColumn<double>(
      'min_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _maxPriceMeta =
      const VerificationMeta('maxPrice');
  @override
  late final GeneratedColumn<double> maxPrice = GeneratedColumn<double>(
      'max_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urgencyMeta =
      const VerificationMeta('urgency');
  @override
  late final GeneratedColumn<String> urgency = GeneratedColumn<String>(
      'urgency', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        buyerId,
        propertyCategory,
        propertyType,
        minPrice,
        maxPrice,
        location,
        urgency,
        status,
        createdAt,
        updatedAt,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'property_requests';
  @override
  VerificationContext validateIntegrity(Insertable<PropertyRequest> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('buyer_id')) {
      context.handle(_buyerIdMeta,
          buyerId.isAcceptableOrUnknown(data['buyer_id']!, _buyerIdMeta));
    } else if (isInserting) {
      context.missing(_buyerIdMeta);
    }
    if (data.containsKey('property_category')) {
      context.handle(
          _propertyCategoryMeta,
          propertyCategory.isAcceptableOrUnknown(
              data['property_category']!, _propertyCategoryMeta));
    } else if (isInserting) {
      context.missing(_propertyCategoryMeta);
    }
    if (data.containsKey('property_type')) {
      context.handle(
          _propertyTypeMeta,
          propertyType.isAcceptableOrUnknown(
              data['property_type']!, _propertyTypeMeta));
    }
    if (data.containsKey('min_price')) {
      context.handle(_minPriceMeta,
          minPrice.isAcceptableOrUnknown(data['min_price']!, _minPriceMeta));
    }
    if (data.containsKey('max_price')) {
      context.handle(_maxPriceMeta,
          maxPrice.isAcceptableOrUnknown(data['max_price']!, _maxPriceMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('urgency')) {
      context.handle(_urgencyMeta,
          urgency.isAcceptableOrUnknown(data['urgency']!, _urgencyMeta));
    } else if (isInserting) {
      context.missing(_urgencyMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PropertyRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PropertyRequest(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      buyerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}buyer_id'])!,
      propertyCategory: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}property_category'])!,
      propertyType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}property_type']),
      minPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}min_price']),
      maxPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}max_price']),
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
      urgency: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}urgency'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $PropertyRequestsTable createAlias(String alias) {
    return $PropertyRequestsTable(attachedDatabase, alias);
  }
}

class PropertyRequest extends DataClass implements Insertable<PropertyRequest> {
  final String id;
  final String buyerId;
  final String propertyCategory;
  final String? propertyType;
  final double? minPrice;
  final double? maxPrice;
  final String location;
  final String urgency;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const PropertyRequest(
      {required this.id,
      required this.buyerId,
      required this.propertyCategory,
      this.propertyType,
      this.minPrice,
      this.maxPrice,
      required this.location,
      required this.urgency,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['buyer_id'] = Variable<String>(buyerId);
    map['property_category'] = Variable<String>(propertyCategory);
    if (!nullToAbsent || propertyType != null) {
      map['property_type'] = Variable<String>(propertyType);
    }
    if (!nullToAbsent || minPrice != null) {
      map['min_price'] = Variable<double>(minPrice);
    }
    if (!nullToAbsent || maxPrice != null) {
      map['max_price'] = Variable<double>(maxPrice);
    }
    map['location'] = Variable<String>(location);
    map['urgency'] = Variable<String>(urgency);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  PropertyRequestsCompanion toCompanion(bool nullToAbsent) {
    return PropertyRequestsCompanion(
      id: Value(id),
      buyerId: Value(buyerId),
      propertyCategory: Value(propertyCategory),
      propertyType: propertyType == null && nullToAbsent
          ? const Value.absent()
          : Value(propertyType),
      minPrice: minPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(minPrice),
      maxPrice: maxPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(maxPrice),
      location: Value(location),
      urgency: Value(urgency),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory PropertyRequest.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PropertyRequest(
      id: serializer.fromJson<String>(json['id']),
      buyerId: serializer.fromJson<String>(json['buyerId']),
      propertyCategory: serializer.fromJson<String>(json['propertyCategory']),
      propertyType: serializer.fromJson<String?>(json['propertyType']),
      minPrice: serializer.fromJson<double?>(json['minPrice']),
      maxPrice: serializer.fromJson<double?>(json['maxPrice']),
      location: serializer.fromJson<String>(json['location']),
      urgency: serializer.fromJson<String>(json['urgency']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'buyerId': serializer.toJson<String>(buyerId),
      'propertyCategory': serializer.toJson<String>(propertyCategory),
      'propertyType': serializer.toJson<String?>(propertyType),
      'minPrice': serializer.toJson<double?>(minPrice),
      'maxPrice': serializer.toJson<double?>(maxPrice),
      'location': serializer.toJson<String>(location),
      'urgency': serializer.toJson<String>(urgency),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  PropertyRequest copyWith(
          {String? id,
          String? buyerId,
          String? propertyCategory,
          Value<String?> propertyType = const Value.absent(),
          Value<double?> minPrice = const Value.absent(),
          Value<double?> maxPrice = const Value.absent(),
          String? location,
          String? urgency,
          String? status,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncStatus}) =>
      PropertyRequest(
        id: id ?? this.id,
        buyerId: buyerId ?? this.buyerId,
        propertyCategory: propertyCategory ?? this.propertyCategory,
        propertyType:
            propertyType.present ? propertyType.value : this.propertyType,
        minPrice: minPrice.present ? minPrice.value : this.minPrice,
        maxPrice: maxPrice.present ? maxPrice.value : this.maxPrice,
        location: location ?? this.location,
        urgency: urgency ?? this.urgency,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  PropertyRequest copyWithCompanion(PropertyRequestsCompanion data) {
    return PropertyRequest(
      id: data.id.present ? data.id.value : this.id,
      buyerId: data.buyerId.present ? data.buyerId.value : this.buyerId,
      propertyCategory: data.propertyCategory.present
          ? data.propertyCategory.value
          : this.propertyCategory,
      propertyType: data.propertyType.present
          ? data.propertyType.value
          : this.propertyType,
      minPrice: data.minPrice.present ? data.minPrice.value : this.minPrice,
      maxPrice: data.maxPrice.present ? data.maxPrice.value : this.maxPrice,
      location: data.location.present ? data.location.value : this.location,
      urgency: data.urgency.present ? data.urgency.value : this.urgency,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PropertyRequest(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('propertyCategory: $propertyCategory, ')
          ..write('propertyType: $propertyType, ')
          ..write('minPrice: $minPrice, ')
          ..write('maxPrice: $maxPrice, ')
          ..write('location: $location, ')
          ..write('urgency: $urgency, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      buyerId,
      propertyCategory,
      propertyType,
      minPrice,
      maxPrice,
      location,
      urgency,
      status,
      createdAt,
      updatedAt,
      syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PropertyRequest &&
          other.id == this.id &&
          other.buyerId == this.buyerId &&
          other.propertyCategory == this.propertyCategory &&
          other.propertyType == this.propertyType &&
          other.minPrice == this.minPrice &&
          other.maxPrice == this.maxPrice &&
          other.location == this.location &&
          other.urgency == this.urgency &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class PropertyRequestsCompanion extends UpdateCompanion<PropertyRequest> {
  final Value<String> id;
  final Value<String> buyerId;
  final Value<String> propertyCategory;
  final Value<String?> propertyType;
  final Value<double?> minPrice;
  final Value<double?> maxPrice;
  final Value<String> location;
  final Value<String> urgency;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const PropertyRequestsCompanion({
    this.id = const Value.absent(),
    this.buyerId = const Value.absent(),
    this.propertyCategory = const Value.absent(),
    this.propertyType = const Value.absent(),
    this.minPrice = const Value.absent(),
    this.maxPrice = const Value.absent(),
    this.location = const Value.absent(),
    this.urgency = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PropertyRequestsCompanion.insert({
    required String id,
    required String buyerId,
    required String propertyCategory,
    this.propertyType = const Value.absent(),
    this.minPrice = const Value.absent(),
    this.maxPrice = const Value.absent(),
    required String location,
    required String urgency,
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        buyerId = Value(buyerId),
        propertyCategory = Value(propertyCategory),
        location = Value(location),
        urgency = Value(urgency),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PropertyRequest> custom({
    Expression<String>? id,
    Expression<String>? buyerId,
    Expression<String>? propertyCategory,
    Expression<String>? propertyType,
    Expression<double>? minPrice,
    Expression<double>? maxPrice,
    Expression<String>? location,
    Expression<String>? urgency,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buyerId != null) 'buyer_id': buyerId,
      if (propertyCategory != null) 'property_category': propertyCategory,
      if (propertyType != null) 'property_type': propertyType,
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
      if (location != null) 'location': location,
      if (urgency != null) 'urgency': urgency,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PropertyRequestsCompanion copyWith(
      {Value<String>? id,
      Value<String>? buyerId,
      Value<String>? propertyCategory,
      Value<String?>? propertyType,
      Value<double?>? minPrice,
      Value<double?>? maxPrice,
      Value<String>? location,
      Value<String>? urgency,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return PropertyRequestsCompanion(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      propertyCategory: propertyCategory ?? this.propertyCategory,
      propertyType: propertyType ?? this.propertyType,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      location: location ?? this.location,
      urgency: urgency ?? this.urgency,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (buyerId.present) {
      map['buyer_id'] = Variable<String>(buyerId.value);
    }
    if (propertyCategory.present) {
      map['property_category'] = Variable<String>(propertyCategory.value);
    }
    if (propertyType.present) {
      map['property_type'] = Variable<String>(propertyType.value);
    }
    if (minPrice.present) {
      map['min_price'] = Variable<double>(minPrice.value);
    }
    if (maxPrice.present) {
      map['max_price'] = Variable<double>(maxPrice.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (urgency.present) {
      map['urgency'] = Variable<String>(urgency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PropertyRequestsCompanion(')
          ..write('id: $id, ')
          ..write('buyerId: $buyerId, ')
          ..write('propertyCategory: $propertyCategory, ')
          ..write('propertyType: $propertyType, ')
          ..write('minPrice: $minPrice, ')
          ..write('maxPrice: $maxPrice, ')
          ..write('location: $location, ')
          ..write('urgency: $urgency, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTable extends Notifications
    with TableInfo<$NotificationsTable, Notification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _messageMeta =
      const VerificationMeta('message');
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
      'message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
      'is_read', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_read" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _relatedIdMeta =
      const VerificationMeta('relatedId');
  @override
  late final GeneratedColumn<String> relatedId = GeneratedColumn<String>(
      'related_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('synced'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, title, message, isRead, relatedId, createdAt, syncStatus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(Insertable<Notification> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta,
          message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('is_read')) {
      context.handle(_isReadMeta,
          isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    }
    if (data.containsKey('related_id')) {
      context.handle(_relatedIdMeta,
          relatedId.isAcceptableOrUnknown(data['related_id']!, _relatedIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Notification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Notification(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      message: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      isRead: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_read'])!,
      relatedId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}related_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $NotificationsTable createAlias(String alias) {
    return $NotificationsTable(attachedDatabase, alias);
  }
}

class Notification extends DataClass implements Insertable<Notification> {
  final String id;
  final String userId;
  final String title;
  final String message;
  final bool isRead;
  final String? relatedId;
  final DateTime createdAt;
  final String syncStatus;
  const Notification(
      {required this.id,
      required this.userId,
      required this.title,
      required this.message,
      required this.isRead,
      this.relatedId,
      required this.createdAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || relatedId != null) {
      map['related_id'] = Variable<String>(relatedId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  NotificationsCompanion toCompanion(bool nullToAbsent) {
    return NotificationsCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      message: Value(message),
      isRead: Value(isRead),
      relatedId: relatedId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedId),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory Notification.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Notification(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      relatedId: serializer.fromJson<String?>(json['relatedId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'isRead': serializer.toJson<bool>(isRead),
      'relatedId': serializer.toJson<String?>(relatedId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  Notification copyWith(
          {String? id,
          String? userId,
          String? title,
          String? message,
          bool? isRead,
          Value<String?> relatedId = const Value.absent(),
          DateTime? createdAt,
          String? syncStatus}) =>
      Notification(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        message: message ?? this.message,
        isRead: isRead ?? this.isRead,
        relatedId: relatedId.present ? relatedId.value : this.relatedId,
        createdAt: createdAt ?? this.createdAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  Notification copyWithCompanion(NotificationsCompanion data) {
    return Notification(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      relatedId: data.relatedId.present ? data.relatedId.value : this.relatedId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Notification(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('isRead: $isRead, ')
          ..write('relatedId: $relatedId, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, title, message, isRead, relatedId, createdAt, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Notification &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.message == this.message &&
          other.isRead == this.isRead &&
          other.relatedId == this.relatedId &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class NotificationsCompanion extends UpdateCompanion<Notification> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<String> message;
  final Value<bool> isRead;
  final Value<String?> relatedId;
  final Value<DateTime> createdAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const NotificationsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.isRead = const Value.absent(),
    this.relatedId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsCompanion.insert({
    required String id,
    required String userId,
    required String title,
    required String message,
    this.isRead = const Value.absent(),
    this.relatedId = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        title = Value(title),
        message = Value(message),
        createdAt = Value(createdAt);
  static Insertable<Notification> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? message,
    Expression<bool>? isRead,
    Expression<String>? relatedId,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (isRead != null) 'is_read': isRead,
      if (relatedId != null) 'related_id': relatedId,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? title,
      Value<String>? message,
      Value<bool>? isRead,
      Value<String?>? relatedId,
      Value<DateTime>? createdAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return NotificationsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      relatedId: relatedId ?? this.relatedId,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (relatedId.present) {
      map['related_id'] = Variable<String>(relatedId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('isRead: $isRead, ')
          ..write('relatedId: $relatedId, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $PropertiesTable properties = $PropertiesTable(this);
  late final $PropertyImagesTable propertyImages = $PropertyImagesTable(this);
  late final $ContractsTable contracts = $ContractsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $PurchaseRequestsTable purchaseRequests =
      $PurchaseRequestsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $PropertyRequestsTable propertyRequests =
      $PropertyRequestsTable(this);
  late final $NotificationsTable notifications = $NotificationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        properties,
        propertyImages,
        contracts,
        payments,
        purchaseRequests,
        settings,
        propertyRequests,
        notifications
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('properties',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('property_images', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String username,
  required String passwordHash,
  required String email,
  required String fullName,
  Value<String?> fullNameAr,
  Value<String?> phone,
  Value<String?> nationalId,
  required String role,
  Value<String?> logoUrl,
  Value<String?> address,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<bool> isActive,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> username,
  Value<String> passwordHash,
  Value<String> email,
  Value<String> fullName,
  Value<String?> fullNameAr,
  Value<String?> phone,
  Value<String?> nationalId,
  Value<String> role,
  Value<String?> logoUrl,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<bool> isActive,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PropertiesTable, List<Property>>
      _propertiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.properties,
          aliasName: $_aliasNameGenerator(db.users.id, db.properties.ownerId));

  $$PropertiesTableProcessedTableManager get propertiesRefs {
    final manager = $$PropertiesTableTableManager($_db, $_db.properties)
        .filter((f) => f.ownerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_propertiesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.payments,
          aliasName: $_aliasNameGenerator(db.users.id, db.payments.payerId));

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.payerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PurchaseRequestsTable, List<PurchaseRequest>>
      _purchaseRequestsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.purchaseRequests,
              aliasName: $_aliasNameGenerator(
                  db.users.id, db.purchaseRequests.buyerId));

  $$PurchaseRequestsTableProcessedTableManager get purchaseRequestsRefs {
    final manager =
        $$PurchaseRequestsTableTableManager($_db, $_db.purchaseRequests)
            .filter((f) => f.buyerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_purchaseRequestsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PropertyRequestsTable, List<PropertyRequest>>
      _propertyRequestsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.propertyRequests,
              aliasName: $_aliasNameGenerator(
                  db.users.id, db.propertyRequests.buyerId));

  $$PropertyRequestsTableProcessedTableManager get propertyRequestsRefs {
    final manager =
        $$PropertyRequestsTableTableManager($_db, $_db.propertyRequests)
            .filter((f) => f.buyerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_propertyRequestsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$NotificationsTable, List<Notification>>
      _notificationsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.notifications,
              aliasName:
                  $_aliasNameGenerator(db.users.id, db.notifications.userId));

  $$NotificationsTableProcessedTableManager get notificationsRefs {
    final manager = $$NotificationsTableTableManager($_db, $_db.notifications)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_notificationsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullNameAr => $composableBuilder(
      column: $table.fullNameAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoUrl => $composableBuilder(
      column: $table.logoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  Expression<bool> propertiesRefs(
      Expression<bool> Function($$PropertiesTableFilterComposer f) f) {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.ownerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableFilterComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> paymentsRefs(
      Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.payerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> purchaseRequestsRefs(
      Expression<bool> Function($$PurchaseRequestsTableFilterComposer f) f) {
    final $$PurchaseRequestsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.purchaseRequests,
        getReferencedColumn: (t) => t.buyerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRequestsTableFilterComposer(
              $db: $db,
              $table: $db.purchaseRequests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> propertyRequestsRefs(
      Expression<bool> Function($$PropertyRequestsTableFilterComposer f) f) {
    final $$PropertyRequestsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.propertyRequests,
        getReferencedColumn: (t) => t.buyerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertyRequestsTableFilterComposer(
              $db: $db,
              $table: $db.propertyRequests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> notificationsRefs(
      Expression<bool> Function($$NotificationsTableFilterComposer f) f) {
    final $$NotificationsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.notifications,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NotificationsTableFilterComposer(
              $db: $db,
              $table: $db.notifications,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullNameAr => $composableBuilder(
      column: $table.fullNameAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoUrl => $composableBuilder(
      column: $table.logoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
      column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get fullNameAr => $composableBuilder(
      column: $table.fullNameAr, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get nationalId => $composableBuilder(
      column: $table.nationalId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  Expression<T> propertiesRefs<T extends Object>(
      Expression<T> Function($$PropertiesTableAnnotationComposer a) f) {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.ownerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableAnnotationComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
      Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.payerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> purchaseRequestsRefs<T extends Object>(
      Expression<T> Function($$PurchaseRequestsTableAnnotationComposer a) f) {
    final $$PurchaseRequestsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.purchaseRequests,
        getReferencedColumn: (t) => t.buyerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRequestsTableAnnotationComposer(
              $db: $db,
              $table: $db.purchaseRequests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> propertyRequestsRefs<T extends Object>(
      Expression<T> Function($$PropertyRequestsTableAnnotationComposer a) f) {
    final $$PropertyRequestsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.propertyRequests,
        getReferencedColumn: (t) => t.buyerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertyRequestsTableAnnotationComposer(
              $db: $db,
              $table: $db.propertyRequests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> notificationsRefs<T extends Object>(
      Expression<T> Function($$NotificationsTableAnnotationComposer a) f) {
    final $$NotificationsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.notifications,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$NotificationsTableAnnotationComposer(
              $db: $db,
              $table: $db.notifications,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool propertiesRefs,
        bool paymentsRefs,
        bool purchaseRequestsRefs,
        bool propertyRequestsRefs,
        bool notificationsRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> username = const Value.absent(),
            Value<String> passwordHash = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String?> fullNameAr = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> nationalId = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> logoUrl = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            username: username,
            passwordHash: passwordHash,
            email: email,
            fullName: fullName,
            fullNameAr: fullNameAr,
            phone: phone,
            nationalId: nationalId,
            role: role,
            logoUrl: logoUrl,
            address: address,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isActive: isActive,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String username,
            required String passwordHash,
            required String email,
            required String fullName,
            Value<String?> fullNameAr = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> nationalId = const Value.absent(),
            required String role,
            Value<String?> logoUrl = const Value.absent(),
            Value<String?> address = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<bool> isActive = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            username: username,
            passwordHash: passwordHash,
            email: email,
            fullName: fullName,
            fullNameAr: fullNameAr,
            phone: phone,
            nationalId: nationalId,
            role: role,
            logoUrl: logoUrl,
            address: address,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isActive: isActive,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {propertiesRefs = false,
              paymentsRefs = false,
              purchaseRequestsRefs = false,
              propertyRequestsRefs = false,
              notificationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (propertiesRefs) db.properties,
                if (paymentsRefs) db.payments,
                if (purchaseRequestsRefs) db.purchaseRequests,
                if (propertyRequestsRefs) db.propertyRequests,
                if (notificationsRefs) db.notifications
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (propertiesRefs)
                    await $_getPrefetchedData<User, $UsersTable, Property>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._propertiesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .propertiesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.ownerId == item.id),
                        typedResults: items),
                  if (paymentsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Payment>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).paymentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.payerId == item.id),
                        typedResults: items),
                  if (purchaseRequestsRefs)
                    await $_getPrefetchedData<User, $UsersTable,
                            PurchaseRequest>(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._purchaseRequestsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .purchaseRequestsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.buyerId == item.id),
                        typedResults: items),
                  if (propertyRequestsRefs)
                    await $_getPrefetchedData<User, $UsersTable,
                            PropertyRequest>(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._propertyRequestsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .propertyRequestsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.buyerId == item.id),
                        typedResults: items),
                  if (notificationsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Notification>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._notificationsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .notificationsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool propertiesRefs,
        bool paymentsRefs,
        bool purchaseRequestsRefs,
        bool propertyRequestsRefs,
        bool notificationsRefs})>;
typedef $$PropertiesTableCreateCompanionBuilder = PropertiesCompanion Function({
  required String id,
  required String ownerId,
  required String title,
  Value<String?> titleAr,
  Value<String?> description,
  Value<String?> descriptionAr,
  required String propertyType,
  Value<String?> propertyCategory,
  required String listingType,
  required double price,
  required double area,
  Value<int?> bedrooms,
  Value<int?> bathrooms,
  required String address,
  required String city,
  required String country,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String> status,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$PropertiesTableUpdateCompanionBuilder = PropertiesCompanion Function({
  Value<String> id,
  Value<String> ownerId,
  Value<String> title,
  Value<String?> titleAr,
  Value<String?> description,
  Value<String?> descriptionAr,
  Value<String> propertyType,
  Value<String?> propertyCategory,
  Value<String> listingType,
  Value<double> price,
  Value<double> area,
  Value<int?> bedrooms,
  Value<int?> bathrooms,
  Value<String> address,
  Value<String> city,
  Value<String> country,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$PropertiesTableReferences
    extends BaseReferences<_$AppDatabase, $PropertiesTable, Property> {
  $$PropertiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _ownerIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.properties.ownerId, db.users.id));

  $$UsersTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PropertyImagesTable, List<PropertyImage>>
      _propertyImagesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.propertyImages,
              aliasName: $_aliasNameGenerator(
                  db.properties.id, db.propertyImages.propertyId));

  $$PropertyImagesTableProcessedTableManager get propertyImagesRefs {
    final manager = $$PropertyImagesTableTableManager($_db, $_db.propertyImages)
        .filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_propertyImagesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ContractsTable, List<Contract>>
      _contractsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.contracts,
          aliasName:
              $_aliasNameGenerator(db.properties.id, db.contracts.propertyId));

  $$ContractsTableProcessedTableManager get contractsRefs {
    final manager = $$ContractsTableTableManager($_db, $_db.contracts)
        .filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_contractsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PurchaseRequestsTable, List<PurchaseRequest>>
      _purchaseRequestsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.purchaseRequests,
              aliasName: $_aliasNameGenerator(
                  db.properties.id, db.purchaseRequests.propertyId));

  $$PurchaseRequestsTableProcessedTableManager get purchaseRequestsRefs {
    final manager = $$PurchaseRequestsTableTableManager(
            $_db, $_db.purchaseRequests)
        .filter((f) => f.propertyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_purchaseRequestsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PropertiesTableFilterComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get titleAr => $composableBuilder(
      column: $table.titleAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get propertyType => $composableBuilder(
      column: $table.propertyType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get propertyCategory => $composableBuilder(
      column: $table.propertyCategory,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get listingType => $composableBuilder(
      column: $table.listingType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get area => $composableBuilder(
      column: $table.area, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bedrooms => $composableBuilder(
      column: $table.bedrooms, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bathrooms => $composableBuilder(
      column: $table.bathrooms, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get ownerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> propertyImagesRefs(
      Expression<bool> Function($$PropertyImagesTableFilterComposer f) f) {
    final $$PropertyImagesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.propertyImages,
        getReferencedColumn: (t) => t.propertyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertyImagesTableFilterComposer(
              $db: $db,
              $table: $db.propertyImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> contractsRefs(
      Expression<bool> Function($$ContractsTableFilterComposer f) f) {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.contracts,
        getReferencedColumn: (t) => t.propertyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContractsTableFilterComposer(
              $db: $db,
              $table: $db.contracts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> purchaseRequestsRefs(
      Expression<bool> Function($$PurchaseRequestsTableFilterComposer f) f) {
    final $$PurchaseRequestsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.purchaseRequests,
        getReferencedColumn: (t) => t.propertyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRequestsTableFilterComposer(
              $db: $db,
              $table: $db.purchaseRequests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PropertiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get titleAr => $composableBuilder(
      column: $table.titleAr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get propertyType => $composableBuilder(
      column: $table.propertyType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get propertyCategory => $composableBuilder(
      column: $table.propertyCategory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get listingType => $composableBuilder(
      column: $table.listingType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get area => $composableBuilder(
      column: $table.area, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bedrooms => $composableBuilder(
      column: $table.bedrooms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bathrooms => $composableBuilder(
      column: $table.bathrooms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get country => $composableBuilder(
      column: $table.country, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get ownerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertiesTable> {
  $$PropertiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get titleAr =>
      $composableBuilder(column: $table.titleAr, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr, builder: (column) => column);

  GeneratedColumn<String> get propertyType => $composableBuilder(
      column: $table.propertyType, builder: (column) => column);

  GeneratedColumn<String> get propertyCategory => $composableBuilder(
      column: $table.propertyCategory, builder: (column) => column);

  GeneratedColumn<String> get listingType => $composableBuilder(
      column: $table.listingType, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<int> get bedrooms =>
      $composableBuilder(column: $table.bedrooms, builder: (column) => column);

  GeneratedColumn<int> get bathrooms =>
      $composableBuilder(column: $table.bathrooms, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  $$UsersTableAnnotationComposer get ownerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> propertyImagesRefs<T extends Object>(
      Expression<T> Function($$PropertyImagesTableAnnotationComposer a) f) {
    final $$PropertyImagesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.propertyImages,
        getReferencedColumn: (t) => t.propertyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertyImagesTableAnnotationComposer(
              $db: $db,
              $table: $db.propertyImages,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> contractsRefs<T extends Object>(
      Expression<T> Function($$ContractsTableAnnotationComposer a) f) {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.contracts,
        getReferencedColumn: (t) => t.propertyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContractsTableAnnotationComposer(
              $db: $db,
              $table: $db.contracts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> purchaseRequestsRefs<T extends Object>(
      Expression<T> Function($$PurchaseRequestsTableAnnotationComposer a) f) {
    final $$PurchaseRequestsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.purchaseRequests,
        getReferencedColumn: (t) => t.propertyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PurchaseRequestsTableAnnotationComposer(
              $db: $db,
              $table: $db.purchaseRequests,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PropertiesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PropertiesTable,
    Property,
    $$PropertiesTableFilterComposer,
    $$PropertiesTableOrderingComposer,
    $$PropertiesTableAnnotationComposer,
    $$PropertiesTableCreateCompanionBuilder,
    $$PropertiesTableUpdateCompanionBuilder,
    (Property, $$PropertiesTableReferences),
    Property,
    PrefetchHooks Function(
        {bool ownerId,
        bool propertyImagesRefs,
        bool contractsRefs,
        bool purchaseRequestsRefs})> {
  $$PropertiesTableTableManager(_$AppDatabase db, $PropertiesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> ownerId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> titleAr = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> descriptionAr = const Value.absent(),
            Value<String> propertyType = const Value.absent(),
            Value<String?> propertyCategory = const Value.absent(),
            Value<String> listingType = const Value.absent(),
            Value<double> price = const Value.absent(),
            Value<double> area = const Value.absent(),
            Value<int?> bedrooms = const Value.absent(),
            Value<int?> bathrooms = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<String> country = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PropertiesCompanion(
            id: id,
            ownerId: ownerId,
            title: title,
            titleAr: titleAr,
            description: description,
            descriptionAr: descriptionAr,
            propertyType: propertyType,
            propertyCategory: propertyCategory,
            listingType: listingType,
            price: price,
            area: area,
            bedrooms: bedrooms,
            bathrooms: bathrooms,
            address: address,
            city: city,
            country: country,
            latitude: latitude,
            longitude: longitude,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String ownerId,
            required String title,
            Value<String?> titleAr = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> descriptionAr = const Value.absent(),
            required String propertyType,
            Value<String?> propertyCategory = const Value.absent(),
            required String listingType,
            required double price,
            required double area,
            Value<int?> bedrooms = const Value.absent(),
            Value<int?> bathrooms = const Value.absent(),
            required String address,
            required String city,
            required String country,
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String> status = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PropertiesCompanion.insert(
            id: id,
            ownerId: ownerId,
            title: title,
            titleAr: titleAr,
            description: description,
            descriptionAr: descriptionAr,
            propertyType: propertyType,
            propertyCategory: propertyCategory,
            listingType: listingType,
            price: price,
            area: area,
            bedrooms: bedrooms,
            bathrooms: bathrooms,
            address: address,
            city: city,
            country: country,
            latitude: latitude,
            longitude: longitude,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PropertiesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {ownerId = false,
              propertyImagesRefs = false,
              contractsRefs = false,
              purchaseRequestsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (propertyImagesRefs) db.propertyImages,
                if (contractsRefs) db.contracts,
                if (purchaseRequestsRefs) db.purchaseRequests
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (ownerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ownerId,
                    referencedTable:
                        $$PropertiesTableReferences._ownerIdTable(db),
                    referencedColumn:
                        $$PropertiesTableReferences._ownerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (propertyImagesRefs)
                    await $_getPrefetchedData<Property, $PropertiesTable,
                            PropertyImage>(
                        currentTable: table,
                        referencedTable: $$PropertiesTableReferences
                            ._propertyImagesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PropertiesTableReferences(db, table, p0)
                                .propertyImagesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.propertyId == item.id),
                        typedResults: items),
                  if (contractsRefs)
                    await $_getPrefetchedData<Property, $PropertiesTable,
                            Contract>(
                        currentTable: table,
                        referencedTable:
                            $$PropertiesTableReferences._contractsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PropertiesTableReferences(db, table, p0)
                                .contractsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.propertyId == item.id),
                        typedResults: items),
                  if (purchaseRequestsRefs)
                    await $_getPrefetchedData<Property, $PropertiesTable,
                            PurchaseRequest>(
                        currentTable: table,
                        referencedTable: $$PropertiesTableReferences
                            ._purchaseRequestsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PropertiesTableReferences(db, table, p0)
                                .purchaseRequestsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.propertyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PropertiesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PropertiesTable,
    Property,
    $$PropertiesTableFilterComposer,
    $$PropertiesTableOrderingComposer,
    $$PropertiesTableAnnotationComposer,
    $$PropertiesTableCreateCompanionBuilder,
    $$PropertiesTableUpdateCompanionBuilder,
    (Property, $$PropertiesTableReferences),
    Property,
    PrefetchHooks Function(
        {bool ownerId,
        bool propertyImagesRefs,
        bool contractsRefs,
        bool purchaseRequestsRefs})>;
typedef $$PropertyImagesTableCreateCompanionBuilder = PropertyImagesCompanion
    Function({
  required String id,
  required String propertyId,
  required String imageUrl,
  Value<String?> thumbnailUrl,
  Value<bool> isPrimary,
  Value<int> displayOrder,
  required DateTime createdAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$PropertyImagesTableUpdateCompanionBuilder = PropertyImagesCompanion
    Function({
  Value<String> id,
  Value<String> propertyId,
  Value<String> imageUrl,
  Value<String?> thumbnailUrl,
  Value<bool> isPrimary,
  Value<int> displayOrder,
  Value<DateTime> createdAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$PropertyImagesTableReferences
    extends BaseReferences<_$AppDatabase, $PropertyImagesTable, PropertyImage> {
  $$PropertyImagesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias(
          $_aliasNameGenerator(db.propertyImages.propertyId, db.properties.id));

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager($_db, $_db.properties)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PropertyImagesTableFilterComposer
    extends Composer<_$AppDatabase, $PropertyImagesTable> {
  $$PropertyImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get thumbnailUrl => $composableBuilder(
      column: $table.thumbnailUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPrimary => $composableBuilder(
      column: $table.isPrimary, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableFilterComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertyImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertyImagesTable> {
  $$PropertyImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get thumbnailUrl => $composableBuilder(
      column: $table.thumbnailUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
      column: $table.isPrimary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableOrderingComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertyImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertyImagesTable> {
  $$PropertyImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get thumbnailUrl => $composableBuilder(
      column: $table.thumbnailUrl, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableAnnotationComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertyImagesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PropertyImagesTable,
    PropertyImage,
    $$PropertyImagesTableFilterComposer,
    $$PropertyImagesTableOrderingComposer,
    $$PropertyImagesTableAnnotationComposer,
    $$PropertyImagesTableCreateCompanionBuilder,
    $$PropertyImagesTableUpdateCompanionBuilder,
    (PropertyImage, $$PropertyImagesTableReferences),
    PropertyImage,
    PrefetchHooks Function({bool propertyId})> {
  $$PropertyImagesTableTableManager(
      _$AppDatabase db, $PropertyImagesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertyImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertyImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertyImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> propertyId = const Value.absent(),
            Value<String> imageUrl = const Value.absent(),
            Value<String?> thumbnailUrl = const Value.absent(),
            Value<bool> isPrimary = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PropertyImagesCompanion(
            id: id,
            propertyId: propertyId,
            imageUrl: imageUrl,
            thumbnailUrl: thumbnailUrl,
            isPrimary: isPrimary,
            displayOrder: displayOrder,
            createdAt: createdAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String propertyId,
            required String imageUrl,
            Value<String?> thumbnailUrl = const Value.absent(),
            Value<bool> isPrimary = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            required DateTime createdAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PropertyImagesCompanion.insert(
            id: id,
            propertyId: propertyId,
            imageUrl: imageUrl,
            thumbnailUrl: thumbnailUrl,
            isPrimary: isPrimary,
            displayOrder: displayOrder,
            createdAt: createdAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PropertyImagesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({propertyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (propertyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.propertyId,
                    referencedTable:
                        $$PropertyImagesTableReferences._propertyIdTable(db),
                    referencedColumn:
                        $$PropertyImagesTableReferences._propertyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PropertyImagesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PropertyImagesTable,
    PropertyImage,
    $$PropertyImagesTableFilterComposer,
    $$PropertyImagesTableOrderingComposer,
    $$PropertyImagesTableAnnotationComposer,
    $$PropertyImagesTableCreateCompanionBuilder,
    $$PropertyImagesTableUpdateCompanionBuilder,
    (PropertyImage, $$PropertyImagesTableReferences),
    PropertyImage,
    PrefetchHooks Function({bool propertyId})>;
typedef $$ContractsTableCreateCompanionBuilder = ContractsCompanion Function({
  required String id,
  required String propertyId,
  required String ownerId,
  required String tenantBuyerId,
  required String contractType,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<double?> monthlyRent,
  Value<double?> salePrice,
  Value<double?> depositAmount,
  Value<String?> terms,
  Value<String?> description,
  Value<String?> descriptionAr,
  Value<String?> concessions,
  Value<String?> fileUrl,
  Value<String> paymentFrequency,
  Value<int?> customFrequencyDays,
  Value<String> status,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$ContractsTableUpdateCompanionBuilder = ContractsCompanion Function({
  Value<String> id,
  Value<String> propertyId,
  Value<String> ownerId,
  Value<String> tenantBuyerId,
  Value<String> contractType,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<double?> monthlyRent,
  Value<double?> salePrice,
  Value<double?> depositAmount,
  Value<String?> terms,
  Value<String?> description,
  Value<String?> descriptionAr,
  Value<String?> concessions,
  Value<String?> fileUrl,
  Value<String> paymentFrequency,
  Value<int?> customFrequencyDays,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$ContractsTableReferences
    extends BaseReferences<_$AppDatabase, $ContractsTable, Contract> {
  $$ContractsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias(
          $_aliasNameGenerator(db.contracts.propertyId, db.properties.id));

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager($_db, $_db.properties)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _ownerIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.contracts.ownerId, db.users.id));

  $$UsersTableProcessedTableManager get ownerId {
    final $_column = $_itemColumn<String>('owner_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ownerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _tenantBuyerIdTable(_$AppDatabase db) =>
      db.users.createAlias(
          $_aliasNameGenerator(db.contracts.tenantBuyerId, db.users.id));

  $$UsersTableProcessedTableManager get tenantBuyerId {
    final $_column = $_itemColumn<String>('tenant_buyer_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenantBuyerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PaymentsTable, List<Payment>> _paymentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.payments,
          aliasName:
              $_aliasNameGenerator(db.contracts.id, db.payments.contractId));

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager($_db, $_db.payments)
        .filter((f) => f.contractId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ContractsTableFilterComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contractType => $composableBuilder(
      column: $table.contractType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get monthlyRent => $composableBuilder(
      column: $table.monthlyRent, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get salePrice => $composableBuilder(
      column: $table.salePrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get depositAmount => $composableBuilder(
      column: $table.depositAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get terms => $composableBuilder(
      column: $table.terms, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get concessions => $composableBuilder(
      column: $table.concessions, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentFrequency => $composableBuilder(
      column: $table.paymentFrequency,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customFrequencyDays => $composableBuilder(
      column: $table.customFrequencyDays,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableFilterComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get ownerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get tenantBuyerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tenantBuyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> paymentsRefs(
      Expression<bool> Function($$PaymentsTableFilterComposer f) f) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.contractId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableFilterComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContractsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contractType => $composableBuilder(
      column: $table.contractType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get monthlyRent => $composableBuilder(
      column: $table.monthlyRent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get salePrice => $composableBuilder(
      column: $table.salePrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get depositAmount => $composableBuilder(
      column: $table.depositAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get terms => $composableBuilder(
      column: $table.terms, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get concessions => $composableBuilder(
      column: $table.concessions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileUrl => $composableBuilder(
      column: $table.fileUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentFrequency => $composableBuilder(
      column: $table.paymentFrequency,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customFrequencyDays => $composableBuilder(
      column: $table.customFrequencyDays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableOrderingComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get ownerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get tenantBuyerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tenantBuyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ContractsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContractsTable> {
  $$ContractsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contractType => $composableBuilder(
      column: $table.contractType, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<double> get monthlyRent => $composableBuilder(
      column: $table.monthlyRent, builder: (column) => column);

  GeneratedColumn<double> get salePrice =>
      $composableBuilder(column: $table.salePrice, builder: (column) => column);

  GeneratedColumn<double> get depositAmount => $composableBuilder(
      column: $table.depositAmount, builder: (column) => column);

  GeneratedColumn<String> get terms =>
      $composableBuilder(column: $table.terms, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get descriptionAr => $composableBuilder(
      column: $table.descriptionAr, builder: (column) => column);

  GeneratedColumn<String> get concessions => $composableBuilder(
      column: $table.concessions, builder: (column) => column);

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);

  GeneratedColumn<String> get paymentFrequency => $composableBuilder(
      column: $table.paymentFrequency, builder: (column) => column);

  GeneratedColumn<int> get customFrequencyDays => $composableBuilder(
      column: $table.customFrequencyDays, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableAnnotationComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get ownerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ownerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get tenantBuyerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tenantBuyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> paymentsRefs<T extends Object>(
      Expression<T> Function($$PaymentsTableAnnotationComposer a) f) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.payments,
        getReferencedColumn: (t) => t.contractId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PaymentsTableAnnotationComposer(
              $db: $db,
              $table: $db.payments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContractsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContractsTable,
    Contract,
    $$ContractsTableFilterComposer,
    $$ContractsTableOrderingComposer,
    $$ContractsTableAnnotationComposer,
    $$ContractsTableCreateCompanionBuilder,
    $$ContractsTableUpdateCompanionBuilder,
    (Contract, $$ContractsTableReferences),
    Contract,
    PrefetchHooks Function(
        {bool propertyId,
        bool ownerId,
        bool tenantBuyerId,
        bool paymentsRefs})> {
  $$ContractsTableTableManager(_$AppDatabase db, $ContractsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContractsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContractsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContractsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> propertyId = const Value.absent(),
            Value<String> ownerId = const Value.absent(),
            Value<String> tenantBuyerId = const Value.absent(),
            Value<String> contractType = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<double?> monthlyRent = const Value.absent(),
            Value<double?> salePrice = const Value.absent(),
            Value<double?> depositAmount = const Value.absent(),
            Value<String?> terms = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> descriptionAr = const Value.absent(),
            Value<String?> concessions = const Value.absent(),
            Value<String?> fileUrl = const Value.absent(),
            Value<String> paymentFrequency = const Value.absent(),
            Value<int?> customFrequencyDays = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ContractsCompanion(
            id: id,
            propertyId: propertyId,
            ownerId: ownerId,
            tenantBuyerId: tenantBuyerId,
            contractType: contractType,
            startDate: startDate,
            endDate: endDate,
            monthlyRent: monthlyRent,
            salePrice: salePrice,
            depositAmount: depositAmount,
            terms: terms,
            description: description,
            descriptionAr: descriptionAr,
            concessions: concessions,
            fileUrl: fileUrl,
            paymentFrequency: paymentFrequency,
            customFrequencyDays: customFrequencyDays,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String propertyId,
            required String ownerId,
            required String tenantBuyerId,
            required String contractType,
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<double?> monthlyRent = const Value.absent(),
            Value<double?> salePrice = const Value.absent(),
            Value<double?> depositAmount = const Value.absent(),
            Value<String?> terms = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> descriptionAr = const Value.absent(),
            Value<String?> concessions = const Value.absent(),
            Value<String?> fileUrl = const Value.absent(),
            Value<String> paymentFrequency = const Value.absent(),
            Value<int?> customFrequencyDays = const Value.absent(),
            Value<String> status = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ContractsCompanion.insert(
            id: id,
            propertyId: propertyId,
            ownerId: ownerId,
            tenantBuyerId: tenantBuyerId,
            contractType: contractType,
            startDate: startDate,
            endDate: endDate,
            monthlyRent: monthlyRent,
            salePrice: salePrice,
            depositAmount: depositAmount,
            terms: terms,
            description: description,
            descriptionAr: descriptionAr,
            concessions: concessions,
            fileUrl: fileUrl,
            paymentFrequency: paymentFrequency,
            customFrequencyDays: customFrequencyDays,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ContractsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {propertyId = false,
              ownerId = false,
              tenantBuyerId = false,
              paymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (paymentsRefs) db.payments],
              addJoins: <
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
                      dynamic>>(state) {
                if (propertyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.propertyId,
                    referencedTable:
                        $$ContractsTableReferences._propertyIdTable(db),
                    referencedColumn:
                        $$ContractsTableReferences._propertyIdTable(db).id,
                  ) as T;
                }
                if (ownerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ownerId,
                    referencedTable:
                        $$ContractsTableReferences._ownerIdTable(db),
                    referencedColumn:
                        $$ContractsTableReferences._ownerIdTable(db).id,
                  ) as T;
                }
                if (tenantBuyerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tenantBuyerId,
                    referencedTable:
                        $$ContractsTableReferences._tenantBuyerIdTable(db),
                    referencedColumn:
                        $$ContractsTableReferences._tenantBuyerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (paymentsRefs)
                    await $_getPrefetchedData<Contract, $ContractsTable,
                            Payment>(
                        currentTable: table,
                        referencedTable:
                            $$ContractsTableReferences._paymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContractsTableReferences(db, table, p0)
                                .paymentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contractId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ContractsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContractsTable,
    Contract,
    $$ContractsTableFilterComposer,
    $$ContractsTableOrderingComposer,
    $$ContractsTableAnnotationComposer,
    $$ContractsTableCreateCompanionBuilder,
    $$ContractsTableUpdateCompanionBuilder,
    (Contract, $$ContractsTableReferences),
    Contract,
    PrefetchHooks Function(
        {bool propertyId,
        bool ownerId,
        bool tenantBuyerId,
        bool paymentsRefs})>;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  required String id,
  required String contractId,
  required String payerId,
  required double amount,
  required DateTime paymentDate,
  Value<DateTime?> dueDate,
  required String paymentType,
  Value<String?> paymentMethod,
  Value<String> status,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<String> id,
  Value<String> contractId,
  Value<String> payerId,
  Value<double> amount,
  Value<DateTime> paymentDate,
  Value<DateTime?> dueDate,
  Value<String> paymentType,
  Value<String?> paymentMethod,
  Value<String> status,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, Payment> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ContractsTable _contractIdTable(_$AppDatabase db) =>
      db.contracts.createAlias(
          $_aliasNameGenerator(db.payments.contractId, db.contracts.id));

  $$ContractsTableProcessedTableManager get contractId {
    final $_column = $_itemColumn<String>('contract_id')!;

    final manager = $$ContractsTableTableManager($_db, $_db.contracts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contractIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _payerIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.payments.payerId, db.users.id));

  $$UsersTableProcessedTableManager get payerId {
    final $_column = $_itemColumn<String>('payer_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_payerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  $$ContractsTableFilterComposer get contractId {
    final $$ContractsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contractId,
        referencedTable: $db.contracts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContractsTableFilterComposer(
              $db: $db,
              $table: $db.contracts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get payerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.payerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  $$ContractsTableOrderingComposer get contractId {
    final $$ContractsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contractId,
        referencedTable: $db.contracts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContractsTableOrderingComposer(
              $db: $db,
              $table: $db.contracts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get payerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.payerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get paymentDate => $composableBuilder(
      column: $table.paymentDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get paymentType => $composableBuilder(
      column: $table.paymentType, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  $$ContractsTableAnnotationComposer get contractId {
    final $$ContractsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contractId,
        referencedTable: $db.contracts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContractsTableAnnotationComposer(
              $db: $db,
              $table: $db.contracts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get payerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.payerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool contractId, bool payerId})> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> contractId = const Value.absent(),
            Value<String> payerId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> paymentDate = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String> paymentType = const Value.absent(),
            Value<String?> paymentMethod = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            contractId: contractId,
            payerId: payerId,
            amount: amount,
            paymentDate: paymentDate,
            dueDate: dueDate,
            paymentType: paymentType,
            paymentMethod: paymentMethod,
            status: status,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String contractId,
            required String payerId,
            required double amount,
            required DateTime paymentDate,
            Value<DateTime?> dueDate = const Value.absent(),
            required String paymentType,
            Value<String?> paymentMethod = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsCompanion.insert(
            id: id,
            contractId: contractId,
            payerId: payerId,
            amount: amount,
            paymentDate: paymentDate,
            dueDate: dueDate,
            paymentType: paymentType,
            paymentMethod: paymentMethod,
            status: status,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PaymentsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({contractId = false, payerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (contractId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contractId,
                    referencedTable:
                        $$PaymentsTableReferences._contractIdTable(db),
                    referencedColumn:
                        $$PaymentsTableReferences._contractIdTable(db).id,
                  ) as T;
                }
                if (payerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.payerId,
                    referencedTable:
                        $$PaymentsTableReferences._payerIdTable(db),
                    referencedColumn:
                        $$PaymentsTableReferences._payerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, $$PaymentsTableReferences),
    Payment,
    PrefetchHooks Function({bool contractId, bool payerId})>;
typedef $$PurchaseRequestsTableCreateCompanionBuilder
    = PurchaseRequestsCompanion Function({
  required String id,
  required String propertyId,
  required String buyerId,
  required double offeredPrice,
  Value<String?> message,
  Value<String> status,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$PurchaseRequestsTableUpdateCompanionBuilder
    = PurchaseRequestsCompanion Function({
  Value<String> id,
  Value<String> propertyId,
  Value<String> buyerId,
  Value<double> offeredPrice,
  Value<String?> message,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$PurchaseRequestsTableReferences extends BaseReferences<
    _$AppDatabase, $PurchaseRequestsTable, PurchaseRequest> {
  $$PurchaseRequestsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PropertiesTable _propertyIdTable(_$AppDatabase db) =>
      db.properties.createAlias($_aliasNameGenerator(
          db.purchaseRequests.propertyId, db.properties.id));

  $$PropertiesTableProcessedTableManager get propertyId {
    final $_column = $_itemColumn<String>('property_id')!;

    final manager = $$PropertiesTableTableManager($_db, $_db.properties)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_propertyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _buyerIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.purchaseRequests.buyerId, db.users.id));

  $$UsersTableProcessedTableManager get buyerId {
    final $_column = $_itemColumn<String>('buyer_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_buyerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PurchaseRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $PurchaseRequestsTable> {
  $$PurchaseRequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get offeredPrice => $composableBuilder(
      column: $table.offeredPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  $$PropertiesTableFilterComposer get propertyId {
    final $$PropertiesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableFilterComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get buyerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PurchaseRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $PurchaseRequestsTable> {
  $$PurchaseRequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get offeredPrice => $composableBuilder(
      column: $table.offeredPrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  $$PropertiesTableOrderingComposer get propertyId {
    final $$PropertiesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableOrderingComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get buyerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PurchaseRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PurchaseRequestsTable> {
  $$PurchaseRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get offeredPrice => $composableBuilder(
      column: $table.offeredPrice, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  $$PropertiesTableAnnotationComposer get propertyId {
    final $$PropertiesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.propertyId,
        referencedTable: $db.properties,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PropertiesTableAnnotationComposer(
              $db: $db,
              $table: $db.properties,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get buyerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PurchaseRequestsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PurchaseRequestsTable,
    PurchaseRequest,
    $$PurchaseRequestsTableFilterComposer,
    $$PurchaseRequestsTableOrderingComposer,
    $$PurchaseRequestsTableAnnotationComposer,
    $$PurchaseRequestsTableCreateCompanionBuilder,
    $$PurchaseRequestsTableUpdateCompanionBuilder,
    (PurchaseRequest, $$PurchaseRequestsTableReferences),
    PurchaseRequest,
    PrefetchHooks Function({bool propertyId, bool buyerId})> {
  $$PurchaseRequestsTableTableManager(
      _$AppDatabase db, $PurchaseRequestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PurchaseRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PurchaseRequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PurchaseRequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> propertyId = const Value.absent(),
            Value<String> buyerId = const Value.absent(),
            Value<double> offeredPrice = const Value.absent(),
            Value<String?> message = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PurchaseRequestsCompanion(
            id: id,
            propertyId: propertyId,
            buyerId: buyerId,
            offeredPrice: offeredPrice,
            message: message,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String propertyId,
            required String buyerId,
            required double offeredPrice,
            Value<String?> message = const Value.absent(),
            Value<String> status = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PurchaseRequestsCompanion.insert(
            id: id,
            propertyId: propertyId,
            buyerId: buyerId,
            offeredPrice: offeredPrice,
            message: message,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PurchaseRequestsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({propertyId = false, buyerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (propertyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.propertyId,
                    referencedTable:
                        $$PurchaseRequestsTableReferences._propertyIdTable(db),
                    referencedColumn: $$PurchaseRequestsTableReferences
                        ._propertyIdTable(db)
                        .id,
                  ) as T;
                }
                if (buyerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.buyerId,
                    referencedTable:
                        $$PurchaseRequestsTableReferences._buyerIdTable(db),
                    referencedColumn:
                        $$PurchaseRequestsTableReferences._buyerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PurchaseRequestsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PurchaseRequestsTable,
    PurchaseRequest,
    $$PurchaseRequestsTableFilterComposer,
    $$PurchaseRequestsTableOrderingComposer,
    $$PurchaseRequestsTableAnnotationComposer,
    $$PurchaseRequestsTableCreateCompanionBuilder,
    $$PurchaseRequestsTableUpdateCompanionBuilder,
    (PurchaseRequest, $$PurchaseRequestsTableReferences),
    PurchaseRequest,
    PrefetchHooks Function({bool propertyId, bool buyerId})>;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
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
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()> {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SettingsCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SettingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SettingsTable,
    Setting,
    $$SettingsTableFilterComposer,
    $$SettingsTableOrderingComposer,
    $$SettingsTableAnnotationComposer,
    $$SettingsTableCreateCompanionBuilder,
    $$SettingsTableUpdateCompanionBuilder,
    (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
    Setting,
    PrefetchHooks Function()>;
typedef $$PropertyRequestsTableCreateCompanionBuilder
    = PropertyRequestsCompanion Function({
  required String id,
  required String buyerId,
  required String propertyCategory,
  Value<String?> propertyType,
  Value<double?> minPrice,
  Value<double?> maxPrice,
  required String location,
  required String urgency,
  Value<String> status,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$PropertyRequestsTableUpdateCompanionBuilder
    = PropertyRequestsCompanion Function({
  Value<String> id,
  Value<String> buyerId,
  Value<String> propertyCategory,
  Value<String?> propertyType,
  Value<double?> minPrice,
  Value<double?> maxPrice,
  Value<String> location,
  Value<String> urgency,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$PropertyRequestsTableReferences extends BaseReferences<
    _$AppDatabase, $PropertyRequestsTable, PropertyRequest> {
  $$PropertyRequestsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _buyerIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.propertyRequests.buyerId, db.users.id));

  $$UsersTableProcessedTableManager get buyerId {
    final $_column = $_itemColumn<String>('buyer_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_buyerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PropertyRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $PropertyRequestsTable> {
  $$PropertyRequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get propertyCategory => $composableBuilder(
      column: $table.propertyCategory,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get propertyType => $composableBuilder(
      column: $table.propertyType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minPrice => $composableBuilder(
      column: $table.minPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get maxPrice => $composableBuilder(
      column: $table.maxPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urgency => $composableBuilder(
      column: $table.urgency, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get buyerId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertyRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $PropertyRequestsTable> {
  $$PropertyRequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get propertyCategory => $composableBuilder(
      column: $table.propertyCategory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get propertyType => $composableBuilder(
      column: $table.propertyType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minPrice => $composableBuilder(
      column: $table.minPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get maxPrice => $composableBuilder(
      column: $table.maxPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urgency => $composableBuilder(
      column: $table.urgency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get buyerId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertyRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PropertyRequestsTable> {
  $$PropertyRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get propertyCategory => $composableBuilder(
      column: $table.propertyCategory, builder: (column) => column);

  GeneratedColumn<String> get propertyType => $composableBuilder(
      column: $table.propertyType, builder: (column) => column);

  GeneratedColumn<double> get minPrice =>
      $composableBuilder(column: $table.minPrice, builder: (column) => column);

  GeneratedColumn<double> get maxPrice =>
      $composableBuilder(column: $table.maxPrice, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get urgency =>
      $composableBuilder(column: $table.urgency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  $$UsersTableAnnotationComposer get buyerId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.buyerId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PropertyRequestsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PropertyRequestsTable,
    PropertyRequest,
    $$PropertyRequestsTableFilterComposer,
    $$PropertyRequestsTableOrderingComposer,
    $$PropertyRequestsTableAnnotationComposer,
    $$PropertyRequestsTableCreateCompanionBuilder,
    $$PropertyRequestsTableUpdateCompanionBuilder,
    (PropertyRequest, $$PropertyRequestsTableReferences),
    PropertyRequest,
    PrefetchHooks Function({bool buyerId})> {
  $$PropertyRequestsTableTableManager(
      _$AppDatabase db, $PropertyRequestsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PropertyRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PropertyRequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PropertyRequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> buyerId = const Value.absent(),
            Value<String> propertyCategory = const Value.absent(),
            Value<String?> propertyType = const Value.absent(),
            Value<double?> minPrice = const Value.absent(),
            Value<double?> maxPrice = const Value.absent(),
            Value<String> location = const Value.absent(),
            Value<String> urgency = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PropertyRequestsCompanion(
            id: id,
            buyerId: buyerId,
            propertyCategory: propertyCategory,
            propertyType: propertyType,
            minPrice: minPrice,
            maxPrice: maxPrice,
            location: location,
            urgency: urgency,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String buyerId,
            required String propertyCategory,
            Value<String?> propertyType = const Value.absent(),
            Value<double?> minPrice = const Value.absent(),
            Value<double?> maxPrice = const Value.absent(),
            required String location,
            required String urgency,
            Value<String> status = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PropertyRequestsCompanion.insert(
            id: id,
            buyerId: buyerId,
            propertyCategory: propertyCategory,
            propertyType: propertyType,
            minPrice: minPrice,
            maxPrice: maxPrice,
            location: location,
            urgency: urgency,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PropertyRequestsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({buyerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (buyerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.buyerId,
                    referencedTable:
                        $$PropertyRequestsTableReferences._buyerIdTable(db),
                    referencedColumn:
                        $$PropertyRequestsTableReferences._buyerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PropertyRequestsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PropertyRequestsTable,
    PropertyRequest,
    $$PropertyRequestsTableFilterComposer,
    $$PropertyRequestsTableOrderingComposer,
    $$PropertyRequestsTableAnnotationComposer,
    $$PropertyRequestsTableCreateCompanionBuilder,
    $$PropertyRequestsTableUpdateCompanionBuilder,
    (PropertyRequest, $$PropertyRequestsTableReferences),
    PropertyRequest,
    PrefetchHooks Function({bool buyerId})>;
typedef $$NotificationsTableCreateCompanionBuilder = NotificationsCompanion
    Function({
  required String id,
  required String userId,
  required String title,
  required String message,
  Value<bool> isRead,
  Value<String?> relatedId,
  required DateTime createdAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$NotificationsTableUpdateCompanionBuilder = NotificationsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> title,
  Value<String> message,
  Value<bool> isRead,
  Value<String?> relatedId,
  Value<DateTime> createdAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$NotificationsTableReferences
    extends BaseReferences<_$AppDatabase, $NotificationsTable, Notification> {
  $$NotificationsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.notifications.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$NotificationsTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relatedId => $composableBuilder(
      column: $table.relatedId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NotificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get message => $composableBuilder(
      column: $table.message, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRead => $composableBuilder(
      column: $table.isRead, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relatedId => $composableBuilder(
      column: $table.relatedId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NotificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTable> {
  $$NotificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<String> get relatedId =>
      $composableBuilder(column: $table.relatedId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$NotificationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NotificationsTable,
    Notification,
    $$NotificationsTableFilterComposer,
    $$NotificationsTableOrderingComposer,
    $$NotificationsTableAnnotationComposer,
    $$NotificationsTableCreateCompanionBuilder,
    $$NotificationsTableUpdateCompanionBuilder,
    (Notification, $$NotificationsTableReferences),
    Notification,
    PrefetchHooks Function({bool userId})> {
  $$NotificationsTableTableManager(_$AppDatabase db, $NotificationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> message = const Value.absent(),
            Value<bool> isRead = const Value.absent(),
            Value<String?> relatedId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationsCompanion(
            id: id,
            userId: userId,
            title: title,
            message: message,
            isRead: isRead,
            relatedId: relatedId,
            createdAt: createdAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String title,
            required String message,
            Value<bool> isRead = const Value.absent(),
            Value<String?> relatedId = const Value.absent(),
            required DateTime createdAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NotificationsCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            message: message,
            isRead: isRead,
            relatedId: relatedId,
            createdAt: createdAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$NotificationsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$NotificationsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$NotificationsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$NotificationsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NotificationsTable,
    Notification,
    $$NotificationsTableFilterComposer,
    $$NotificationsTableOrderingComposer,
    $$NotificationsTableAnnotationComposer,
    $$NotificationsTableCreateCompanionBuilder,
    $$NotificationsTableUpdateCompanionBuilder,
    (Notification, $$NotificationsTableReferences),
    Notification,
    PrefetchHooks Function({bool userId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PropertiesTableTableManager get properties =>
      $$PropertiesTableTableManager(_db, _db.properties);
  $$PropertyImagesTableTableManager get propertyImages =>
      $$PropertyImagesTableTableManager(_db, _db.propertyImages);
  $$ContractsTableTableManager get contracts =>
      $$ContractsTableTableManager(_db, _db.contracts);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$PurchaseRequestsTableTableManager get purchaseRequests =>
      $$PurchaseRequestsTableTableManager(_db, _db.purchaseRequests);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$PropertyRequestsTableTableManager get propertyRequests =>
      $$PropertyRequestsTableTableManager(_db, _db.propertyRequests);
  $$NotificationsTableTableManager get notifications =>
      $$NotificationsTableTableManager(_db, _db.notifications);
}
