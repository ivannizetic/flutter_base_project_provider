import 'package:base_project_provider/core/enums/viewstate.dart';
import 'package:base_project_provider/core/models/post.dart';
import 'package:base_project_provider/core/models/user.dart';
import 'package:base_project_provider/core/viewmodels/home_model.dart';
import 'package:base_project_provider/ui/shared/common/app_colors.dart';
import 'package:base_project_provider/ui/shared/common/text_styles.dart';
import 'package:base_project_provider/ui/shared/common/ui_helpers.dart';
import 'package:base_project_provider/ui/views/home_view/widgets/postlist_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      // A consumer so that we don't rebuild `Scaffold` when `HomeModel` change.
      body: Consumer<HomeModel>(
        builder: (context, model, _) {
          return model.state == ViewState.Busy
              ? const Center(child: CircularProgressIndicator())
              : const HomeContent(
                  header: HeaderTitle(),
                  body: PostList(),
                );
        },
      ),
    );
  }
}

class HeaderTitle extends StatelessWidget {
  const HeaderTitle();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Text(
      'Welcome ${user.name}',
      style: headerStyle,
    );
  }
}

class PostList extends StatelessWidget {
  const PostList();

  @override
  Widget build(BuildContext context) {
    final homeModel = Provider.of<HomeModel>(context);
    return ListView.builder(
      itemCount: homeModel.posts.length,
      itemBuilder: (context, index) {
        var post = homeModel.posts[index];
        return Provider<Post>.value(
          key: ValueKey(post.id),
          value: post,
          // it's not necessary to move the click handler to PostListItem
          // but this allows to use a const constructor, which is better for performance.
          // this way, only the item that changes rebuilds. Not the whole list.
          child: const PostListItem(),
        );
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  final Widget header;
  final Widget body;

  const HomeContent({this.header, this.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        UIHelper.verticalSpaceLarge,
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: header,
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: const Text(
            'Here are all your posts',
            style: subHeaderStyle,
          ),
        ),
        UIHelper.verticalSpaceSmall,
        Expanded(child: body),
      ],
    );
  }
}
