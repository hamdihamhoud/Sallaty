import 'package:cool_alert/cool_alert.dart';
import 'package:ecart/providers/addresses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaquery = MediaQuery.of(context);
    final addressesProvider = Provider.of<AddressesProvider>(context);
    return Expanded(
      child: addressesProvider.addresses.length > 0
          ? ListView.builder(
              itemCount: addressesProvider.addresses.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        border: Border.all(
                          width: 2,
                          color: theme.accentColor,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            addressesProvider.addresses[index],
                            style: TextStyle(
                              fontSize: 21,
                              color: Color(0xFF333333),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                            ),
                            child: Container(
                              width: mediaquery.size.width,
                              child: TextButton(
                                onPressed: () {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.success,
                                    animType: CoolAlertAnimType.scale,
                                    title: 'ads',
                                  );
                                },
                                child: Text(
                                  'Select Address',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/no_address_found.png"),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    "No Address Added Yet",
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    "Tap 'Add a new Address' button below to add your first Address and start shopping!",
                    style: TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
    );
  }
}
