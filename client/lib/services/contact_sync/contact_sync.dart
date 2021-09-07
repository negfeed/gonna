class ContactSyncService {
  
  static ContactSyncService? _instance;

  static ContactSyncService get instance {
    if (_instance == null) {
      _instance = ContactSyncService();
    }
    return _instance!;
  }

  Future<void> syncAllContacts() async {
    // TODO(mshamma): Implement.
    // Read contacts from phone.
    // Read profiles corresponding to these contacts.
    // Update (contact, profile) tuples in local db.
  }

  Future<void> syncContact(String phoneNumber) async {
    // TODO(mshamma): Implement.
    // Read contact from phone.
    // Read profile corresponding to these contacts.
    // Update (contact, profile) tuple in local db.
  }
}