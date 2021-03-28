import 'package:fitness_app/src/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  UserController _con = Get.put(UserController());
  GlobalKey<FormState> _signupFormKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signupFormKey = new GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Form(
          key: _signupFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _con.user.name,
                  validator: (input) => input.length < 3
                      ? Constants.name_should_be_min_three_char
                      : null,
                  decoration: InputDecoration(
                    labelText: Constants.enterName,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _con.user.email,
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
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    ),
                  ),
                ),
                // SizedBox(height: 15.0),
                // TextFormField(
                //   keyboardType: TextInputType.phone,
                //   // onSaved: (input) => _email = input,
                //   // validator: (input) =>
                //   //     !input.contains('@') ? Constants.invalidEmail : null,
                //   decoration: InputDecoration(
                //     labelText: Constants.enterPhone,
                //     floatingLabelBehavior: FloatingLabelBehavior.never,
                //     labelStyle: TextStyle(
                //         color: Theme.of(context).secondaryHeaderColor,
                //         fontWeight: FontWeight.bold),
                //     contentPadding: EdgeInsets.all(10),
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(
                //           width: 2.0,
                //           color:
                //               Theme.of(context).accentColor.withOpacity(0.2)),
                //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     ),
                //   ),
                // ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _con.user.age,
                  validator: (input) =>
                      input.length >= 3 ? Constants.invalid_age : null,
                  decoration: InputDecoration(
                    labelText: Constants.enterAge,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                DropdownButtonFormField(
                  // onSaved: (input) => _con.user,
                  // validator: (input) => input.length < 3
                  //     ? S.of(context).should_be_more_than_3_letters
                  //     : null,
                  onChanged: (value) {
                    // print(value);
                    // _priority = todoPriorities.indexOf(value);
                    // print(_priority);
                  },
                  items: Constants.selectGender.map((String priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text("$priority"),
                    );
                  }).toList(),
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  iconSize: 20.0,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: "Gender",
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor),
                    contentPadding: EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _con.user.height,
                  validator: (input) => !input.contains('.')
                      ? Constants.enter_height_in_cm
                      : null,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: "150.00",
                    hintStyle: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    labelText: Constants.enterHeight,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _con.user.weight,
                  validator: (input) =>
                      input.length > 2 ? Constants.enter_weight_in_cm : null,
                  decoration: InputDecoration(
                    labelText: Constants.enterWeight,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _con.user.bmi,
                  validator: (input) =>
                      input.length > 2 ? Constants.invalid_bmi : null,
                  decoration: InputDecoration(
                    labelText: Constants.enterBmi,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onSaved: (input) => _con.user.injury,
                  // validator: (input) =>
                  //     input.length < 4 ? Constants.incorrectPassword : null,
                  decoration: InputDecoration(
                    labelText: Constants.injuryIfAny,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onSaved: (input) => _con.user.medicalBG,
                  // validator: (input) =>
                  //     input.length < 4 ? Constants.incorrectPassword : null,
                  decoration: InputDecoration(
                    labelText: Constants.medicalBackground,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onSaved: (input) => _con.user.familyMedicalBG,
                  // validator: (input) =>
                  //     input.length < 4 ? Constants.incorrectPassword : null,
                  decoration: InputDecoration(
                    labelText: Constants.familyMedicalBG,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onSaved: (input) => _con.user.password,
                  validator: (input) => input.length < 4
                      ? Constants.password_should_be_greater_than_three
                      : null,
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
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  // onSaved: (input) => _password = input,
                  // validator: (input) =>
                  //     input.length < 4 ? Constants.incorrectPassword : null,
                  decoration: InputDecoration(
                    labelText: Constants.confirmPassord,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.all(Radius.circular(150.0)),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                TextButton(
                    onPressed: () async {
                      if (!_signupFormKey.currentState.validate()) {
                        return;
                      } else if (_signupFormKey.currentState.validate()) {
                        _signupFormKey.currentState.save();
                        // Todo:
                        // create registerUser function in user controller
                        // call that function
                      }
                    },
                    child: Text(
                      Constants.signup,
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 50.0)),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(150.0)),
                        )))),
                TextButton(
                  onPressed: () async {
                    Get.back();
                  },
                  child: Text(
                    Constants.alreadyHaveAnAcc,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
