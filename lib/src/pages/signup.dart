// import 'package:fitness_app/src/controllers/user_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../helpers/app_constants.dart' as Constants;

// File no longer in use
// Visit stepper_signup.dart instead

// class Signup extends StatefulWidget {
//   @override
//   _SignupState createState() => _SignupState();
// }

// class _SignupState extends State<Signup> {
//   UserController _con = Get.put(UserController());
//   GlobalKey<FormState> _signupFormKey;
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();
//   bool _isTrainer = false;
//   bool _isTrainee = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _signupFormKey = new GlobalKey<FormState>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign Up"),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
//         child: Form(
//           key: _signupFormKey,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 5.0,
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   onSaved: (input) => _con.user.name,
//                   validator: (input) => input.length < 3
//                       ? Constants.name_should_be_min_three_char
//                       : null,
//                   decoration: InputDecoration(
//                     labelText: Constants.enterName,
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         fontWeight: FontWeight.bold),
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(150.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   onSaved: (input) => _con.user.userName,
//                   validator: (input) => input.length < 4
//                       ? Constants.username_should_be_min_four_char
//                       : null,
//                   decoration: InputDecoration(
//                     labelText: Constants.enter_username,
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         fontWeight: FontWeight.bold),
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(150.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   onSaved: (input) => _con.user.email,
//                   validator: (input) =>
//                       !input.contains('@') ? Constants.invalidEmail : null,
//                   decoration: InputDecoration(
//                     labelText: Constants.enterEmail,
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         fontWeight: FontWeight.bold),
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(150.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 TextFormField(
//                   keyboardType: TextInputType.phone,
//                   onSaved: (input) => _con.user.phone,
//                   validator: (input) =>
//                       !input.startsWith("+92") ? Constants.invalidNumber : null,
//                   decoration: InputDecoration(
//                     labelText: Constants.enterPhone,
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         fontWeight: FontWeight.bold),
//                     hintText: Constants.phoneHint,
//                     hintStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         fontWeight: FontWeight.bold),
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   onSaved: (input) => _con.user.age,
//                   validator: (input) => input.length >= 3 || input.length < 1
//                       ? Constants.invalid_age
//                       : null,
//                   decoration: InputDecoration(
//                     labelText: Constants.enterAge,
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         fontWeight: FontWeight.bold),
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 DropdownButtonFormField(
//                   onSaved: (input) => _con.user.gender,
//                   onChanged: (gender) {
//                     // _con.user.gender = gender.toString();
//                   },
//                   items: Constants.selectGender.map((String gender) {
//                     return DropdownMenuItem(
//                       value: gender,
//                       child: Text("$gender"),
//                     );
//                   }).toList(),
//                   icon: Icon(
//                     Icons.arrow_drop_down_circle_outlined,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   iconSize: 20.0,
//                   decoration: InputDecoration(
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     labelText: "Gender",
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor),
//                     contentPadding: EdgeInsets.all(12),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   onSaved: (input) => _con.user.height,
//                   validator: (input) => !input.contains('.')
//                       ? Constants.enter_height_in_inches
//                       : null,
//                   decoration: InputDecoration(
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     hintText: "150.00",
//                     hintStyle: TextStyle(
//                       color: Theme.of(context).secondaryHeaderColor,
//                     ),
//                     labelText: Constants.enterHeight,
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         fontWeight: FontWeight.bold),
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 TextFormField(
//                   keyboardType: TextInputType.number,
//                   onSaved: (input) => _con.user.weight,
//                   validator: (input) => input.length > 2 || input.length < 1
//                       ? Constants.enter_weight_in_cm
//                       : null,
//                   decoration: InputDecoration(
//                     labelText: Constants.enterWeight,
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor,
//                         fontWeight: FontWeight.bold),
//                     contentPadding: EdgeInsets.all(10),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15.0),
//                 DropdownButtonFormField(
//                   // onSaved: (input) => _con.user,
//                   // validator: (input) => input.length < 3
//                   //     ? S.of(context).should_be_more_than_3_letters
//                   //     : null,
//                   onChanged: (value) {
//                     print(value);
//                     int index = Constants.joinAsA.indexOf(value);
//                     print(index);
//                     if (index == 0) {
//                       setState(() {
//                         // _con.user.isTrainee = true;
//                         // _con.user.isTrainer = false;
//                         _con.user.role = value.toString();
//                         _isTrainee = true;
//                         _isTrainer = false;
//                       });
//                     } else if (index == 1) {
//                       setState(() {
//                         // _con.user.isTrainee = false;
//                         // _con.user.isTrainer = true;
//                         _con.user.role = value.toString();
//                         _isTrainer = true;
//                         _isTrainee = false;
//                       });
//                     } else {
//                       setState(() {
//                         // _con.user.isTrainee = false;
//                         // _con.user.isTrainer = false;
//                         _con.user.role = value.toString();
//                         _isTrainer = false;
//                         _isTrainee = false;
//                       });
//                     }
//                   },
//                   items: Constants.joinAsA.map((String priority) {
//                     return DropdownMenuItem(
//                       value: priority,
//                       child: Text("$priority"),
//                     );
//                   }).toList(),
//                   icon: Icon(
//                     Icons.arrow_drop_down_circle_outlined,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                   iconSize: 20.0,
//                   decoration: InputDecoration(
//                     // floatingLabelBehavior: FloatingLabelBehavior.never,
//                     labelText: "Joining as a",
//                     labelStyle: TextStyle(
//                         color: Theme.of(context).secondaryHeaderColor),
//                     contentPadding: EdgeInsets.all(12),
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 2.0,
//                           color:
//                               Theme.of(context).accentColor.withOpacity(0.2)),
//                       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 // adding Trainer fields
//                 !_isTrainer
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : TextFormField(
//                         keyboardType: TextInputType.text,
//                         maxLines: null,
//                         onSaved: (input) => _con.user.experience,
//                         validator: (input) =>
//                             input.length < 1 ? Constants.invalidInput : null,
//                         decoration: InputDecoration(
//                           labelText: Constants.experience,
//                           // floatingLabelBehavior: FloatingLabelBehavior.never,
//                           labelStyle: TextStyle(
//                               color: Theme.of(context).secondaryHeaderColor,
//                               fontWeight: FontWeight.bold),
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: Theme.of(context)
//                                     .accentColor
//                                     .withOpacity(0.2)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                           ),
//                         ),
//                       ),
//                 SizedBox(
//                   height: 15.0,
//                 ),
//                 !_isTrainer
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : TextFormField(
//                         keyboardType: TextInputType.text,
//                         maxLines: null,
//                         onSaved: (input) => _con.user.specializesIn,
//                         validator: (input) =>
//                             input.length < 1 ? Constants.invalidInput : null,
//                         decoration: InputDecoration(
//                           labelText: Constants.specializesIn,
//                           labelStyle: TextStyle(
//                               color: Theme.of(context).secondaryHeaderColor,
//                               fontWeight: FontWeight.bold),
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: Theme.of(context)
//                                     .accentColor
//                                     .withOpacity(0.2)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                           ),
//                         ),
//                       ),
//                 // adding Trainee fields
//                 !_isTrainee
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : TextFormField(
//                         keyboardType: TextInputType.multiline,
//                         maxLines: null,
//                         onSaved: (input) => _con.user.injury,
//                         // validator: (input) =>
//                         //     input.length < 4 ? Constants.incorrectPassword : null,
//                         decoration: InputDecoration(
//                           labelText: Constants.injuryIfAny,
//                           // floatingLabelBehavior: FloatingLabelBehavior.never,
//                           labelStyle: TextStyle(
//                               color: Theme.of(context).secondaryHeaderColor,
//                               fontWeight: FontWeight.bold),
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: Theme.of(context)
//                                     .accentColor
//                                     .withOpacity(0.2)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                           ),
//                         ),
//                       ),
//                 !_isTrainee
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : SizedBox(height: 15.0),
//                 !_isTrainee
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : TextFormField(
//                         keyboardType: TextInputType.multiline,
//                         maxLines: null,
//                         onSaved: (input) => _con.user.medicalBG,
//                         // validator: (input) =>
//                         //     input.length < 4 ? Constants.incorrectPassword : null,
//                         decoration: InputDecoration(
//                           labelText: Constants.medicalBackground,
//                           // floatingLabelBehavior: FloatingLabelBehavior.never,
//                           labelStyle: TextStyle(
//                               color: Theme.of(context).secondaryHeaderColor,
//                               fontWeight: FontWeight.bold),
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: Theme.of(context)
//                                     .accentColor
//                                     .withOpacity(0.2)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                           ),
//                         ),
//                       ),
//                 !_isTrainee
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : SizedBox(height: 15.0),
//                 !_isTrainee
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : TextFormField(
//                         keyboardType: TextInputType.multiline,
//                         maxLines: null,
//                         onSaved: (input) => _con.user.familyMedicalBG,
//                         // validator: (input) =>
//                         //     input.length < 4 ? Constants.incorrectPassword : null,
//                         decoration: InputDecoration(
//                           labelText: Constants.familyMedicalBG,
//                           // floatingLabelBehavior: FloatingLabelBehavior.never,
//                           labelStyle: TextStyle(
//                               color: Theme.of(context).secondaryHeaderColor,
//                               fontWeight: FontWeight.bold),
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: Theme.of(context)
//                                     .accentColor
//                                     .withOpacity(0.2)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20.0)),
//                           ),
//                         ),
//                       ),
//                 !_isTrainee && !_isTrainer
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : SizedBox(height: 15.0),
//                 !_isTrainee && !_isTrainer
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : TextFormField(
//                         controller: _passwordController,
//                         keyboardType: TextInputType.text,
//                         obscureText: true,
//                         onSaved: (input) => _con.user.password,
//                         validator: (input) {
//                           if (input.length < 4) {
//                             return Constants
//                                 .password_should_be_greater_than_three;
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           labelText: Constants.enterPassword,
//                           // floatingLabelBehavior: FloatingLabelBehavior.never,
//                           labelStyle: TextStyle(
//                               color: Theme.of(context).secondaryHeaderColor,
//                               fontWeight: FontWeight.bold),
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: Theme.of(context)
//                                     .accentColor
//                                     .withOpacity(0.2)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(150.0)),
//                           ),
//                         ),
//                       ),
//                 !_isTrainee && !_isTrainer
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : SizedBox(height: 15.0),
//                 !_isTrainee && !_isTrainer
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : TextFormField(
//                         controller: _confirmPasswordController,
//                         keyboardType: TextInputType.text,
//                         obscureText: true,
//                         validator: (input) {
//                           if (input != _passwordController.value.toString()) {
//                             return Constants.password_doesnt_match;
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           labelText: Constants.confirmPassord,
//                           // floatingLabelBehavior: FloatingLabelBehavior.never,
//                           labelStyle: TextStyle(
//                               color: Theme.of(context).secondaryHeaderColor,
//                               fontWeight: FontWeight.bold),
//                           contentPadding: EdgeInsets.all(10),
//                           border: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: 2.0,
//                                 color: Theme.of(context)
//                                     .accentColor
//                                     .withOpacity(0.2)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(150.0)),
//                           ),
//                         ),
//                       ),
//                 !_isTrainee && !_isTrainer
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : SizedBox(height: 15.0),
//                 !_isTrainee && !_isTrainer
//                     ? SizedBox(
//                         height: 0.0,
//                       )
//                     : TextButton(
//                         onPressed: () async {
//                           if (!_signupFormKey.currentState.validate()) {
//                             return;
//                           } else if (_signupFormKey.currentState.validate()) {
//                             _signupFormKey.currentState.save();
//                             // Todo:
//                             // create registerUser function in user controller
//                             // call that function
//                           }
//                         },
//                         child: Text(
//                           Constants.signup,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         style: ButtonStyle(
//                           padding: MaterialStateProperty.all<EdgeInsets>(
//                               EdgeInsets.symmetric(horizontal: 50.0)),
//                           backgroundColor: MaterialStateProperty.all(
//                               Theme.of(context).primaryColor),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(150.0)),
//                             ),
//                           ),
//                         ),
//                       ),
//                 TextButton(
//                   onPressed: () async {
//                     Get.back();
//                   },
//                   child: Text(
//                     Constants.alreadyHaveAnAcc,
//                     style: TextStyle(color: Theme.of(context).primaryColor),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
