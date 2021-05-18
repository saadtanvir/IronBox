import 'package:fitness_app/src/controllers/user_controller.dart';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/app_constants.dart' as Constants;

class StepperSignup extends StatefulWidget {
  @override
  _StepperSignupState createState() => _StepperSignupState();
}

class _StepperSignupState extends State<StepperSignup> {
  UserController _con = Get.put(UserController());
  GlobalKey<FormState> _signupFormKey;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isTrainer = false;
  bool _isTrainee = false;
  bool _roleSelected = false;
  String _gender = "";
  int _currentIndex = 0;
  var _weightUnitValueO = Constants.weightUnits[0].obs;

  @override
  void initState() {
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
      body: Form(
        key: _signupFormKey,
        child: Stepper(
          steps: _getSignUpSteps(),
          currentStep: _currentIndex,
          onStepTapped: _stepTapped,
          controlsBuilder: (BuildContext context,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (_currentIndex == (_getSignUpSteps().length - 2) &&
                            !_roleSelected) ||
                        _currentIndex == (_getSignUpSteps().length - 1)
                    ? SizedBox(height: 0.0, width: 0.0)
                    : TextButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          setState(() {
                            _currentIndex++;
                          });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                        ),
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                SizedBox(
                  height: 0.0,
                ),
                TextButton(
                  onPressed: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Get.back();
                  },
                  child: Text(
                    Constants.alreadyHaveAnAcc,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _stepTapped(int stepIndex) {
    if (stepIndex < _currentIndex && _currentIndex > 0) {
      setState(() {
        _currentIndex = stepIndex;
      });
    } else {
      Get.snackbar(
        "Alert",
        "Press Continue to go on next step.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
        colorText: Theme.of(context).scaffoldBackgroundColor,
      );
      return;
    }
  }

  List<Step> _getSignUpSteps() {
    List<Step> signUpSteps = [];
    // adding name, username, email, phone
    signUpSteps.add(Step(
      title: Text("Basic Info"),
      isActive: _currentIndex == 0,
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5.0,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              focusNode: Helper.getFocusNode(),
              onSaved: (input) => _con.user.name = input,
              validator: (input) => input.length < 3
                  ? Constants.name_should_be_min_three_char
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: Constants.enterName,
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
              onSaved: (input) => _con.user.userName = input,
              validator: (input) => input.length < 3 || input.length > 20
                  ? Constants.username_should_be_min_four_char
                  : input.contains(" ") ||
                          input.contains("@") ||
                          input.contains("+")
                      ? Constants.username_shouldnt_contain_spaces
                      : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: Constants.enter_username,
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
              keyboardType: TextInputType.emailAddress,
              onSaved: (input) => _con.user.email = input,
              validator: (input) =>
                  GetUtils.isEmail(input) ? null : Constants.invalidEmail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: Constants.enterEmail,
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
              keyboardType: TextInputType.phone,
              onSaved: (input) => _con.user.phone = input,
              validator: (input) =>
                  input.length != 13 || !input.startsWith("+92")
                      ? Constants.invalidNumber
                      : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: Constants.enterPhone,
                labelStyle: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.bold),
                hintText: Constants.phoneHint,
                hintStyle: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.bold),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    ));

    // adding age, gender, height, weight
    signUpSteps.add(Step(
      title: Text("Body Info"),
      isActive: _currentIndex == 1,
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15.0),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (input) => _con.user.age = int.parse(input),
              validator: (input) => input.length >= 3 || input.length < 1
                  ? Constants.invalid_age
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: Constants.enterAge,
                labelStyle: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.bold),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            DropdownButtonFormField(
              onSaved: (input) => _con.user.gender = input,
              validator: (input) => _gender.length == 0 ? "Select one" : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (gender) {
                // _con.user.gender = gender.toString();
                print(gender);
                _con.user.gender = gender.toString();
                _gender = gender.toString();
              },
              items: Constants.selectGender.map((String gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text("$gender"),
                );
              }).toList(),
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Theme.of(context).primaryColor,
              ),
              iconSize: 20.0,
              decoration: InputDecoration(
                labelText: "Gender",
                labelStyle:
                    TextStyle(color: Theme.of(context).secondaryHeaderColor),
                contentPadding: EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (input) => _con.user.height = double.parse(input),
              validator: (input) => !(input.length == 2)
                  ? Constants.enter_height_in_inches
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: "70",
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
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                            value: Constants.weightUnits[0],
                            groupValue: _weightUnitValueO.value,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              // _weightUnitValue = value;
                              _weightUnitValueO.value = value;
                            }),
                        Text("${Constants.kg}"),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                            value: Constants.weightUnits[1],
                            groupValue: _weightUnitValueO.value,
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              // _weightUnitValue = value;
                              _weightUnitValueO.value = value;
                            }),
                        Text("${Constants.pound}"),
                      ],
                    ),
                  )
                ],
              );
            }),
            SizedBox(height: 10.0),
            Obx(() {
              return TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (input) => _con.user.weight = double.parse(input),
                validator: (input) => input.length > 3 || input.length < 1
                    ? Constants.enter_weight_in_cm
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: _weightUnitValueO.value == Constants.weightUnits[0]
                      ? Constants.enterWeight
                      : Constants.enterWeightPound,
                  labelStyle: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontWeight: FontWeight.bold),
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).accentColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              );
            }),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    ));

    // adding specialized info
    signUpSteps.add(Step(
      title: Text("Specialized Info"),
      isActive: _currentIndex == 2,
      content: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButtonFormField(
              // onSaved: (input) => _con.user,
              // validator: (input) => input.length < 3
              //     ? S.of(context).should_be_more_than_3_letters
              //     : null,
              onChanged: (value) {
                print(value);
                int index = Constants.joinAsA.indexOf(value);
                print(index);
                if (index == 0) {
                  setState(() {
                    _con.user.role = value.toString();
                    _isTrainee = true;
                    _isTrainer = false;
                    _roleSelected = true;
                  });
                } else if (index == 1) {
                  setState(() {
                    _con.user.role = value.toString();
                    _isTrainer = true;
                    _isTrainee = false;
                    _roleSelected = true;
                  });
                } else {
                  // _con.user.role = value.toString();
                  setState(() {
                    _isTrainer = false;
                    _isTrainee = false;
                  });
                }
              },
              items: Constants.joinAsA.map((String priority) {
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
                // floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: "${Constants.joining_as_a}",
                labelStyle:
                    TextStyle(color: Theme.of(context).secondaryHeaderColor),
                contentPadding: EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            // adding Trainer fields
            !_isTrainer
                ? SizedBox(
                    height: 0.0,
                  )
                : TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    onSaved: (input) => _con.user.experience = input,
                    validator: (input) =>
                        input.length < 1 ? Constants.invalidInput : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: Constants.experience,
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
            SizedBox(
              height: 15.0,
            ),
            !_isTrainer
                ? SizedBox(
                    height: 0.0,
                  )
                : TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    onSaved: (input) => _con.user.specializesIn = input,
                    validator: (input) =>
                        input.length < 1 ? Constants.invalidInput : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: Constants.specializesIn,
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
            // adding Trainee fields
            !_isTrainee
                ? SizedBox(
                    height: 0.0,
                  )
                : TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onSaved: (input) => input.length > 0
                        ? _con.user.injury = input
                        : "${Constants.none}",
                    validator: (input) => input.length < 1
                        ? Constants.this_field_cannt_be_empty
                        : null,
                    decoration: InputDecoration(
                      labelText: Constants.injuryIfAny,
                      labelStyle: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold),
                      hintText: "${Constants.none}",
                      hintStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
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
            !_isTrainee
                ? SizedBox(
                    height: 0.0,
                  )
                : SizedBox(height: 15.0),
            !_isTrainee
                ? SizedBox(
                    height: 0.0,
                  )
                : TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onSaved: (input) => input.length > 0
                        ? _con.user.medicalBG = input
                        : "${Constants.none}",
                    validator: (input) => input.length < 1
                        ? Constants.this_field_cannt_be_empty
                        : null,
                    decoration: InputDecoration(
                      labelText: Constants.medicalBackground,
                      // floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelStyle: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold),
                      hintText: "${Constants.none}",
                      hintStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
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
            !_isTrainee
                ? SizedBox(
                    height: 0.0,
                  )
                : SizedBox(height: 15.0),
            !_isTrainee
                ? SizedBox(
                    height: 0.0,
                  )
                : TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onSaved: (input) => input.length > 0
                        ? _con.user.familyMedicalBG = input
                        : "${Constants.none}",
                    validator: (input) => input.length < 1
                        ? Constants.this_field_cannt_be_empty
                        : null,
                    decoration: InputDecoration(
                      labelText: Constants.familyMedicalBG,
                      labelStyle: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold),
                      hintText: "${Constants.none}",
                      hintStyle: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
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
          ],
        ),
      ),
    ));

    // adding password and confirm password
    signUpSteps.add(Step(
      title: Text("Privacy"),
      isActive: _currentIndex == 3,
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              onSaved: (input) => _con.user.password = input,
              validator: (input) {
                if (input.length < 7) {
                  return Constants.password_should_be_greater_than_seven;
                } else if (!input.contains(Helper.passwordRegExp())) {
                  return Constants.pass_should_contain_special_char;
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: Constants.enterPassword,
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
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              controller: _confirmPasswordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              validator: (input) {
                // print(_passwordController.text);
                if (input != _passwordController.text) {
                  return Constants.password_doesnt_match;
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: Constants.confirmPassord,
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
            SizedBox(
              height: 15.0,
            ),
            TextButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                if (!_signupFormKey.currentState.validate()) {
                  // get this snackbar from helper in future
                  // by sending message and title
                  Get.snackbar(
                    "Failed !",
                    "${Constants.invalidInput}",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Theme.of(context).primaryColor,
                    colorText: Theme.of(context).scaffoldBackgroundColor,
                  );
                  return;
                } else if (_signupFormKey.currentState.validate()) {
                  print("saving form state");
                  _signupFormKey.currentState.save();
                  // Todo:
                  // create registerUser function in user controller
                  // call that function
                  _con.registerUser(context);
                }
              },
              child: Text(
                Constants.signup,
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 50.0)),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
          ],
        ),
      ),
    ));

    return signUpSteps;
  }
}
