import 'package:base_project_provider/core/enums/viewstate.dart';
import 'package:base_project_provider/core/viewmodels/login_model.dart';
import 'package:base_project_provider/ui/shared/common/app_colors.dart';
import 'package:base_project_provider/ui/views/login_view/widgets/login_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoginHeader(
            validationMessage: model.errorMessage,
            controller: _controller,
          ),
          model.state == ViewState.Busy
              ? const CircularProgressIndicator()
              : FlatButton(
                  color: Colors.white,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    var loginSuccess = await model.login(_controller.text);
                    if (loginSuccess) {
                      Navigator.pushNamed(context, '/');
                    }
                  },
                )
        ],
      ),
    );
  }
}
