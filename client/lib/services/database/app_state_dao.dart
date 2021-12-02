import 'package:drift/drift.dart';
import 'package:gonna_client/services/database/database.dart';

part 'app_state_dao.g.dart';

const int _singletonId = 1;

@DriftAccessor(tables: [AppState])
class AppStateDao extends DatabaseAccessor<GonnaDatabase>
    with _$AppStateDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  AppStateDao(GonnaDatabase db) : super(db);

  static AppStateDao? _instance;

  static AppStateDao get instance {
    if (_instance == null) {
      _instance = AppStateDao(GonnaDatabase.instance);
    }
    return _instance!;
  }

  Stream<AppStateData?> watchAppState() {
    return select(appState).watchSingleOrNull();
  }

  Future<void> markPhoneVerificationStarted (
      String phoneNumber, int verificationTimeoutInSeconds) async {
    await into(appState).insert(AppStateData(
        id: _singletonId,
        verificationStartTime: DateTime.now(),
        phoneNumber: phoneNumber,
        verificationTimeoutInSeconds: verificationTimeoutInSeconds));
  }

  Future<void> setVerificationId(String verificationId, int? resendToken) async {
    await updateSingleton().write(AppStateCompanion(
        verificationId: Value(verificationId),
        resendToken: Value(resendToken)));
  }

  Future<void> setProfileData(String firstName, String lastName) async {
    await updateSingleton().write(AppStateCompanion(
        firstName: Value(firstName), lastName: Value(lastName)));
  }

  Future<void> markPhoneNumberAsMappedToProfile() async {
    await updateSingleton()
        .write(AppStateCompanion(phoneNumberMappedToProfile: Value(true)));
  }

  Future<String> getVerificationId() async {
    var query = select(appState)..where((as) => as.id.equals(_singletonId));
    return query.getSingle().then((value) => value.verificationId!);
  }

  Future<void> reset() async {
    await delete(appState)..where((as) => as.id.equals(_singletonId))..go();
  }

  UpdateStatement<AppState, AppStateData> updateSingleton() {
    return update(appState)..where((as) => as.id.equals(_singletonId));
  }
}
