import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ironbox/src/controllers/dietPlan_controller.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/planRequest.dart';
import 'package:ironbox/src/widgets/dialogs/confirmationDialog.dart';
import '../helpers/app_constants.dart' as Constants;
import '../repositories/user_repo.dart' as userRepo;

class CreateCustomDietPlan extends StatefulWidget {
  final PlanRequest request;
  const CreateCustomDietPlan({Key key, @required this.request})
      : super(key: key);

  @override
  _CreateCustomDietPlanState createState() => _CreateCustomDietPlanState();
}

class _CreateCustomDietPlanState extends State<CreateCustomDietPlan> {
  GlobalKey<FormState> _createDietPlanFormKey;

  DietPlanController _con =
      Get.put(DietPlanController(), tag: Constants.dietPlanCreationController);
  // radio tile group values
  var difficultyRadioTileGroupValue = 0.obs;

  // image picker values
  final ImagePicker _picker = ImagePicker();
  File _imageFile;
  var imageName = "".obs;

  void _selectImage() async {
    // await ImagePicker.getImage(source: imageSource, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 60);
    if (pickedFile != null) {
      print(pickedFile.path);
      _imageFile = File(pickedFile.path);
      imageName.value = _imageFile.path.split('/').last;
    }
  }

  void cancelMakingPlan() {
    Get.back();
    _con.deleteDietPlan(_con.createdDietPlanId);
  }

  @override
  void initState() {
    _createDietPlanFormKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Custom Diet Plan"),
        leading: IconButton(
          onPressed: () {
            if (_con.isPlanCreated) {
              // delete the created plan
              // get back

              Get.dialog(ConfirmationDialog(
                  "Are you sure you want to cancel making plan?",
                  cancelMakingPlan));
            } else {
              Get.back();
            }
          },
          icon: Icon(
            Icons.cancel,
          ),
        ),
      ),
      body: Form(
        key: _createDietPlanFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dietPlanTitleTextWidget("Title"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _con.dietPlan.title = input,
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                      labelText: Constants.plan_name,
                      hintText: Constants.weight_gain),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _dietPlanTitleTextWidget("Description"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _con.dietPlan.description = input,
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                      labelText: Constants.description,
                      hintText: Constants.description),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _dietPlanTitleTextWidget("Caution"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _con.dietPlan.caution = input,
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                      labelText: Constants.caution,
                      hintText: "Not for sugar patient"),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _dietPlanTitleTextWidget("Goal"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  onSaved: (input) => _con.dietPlan.goal = input,
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                    labelText: "Plan Goal",
                    hintText: "Caloric maintenance",
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _dietPlanTitleTextWidget("Duration"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) =>
                      _con.dietPlan.durationInWeeks = int.parse(input),
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                    labelText: "Duration in weeks",
                    hintText: "4",
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _dietPlanTitleTextWidget("Difficulty Level"),
                const SizedBox(
                  height: 10.0,
                ),
                Obx(() {
                  return _dietPlanDifficultyObservableWidget(
                      tileValue: 1,
                      groupValue: difficultyRadioTileGroupValue.value,
                      title: "Easy");
                }),
                Obx(() {
                  return _dietPlanDifficultyObservableWidget(
                      tileValue: 2,
                      groupValue: difficultyRadioTileGroupValue.value,
                      title: "Intermediate");
                }),
                Obx(() {
                  return _dietPlanDifficultyObservableWidget(
                      tileValue: 3,
                      groupValue: difficultyRadioTileGroupValue.value,
                      title: "Hard");
                }),
                const SizedBox(
                  height: 30,
                ),
                _dietPlanTitleTextWidget("Proteins"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) =>
                      _con.dietPlan.protein = double.parse(input),
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                    labelText: "Total protein gain",
                    hintText: "125",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _dietPlanTitleTextWidget("Fats"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) => _con.dietPlan.fat = double.parse(input),
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                    labelText: "Total fat gain",
                    hintText: "55.5",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _dietPlanTitleTextWidget("Calories"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) =>
                      _con.dietPlan.calories = double.parse(input),
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                    labelText: "Total calories gain",
                    hintText: "1500",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                _dietPlanTitleTextWidget("Carbohydrates"),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (input) =>
                      _con.dietPlan.carbohydrates = double.parse(input),
                  validator: (input) => input.length < 1 ? "required" : null,
                  decoration: _dietPlanTextFieldInputDecoration(
                    labelText: "Total carbs gain",
                    hintText: "120",
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                _dietPlanTitleTextWidget("Cover Image"),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () async {
                          _selectImage();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 5.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[300],
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
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
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      flex: 3,
                      child: Obx(() {
                        return Text(
                          imageName.value,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 15.0,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (!_createDietPlanFormKey.currentState.validate() ||
                          difficultyRadioTileGroupValue.value == 0) {
                        Get.snackbar(
                          "Invalid Input",
                          "Kindly fill all the values",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      } else if (_createDietPlanFormKey.currentState
                          .validate()) {
                        _createDietPlanFormKey.currentState.save();
                        _con.dietPlan.traineeId = widget.request.traineeId;
                        _con.dietPlan.trainerId = widget.request.trainerId;
                        _con.dietPlan.requestId = widget.request.id;
                        _con.createDietPlan(context, _imageFile);
                      }
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                      overlayColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor.withOpacity(0.3),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _dietPlanTitleTextWidget(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  RadioListTile _dietPlanDifficultyObservableWidget(
      {@required int tileValue,
      @required int groupValue,
      @required String title}) {
    return RadioListTile(
      value: tileValue,
      groupValue: groupValue,
      title: Text("$title"),
      // subtitle: Text("Weeks"),
      activeColor: Theme.of(context).primaryColor,
      selected: groupValue == tileValue ? true : false,
      onChanged: (val) {
        FocusScope.of(context).requestFocus(new FocusNode());

        print(val);
        difficultyRadioTileGroupValue.value = val;
        _con.dietPlan.difficultyLevel = difficultyRadioTileGroupValue.value;
      },
    );
  }

  InputDecoration _dietPlanTextFieldInputDecoration(
      {@required String labelText, @required String hintText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).accentColor.withOpacity(0.5),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 12.0,
        color: Theme.of(context).accentColor.withOpacity(0.3),
      ),
      contentPadding: const EdgeInsets.all(10),
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
    );
  }
}
