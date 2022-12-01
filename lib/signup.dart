import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Authenticate.dart';
import 'SignInButton.dart';

Authenticate auth = new Authenticate();

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SizedBox(height: 80),
        FutureBuilder(
          future: Authenticate.initializeFirebase(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error initializing Firebase');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return GoogleSignInButton();
            }
            return CircularProgressIndicator(
                // valueColor: AlwaysStoppedAnimation<Color>(
                //   CustomColors.firebaseOrange,
                // ),
                );
          },
        ),
      ],
    );
  }
}
