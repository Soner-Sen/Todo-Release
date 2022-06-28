import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/failures/auth_failures.dart';

import 'package:dartz/dartz.dart';
import 'package:todo/domain/entities/userID/user.dart';

import '../../domain/repositories/auth_repository.dart';
import 'package:todo/infrastructure/extensions/firebase_user_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  //Benutzen Firebase Data: Dependency Injection
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required email, required password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left(EmailAlreadyInUseFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required email, required password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        return left(InvalidEmailAndPasswordCombinationFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<void> signOut() => Future.wait([firebaseAuth.signOut()]);

  @override
  Option<CustomUser> getSignedInUser() =>
      optionOf(firebaseAuth.currentUser?.toDomain());
}
