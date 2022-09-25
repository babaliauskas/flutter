import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSignUpComplete = false;

  Future<void> _signUp() async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: 'l.babaliauskas@gmail.com',
        CognitoUserAttributeKey.phoneNumber: '+15559101234',
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: 'l.babaliauskas@gmail.com',
        password: 'Test123!',
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      setState(() {
        isSignUpComplete = result.isSignUpComplete;
      });
      safePrint('Success - Signed UP');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> _confirmUser() async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: 'l.babaliauskas@gmail.com', confirmationCode: '840362');

      setState(() {
        isSignUpComplete = result.isSignUpComplete;
      });
      safePrint('Confirmed');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: _signUp,
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: _confirmUser,
              child: const Text(
                'Confirm SignUp',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
