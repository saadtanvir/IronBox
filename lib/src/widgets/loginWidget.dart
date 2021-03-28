import 'package:fitness_app/src/controllers/user_controller.dart';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  UserController _con = Get.put(UserController());
  GlobalKey<FormState> _loginFormKey;
  String _email = "";
  String _password = "";

  void _validate() async {
    // create login functin in user controller
    // call login function
    // pass email & pass as arguments
  }

  @override
  void initState() {
    // TODO: implement initState
    _loginFormKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Form(
        key: _loginFormKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (input) => _email = input,
                validator: (input) =>
                    !input.contains('@') ? Constants.invalidEmail : null,
                decoration: InputDecoration(
                  labelText: Constants.enterEmail,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).accentColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                onSaved: (input) => _password = input,
                validator: (input) =>
                    input.length < 4 ? Constants.incorrectPassword : null,
                decoration: InputDecoration(
                  labelText: Constants.enterPassword,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelStyle: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).accentColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              TextButton(
                  onPressed: () async {
                    if (!_loginFormKey.currentState.validate()) {
                      return;
                    } else if (_loginFormKey.currentState.validate()) {
                      _loginFormKey.currentState.save();
                      await _validate();
                    }
                  },
                  child: Text(
                    Constants.login,
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(150.0)),
                      ))))
            ],
          ),
        ),
      ),
    );
  }
}
