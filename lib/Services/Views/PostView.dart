
import 'package:flutter/material.dart';


import '../Controller/I_PostServices.dart';
import '../Controller/PostServices.dart';
import '../Models/PostModel.dart';
import 'CommentsView.dart';

class ServicesView extends StatefulWidget {
  const ServicesView({super.key});

  @override
  State<ServicesView> createState() => _ServicesViewState();
}

class _ServicesViewState extends State<ServicesView> {
  String? name;
  List<PostModel>? _items;
  bool _isLoading = false;
  late final IPostServices _postServis;
  @override
  void initState() {
    super.initState();
    _postServis = PostServis();
    fetchPostItemAdvence();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }
/*
  Future<void> fetchPostItem() async {
    _changeLoading();

    final response =
        await Dio().get('https://jsonplaceholder.typicode.com/posts');
    if (response.statusCode == HttpStatus.ok) {
      final dates = response.data;
      if (dates is List) {
        setState(() {
          _items = dates.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
    _changeLoading();
  }  */

  Future<void> fetchPostItemAdvence() async {
    _changeLoading();
    _items = await _postServis.fetchPostItemAdvence();
    _changeLoading();
  }

  Future<void> addItemToService(Map<String, dynamic> model) async {
    _changeLoading();
    _postServis.addItemToService(model);

    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _isLoading
              ? null
              : () {
                  final model = PostModel(
                          body: 'benim body',
                          userId: 55,
                          title: 'benim title',
                          id: 56)
                      .toJson();

                  addItemToService(model);
                }),
      appBar: AppBar(
        title: _isLoading
            ? const CircularProgressIndicator.adaptive(
                backgroundColor: Colors.red,
              )
            : const SizedBox.shrink(),
      ),
      body: _items == null
          ? const Placeholder()
          : ListView.builder(
              itemCount: _items?.length ?? 0,
              itemBuilder: ((context, index) {
                return PostCard(model: _items?[index]);
              }),
            ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({Key? key, required PostModel? model})
      : _model = model,
        super(key: key);
  final PostModel? _model;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 175, 168, 144),
      child: ListTile(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CommetsView(postId: _model?.id,)));
        },
        title: Text(_model?.title.toString() ?? ''),
        subtitle: Text(_model?.body.toString() ?? ''),
      ),
    );
  }
}
