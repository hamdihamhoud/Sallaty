import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AddImageViewer extends StatefulWidget {
  final List<File> imgList;
  AddImageViewer(this.imgList);
  @override
  State<StatefulWidget> createState() {
    return _AddImageViewerState();
  }
}

class _AddImageViewerState extends State<AddImageViewer> {
  int _current = 0;
  List<Widget> imageSliders;
  @override
  void initState() {
    super.initState();
    imageSliders = widget.imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.file(
                    item,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: imageSliders,
        options: CarouselOptions(
            aspectRatio: 3 / 2,
            viewportFraction: 1,

            // enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imgList.map((url) {
          int index = widget.imgList.indexOf(url);
          return Container(
            width: 15,
            height: 8.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Theme.of(context).accentColor
                  : Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
