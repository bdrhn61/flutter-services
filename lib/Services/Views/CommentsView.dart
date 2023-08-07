import 'package:flutter/material.dart';


import '../Controller/I_PostServices.dart';
import '../Controller/PostServices.dart';
import '../Models/CommentModel.dart';

class CommetsView extends StatefulWidget {
  const CommetsView( {super.key, this.postId});
  final int? postId;

  @override
  State<CommetsView> createState() => _CommetsViewState();
}

class _CommetsViewState extends State<CommetsView> {
  late final IPostServices iPostServices;
  bool _isLoading = false;
  List<CommentModel>? _commentListItem;

  @override
  void initState() {
    super.initState();
    iPostServices = PostServis();
    fetchItemWithId(widget.postId ?? 0);
  }

  Future<void> fetchItemWithId(int postId) async {
    _changeLoading();
    _commentListItem =
        await iPostServices.fetchRelatedCommntsWithPostId(postId);
    _changeLoading();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: _commentListItem?.length ?? 0,
          itemBuilder: (context, index) {
          return  Card(
              child: Text(
                _commentListItem?[index].email.toString() ?? '',
              ),
            );
          }),
    );
  }
}
