import 'package:base_project_provider/core/models/post.dart';
import 'package:base_project_provider/core/models/user.dart';
import 'package:base_project_provider/ui/shared/common/app_colors.dart';
import 'package:base_project_provider/ui/shared/common/text_styles.dart';
import 'package:base_project_provider/ui/shared/common/ui_helpers.dart';
import 'package:base_project_provider/ui/views/post_view/widgets/comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceLarge,
            Text(post.title, style: headerStyle),
            Text(
              'by ${user.name}',
              style: TextStyle(fontSize: 9.0),
            ),
            UIHelper.verticalSpaceMedium(),
            Text(post.body),
            const Comments(),
          ],
        ),
      ),
    );
  }
}
