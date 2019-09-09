import 'package:base_project_provider/core/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Post>(context);
    return _PostListItem(
      onTap: () {
        Navigator.pushNamed(context, '/post', arguments: post);
      },
      title: Text(post.title),
      body: Text(post.body),
    );
  }
}

// separation of design the data-binding
class _PostListItem extends StatelessWidget {
  final Widget title;
  final Widget body;
  final VoidCallback onTap;

  const _PostListItem({this.title, this.body, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                blurRadius: 3.0,
                offset: Offset(0.0, 2.0),
                color: Color.fromARGB(80, 0, 0, 0),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DefaultTextStyle.merge(
              child: title,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16.0),
            ),
            DefaultTextStyle.merge(
              child: body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
