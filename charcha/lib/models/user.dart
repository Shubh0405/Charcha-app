import 'package:flutter/material.dart';

class User {
  final String userId;
  final String userProfileId;
  final String userName;
  final String fullName;
  String profilePic;
  String profileStatus;

  User(
      {required this.userId,
      required this.userProfileId,
      required this.userName,
      required this.fullName,
      this.profilePic = "",
      this.profileStatus = ""});
}
