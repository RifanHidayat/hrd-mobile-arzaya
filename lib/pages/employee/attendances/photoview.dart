import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:magentahrdios/services/api_clien.dart';

import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  PhotoViewPage({this.image});

  var image;

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Data image ${image_ur}/${widget.image}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: Colors.black87,
          child: Center(
            child: Hero(
              tag: "avatar-1",
              child: Container(
                  child: widget.image == null
                      ? PhotoView(
                          imageProvider: AssetImage(
                          "assets/absen.jpeg",
                        ))
                      : CachedNetworkImage(
                          imageUrl: "${image_ur}/${widget.image}",
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Center(child: new CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                        )),
            ),
          ),
        ));
  }
}
