class Contact {
}

class ContactService {
  
  static ContactService _instance;

  static ContactService get instance {
    if (_instance == null) {
      _instance = ContactService();
    }
    return _instance;
  }

  Future<void> syncAllContacts() {
    return null;
  }

  Future<Contact> syncContact(String phoneNumber) {
    return null;
  }

  Stream<Contact> readContactByPhoneNumber(String phoneNumber) {
    return null;
  }

  Stream<List<Contact>> readContactsByProfileIds(List<String> profileIds) {
    return null;
  }

  Stream<List<Contact>> query({String phoneNumber, String firstName, String lastName}) {
    return null;
  }
}