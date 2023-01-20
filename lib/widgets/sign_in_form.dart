import 'package:flutter/material.dart';
import 'package:practiceinsta/constants/common_size.dart';
import 'package:practiceinsta/home_page.dart';
import 'package:practiceinsta/models/firebase_auth_state.dart';
import 'package:provider/provider.dart';

import '../constants/auth_input_decor.dart';
import '../constants/etc.dart';
import 'or_divier.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _cpwController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: common_l_gap,),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                cursorColor: Colors.black,
                controller: _emailController,
                decoration: textInputDecor('Email'),
                validator: (text) {
                  if (text!.isNotEmpty && text.contains("@")) {
                    return null;
                  }
                  else {
                    return '올바른 이메일 형식이 아닙니다';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                cursorColor: Colors.black,
                controller: _pwController,
                decoration: textInputDecor('Password'),
                obscureText: true,
                validator: (text) {
                  if (text!.isNotEmpty && text.length > 2) {
                    return null;
                  }
                  else {
                    return '제대로된 비밀번호가 아닙니다';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextButton(
                style: flatButtonStyle_blue,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('일반 login 으로 signin 상태변경 ');
                    Provider.of<FirebaseAuthState>(context, listen : false).changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                  }
                },
                child: Text(
                  'Join',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                    },
                    style:  ButtonStyle( overlayColor: MaterialStateProperty.all<Color>(Colors.black12), ),
                    child: Text('Forgotten Password', style: TextStyle(color: Colors.blue),)
                ),
              ),

              SizedBox(height: common_l_gap),
              OrDivider(),
              SizedBox(height: common_l_gap),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    print('Facebook login 으로 signin 상태변경 ');
                    Provider.of<FirebaseAuthState>(context, listen : false).changeFirebaseAuthStatus(FirebaseAuthStatus.signin);
                  });
                },
                icon: ImageIcon(AssetImage('assets/images/facebook.png')),
                label: Text('Login with Facebook'), // <-- Text
                style: FlatButtonStyle(Colors.blue, Colors.white, true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

