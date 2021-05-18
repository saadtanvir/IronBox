import 'package:fitness_app/src/controllers/user_controller.dart';
import 'package:fitness_app/src/widgets/blockButtonWidget.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:fitness_app/src/repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:fitness_app/src/helpers/helper.dart';
import 'package:get/get.dart';

class TrainerRegistrationForm extends StatefulWidget {
  @override
  _TrainerRegistrationFormState createState() =>
      _TrainerRegistrationFormState();
}

class _TrainerRegistrationFormState extends State<TrainerRegistrationForm> {
  UserController _con = Get.put(UserController());
  GlobalKey<FormState> _trainerRegFormKey;
  @override
  void initState() {
    _trainerRegFormKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: Helper.of(context).getScreenWidth(),
              height: Helper.of(context).getScreenHeight() * 0.40,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Center(
                child: Text(
                  "Become a Trainer",
                  style: Theme.of(context).textTheme.headline4.merge(TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor)),
                ),
              ),
            ),
          ),
          Positioned(
            top: (Helper.of(context).getScreenHeight() * 0.37) - 50,
            child: Container(
              width: Helper.of(context).getScreenWidth() * 0.88,
              constraints: BoxConstraints(
                maxHeight: Helper.of(context).getScreenHeight() * 0.60,
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding:
                  EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
              child: Form(
                key: _trainerRegFormKey,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (input) =>
                            userRepo.currentUser.value.experience = input,
                        validator: (input) =>
                            input.length > 0 ? null : "Required",
                        decoration: InputDecoration(
                          labelText: "Experience In Years",
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '0.8 year',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5)),
                          prefixIcon: Icon(Icons.timer,
                              color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                            userRepo.currentUser.value.specializesIn = input,
                        validator: (input) =>
                            input.length > 0 ? null : "Required",
                        decoration: InputDecoration(
                          labelText: "Specializes In",
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Weight loss',
                          hintStyle: TextStyle(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5)),
                          prefixIcon: Icon(Icons.fitness_center,
                              color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 30),
                      BlockButtonWidget(
                        text: Text(
                          "Register as a Trainer",
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          if (!_trainerRegFormKey.currentState.validate()) {
                            return;
                          } else if (_trainerRegFormKey.currentState
                              .validate()) {
                            _trainerRegFormKey.currentState.save();
                            userRepo.currentUser.value.role =
                                Constants.joinAsA[1];
                            _con.updateUser(
                                context, userRepo.currentUser.value);
                          }
                        },
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
