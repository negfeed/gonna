// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
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

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ContactsTable contacts = $ContactsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [contacts];
}
