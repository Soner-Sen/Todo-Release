//Erweitern Firebase User

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/domain/entities/userID/id.dart';
import 'package:todo/domain/entities/userID/user.dart';

extension FirebaseUserMapper on User {
  CustomUser toDomain() {
    //uid kommt von Firebase
    return CustomUser(id: UniqueID.fromUniqueString(uid));
  }
}
