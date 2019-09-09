import 'package:base_project_provider/core/enums/viewstate.dart';
import 'package:flutter/widgets.dart';

class BaseModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
