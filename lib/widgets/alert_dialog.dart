import 'package:flutter/material.dart';

showAlertDialog({
  BuildContext context,
  final Map<Color, Map<String, int>> colorsAndQuantityAndSizes,
  final List<int> quantity,
}) {
  Widget okButton = ElevatedButton(
    child: Text(
      "OK",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    style: ElevatedButton.styleFrom(
      shadowColor: Colors.transparent,
      primary: Color(0xFF333333),
      onPrimary: Color(0xFF828282),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  final int colorsNumber = colorsAndQuantityAndSizes.keys.length;
  AlertDialog alert = AlertDialog(
    content: Container(
      width: MediaQuery.of(context).size.width,
      height: colorsNumber == 1 ? 60 : colorsNumber.toDouble() * 50,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Colors',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (int i = 0; i < colorsNumber; i++)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                          color: colorsAndQuantityAndSizes.keys.elementAt(i),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          )),
                    ),
                  ),
              ],
            ),
            if (colorsAndQuantityAndSizes.entries
                    .elementAt(0)
                    .value
                    .keys
                    .elementAt(0) !=
                '0')
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Sizes',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  for (int i = 0; i < colorsNumber; i++)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Row(
                        children: [
                          for (int j = 0;
                              j <
                                  colorsAndQuantityAndSizes.entries
                                      .elementAt(i)
                                      .value
                                      .length;
                              j++)
                            Container(
                              height: 30,
                              child: j !=
                                      (colorsAndQuantityAndSizes.entries
                                              .elementAt(i)
                                              .value
                                              .length -
                                          1)
                                  ? Center(
                                      child: Text(
                                        "${colorsAndQuantityAndSizes.entries.elementAt(i).value.keys.elementAt(j)} - ",
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: Color(0xFF828282),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        "${colorsAndQuantityAndSizes.entries.elementAt(i).value.keys.elementAt(j)}",
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                          color: Color(0xFF828282),
                                        ),
                                      ),
                                    ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Quantity',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                for (int i = 0; i < colorsNumber; i++)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Container(
                            height: 30,
                            child: Center(
                              child: Text(
                                " ${quantity[i]}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xFF828282),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    barrierColor: Colors.black45,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
