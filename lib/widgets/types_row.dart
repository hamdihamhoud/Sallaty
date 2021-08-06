import 'package:flutter/material.dart';
import '../screens/type_screen.dart';
import '../models/category.dart' show Type;

class TypesRow extends StatelessWidget {
  final List<Type> types;
  TypesRow(this.types);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: types
            .map((e) => Padding(
                  padding: const EdgeInsets.only(
                    top: 18,
                    bottom: 18,
                    left: 8,
                    right: 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    height: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(TypeScreen.routeName, arguments: e);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                          left: 15,
                          right: 15,
                        ),
                        child: Text(
                          e.title,
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
