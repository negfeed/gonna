// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
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
  final GeneratedDatabase _db;
  final String? _alias;
  $AppStateTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _verificationStartTimeMeta =
      const VerificationMeta('verificationStartTime');
  late final GeneratedColumn<DateTime?> verificationStartTime =
      GeneratedColumn<DateTime?>('verification_start_time', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _verificationTimeoutInSecondsMeta =
      const VerificationMeta('verificationTimeoutInSeconds');
  late final GeneratedColumn<int?> verificationTimeoutInSeconds =
      GeneratedColumn<int?>(
          'verification_timeout_in_seconds', aliasedName, true,
          typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _verificationIdMeta =
      const VerificationMeta('verificationId');
  late final GeneratedColumn<String?> verificationId = GeneratedColumn<String?>(
      'verification_id', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _resendTokenMeta =
      const VerificationMeta('resendToken');
  late final GeneratedColumn<int?> resendToken = GeneratedColumn<int?>(
      'resend_token', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  late final GeneratedColumn<String?> phoneNumber = GeneratedColumn<String?>(
      'phone_number', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _phoneNumberMappedToProfileMeta =
      const VerificationMeta('phoneNumberMappedToProfile');
  late final GeneratedColumn<bool?> phoneNumberMappedToProfile =
      GeneratedColumn<bool?>(
          'phone_number_mapped_to_profile', aliasedName, true,
          typeName: 'INTEGER',
          requiredDuringInsert: false,
          defaultConstraints:
              'CHECK (phone_number_mapped_to_profile IN (0, 1))',
          defaultValue: const Constant(false));
  final VerificationMeta _firstNameMeta = const VerificationMeta('firstName');
  late final GeneratedColumn<String?> firstName = GeneratedColumn<String?>(
      'first_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _lastNameMeta = const VerificationMeta('lastName');
  late final GeneratedColumn<String?> lastName = GeneratedColumn<String?>(
      'last_name', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false);
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
    return $AppStateTable(_db, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final String phoneNumber;
  final String? contactsPhoneNumberType;
  final String profileId;
  final String? contactsFirstName;
  final String? contactsLastName;
  final String? profileFirstName;
  final String? profileLastName;
  final int creationTimestamp;
  final DateTime lastUpdatedTimestamp;
  Contact(
      {required this.phoneNumber,
      this.contactsPhoneNumberType,
      required this.profileId,
      this.contactsFirstName,
      this.contactsLastName,
      this.profileFirstName,
      this.profileLastName,
      required this.creationTimestamp,
      required this.lastUpdatedTimestamp});
  factory Contact.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Contact(
      phoneNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone_number'])!,
      contactsPhoneNumberType: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}contacts_phone_number_type']),
      profileId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}profile_id'])!,
      contactsFirstName: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}contacts_first_name']),
      contactsLastName: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}contacts_last_name']),
      profileFirstName: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}profile_first_name']),
      profileLastName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}profile_last_name']),
      creationTimestamp: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}creation_timestamp'])!,
      lastUpdatedTimestamp: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}last_updated_timestamp'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || contactsPhoneNumberType != null) {
      map['contacts_phone_number_type'] =
          Variable<String?>(contactsPhoneNumberType);
    }
    map['profile_id'] = Variable<String>(profileId);
    if (!nullToAbsent || contactsFirstName != null) {
      map['contacts_first_name'] = Variable<String?>(contactsFirstName);
    }
    if (!nullToAbsent || contactsLastName != null) {
      map['contacts_last_name'] = Variable<String?>(contactsLastName);
    }
    if (!nullToAbsent || profileFirstName != null) {
      map['profile_first_name'] = Variable<String?>(profileFirstName);
    }
    if (!nullToAbsent || profileLastName != null) {
      map['profile_last_name'] = Variable<String?>(profileLastName);
    }
    map['creation_timestamp'] = Variable<int>(creationTimestamp);
    map['last_updated_timestamp'] = Variable<DateTime>(lastUpdatedTimestamp);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      phoneNumber: Value(phoneNumber),
      contactsPhoneNumberType: contactsPhoneNumberType == null && nullToAbsent
          ? const Value.absent()
          : Value(contactsPhoneNumberType),
      profileId: Value(profileId),
      contactsFirstName: contactsFirstName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactsFirstName),
      contactsLastName: contactsLastName == null && nullToAbsent
          ? const Value.absent()
          : Value(contactsLastName),
      profileFirstName: profileFirstName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileFirstName),
      profileLastName: profileLastName == null && nullToAbsent
          ? const Value.absent()
          : Value(profileLastName),
      creationTimestamp: Value(creationTimestamp),
      lastUpdatedTimestamp: Value(lastUpdatedTimestamp),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      contactsPhoneNumberType:
          serializer.fromJson<String?>(json['contactsPhoneNumberType']),
      profileId: serializer.fromJson<String>(json['profileId']),
      contactsFirstName:
          serializer.fromJson<String?>(json['contactsFirstName']),
      contactsLastName: serializer.fromJson<String?>(json['contactsLastName']),
      profileFirstName: serializer.fromJson<String?>(json['profileFirstName']),
      profileLastName: serializer.fromJson<String?>(json['profileLastName']),
      creationTimestamp: serializer.fromJson<int>(json['creationTimestamp']),
      lastUpdatedTimestamp:
          serializer.fromJson<DateTime>(json['lastUpdatedTimestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'contactsPhoneNumberType':
          serializer.toJson<String?>(contactsPhoneNumberType),
      'profileId': serializer.toJson<String>(profileId),
      'contactsFirstName': serializer.toJson<String?>(contactsFirstName),
      'contactsLastName': serializer.toJson<String?>(contactsLastName),
      'profileFirstName': serializer.toJson<String?>(profileFirstName),
      'profileLastName': serializer.toJson<String?>(profileLastName),
      'creationTimestamp': serializer.toJson<int>(creationTimestamp),
      'lastUpdatedTimestamp': serializer.toJson<DateTime>(lastUpdatedTimestamp),
    };
  }

  Contact copyWith(
          {String? phoneNumber,
          String? contactsPhoneNumberType,
          String? profileId,
          String? contactsFirstName,
          String? contactsLastName,
          String? profileFirstName,
          String? profileLastName,
          int? creationTimestamp,
          DateTime? lastUpdatedTimestamp}) =>
      Contact(
        phoneNumber: phoneNumber ?? this.phoneNumber,
        contactsPhoneNumberType:
            contactsPhoneNumberType ?? this.contactsPhoneNumberType,
        profileId: profileId ?? this.profileId,
        contactsFirstName: contactsFirstName ?? this.contactsFirstName,
        contactsLastName: contactsLastName ?? this.contactsLastName,
        profileFirstName: profileFirstName ?? this.profileFirstName,
        profileLastName: profileLastName ?? this.profileLastName,
        creationTimestamp: creationTimestamp ?? this.creationTimestamp,
        lastUpdatedTimestamp: lastUpdatedTimestamp ?? this.lastUpdatedTimestamp,
      );
  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactsPhoneNumberType: $contactsPhoneNumberType, ')
          ..write('profileId: $profileId, ')
          ..write('contactsFirstName: $contactsFirstName, ')
          ..write('contactsLastName: $contactsLastName, ')
          ..write('profileFirstName: $profileFirstName, ')
          ..write('profileLastName: $profileLastName, ')
          ..write('creationTimestamp: $creationTimestamp, ')
          ..write('lastUpdatedTimestamp: $lastUpdatedTimestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      phoneNumber,
      contactsPhoneNumberType,
      profileId,
      contactsFirstName,
      contactsLastName,
      profileFirstName,
      profileLastName,
      creationTimestamp,
      lastUpdatedTimestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.phoneNumber == this.phoneNumber &&
          other.contactsPhoneNumberType == this.contactsPhoneNumberType &&
          other.profileId == this.profileId &&
          other.contactsFirstName == this.contactsFirstName &&
          other.contactsLastName == this.contactsLastName &&
          other.profileFirstName == this.profileFirstName &&
          other.profileLastName == this.profileLastName &&
          other.creationTimestamp == this.creationTimestamp &&
          other.lastUpdatedTimestamp == this.lastUpdatedTimestamp);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<String> phoneNumber;
  final Value<String?> contactsPhoneNumberType;
  final Value<String> profileId;
  final Value<String?> contactsFirstName;
  final Value<String?> contactsLastName;
  final Value<String?> profileFirstName;
  final Value<String?> profileLastName;
  final Value<int> creationTimestamp;
  final Value<DateTime> lastUpdatedTimestamp;
  const ContactsCompanion({
    this.phoneNumber = const Value.absent(),
    this.contactsPhoneNumberType = const Value.absent(),
    this.profileId = const Value.absent(),
    this.contactsFirstName = const Value.absent(),
    this.contactsLastName = const Value.absent(),
    this.profileFirstName = const Value.absent(),
    this.profileLastName = const Value.absent(),
    this.creationTimestamp = const Value.absent(),
    this.lastUpdatedTimestamp = const Value.absent(),
  });
  ContactsCompanion.insert({
    required String phoneNumber,
    this.contactsPhoneNumberType = const Value.absent(),
    required String profileId,
    this.contactsFirstName = const Value.absent(),
    this.contactsLastName = const Value.absent(),
    this.profileFirstName = const Value.absent(),
    this.profileLastName = const Value.absent(),
    required int creationTimestamp,
    required DateTime lastUpdatedTimestamp,
  })  : phoneNumber = Value(phoneNumber),
        profileId = Value(profileId),
        creationTimestamp = Value(creationTimestamp),
        lastUpdatedTimestamp = Value(lastUpdatedTimestamp);
  static Insertable<Contact> custom({
    Expression<String>? phoneNumber,
    Expression<String?>? contactsPhoneNumberType,
    Expression<String>? profileId,
    Expression<String?>? contactsFirstName,
    Expression<String?>? contactsLastName,
    Expression<String?>? profileFirstName,
    Expression<String?>? profileLastName,
    Expression<int>? creationTimestamp,
    Expression<DateTime>? lastUpdatedTimestamp,
  }) {
    return RawValuesInsertable({
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (contactsPhoneNumberType != null)
        'contacts_phone_number_type': contactsPhoneNumberType,
      if (profileId != null) 'profile_id': profileId,
      if (contactsFirstName != null) 'contacts_first_name': contactsFirstName,
      if (contactsLastName != null) 'contacts_last_name': contactsLastName,
      if (profileFirstName != null) 'profile_first_name': profileFirstName,
      if (profileLastName != null) 'profile_last_name': profileLastName,
      if (creationTimestamp != null) 'creation_timestamp': creationTimestamp,
      if (lastUpdatedTimestamp != null)
        'last_updated_timestamp': lastUpdatedTimestamp,
    });
  }

  ContactsCompanion copyWith(
      {Value<String>? phoneNumber,
      Value<String?>? contactsPhoneNumberType,
      Value<String>? profileId,
      Value<String?>? contactsFirstName,
      Value<String?>? contactsLastName,
      Value<String?>? profileFirstName,
      Value<String?>? profileLastName,
      Value<int>? creationTimestamp,
      Value<DateTime>? lastUpdatedTimestamp}) {
    return ContactsCompanion(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      contactsPhoneNumberType:
          contactsPhoneNumberType ?? this.contactsPhoneNumberType,
      profileId: profileId ?? this.profileId,
      contactsFirstName: contactsFirstName ?? this.contactsFirstName,
      contactsLastName: contactsLastName ?? this.contactsLastName,
      profileFirstName: profileFirstName ?? this.profileFirstName,
      profileLastName: profileLastName ?? this.profileLastName,
      creationTimestamp: creationTimestamp ?? this.creationTimestamp,
      lastUpdatedTimestamp: lastUpdatedTimestamp ?? this.lastUpdatedTimestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (contactsPhoneNumberType.present) {
      map['contacts_phone_number_type'] =
          Variable<String?>(contactsPhoneNumberType.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (contactsFirstName.present) {
      map['contacts_first_name'] = Variable<String?>(contactsFirstName.value);
    }
    if (contactsLastName.present) {
      map['contacts_last_name'] = Variable<String?>(contactsLastName.value);
    }
    if (profileFirstName.present) {
      map['profile_first_name'] = Variable<String?>(profileFirstName.value);
    }
    if (profileLastName.present) {
      map['profile_last_name'] = Variable<String?>(profileLastName.value);
    }
    if (creationTimestamp.present) {
      map['creation_timestamp'] = Variable<int>(creationTimestamp.value);
    }
    if (lastUpdatedTimestamp.present) {
      map['last_updated_timestamp'] =
          Variable<DateTime>(lastUpdatedTimestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('contactsPhoneNumberType: $contactsPhoneNumberType, ')
          ..write('profileId: $profileId, ')
          ..write('contactsFirstName: $contactsFirstName, ')
          ..write('contactsLastName: $contactsLastName, ')
          ..write('profileFirstName: $profileFirstName, ')
          ..write('profileLastName: $profileLastName, ')
          ..write('creationTimestamp: $creationTimestamp, ')
          ..write('lastUpdatedTimestamp: $lastUpdatedTimestamp')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  final GeneratedDatabase _db;
  final String? _alias;
  $ContactsTable(this._db, [this._alias]);
  final VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  late final GeneratedColumn<String?> phoneNumber = GeneratedColumn<String?>(
      'phone_number', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _contactsPhoneNumberTypeMeta =
      const VerificationMeta('contactsPhoneNumberType');
  late final GeneratedColumn<String?> contactsPhoneNumberType =
      GeneratedColumn<String?>('contacts_phone_number_type', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _profileIdMeta = const VerificationMeta('profileId');
  late final GeneratedColumn<String?> profileId = GeneratedColumn<String?>(
      'profile_id', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _contactsFirstNameMeta =
      const VerificationMeta('contactsFirstName');
  late final GeneratedColumn<String?> contactsFirstName =
      GeneratedColumn<String?>('contacts_first_name', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _contactsLastNameMeta =
      const VerificationMeta('contactsLastName');
  late final GeneratedColumn<String?> contactsLastName =
      GeneratedColumn<String?>('contacts_last_name', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _profileFirstNameMeta =
      const VerificationMeta('profileFirstName');
  late final GeneratedColumn<String?> profileFirstName =
      GeneratedColumn<String?>('profile_first_name', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _profileLastNameMeta =
      const VerificationMeta('profileLastName');
  late final GeneratedColumn<String?> profileLastName =
      GeneratedColumn<String?>('profile_last_name', aliasedName, true,
          typeName: 'TEXT', requiredDuringInsert: false);
  final VerificationMeta _creationTimestampMeta =
      const VerificationMeta('creationTimestamp');
  late final GeneratedColumn<int?> creationTimestamp = GeneratedColumn<int?>(
      'creation_timestamp', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _lastUpdatedTimestampMeta =
      const VerificationMeta('lastUpdatedTimestamp');
  late final GeneratedColumn<DateTime?> lastUpdatedTimestamp =
      GeneratedColumn<DateTime?>('last_updated_timestamp', aliasedName, false,
          typeName: 'INTEGER', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        phoneNumber,
        contactsPhoneNumberType,
        profileId,
        contactsFirstName,
        contactsLastName,
        profileFirstName,
        profileLastName,
        creationTimestamp,
        lastUpdatedTimestamp
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
    if (data.containsKey('contacts_phone_number_type')) {
      context.handle(
          _contactsPhoneNumberTypeMeta,
          contactsPhoneNumberType.isAcceptableOrUnknown(
              data['contacts_phone_number_type']!,
              _contactsPhoneNumberTypeMeta));
    }
    if (data.containsKey('profile_id')) {
      context.handle(_profileIdMeta,
          profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta));
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('contacts_first_name')) {
      context.handle(
          _contactsFirstNameMeta,
          contactsFirstName.isAcceptableOrUnknown(
              data['contacts_first_name']!, _contactsFirstNameMeta));
    }
    if (data.containsKey('contacts_last_name')) {
      context.handle(
          _contactsLastNameMeta,
          contactsLastName.isAcceptableOrUnknown(
              data['contacts_last_name']!, _contactsLastNameMeta));
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
    } else if (isInserting) {
      context.missing(_creationTimestampMeta);
    }
    if (data.containsKey('last_updated_timestamp')) {
      context.handle(
          _lastUpdatedTimestampMeta,
          lastUpdatedTimestamp.isAcceptableOrUnknown(
              data['last_updated_timestamp']!, _lastUpdatedTimestampMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedTimestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {phoneNumber, profileId};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Contact.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(_db, alias);
  }
}

abstract class _$GonnaDatabase extends GeneratedDatabase {
  _$GonnaDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AppStateTable appState = $AppStateTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final AppStateDao appStateDao = AppStateDao(this as GonnaDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [appState, contacts];
}
