import 'package:base_project_provider/core/models/post.dart';
import 'package:base_project_provider/ui/views/post_view/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/post':
        var post = settings.arguments as Post;
        return MaterialPageRoute(
          builder: (_) => Provider.value(value: post, child: PostView()),
        );
      default:
        return null;
    }
  }
}
