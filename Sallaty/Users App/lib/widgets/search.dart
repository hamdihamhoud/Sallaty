import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}
class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFE0E0E0),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: TextField(
        cursorColor: Colors.grey,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
              size: 16,
            ),
            border: InputBorder.none,
            hintText: "Search products",
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0)),
      ),
    );
  }
}
