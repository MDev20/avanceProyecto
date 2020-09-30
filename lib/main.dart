import 'package:appedejemplo/src/home_widget.dart';
import 'package:appedejemplo/src/services/auth_services.dart';
import 'package:appedejemplo/src/views/sign_up_view.dart';
import 'package:appedejemplo/src/widgets/provider_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appedejemplo/src/views/first_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/signUp': (BuildContext context) => SignUpView(
                  authFormType: AuthFormType.signUp,
                ),
            '/signIn': (BuildContext context) => SignUpView(
                  authFormType: AuthFormType.signIn,
                ),
            '/home': (BuildContext context) => HomeController()
          }),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : FirstView();
        }
        return CircularProgressIndicator();
      },
    );
  }
}
