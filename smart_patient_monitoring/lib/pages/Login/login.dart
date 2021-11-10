import 'package:flutter/material.dart';
import 'package:smart_patient_monitoring/pages/Login/Widgets/banner_widget.dart';
import 'package:smart_patient_monitoring/pages/Login/Widgets/facebook_widget.dart';
import 'package:smart_patient_monitoring/pages/Login/Widgets/google_widget.dart';
import 'package:smart_patient_monitoring/pages/Login/Widgets/login_form_widget.dart';
import 'package:smart_patient_monitoring/pages/Login/Widgets/logo_widget.dart';
import 'package:smart_patient_monitoring/pages/Login/Widgets/yahoo_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: const Color(0xFFFFFFFF),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  const BannerWidget(),
                  Padding(
                    padding: EdgeInsets.only(top: height / 3),
                    child: const LogoWidget(),
                  ),
                ],
              ),
              const LoginFormWidget(),
              const SizedBox(height: 20.0),
              const Text(
                'Or Login with',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.grey,
                  fontFamily: 'Arial'
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  GoogleLogin(),
                  FacebookLogin(),
                  YahooLogin(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
