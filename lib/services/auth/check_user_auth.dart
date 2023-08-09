import '../../global/global.dart';
import 'auth_provider.dart';
import '../general_services/check_internet_connectivity.dart';

Future<bool> checkUserLoggedIn() async {
  String? token = await storage.read(key: 'token');
  print("stored token is $token");
  if (token != null) {
    return true;
  }
  return false;
}

Future<bool> checkFirstSeen() async {
  String? _seen = await storage.read(key: 'seen');
  // bool _seen = (prefs.getBool('seen') ?? false);

  if (_seen == '1') {
    // Navigator.of(context).pushReplacement(
    //     new MaterialPageRoute(builder: (context) => new Home()));
    return true;
  } else {
    // await prefs.setBool('seen', true);
    await storage.write(key: 'seen', value: '1');
    return false;
    // Navigator.of(context).pushReplacement(
    //     new MaterialPageRoute(builder: (context) => new IntroScreen()));
  }
}

Future readToken(context) async {
  final String? token = await storage.read(key: 'token');
  await checkAndShowInternetConnection(context);

  try {
    await AuthProvider().getUser(token);
  } catch (e) {
    // errorSnackBar(context, SessionExperiedAlert);
    // await AuthProvider().logout();
    // Navigator.pushReplacementNamed(context, SignInScreen.routeName);
  }
}
