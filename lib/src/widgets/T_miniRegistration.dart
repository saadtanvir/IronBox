import '../controllers/user_controller.dart';
import '../pages/showVideoLib.dart';
import '../widgets/blockButtonWidget.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:ironbox/src/repositories/user_repo.dart' as userRepo;
import 'package:flutter/material.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:get/get.dart';

class TrainerRegistrationForm extends StatefulWidget {
  @override
  _TrainerRegistrationFormState createState() =>
      _TrainerRegistrationFormState();
}

class _TrainerRegistrationFormState extends State<TrainerRegistrationForm> {
  UserController _con = Get.put(UserController());
  GlobalKey<FormState> _trainerRegFormKey;
  var _videoUrlTextFieldController = new TextEditingController().obs;
  @override
  void initState() {
    _trainerRegFormKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _con.scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.cancel,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              width: Helper.of(context).getScreenWidth(),
              height: Helper.of(context).getScreenHeight() * 0.30,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                child: Text(
                  "Become a Trainer",
                  style: Theme.of(context).textTheme.headline5.merge(TextStyle(
                      color: Theme.of(context).scaffoldBackgroundColor)),
                ),
              ),
            ),
          ),
          Positioned(
            top: (Helper.of(context).getScreenHeight() * 0.20),
            child: Container(
              width: Helper.of(context).getScreenWidth() * 0.88,
              constraints: BoxConstraints(
                maxHeight: Helper.of(context).getScreenHeight() * 0.40,
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]),
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding: const EdgeInsets.only(
                  top: 50, right: 27, left: 27, bottom: 20),
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
                          contentPadding: const EdgeInsets.all(12),
                          hintText: '0.8 year',
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5)),
                          // prefixIcon: Icon(Icons.timer,
                          //     color: Theme.of(context).primaryColor),
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
                      const SizedBox(height: 30),
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
                          hintText: 'weight loss',
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5)),
                          // prefixIcon: Icon(Icons.fitness_center,
                          //     color: Theme.of(context).primaryColor),
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
                      const SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) =>
                            userRepo.currentUser.value.description = input,
                        validator: (input) =>
                            input.length > 0 ? null : "Required",
                        decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle:
                              TextStyle(color: Theme.of(context).accentColor),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Tell us about yourself',
                          hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5)),
                          // prefixIcon: Icon(Icons.fitness_center,
                          //     color: Theme.of(context).primaryColor),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.5)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.2)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Obx(() {
                        return TextFormField(
                          controller: _videoUrlTextFieldController.value,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          onSaved: (input) =>
                              userRepo.currentUser.value.videoUrl = input,
                          // validator: (input) {
                          //   print(input);
                          //   return !input.contains(Helper.youtubeUrlRegExp())
                          //       ? "Not a valid youtube URL"
                          //       : null;
                          // },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelText: Constants.supporting_video_url,
                            labelStyle: TextStyle(
                              fontSize: 12.0,
                              // fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.5),
                            ),
                            hintText: Constants.youtube_your_video,
                            hintStyle: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.3),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                // open bottom sheet
                                // show list of all videos from video lib
                                // on tap send video object back to screen
                                var data = await Get.to(
                                  VideoLib(),
                                  fullscreenDialog: true,
                                  transition: Transition.downToUp,
                                );
                                print(data.link);
                                _videoUrlTextFieldController.value.text =
                                    data.link;
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.2)),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
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
                              onSaved: (input) =>
                                  userRepo.currentUser.value.price = input,
                              validator: (input) =>
                                  input.isEmpty ? "required" : null,
                              decoration: InputDecoration(
                                labelText: Constants.price,
                                labelStyle: TextStyle(
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                    fontWeight: FontWeight.bold),
                                contentPadding: const EdgeInsets.all(10),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.5)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .focusColor
                                          .withOpacity(0.2)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      BlockButtonWidget(
                        text: Text(
                          "Register as a Trainer",
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        color: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          if (!_trainerRegFormKey.currentState.validate()) {
                            return;
                          } else if (_trainerRegFormKey.currentState
                              .validate()) {
                            _trainerRegFormKey.currentState.save();
                            userRepo.currentUser.value.role =
                                Constants.joinAsA[1];
                            userRepo.currentUser.value.accountStatus = 0;
                            _con.updateCurrentUser(
                                context, userRepo.currentUser.value);
                          }
                        },
                      ),
                      const SizedBox(height: 15),
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
