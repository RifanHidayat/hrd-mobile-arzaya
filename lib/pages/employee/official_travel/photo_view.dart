import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:magentahrdios/services/api_clien.dart';

import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  PhotoViewPage({this.image_url, this.iamge_file});

  var image_url, iamge_file;

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("image url ${widget.image_url}");
    print("image file ${widget.iamge_file}");
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
                  child: widget.image_url != ""
                      ? PhotoView(
                          imageProvider: NetworkImage(
                          "${image_ur}/${widget.image_url}",
                        ))
                      : widget.iamge_file != ""
                          ? Image.file(File(widget.iamge_file))
                          : PhotoView(
                              imageProvider: NetworkImage(
                              "${image_ur}/${widget.image_url}",
                            ))),
            ),
          ),
        ));
  }
}
