import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_patient_monitoring/pages/Home/home.dart';
import 'package:smart_patient_monitoring/setting/login_page_setting.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final __formKey = GlobalKey<FormState>();
  final __emailController = TextEditingController();
  final __pswrdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Form(
          key: __formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20.0),
              emailWidget(),
              const SizedBox(height: 30.0),
              passwordWidget(),
              const SizedBox(height: 10.0),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailWidget() {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: kBoxDecorationStyle,
      height: 60.0,
      width: 350,
      child: TextFormField(
        controller: __emailController,
        validator: (value) {
          if (value == null || value.isEmpty) return '*required';
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        style:
            const TextStyle(color: Colors.deepPurple, fontFamily: 'OpenSans'),
        decoration:
            kInputDecorationStyle('Email Id', Icons.alternate_email_rounded),
      ),
    );
  }

  Widget passwordWidget() {
    return Container(
        padding: const EdgeInsets.all(6.0),
        decoration: kBoxDecorationStyle,
        height: 60.0,
        width: 350.0,
        child: TextFormField(
          controller: __pswrdController,
          validator: (value) {
            if (value == null || (value.isEmpty)) return '*requierd';
            return null;
          },
          obscureText: true,
          decoration: kInputDecorationStyle('Password', Icons.lock_rounded),
        ));
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
        elevation: 20.0,
        clipBehavior: Clip.antiAlias,
        child: MaterialButton(
          onPressed: () {
        /*
          TODO: Implement Proper Login (Current hack to directly navigate to homePage)
        */
             Navigator.of(context).push(MaterialPageRoute(builder: (arg) => const HomePage()));
          },
          minWidth: 200.0,
          height: 50.0,
          color: const Color(0xFF295BE0),
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
              fontSize: 22.0,
            ),
          ),
        ),
      ),
    );
  }
}
