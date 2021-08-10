import 'dart:io';
import 'package:ironbox/src/controllers/user_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../helpers/app_constants.dart' as Constants;

class StepperSignup extends StatefulWidget {
  @override
  _StepperSignupState createState() => _StepperSignupState();
}

class _StepperSignupState extends State<StepperSignup> {
  UserController _con = Get.put(UserController());
  GlobalKey<FormState> _signupFormKey;

  // controllers
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isTrainer = false;
  bool _isTrainee = false;
  bool _roleSelected = false;
  String _gender = "";
  int _currentIndex = 0;
  int groupValue = 0;
  var specialisedCategoryGroupValue = 0.obs;
  var _weightUnitValue = Constants.weightUnits[0].obs;

  // image file variables
  File _imageFile;
  var imageName = "".obs;
  final ImagePicker _picker = ImagePicker();

  void _selectImage() async {
    // await ImagePicker.getImage(source: imageSource, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 60);
    if (pickedFile != null) {
      print(pickedFile.path);
      _imageFile = File(pickedFile.path);
      _con.user.avatarImageFile = _imageFile;
      imageName.value = _imageFile.path.split('/').last;
    }
  }

  @override
  void initState() {
    super.initState();
    _signupFormKey = new GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
                            const EdgeInsets.symmetric(horizontal: 20.0),
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
                const SizedBox(
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

    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    // adding name, username, email, phone
    signUpSteps.add(Step(
      title: const Text("Basic Info"),
      isActive: _currentIndex == 0,
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
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
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(150.0)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
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
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(150.0)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
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
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(150.0)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
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
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Obx(() {
                    return imageName.isEmpty
                        ? Container(
                            height: 74,
                            width: 74,
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: const AssetImage(
                                    "assets/img/profile_placeholder.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : Container(
                            height: 74,
                            width: 84,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(_imageFile),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                  }),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () async {
                      _selectImage();
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 5.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Colors.grey[300],
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                      ),
                    ),
                    child: Text(
                      Constants.choose_file,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    ));

    ////////////////////////////////////////////////////////////////////////////////////////////////////////
    // adding age, gender, height, weight
    signUpSteps.add(Step(
      title: const Text("Personal Info"),
      isActive: _currentIndex == 1,
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15.0),
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
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
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
                  child: Text(
                    "$gender",
                  ),
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
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
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
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            // Obx(() {
            //   return Row(
            //     children: [
            //       Expanded(
            //         flex: 1,
            //         child: Row(
            //           children: [
            //             Radio(
            //                 value: Constants.weightUnits[0],
            //                 groupValue: _weightUnitValueO.value,
            //                 activeColor: Theme.of(context).primaryColor,
            //                 onChanged: (value) {
            //                   // _weightUnitValue = value;
            //                   _weightUnitValueO.value = value;
            //                 }),
            //             const Text("${Constants.kg}"),
            //           ],
            //         ),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: Row(
            //           children: [
            //             Radio(
            //                 value: Constants.weightUnits[1],
            //                 groupValue: _weightUnitValueO.value,
            //                 activeColor: Theme.of(context).primaryColor,
            //                 onChanged: (value) {
            //                   // _weightUnitValue = value;
            //                   _weightUnitValueO.value = value;
            //                 }),
            //             const Text("${Constants.pound}"),
            //           ],
            //         ),
            //       )
            //     ],
            //   );
            // }),
            const SizedBox(height: 10.0),
            // Obx(() {
            //   return TextFormField(
            //     keyboardType: TextInputType.number,
            //     onSaved: (input) => _con.user.weight = double.parse(input),
            //     validator: (input) => input.length > 3 || input.length < 1
            //         ? Constants.enter_weight_in_cm
            //         : null,
            //     autovalidateMode: AutovalidateMode.onUserInteraction,
            //     decoration: InputDecoration(
            //       labelText: _weightUnitValueO.value == Constants.weightUnits[0]
            //           ? Constants.enterWeight
            //           : Constants.enterWeightPound,
            //       labelStyle: TextStyle(
            //           color: Theme.of(context).secondaryHeaderColor,
            //           fontWeight: FontWeight.bold),
            //       contentPadding: const EdgeInsets.all(10),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(
            //             width: 2.0,
            //             color: Theme.of(context).accentColor.withOpacity(0.2)),
            //         borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //       ),
            //     ),
            //   );
            // }),
            TextFormField(
              keyboardType: TextInputType.number,
              onSaved: (input) => _con.user.weight = double.parse(input),
              validator: (input) => input.length > 3 || input.length < 1
                  ? Constants.enter_weight_in_kg
                  : null,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: Constants.enterWeight,
                labelStyle: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontWeight: FontWeight.bold),
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    ));

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // adding specialized info
    signUpSteps.add(Step(
      title: const Text("Specialized Info"),
      isActive: _currentIndex == 2,
      content: SingleChildScrollView(
        child: Column(
          children: [
            // DropdownButtonFormField(
            //   // onSaved: (input) => _con.user,
            //   validator: (input) => _roleSelected ? null : "Select one",
            //   onChanged: (value) {
            //     print(value);
            //     int index = Constants.joinAsA.indexOf(value);
            //     print(index);
            //     if (index == 0) {
            //       setState(() {
            //         _con.user.role = value.toString();

            //         _isTrainee = true;
            //         _isTrainer = false;
            //         _roleSelected = true;
            //         _con.user.isTrainee = "1";
            //         _con.user.isTrainer = "0";
            //         _con.user.accountStatus = _isTrainee && !_isTrainer ? 1 : 0;
            //       });
            //     } else if (index == 1) {
            //       setState(() {
            //         _con.user.role = value.toString();
            //         _isTrainer = true;
            //         _isTrainee = false;
            //         _roleSelected = true;
            //         _con.user.isTrainee = "0";
            //         _con.user.isTrainer = "1";
            //         _con.user.accountStatus = !_isTrainee && _isTrainer ? 0 : 1;
            //       });
            //     } else {
            //       // _con.user.role = value.toString();
            //       setState(() {
            //         _isTrainer = false;
            //         _isTrainee = false;
            //         _roleSelected = false;
            //       });
            //     }
            //   },
            //   items: Constants.joinAsA.map((String priority) {
            //     return DropdownMenuItem(
            //       value: priority,
            //       child: Text("$priority"),
            //     );
            //   }).toList(),
            //   icon: Icon(
            //     Icons.arrow_drop_down_circle_outlined,
            //     color: Theme.of(context).primaryColor,
            //   ),
            //   iconSize: 20.0,
            //   decoration: InputDecoration(
            //     // floatingLabelBehavior: FloatingLabelBehavior.never,
            //     labelText: "${Constants.joining_as_a}",
            //     labelStyle:
            //         TextStyle(color: Theme.of(context).secondaryHeaderColor),
            //     contentPadding: EdgeInsets.all(12),
            //     border: OutlineInputBorder(
            //       borderSide: BorderSide(
            //           width: 2.0,
            //           color: Theme.of(context).accentColor.withOpacity(0.2)),
            //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //     ),
            //   ),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // flex: 1,
                  child: RadioListTile(
                    value: 1,
                    groupValue: groupValue,
                    title: Text(
                      Constants.joinAsA[0],
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    subtitle: const Text(
                      "Joining as a:",
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    activeColor: Theme.of(context).primaryColor,
                    selected: groupValue == 1 ? true : false,
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        groupValue = val;
                        _con.user.role = Constants.joinAsA[0];
                        _isTrainee = true;
                        _isTrainer = false;
                        _roleSelected = true;
                        _con.user.isTrainee = "1";
                        _con.user.isTrainer = "0";
                        _con.user.accountStatus =
                            _isTrainee && !_isTrainer ? 1 : 0;
                      });
                    },
                  ),
                ),
                Expanded(
                  // flex: 1,
                  child: RadioListTile(
                    value: 2,
                    groupValue: groupValue,
                    title: Text(
                      Constants.joinAsA[1],
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    subtitle: const Text(
                      "Joining as a:",
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    activeColor: Theme.of(context).primaryColor,
                    selected: groupValue == 2 ? true : false,
                    onChanged: (val) {
                      print(val);
                      setState(() {
                        groupValue = val;
                        _con.user.role = Constants.joinAsA[1];
                        _isTrainer = true;
                        _isTrainee = false;
                        _roleSelected = true;
                        _con.user.isTrainee = "0";
                        _con.user.isTrainer = "1";
                        _con.user.accountStatus =
                            !_isTrainee && _isTrainer ? 0 : 1;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15.0,
            ),
            // adding Trainer fields
            !_isTrainer
                ? const SizedBox(
                    height: 0.0,
                  )
                : TextFormField(
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    onSaved: (input) => _con.user.experience = input,
                    validator: (input) =>
                        input.length < 1 ? Constants.invalidInput : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: Constants.experience_in_years,
                      labelStyle: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),

            _isTrainer
                ? const SizedBox(
                    height: 15.0,
                  )
                : const SizedBox(height: 0.0),
            !_isTrainer
                ? const SizedBox(
                    height: 0.0,
                  )
                : Container(
                    height: 150.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          // flex: 1,
                          child: Obx(() {
                            return RadioListTile(
                              value: 1,
                              groupValue: specialisedCategoryGroupValue.value,
                              title: Text(
                                "Workout",
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              subtitle: const Text(
                                "Training Expertise in:",
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              selected: specialisedCategoryGroupValue.value == 1
                                  ? true
                                  : false,
                              onChanged: (val) {
                                print(val);
                                specialisedCategoryGroupValue.value = val;
                                _con.user.specializationCategory = 1;
                              },
                            );
                          }),
                        ),
                        Expanded(
                          // flex: 1,
                          child: Obx(() {
                            return RadioListTile(
                              value: 2,
                              groupValue: specialisedCategoryGroupValue.value,
                              title: Text(
                                "Diet",
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              subtitle: const Text(
                                "Training Expertise in:",
                                style: TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                              activeColor: Theme.of(context).primaryColor,
                              selected: specialisedCategoryGroupValue.value == 2
                                  ? true
                                  : false,
                              onChanged: (val) {
                                print(val);
                                specialisedCategoryGroupValue.value = val;
                                _con.user.specializationCategory = 2;
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
            _isTrainer
                ? const SizedBox(
                    height: 15.0,
                  )
                : const SizedBox(height: 0.0),
            !_isTrainer
                ? const SizedBox(
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
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
            _isTrainer
                ? const SizedBox(
                    height: 15.0,
                  )
                : const SizedBox(height: 0.0),
            !_isTrainer
                ? const SizedBox(
                    height: 0.0,
                  )
                : TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    maxLength: 350,
                    onSaved: (input) => _con.user.description = input,
                    validator: (input) =>
                        input.length < 1 ? Constants.invalidInput : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: Constants.tell_us_about_yourself,
                      labelStyle: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
            _isTrainer
                ? const SizedBox(
                    height: 15.0,
                  )
                : const SizedBox(height: 0.0),
            !_isTrainer
                ? const SizedBox(
                    height: 0.0,
                  )
                : TextFormField(
                    keyboardType: TextInputType.text,
                    maxLines: null,
                    onSaved: (input) => _con.user.videoUrl = input,
                    validator: (input) =>
                        input.contains(Helper.youtubeUrlRegExp()) || input == ""
                            ? null
                            : "Not a valid youtube URL",
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: Constants.introductory_video,
                      labelStyle: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold),
                      hintText: Constants.youtube_video_link,
                      hintStyle: TextStyle(color: Colors.grey[300]),
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
            _isTrainer
                ? const SizedBox(
                    height: 15.0,
                  )
                : const SizedBox(height: 0.0),
            !_isTrainer
                ? const SizedBox(
                    height: 0.0,
                  )
                : Row(
                    children: [
                      Text(
                        "\$",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      SizedBox(
                        width: 200.0,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onSaved: (input) => _con.user.price = input,
                          validator: (input) =>
                              input.isEmpty ? "required" : null,
                          decoration: InputDecoration(
                            labelText: Constants.price,
                            labelStyle: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            // adding Trainee fields
            !_isTrainee
                ? const SizedBox(
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
                      contentPadding: const EdgeInsets.all(10),
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
                ? const SizedBox(
                    height: 0.0,
                  )
                : const SizedBox(height: 15.0),
            !_isTrainee
                ? const SizedBox(
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
                      contentPadding: const EdgeInsets.all(10),
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
                ? const SizedBox(
                    height: 0.0,
                  )
                : const SizedBox(height: 15.0),
            !_isTrainee
                ? const SizedBox(
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
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    ));

    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    // adding password and confirm password
    signUpSteps.add(Step(
      title: const Text("Privacy"),
      isActive: _currentIndex == 3,
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
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
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(150.0)),
                ),
              ),
            ),
            const SizedBox(
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
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: Theme.of(context).accentColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.all(Radius.circular(150.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            TextButton(
              onPressed: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                if (!_signupFormKey.currentState.validate() ||
                    _con.user.specializationCategory == null) {
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
                  // _con.registerUser(context);
                  _con.registerUserWithImage(context);
                }
              },
              child: const Text(
                Constants.signup,
                style: const TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 50.0)),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(150.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    ));

    return signUpSteps;
  }
}
