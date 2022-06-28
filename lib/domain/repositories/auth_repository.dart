import 'package:dartz/dartz.dart';

import '../../core/failures/auth_failures.dart';
import '../entities/userID/user.dart';

abstract class AuthRepository {
  //Welche funktionen sollen drin sein

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required email, required password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required email, required password});

  Future<void> signOut();
  //Entweder None oder Sum mit ID/USER Entity ID
  Option<CustomUser> getSignedInUser();
}
