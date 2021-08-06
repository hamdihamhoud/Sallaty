import 'package:flutter/foundation.dart';

class AddressesProvider with ChangeNotifier {
  List<String> _addresses = [
    // 'mazzeh hamdi building 662 street ghazawi hamak bab toma',
    // 'madamya shaalan muhajreen bns albld marje'
  ];

  List<String> get addresses {
    return _addresses;
  }

  void setAddress(String address) {
    addresses.add(address);
    notifyListeners();
  }
}
