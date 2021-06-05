import 'package:flutter/material.dart';
import '../screens/type_screen.dart';
import '../models/category.dart' show Type;

class TypesRow extends StatelessWidget {
  final List<Type> types;
  TypesRow(this.types);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 127,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: types
            .map((e) => InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(TypeScreen.routeName, arguments: e);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 41,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                // child: Image.asset(
                                //   e.imageAsset,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                            radius: 40,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          e.title,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
