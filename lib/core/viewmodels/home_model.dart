
import 'package:base_project_provider/core/enums/viewstate.dart';
import 'package:base_project_provider/core/models/post.dart';
import 'package:base_project_provider/core/services/api.dart';
import 'package:base_project_provider/core/viewmodels/base_model.dart';

class HomeModel extends BaseModel {
  Api _api;
  Api get api => _api;
  set api(Api api) {
    _api = api;
    notifyListeners();
  }

  int _userId;
  int get userId => _userId;
  set userId(int userId) {
    if (_userId != userId) {
      _userId = userId;
      _getPosts(userId);
      notifyListeners();
    }
  }

  List<Post> posts = [];

  Future _getPosts(int userId) async {
    if (state == ViewState.Busy) {
      throw StateError(
          "fetching posts again when the current request haven't finished");
    }
    setState(ViewState.Busy);
    posts = await _api.getPostsForUser(userId);
    setState(ViewState.Idle);
  }
}
