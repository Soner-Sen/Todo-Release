import 'package:uuid/uuid.dart';

class UniqueID {
  const UniqueID._(this.value);

  final String value;

  factory UniqueID() {
    //UUid.v1 generiert eine Zeitbasierte ID
    return UniqueID._(const Uuid().v1());
  }

  factory UniqueID.fromUniqueString(String uniqueID) {
    return UniqueID._(uniqueID);
  }
}
