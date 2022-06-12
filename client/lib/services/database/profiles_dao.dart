import 'package:drift/drift.dart';
import 'package:gonna_client/services/database/database.dart';

part 'profiles_dao.g.dart';

class UpsertProfile {
  String profileId;
  String? firstName;
  String? lastName;
  UpsertProfile(this.profileId, {this.firstName = null, this.lastName = null});
}

@DriftAccessor(tables: [Profiles])
class ProfilesDao extends DatabaseAccessor<GonnaDatabase>
    with _$ProfilesDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ProfilesDao(GonnaDatabase db) : super(db);

  static ProfilesDao? _instance;

  static ProfilesDao get instance {
    if (_instance == null) {
      _instance = ProfilesDao(GonnaDatabase.instance);
    }
    return _instance!;
  }

  Future<void> upsertProfile(UpsertProfile upsertProfile) {
    return into(profiles).insertOnConflictUpdate(ProfilesCompanion(
        profileId: Value(upsertProfile.profileId),
        firstName: Value<String>.ofNullable(upsertProfile.firstName),
        lastName: Value<String>.ofNullable(upsertProfile.lastName),
        lastSyncTimestamp: Value<DateTime>(DateTime.now())));
  }

  Future<void> upsertProfiles(Iterable<UpsertProfile> upsertProfiles) async {
    await Future.wait(upsertProfiles.map((e) => upsertProfile(e)));
  }
}
