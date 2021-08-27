import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/addresses.dart';

class AddressesScreen extends StatelessWidget {
  static const routeName = '/addresses';
  @override
  Widget build(BuildContext context) {
    final addressesProvider = Provider.of<AddressesProvider>(context);
    List<String> addresses = [];
    return Scaffold(
        appBar: AppBar(
          title: Text('Addresses'),
          actions: [
            IconButton(
              icon: Icon(Icons.add_location_alt_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AddAddressForm(),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: addressesProvider.addresses,
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              addresses = snapshot.data;
              return addresses != null ? ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (ctx, index) => Container(
                  child: ListTile(
                    title: Text(addresses[index]),
                  ),
                ),
              ) : Center(child: Text('No addresses yet start adding one'));
            }));
  }
}

class AddAddressForm extends StatefulWidget {
  @override
  _AddAddressFormState createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  final _key = GlobalKey<FormState>();

  String address;

  Future<void> _save() async {
    if (!_key.currentState.validate()) return;
    _key.currentState.save();
    Navigator.of(context).pop();
    await Provider.of<AddressesProvider>(context,listen: false)
        .setAddress(address);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _key,
      child: AlertDialog(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF828282),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                      ),
                      onPressed: () {
                        _save();
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Address'),
              cursorColor: Color(0xFF333333),
              validator: (value) {
                value.trim();
                if (value.isEmpty) return 'This can\'t be empty';
                if (value.length < 20) return 'too short address';
                return null;
              },
              onSaved: (value) {
                value.trim();
                address = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}
