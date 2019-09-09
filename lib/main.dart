import 'package:base_project_provider/core/models/user.dart';
import 'package:base_project_provider/core/services/api.dart';
import 'package:base_project_provider/core/services/authentication_service.dart';
import 'package:base_project_provider/core/viewmodels/home_model.dart';
import 'package:base_project_provider/core/viewmodels/login_model.dart';
import 'package:base_project_provider/ui/router.dart';
import 'package:base_project_provider/ui/views/home_view/home_view.dart';
import 'package:base_project_provider/ui/views/login_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          builder: (_) => Api(),
          dispose: (_, api) => api.dispose(),
        ),
        ProxyProvider<Api, AuthenticationService>(
          builder: (_, api, previous) =>
              (previous ?? AuthenticationService())..api = api,
          dispose: (_, auth) => auth.dispose(),
        ),
        StreamProvider<User>(
          builder: (context) =>
              Provider.of<AuthenticationService>(context, listen: false).user,
        ),
        ChangeNotifierProxyProvider2<User, Api, HomeModel>(
          initialBuilder: (_) => HomeModel(),
          builder: (context, user, api, model) => model
            ..api = api
            ..userId = user?.id,
        ),
        ChangeNotifierProxyProvider<AuthenticationService, LoginModel>(
          initialBuilder: (_) => LoginModel(),
          builder: (_, auth, model) => model..authenticationService = auth,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          '/': (context) => Provider.of<User>(context)?.id != null
              ? const HomeView()
              : const LoginView(),
          '/login': (_) => const LoginView(),
        },
        onGenerateRoute: Router.generateRoute,
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No Route defined for ${settings.name}'),
            ),
          ),
        ),
      ),
    );
  }
}
