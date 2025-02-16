import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tanvir/auth/sing_up.dart';
import 'package:tanvir/auth_controller.dart';
import 'package:tanvir/models/User_data.dart';
import 'package:tanvir/services/network_caller.dart';
import 'package:tanvir/services/network_response.dart';
import 'package:tanvir/services/urls.dart';
import 'package:tanvir/task/all_task_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Form(
          key: _globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get Start With',
                style: textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailTEController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (String? value) {
                  if (value?.isEmpty == true) {
                    return 'Enter valid email';
                  }
                  if (!value!.contains('@')) {
                    return "Enter valid email '@'";
                  }
                  if (!value.contains('.com')) {
                    return "Enter valid email '.com'";
                  }
                  return null;
                },
              ),
              const SizedBox(height:10),
              TextFormField(
                controller: _passwordTEController,
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Enter value a minimum 6 character';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 26),
              Center(
                child: ElevatedButton(
                  onPressed: _onTapNextScreen,
                  child: const Text('Sing In'),
                ),
              ),
              const SizedBox(height:16),
            ],
          ),
        ),
            RichText(text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600
              ),
              text: 'Create Account? ',
              children: [
                TextSpan(
                  style: const TextStyle(
                      color: Colors.blue,
                  ),
                  text: 'Sing Up',
                  recognizer: TapGestureRecognizer()..onTap = (){

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                      return const SingUp();
                    }), (_) => false);
                  }
                )
              ]
            ))
          ],
        ),
      ),
    );
  }
  void _onTapNextScreen() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    _login();
  }

  Future<void> _login() async {
    setState(() => inProgress = true);

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: {
        "email": _emailTEController.text.trim(),
        "password": _passwordTEController.text.trim(),
      },
    );

    if (response.isSuccess) {
      LoginModel loginModel = LoginModel.fromJson(response.responseBody);

      // Check if token exists
      if (loginModel.data?.token != null) {
        await AuthController.saveAccessToken(loginModel.data!.token!);
        print('Token => ${loginModel.data!.token}');
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AllTaskScreen()),
              (_) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed. No token received.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.errorMassage)),
      );
    }

    setState(() => inProgress = false);
  }


  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
  }
}
