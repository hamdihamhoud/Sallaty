import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  static const routeName = '/feedback';
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(5),
        child: ListView(
          children: [
            Text(
              'We are more than happy to help you solve any problem you face using our app and listen to your suggestions for a better user experience.',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              maxLines: 8,
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Enter your message here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                validate(context);
              },
              child: Text('Submit'),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor)),
            )
          ],
        ),
      ),
    );
  }

  void validate(BuildContext context) {
    if (controller.text.isEmpty) return;
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Alert!'),
              content:
                  Text('your name and number will be sent with your message'),
              actions: [
                TextButton(onPressed: () {
                  Navigator.of(context).pop();
                }, child: Text('Cancel')),
                TextButton(onPressed: () {
                  controller.text = '';
                  Navigator.of(context).pop();
                }, child: Text('Okay'))
              ],
            ));
  }
}
