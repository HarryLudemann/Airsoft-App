import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnectivityState() async {
  final ConnectivityResult result = await Connectivity().checkConnectivity();

  if (result == ConnectivityResult.wifi) {
    return true;
  } else if (result == ConnectivityResult.mobile) {
    return true;
  } else {
    return false;
  }
}
