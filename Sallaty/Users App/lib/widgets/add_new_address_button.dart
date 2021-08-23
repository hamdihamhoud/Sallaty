import 'package:ecart/screens/adresses_screen.dart';
import 'package:flutter/material.dart';

class NewAddressButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Container(
      width: mediaquery.size.width,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) => Color(0xFF333333),
          ),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => Color(0xFF828282),
          ),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddAddressForm(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add a new Address",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.add_location_alt_outlined),
              )
            ],
          ),
        ),
      ),
    );
  }
}
