import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AddImageViewer extends StatefulWidget {
  final List<Widget> imgList;
  AddImageViewer(this.imgList);
  @override
  State<StatefulWidget> createState() {
    return _AddImageViewerState();
  }
}

class _AddImageViewerState extends State<AddImageViewer> {
  int _current = 0;
  

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: widget.imgList,
        options: CarouselOptions(
            aspectRatio: 3 / 2,
            viewportFraction: 1,
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
