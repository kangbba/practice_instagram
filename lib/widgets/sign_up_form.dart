import 'package:flutter/material.dart';
import 'package:practice_insta/constants/common_size.dart';
import 'package:practice_insta/home_page.dart';

import '../constants/auth_input_decor.dart';
import '../constants/etc.dart';
import 'or_divier.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

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
              SizedBox(height: common_l_gap, ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                cursorColor: Colors.black,
                controller: _emailController,
                decoration: textInputDecor('Email'),
                validator: (text){
                  if(text!.isNotEmpty && text.contains("@"))
                  {
                    return null;
                  }
                  else{
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
                validator: (text){
                  if(text!.isNotEmpty && text.length > 2)
                  {
                    return null;
                  }
                  else{
                    return '제대로된 비밀번호가 아닙니다';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                cursorColor: Colors.black,
                controller: _cpwController,
                obscureText: true,
                decoration: textInputDecor('Confirm Password'),
                validator: (text){
                  if(text!.isNotEmpty && (_pwController.text == _cpwController.text))
                  {
                    return null;
                  }
                  else{
                    return '비밀번호가 일치하지 않아요';
                  }
                },
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextButton(
                style: flatButtonStyle_blue,
                onPressed: () {
                  if(_formKey.currentState!.validate())
                  {
                      print('validation success');
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => HomePage()
                          )
                      );
                  }
                },
                child: Text(
                    'Join',
                  style: TextStyle(color : Colors.white),
                ),
              ),
              SizedBox(height: common_l_gap),
              OrDivider(),
              SizedBox(height: common_l_gap),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => HomePage()
                      )
                  );},
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

