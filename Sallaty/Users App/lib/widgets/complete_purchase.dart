import 'package:ecart/providers/cart.dart';
import 'package:ecart/providers/orders.dart';
import 'package:ecart/widgets/add_copon_form.dart';
import 'package:ecart/widgets/add_new_address_button.dart';
import 'package:ecart/widgets/address_viewer.dart';
import 'package:ecart/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletePurchase extends StatefulWidget {
  const CompletePurchase({
    Key key,
    @required this.cart,
  }) : super(key: key);
  final Cart cart;

  @override
  _CompletePurchaseState createState() => _CompletePurchaseState();
}

class _CompletePurchaseState extends State<CompletePurchase> {
  int deliveryCharge = 0;
  double coponDiscount = 0;
  bool init = true;
  double total;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (init) {
      deliveryCharge =
          await Provider.of<Orders>(context).getOrderDeliveryCharge();
      total = widget.cart.total + deliveryCharge;
      setState(() {
        init = false;
      });
    }
  }

  void setCoponDiscount(double val) {
    coponDiscount = val;
    total = total - deliveryCharge;
    total = total - total * (coponDiscount / 100) + deliveryCharge;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);
    final mediaquery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Container(
      width: mediaquery.size.width,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(coponDiscount == 0 && !init)
            Container(
              width: mediaquery.size.width,
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddCoponForm(setCoponDiscount),
                  );
                },
                child: Text(
                  '+ Add Copon',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    'Delivery Charge',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                  ),
                ),
                init
                    ? Text(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      )
                    : Text(
                        '${deliveryCharge.toStringAsFixed(0)} SP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: Text(
                      init ? '...' : '${total.toStringAsFixed(0)} SP',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Container(
                width: mediaquery.size.width,
                height: 40,
                child: ElevatedButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 21,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: theme.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        barrierColor: Colors.black38,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        context: context,
                        builder: (context) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AddressesViewer(total: total),
                                  NewAddressButton(),
                                ],
                              ),
                            ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
