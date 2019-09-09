import 'dart:async';

import 'package:base_project_provider/core/models/user.dart';
import 'package:base_project_provider/core/services/api.dart';


class AuthenticationService {
  Api api;

  StreamController<User> _userController = StreamController<User>();
  Stream<User> get user => _userController.stream;

  Future<bool> login(int userId) async {
    var fetchedUser = await api.getUserProfile(userId);
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }
    return hasUser;
  }

  dispose() {
    _userController.close();
  }
}
