import 'package:flutter/material.dart';

showAlertDialog({
  BuildContext context,
  String content,
}) {
  AlertDialog alert = AlertDialog(
    contentPadding: const EdgeInsets.all(0),
    content: Container(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 1,
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 19,
              color: Color(0xFF333333),
            ),
          ),
          Container(
            height: 50,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
              ),
            ),
            width: double.infinity,
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(32),
      ),
    ),
  );

  showDialog(
    context: context,
    barrierColor: Colors.black45,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
