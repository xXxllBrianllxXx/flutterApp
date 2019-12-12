import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Galery extends StatelessWidget {
  const Galery({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GaleryPage()
    );
  }
}

class GaleryPage extends StatefulWidget {
  GaleryPage({Key key}) : super(key: key);

  @override
  _GaleryPageState createState() => _GaleryPageState();
}

class _GaleryPageState extends State<GaleryPage> {
  bool loading;
  List<String> ids;

  @override
  void initState() { 
    super.initState();
    loading = true;
    ids = [];

    _loadImageIds();
    
  }

  void _loadImageIds() async {
    final response = await http.get('https://picsum.photos/v2/list');
    final json = jsonDecode(response.body);

    List<String> _ids = [];

    for (var image in json) {
      _ids.add(image['id']);
    }

    setState(() {
      loading = false;
      ids = _ids;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GridView.builder(
      itemCount: ids.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.black,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return ImagePage(ids[index]);
                }
              )
            );
          },
          child: Image.network('https://picsum.photos/id/${ids[index]}/300/300')
        ),
      )
    );
  }
}

class ImagePage extends StatelessWidget {

  final String id;
  ImagePage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network('https://picsum.photos/id/$id/600/600')
      ),
    );
  }
}