// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class AppStateData extends DataClass implements Insertable<AppStateData> {
  final int id;
  final DateTime verificationStartTime;
  final int? verificationTimeoutInSeconds;
  final String? verificationId;
  final int? resendToken;
  final String? phoneNumber;
  final bool? phoneNumberMappedToProfile;
  final String? firstName;
  final String? lastName;
  AppStateData(
      {required this.id,
      required this.verificationStartTime,
      this.verificationTimeoutInSeconds,
      this.verificationId,
      this.resendToken,
      this.phoneNumber,
      this.phoneNumberMappedToProfile,
      this.firstName,
      this.lastName});
  factory AppStateData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AppStateData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      verificationStartTime: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}verification_start_time'])!,
      verificationTimeoutInSeconds: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}verification_timeout_in_seconds']),
      verificationId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}verification_id']),
      resendToken: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}resend_token']),
      phoneNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number']),
      phoneNumberMappedToProfile: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}phone_number_mapped_to_profile']),
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['verification_start_time'] = Variable<DateTime>(verificationStartTime);
    if (!nullToAbsent || verificationTimeoutInSeconds != null) {
      map['verification_timeout_in_seconds'] =
          Variable<int?>(verificationTimeoutInSeconds);
    }
    if (!nullToAbsent || verificationId != null) {
      map['verification_id'] = Variable<String?>(verificationId);
    }
    if (!nullToAbsent || resendToken != null) {
      map['resend_token'] = Variable<int?>(resendToken);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String?>(phoneNumber);
    }
    if (!nullToAbsent || phoneNumberMappedToProfile != null) {
      map['phone_number_mapped_to_profile'] =
          Variable<bool?>(phoneNumberMappedToProfile);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String?>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String?>(lastName);
    }
    return map;
  }

  AppStateCompanion toCompanion(bool nullToAbsent) {
    return AppStateCompanion(
      id: Value(id),
      verificationStartTime: Value(verificationStartTime),
      verificationTimeoutInSeconds:
          verificationTimeoutInSeconds == null && nullToAbsent
              ? const Value.absent()
              : Value(verificationTimeoutInSeconds),
      verificationId: verificationId == null && nullToAbsent
          ? const Value.absent()
          : Value(verificationId),
      resendToken: resendToken == null && nullToAbsent
          ? const Value.absent()
          : Value(resendToken),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      phoneNumberMappedToProfile:
          phoneNumberMappedToProfile == null && nullToAbsent
              ? const Value.absent()
              : Value(phoneNumberMappedToProfile),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
    );
  }

  factory AppStateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppStateData(
      id: serializer.fromJson<int>(json['id']),
      verificationStartTime:
          serializer.fromJson<DateTime>(json['verificationStartTime']),
      verificationTimeoutInSeconds:
          serializer.fromJson<int?>(json['verificationTimeoutInSeconds']),
      verificationId: serializer.fromJson<String?>(json['verificationId']),
      resendToken: serializer.fromJson<int?>(json['resendToken']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      phoneNumberMappedToProfile:
          serializer.fromJson<bool?>(json['phoneNumberMappedToProfile']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'verificationStartTime':
          serializer.toJson<DateTime>(verificationStartTime),
      'verificationTimeoutInSeconds':
          serializer.toJson<int?>(verificationTimeoutInSeconds),
      'verificationId': serializer.toJson<String?>(verificationId),
      'resendToken': serializer.toJson<int?>(resendToken),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'phoneNumberMappedToProfile':
          serializer.toJson<bool?>(phoneNumberMappedToProfile),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
    };
  }

  AppStateData copyWith(
          {int? id,
          DateTime? verificationStartTime,
          int? verificationTimeoutInSeconds,
          String? verificationId,
          int? resendToken,
          String? phoneNumber,
          bool? phoneNumberMappedToProfile,
          String? firstName,
          String? lastName}) =>
      AppStateData(
        id: id ?? this.id,
        verificationStartTime:
            verificationStartTime ?? this.verificationStartTime,
        verificationTimeoutInSeconds:
            verificationTimeoutInSeconds ?? this.verificationTimeoutInSeconds,
        verificationId: verificationId ?? this.verificationId,
        resendToken: resendToken ?? this.resendToken,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        phoneNumberMappedToProfile:
            phoneNumberMappedToProfile ?? this.phoneNumberMappedToProfile,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );
  @override
  String toString() {
    return (StringBuffer('AppStateData(')
          ..write('id: $id, ')
          ..write('verificationStartTime: $verificationStartTime, ')
          ..write(
              'verificationTimeoutInSeconds: $verificationTimeoutInSeconds, ')
          ..write('verificationId: $verificationId, ')
          ..write('resendToken: $resendToken, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('phoneNumberMappedToProfile: $phoneNumberMappedToProfile, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      verificationStartTime,
      verificationTimeoutInSeconds,
      verificationId,
      resendToken,
      phoneNumber,
      phoneNumberMappedToProfile,
      firstName,
      lastName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppStateData &&
          other.id == this.id &&
          other.verificationStartTime == this.verificationStartTime &&
          other.verificationTimeoutInSeconds ==
              this.verificationTimeoutInSeconds &&
          other.verificationId == this.verificationId &&
          other.resendToken == this.resendToken &&
          other.phoneNumber == this.phoneNumber &&
          other.phoneNumberMappedToProfile == this.phoneNumberMappedToProfile &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName);
}

class AppStateCompanion extends UpdateCompanion<AppStateData> {
  final Value<int> id;
  final Value<DateTime> verificationStartTime;
  final Value<int?> verificationTimeoutInSeconds;
  final Value<String?> verificationId;
  final Value<int?> resendToken;
  final Value<String?> phoneNumber;
  final Value<bool?> phoneNumberMappedToProfile;
  final Value<String?> firstName;
  final Value<String?> lastName;
  const AppStateCompanion({
    this.id = const Value.absent(),
    this.verificationStartTime = const Value.absent(),
    this.verificationTimeoutInSeconds = const Value.absent(),
    this.verificationId = const Value.absent(),
    this.resendToken = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.phoneNumberMappedToProfile = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
  });
  AppStateCompanion.insert({
    required int id,
    required DateTime verificationStartTime,
    this.verificationTimeoutInSeconds = const Value.absent(),
    this.verificationId = const Value.absent(),
    this.resendToken = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.phoneNumberMappedToProfile = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
  })  : id = Value(id),
        verificationStartTime = Value(verificationStartTime);
  static Insertable<AppStateData> custom({
    Expression<int>? id,
    Expression<DateTime>? verificationStartTime,
    Expression<int?>? verificationTimeoutInSeconds,
    Expression<String?>? verificationId,
    Expression<int?>? resendToken,
    Expression<String?>? phoneNumber,
    Expression<bool?>? phoneNumberMappedToProfile,
    Expression<String?>? firstName,
    Expression<String?>? lastName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (verificationStartTime != null)
        'verification_start_time': verificationStartTime,
      if (verificationTimeoutInSeconds != null)
        'verification_timeout_in_seconds': verificationTimeoutInSeconds,
      if (verificationId != null) 'verification_id': verificationId,
      if (resendToken != null) 'resend_token': resendToken,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (phoneNumberMappedToProfile != null)
        'phone_number_mapped_to_profile': phoneNumberMappedToProfile,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
    });
  }

  AppStateCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? verificationStartTime,
      Value<int?>? verificationTimeoutInSeconds,
      Value<String?>? verificationId,
      Value<int?>? resendToken,
      Value<String?>? phoneNumber,
      Value<bool?>? phoneNumberMappedToProfile,
      Value<String?>? firstName,
      Value<String?>? lastName}) {
    return AppStateCompanion(
      id: id ?? this.id,
      verificationStartTime:
          verificationStartTime ?? this.verificationStartTime,
      verificationTimeoutInSeconds:
          verificationTimeoutInSeconds ?? this.verificationTimeoutInSeconds,
      verificationId: verificationId ?? this.verificationId,
      resendToken: resendToken ?? this.resendToken,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberMappedToProfile:
          phoneNumberMappedToProfile ?? this.phoneNumberMappedToProfile,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (verificationStartTime.present) {
      map['verification_start_time'] =
          Variable<DateTime>(verificationStartTime.value);
    }
    if (verificationTimeoutInSeconds.present) {
      map['verification_timeout_in_seconds'] =
          Variable<int?>(verificationTimeoutInSeconds.value);
    }
    if (verificationId.present) {
      map['verification_id'] = Variable<String?>(verificationId.value);
    }
    if (resendToken.present) {
      map['resend_token'] = Variable<int?>(resendToken.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String?>(phoneNumber.value);
    }
    if (phoneNumberMappedToProfile.present) {
      map['phone_number_mapped_to_profile'] =
          Variable<bool?>(phoneNumberMappedToProfile.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String?>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String?>(lastName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppStateCompanion(')
          ..write('id: $id, ')
          ..write('verificationStartTime: $verificationStartTime, ')
          ..write(
              'verificationTimeoutInSeconds: $verificationTimeoutInSeconds, ')
          ..write('verificationId: $verificationId, ')
          ..write('resendToken: $resendToken, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('phoneNumberMappedToProfile: $phoneNumberMappedToProfile, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName')
          ..write(')'))
        .toString();
  }
}

class $AppStateTable extends AppState
    with TableInfo<$AppStateTable, AppStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppStateTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _verificationStartTimeMeta =
      const VerificationMeta('verificationStartTime');
  @override
  late final GeneratedColumn<DateTime?> verificationStartTime =
      GeneratedColumn<DateTime?>('verification_start_time', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _verificationTimeoutInSecondsMeta =
      const VerificationMeta('verificationTimeoutInSeconds');
  @override
  late final GeneratedColumn<int?> verificationTimeoutInSeconds =
      GeneratedColumn<int?>(
          'verification_timeout_in_seconds', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _verificationIdMeta =
      const VerificationMeta('verificationId');
  @override
  late final GeneratedColumn<String?> verificationId = GeneratedColumn<String?>(
      'verification_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _resendTokenMeta =
      const VerificationMeta('resendToken');
  @override
  late final GeneratedColumn<int?> resendToken = GeneratedColumn<int?>(
      'resend_token', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String?> phoneNumber = GeneratedColumn<String?>(
      'phone_number', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _phoneNumberMappedToProfileMeta =
      const VerificationMeta('phoneNumberMappedToProfile');
  @override
  late final GeneratedColumn<bool?> phoneNumberMappedToProfile =
      GeneratedColumn<bool?>(
          'phone_number_mapped_to_profile', aliasedName, true,
          type: const BoolType(),
          requiredDuringInsert: false,
          defaultConstraints:
              'CHECK (phone_number_mapped_to_profile IN (0, 1))',
          defaultValue: const Constant(false));
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        verificationStartTime,
        verificationTimeoutInSeconds,
        verificationId,
        resendToken,
        phoneNumber,
        phoneNumberMappedToProfile,
        firstName,
        lastName
      ];
  @override
  String get aliasedName => _alias ?? 'app_state';
  @override
  String get actualTableName => 'app_state';
  @override
  VerificationContext validateIntegrity(Insertable<AppStateData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('verification_start_time')) {
      context.handle(
          _verificationStartTimeMeta,
          verificationStartTime.isAcceptableOrUnknown(
              data['verification_start_time']!, _verificationStartTimeMeta));
    } else if (isInserting) {
      context.missing(_verificationStartTimeMeta);
    }
    if (data.containsKey('verification_timeout_in_seconds')) {
      context.handle(
          _verificationTimeoutInSecondsMeta,
          verificationTimeoutInSeconds.isAcceptableOrUnknown(
              data['verification_timeout_in_seconds']!,
              _verificationTimeoutInSecondsMeta));
    }
    if (data.containsKey('verification_id')) {
      context.handle(
          _verificationIdMeta,
          verificationId.isAcceptableOrUnknown(
              data['verification_id']!, _verificationIdMeta));
    }
    if (data.containsKey('resend_token')) {
      context.handle(
          _resendTokenMeta,
          resendToken.isAcceptableOrUnknown(
              data['resend_token']!, _resendTokenMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('phone_number_mapped_to_profile')) {
      context.handle(
          _phoneNumberMappedToProfileMeta,
          phoneNumberMappedToProfile.isAcceptableOrUnknown(
              data['phone_number_mapped_to_profile']!,
              _phoneNumberMappedToProfileMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  AppStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AppStateData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AppStateTable createAlias(String alias) {
    return $AppStateTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final String phoneNumber;
  final String? profileId;
  final String? firstName;
  final String? lastName;
  final String? profileFirstName;
  final String? profileLastName;
  final DateTime creationTimestamp;
  final DateTime? lastSyncTimestamp;
  Contact(
      {required this.phoneNumber,
      this.profileId,
      this.firstName,
      this.lastName,
      this.profileFirstName,
      this.profileLastName,
      required this.creationTimestamp,
      this.lastSyncTimestamp});
  factory Contact.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Contact(
      phoneNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number'])!,
      profileId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}profile_id']),
      firstName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name']),
      lastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name']),
      profileFirstName: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}profile_first_name']),
      profileLastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}profile_last_name']),
      creationTimestamp: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}creation_timestamp'])!,
      lastSyncTimestamp: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}last_sync_timestamp']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || profileId != null) {
      map['profile_id'] = Variable<String?>(profileId);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String?>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String?>(lastName);
    }
    if (!nullToAbsent || profileFirstName != null) {
      map['profile_first_name'] = Variable<String?>(profileFirstName);
    }
    if (!nullToAbsent || profileLastName != null) {
      map['profile_last_name'] = Variable<String?>(profileLastName);
    }
    map['creation_timestamp'] = Variable<DateTime>(creationTimestamp);
    if (!nullToAbsent || lastSyncTimestamp != null) {
      map['last_sync_timestamp'] = Variable<DateTime?>(lastSyncTimestamp);
    }
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      phoneNumber: Value(phoneNumber),
      profileId: profileId == null && nullToAbsent
          ? const Value.absent()
          : Value(profileId),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      profileFirstName: profileFirstName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileFirstName),
      profileLastName: profileLastName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileLastName),
      creationTimestamp: Value(creationTimestamp),
      lastSyncTimestamp: lastSyncTimestamp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncTimestamp),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      profileId: serializer.fromJson<String?>(json['profileId']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      profileFirstName: serializer.fromJson<String?>(json['profileFirstName']),
      profileLastName: serializer.fromJson<String?>(json['profileLastName']),
      creationTimestamp:
          serializer.fromJson<DateTime>(json['creationTimestamp']),
      lastSyncTimestamp:
          serializer.fromJson<DateTime?>(json['lastSyncTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'profileId': serializer.toJson<String?>(profileId),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'profileFirstName': serializer.toJson<String?>(profileFirstName),
      'profileLastName': serializer.toJson<String?>(profileLastName),
      'creationTimestamp': serializer.toJson<DateTime>(creationTimestamp),
      'lastSyncTimestamp': serializer.toJson<DateTime?>(lastSyncTimestamp),
    };
  }

  Contact copyWith(
          {String? phoneNumber,
          String? profileId,
          String? firstName,
          String? lastName,
          String? profileFirstName,
          String? profileLastName,
          DateTime? creationTimestamp,
          DateTime? lastSyncTimestamp}) =>
      Contact(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        profileId: profileId ?? this.profileId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        profileFirstName: profileFirstName ?? this.profileFirstName,
        profileLastName: profileLastName ?? this.profileLastName,
        creationTimestamp: creationTimestamp ?? this.creationTimestamp,
        lastSyncTimestamp: lastSyncTimestamp ?? this.lastSyncTimestamp,
      );
  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('profileId: $profileId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('profileFirstName: $profileFirstName, ')
          ..write('profileLastName: $profileLastName, ')
          ..write('creationTimestamp: $creationTimestamp, ')
          ..write('lastSyncTimestamp: $lastSyncTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(phoneNumber, profileId, firstName, lastName,
      profileFirstName, profileLastName, creationTimestamp, lastSyncTimestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.phoneNumber == this.phoneNumber &&
          other.profileId == this.profileId &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.profileFirstName == this.profileFirstName &&
          other.profileLastName == this.profileLastName &&
          other.creationTimestamp == this.creationTimestamp &&
          other.lastSyncTimestamp == this.lastSyncTimestamp);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<String> phoneNumber;
  final Value<String?> profileId;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> profileFirstName;
  final Value<String?> profileLastName;
  final Value<DateTime> creationTimestamp;
  final Value<DateTime?> lastSyncTimestamp;
  const ContactsCompanion({
    this.phoneNumber = const Value.absent(),
    this.profileId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.profileFirstName = const Value.absent(),
    this.profileLastName = const Value.absent(),
    this.creationTimestamp = const Value.absent(),
    this.lastSyncTimestamp = const Value.absent(),
  });
  ContactsCompanion.insert({
    required String phoneNumber,
    this.profileId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.profileFirstName = const Value.absent(),
    this.profileLastName = const Value.absent(),
    this.creationTimestamp = const Value.absent(),
    this.lastSyncTimestamp = const Value.absent(),
  }) : phoneNumber = Value(phoneNumber);
  static Insertable<Contact> custom({
    Expression<String>? phoneNumber,
    Expression<String?>? profileId,
    Expression<String?>? firstName,
    Expression<String?>? lastName,
    Expression<String?>? profileFirstName,
    Expression<String?>? profileLastName,
    Expression<DateTime>? creationTimestamp,
    Expression<DateTime?>? lastSyncTimestamp,
  }) {
    return RawValuesInsertable({
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (profileId != null) 'profile_id': profileId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (profileFirstName != null) 'profile_first_name': profileFirstName,
      if (profileLastName != null) 'profile_last_name': profileLastName,
      if (creationTimestamp != null) 'creation_timestamp': creationTimestamp,
      if (lastSyncTimestamp != null) 'last_sync_timestamp': lastSyncTimestamp,
    });
  }

  ContactsCompanion copyWith(
      {Value<String>? phoneNumber,
      Value<String?>? profileId,
      Value<String?>? firstName,
      Value<String?>? lastName,
      Value<String?>? profileFirstName,
      Value<String?>? profileLastName,
      Value<DateTime>? creationTimestamp,
      Value<DateTime?>? lastSyncTimestamp}) {
    return ContactsCompanion(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileId: profileId ?? this.profileId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profileFirstName: profileFirstName ?? this.profileFirstName,
      profileLastName: profileLastName ?? this.profileLastName,
      creationTimestamp: creationTimestamp ?? this.creationTimestamp,
      lastSyncTimestamp: lastSyncTimestamp ?? this.lastSyncTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String?>(profileId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String?>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String?>(lastName.value);
    }
    if (profileFirstName.present) {
      map['profile_first_name'] = Variable<String?>(profileFirstName.value);
    }
    if (profileLastName.present) {
      map['profile_last_name'] = Variable<String?>(profileLastName.value);
    }
    if (creationTimestamp.present) {
      map['creation_timestamp'] = Variable<DateTime>(creationTimestamp.value);
    }
    if (lastSyncTimestamp.present) {
      map['last_sync_timestamp'] = Variable<DateTime?>(lastSyncTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('profileId: $profileId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('profileFirstName: $profileFirstName, ')
          ..write('profileLastName: $profileLastName, ')
          ..write('creationTimestamp: $creationTimestamp, ')
          ..write('lastSyncTimestamp: $lastSyncTimestamp')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String?> phoneNumber = GeneratedColumn<String?>(
      'phone_number', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _profileIdMeta = const VerificationMeta('profileId');
  @override
  late final GeneratedColumn<String?> profileId = GeneratedColumn<String?>(
      'profile_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _profileFirstNameMeta =
      const VerificationMeta('profileFirstName');
  @override
  late final GeneratedColumn<String?> profileFirstName =
      GeneratedColumn<String?>('profile_first_name', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _profileLastNameMeta =
      const VerificationMeta('profileLastName');
  @override
  late final GeneratedColumn<String?> profileLastName =
      GeneratedColumn<String?>('profile_last_name', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _creationTimestampMeta =
      const VerificationMeta('creationTimestamp');
  @override
  late final GeneratedColumn<DateTime?> creationTimestamp =
      GeneratedColumn<DateTime?>('creation_timestamp', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  final VerificationMeta _lastSyncTimestampMeta =
      const VerificationMeta('lastSyncTimestamp');
  @override
  late final GeneratedColumn<DateTime?> lastSyncTimestamp =
      GeneratedColumn<DateTime?>('last_sync_timestamp', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        phoneNumber,
        profileId,
        firstName,
        lastName,
        profileFirstName,
        profileLastName,
        creationTimestamp,
        lastSyncTimestamp
      ];
  @override
  String get aliasedName => _alias ?? 'contacts';
  @override
  String get actualTableName => 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    }
    if (data.containsKey('profile_first_name')) {
      context.handle(
          _profileFirstNameMeta,
          profileFirstName.isAcceptableOrUnknown(
              data['profile_first_name']!, _profileFirstNameMeta));
    }
    if (data.containsKey('profile_last_name')) {
      context.handle(
          _profileLastNameMeta,
          profileLastName.isAcceptableOrUnknown(
              data['profile_last_name']!, _profileLastNameMeta));
    }
    if (data.containsKey('creation_timestamp')) {
      context.handle(
          _creationTimestampMeta,
          creationTimestamp.isAcceptableOrUnknown(
              data['creation_timestamp']!, _creationTimestampMeta));
    }
    if (data.containsKey('last_sync_timestamp')) {
      context.handle(
          _lastSyncTimestampMeta,
          lastSyncTimestamp.isAcceptableOrUnknown(
              data['last_sync_timestamp']!, _lastSyncTimestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phoneNumber};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Contact.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

abstract class _$GonnaDatabase extends GeneratedDatabase {
  _$GonnaDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AppStateTable appState = $AppStateTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final AppStateDao appStateDao = AppStateDao(this as GonnaDatabase);
  late final ContactsDao contactsDao = ContactsDao(this as GonnaDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [appState, contacts];
}
