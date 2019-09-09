import 'package:base_project_provider/core/enums/viewstate.dart';
import 'package:base_project_provider/core/models/comment.dart';
import 'package:base_project_provider/core/models/post.dart';
import 'package:base_project_provider/core/services/api.dart';
import 'package:base_project_provider/core/viewmodels/comments_model.dart';
import 'package:base_project_provider/ui/shared/common/app_colors.dart';
import 'package:base_project_provider/ui/shared/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Comments extends StatelessWidget {
  const Comments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider2<Post, Api, CommentsModel>(
      initialBuilder: (_) => CommentsModel(),
      builder: (context, post, api, model) => model
        ..api = api
        ..postId = post.id,
      child: Consumer<CommentsModel>(
        builder: (context, model, child) => model.state == ViewState.Busy
            ? const Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView.builder(
                  itemCount: model.comments.length,
                  itemBuilder: (context, index) {
                    return Provider.value(
                      value: model.comments[index],
                      child: const CommentItem(),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

/// Renders a single comment given a comment model

class CommentItem extends StatelessWidget {
  const CommentItem();

  @override
  Widget build(BuildContext context) {
    final comment = Provider.of<Comment>(context);
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: commentColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            comment.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          UIHelper.verticalSpaceSmall,
          Text(comment.body),
        ],
      ),
    );
  }
}
