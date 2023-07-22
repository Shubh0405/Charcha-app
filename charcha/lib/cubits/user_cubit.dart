import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/auth_repository.dart';

enum UserStatus { unknown, userLogin, userRegister, error }

class UserBloc extends Cubit<UserStatus> {
  UserBloc() : super(UserStatus.unknown);

  Future<void> checkIfEmailExists(String email) async {
    try {
      final emailExists = await AuthRepository.checkIfEmailExists(email);
      print(emailExists);
      if (emailExists) {
        emit(UserStatus.userLogin);
      } else {
        emit(UserStatus.userRegister);
      }
    } catch (e) {
      emit(UserStatus.error);
      throw Exception(e.toString());
    }
  }

  void passwordScreenBackClick() async {
    emit(UserStatus.unknown);
  }
}
