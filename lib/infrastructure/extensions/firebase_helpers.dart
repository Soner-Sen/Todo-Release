import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/repositories/auth_repository.dart';

import '../../core/errors/erros.dart';
import '../../injection.dart';

extension FirestoreExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());
    //Gehen in den Pfad users und dann in den eingeloggten User
    return FirebaseFirestore.instance.collection('users').doc(user.id.value);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get todoCollection =>
      collection('todo');
}
