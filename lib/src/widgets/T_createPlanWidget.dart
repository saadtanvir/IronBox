import 'dart:io';
import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:ironbox/src/pages/showVideoLib.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:ironbox/src/repositories/user_repo.dart' as userRepo;
import 'package:image_picker/image_picker.dart';

class TrainerCreatePlanWidget extends StatefulWidget {
  final String mainCategoryId;
  TrainerCreatePlanWidget({this.mainCategoryId});
  @override
  _TrainerCreatePlanWidgetState createState() =>
      _TrainerCreatePlanWidgetState();
}

class _TrainerCreatePlanWidgetState extends State<TrainerCreatePlanWidget> {
  GlobalKey<FormState> _createPlanFormKey;
  PlansController _con = Get.put(PlansController());
  var _videoUrlTextFieldController =
      new TextEditingController(text: "Select Video").obs;

  // string values
  var selectedVideoUrl = "Select Video".obs;

  // category lists
  List<Category> subCategories;
  var childCategories = [].obs;

  // different ids
  String planId = "";
  var selectedSubCategoryId = "0".obs;
  var selectedChildCategoryId = "0".obs;

  // radio tile group values
  var subCategoryRadioTileGroupValue = 0.obs;
  var childCategoryRadioTileGroupValue = 0.obs;
  var durationRadioTileGroupValue = 0.obs;
  var difficultyRadioTileGroupValue = 0.obs;

  // image picker values
  final ImagePicker _picker = ImagePicker();
  File _imageFile;
  var imageName = "".obs;

  ////////////////////////////////////

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

  @override
  void initState() {
    subCategories = Helper.getSpecificSubCategories(widget.mainCategoryId);
    _createPlanFormKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Plan"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                key: _createPlanFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.name + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con.workoutPlan.title = input,
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      decoration: InputDecoration(
                        labelText: Constants.plan_name,
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                        hintText: Constants.weight_gain,
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.muscle_type + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con.workoutPlan.muscleType = input,
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      decoration: InputDecoration(
                        labelText: Constants.muscle_type,
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                        hintText: Constants.eg_abs_legs,
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.brief_descp + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 150.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        maxLength: 300,
                        onSaved: (input) =>
                            _con.workoutPlan.description = input,
                        validator: (input) =>
                            input.length < 1 ? "required" : null,
                        decoration: InputDecoration(
                          labelText: Constants.description,
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.5),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     Constants.detail + ":",
                    //     style: TextStyle(
                    //       color: Theme.of(context).accentColor,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Container(
                    //   constraints: BoxConstraints(maxHeight: 100.0),
                    //   child: TextFormField(
                    //     keyboardType: TextInputType.multiline,
                    //     textInputAction: TextInputAction.newline,
                    //     maxLines: null,
                    //     onSaved: (input) => _con.plan.detail = input,
                    //     validator: (input) =>
                    //         input.length < 1 ? "required" : null,
                    //     decoration: InputDecoration(
                    //       labelText: Constants.plan_details,
                    //       labelStyle: TextStyle(
                    //         fontSize: 12.0,
                    //         fontWeight: FontWeight.bold,
                    //         color:
                    //             Theme.of(context).accentColor.withOpacity(0.5),
                    //       ),
                    //       contentPadding: EdgeInsets.all(10),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           width: 0.0,
                    //         ),
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(15.0)),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 40.0,
                    // ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.select_sub_category + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: subCategories.length,
                      itemBuilder: (context, index) {
                        // print("sub category index is: $index");
                        int radioTileValue = index + 1;
                        // print("radio tile value is: $radioTileValue");
                        return Obx(() {
                          return RadioListTile(
                            value: radioTileValue,
                            groupValue: subCategoryRadioTileGroupValue.value,
                            title: Text("${subCategories[index].name}"),
                            activeColor: Theme.of(context).primaryColor,
                            selected: subCategoryRadioTileGroupValue.value ==
                                    radioTileValue
                                ? true
                                : false,
                            onChanged: (val) {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              print("changed value is: $val");
                              subCategoryRadioTileGroupValue.value = val;
                              // change selected sub category id
                              // get list of child categories
                              selectedSubCategoryId.value =
                                  subCategories[index].id;

                              childCategories.assignAll(
                                  Helper.getSpecificChildCategories(
                                      selectedSubCategoryId.value));
                              childCategoryRadioTileGroupValue.value = 0;
                            },
                          );
                        });
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Obx(() {
                      return childCategories.isNotEmpty
                          ? Container(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      Constants.select_child_category + ":",
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    // scrollDirection: Axis.horizontal,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: childCategories.length,
                                    itemBuilder: (context, index) {
                                      // print("sub category index is: $index");
                                      int radioTileValue = index + 1;
                                      // print(
                                      // "radio tile value is: $radioTileValue");
                                      return Obx(() {
                                        return RadioListTile(
                                          value: radioTileValue,
                                          groupValue:
                                              childCategoryRadioTileGroupValue
                                                  .value,
                                          title: Text(
                                              "${childCategories[index].name}"),
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          selected:
                                              childCategoryRadioTileGroupValue
                                                          .value ==
                                                      radioTileValue
                                                  ? true
                                                  : false,
                                          onChanged: (val) {
                                            FocusScope.of(context)
                                                .requestFocus(new FocusNode());

                                            // print("changed value is: $val");
                                            childCategoryRadioTileGroupValue
                                                .value = val;
                                            _con.workoutPlan.categoryId =
                                                childCategories[index]
                                                    .id
                                                    .toString();
                                          },
                                        );
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 40.0,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              height: 0.0,
                            );
                    }),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.duration + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Obx(() {
                            return RadioListTile(
                              value: 1,
                              groupValue: durationRadioTileGroupValue.value,
                              title: Text("4"),
                              subtitle: Text("Weeks"),
                              activeColor: Theme.of(context).primaryColor,
                              selected: durationRadioTileGroupValue.value == 1
                                  ? true
                                  : false,
                              onChanged: (val) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());

                                print(val);
                                durationRadioTileGroupValue.value = val;
                                _con.workoutPlan.durationInWeeks = 4;
                              },
                            );
                          }),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Obx(() {
                            return RadioListTile(
                              value: 2,
                              groupValue: durationRadioTileGroupValue.value,
                              title: Text("6"),
                              subtitle: Text("Weeks"),
                              activeColor: Theme.of(context).primaryColor,
                              selected: durationRadioTileGroupValue.value == 2
                                  ? true
                                  : false,
                              onChanged: (val) {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());

                                print(val);
                                durationRadioTileGroupValue.value = val;
                                _con.workoutPlan.durationInWeeks = 6;
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.difficultly_level + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Obx(() {
                      return RadioListTile(
                        value: 1,
                        groupValue: difficultyRadioTileGroupValue.value,
                        title: Text("Easy"),
                        // subtitle: Text("Weeks"),
                        activeColor: Theme.of(context).primaryColor,
                        selected: difficultyRadioTileGroupValue.value == 1
                            ? true
                            : false,
                        onChanged: (val) {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          print(val);
                          difficultyRadioTileGroupValue.value = val;
                          _con.workoutPlan.difficultyLevel = 1;
                        },
                      );
                    }),
                    Obx(() {
                      return RadioListTile(
                        value: 2,
                        groupValue: difficultyRadioTileGroupValue.value,
                        title: Text("Intermediate"),
                        // subtitle: Text("Weeks"),
                        activeColor: Theme.of(context).primaryColor,
                        selected: difficultyRadioTileGroupValue.value == 2
                            ? true
                            : false,
                        onChanged: (val) {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          print(val);
                          difficultyRadioTileGroupValue.value = val;
                          _con.workoutPlan.difficultyLevel = 2;
                        },
                      );
                    }),
                    Obx(() {
                      return RadioListTile(
                        value: 3,
                        groupValue: difficultyRadioTileGroupValue.value,
                        title: Text("Hard"),
                        // subtitle: Text("Weeks"),
                        activeColor: Theme.of(context).primaryColor,
                        selected: difficultyRadioTileGroupValue.value == 3
                            ? true
                            : false,
                        onChanged: (val) {
                          FocusScope.of(context).requestFocus(new FocusNode());

                          print(val);
                          difficultyRadioTileGroupValue.value = val;
                          _con.workoutPlan.difficultyLevel = 3;
                        },
                      );
                    }),
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.price + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
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
                        SizedBox(
                          width: 5.0,
                        ),
                        SizedBox(
                          width: 200.0,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (input) =>
                                _con.workoutPlan.price = double.parse(input),
                            validator: (input) =>
                                input.length < 1 ? "required" : null,
                            decoration: InputDecoration(
                              labelText: Constants.price,
                              labelStyle: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.5),
                              ),
                              hintText: "20",
                              hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.3),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 0.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.select_video + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Obx(() {
                      return TextFormField(
                        controller: _videoUrlTextFieldController.value,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        onSaved: (input) => _con.workoutPlan.videoUrl = input,
                        // validator: (input) {
                        //   print(input);
                        //   return !input.contains(Helper.youtubeUrlRegExp())
                        //       ? "Not a valid youtube URL"
                        //       : null;
                        // },
                        decoration: InputDecoration(
                          labelText: Constants.supporting_video_url,
                          labelStyle: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.5),
                          ),
                          hintText: Constants.youtube_your_video,
                          hintStyle: TextStyle(
                            fontSize: 12.0,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.3),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              // open bottom sheet
                              // show list of all videos from video lib
                              // on tap send video object back to screen
                              var data = await Get.bottomSheet(VideoLib());
                              print(data.link);

                              // selectedVideoUrl.value = data.link;
                              _videoUrlTextFieldController.value.text =
                                  data.link;
                            },
                            icon: Icon(Icons.arrow_drop_down),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.upload_image + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
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
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
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
                        SizedBox(
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
                    SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.caution + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      onSaved: (input) => _con.workoutPlan.caution = input,
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      decoration: InputDecoration(
                        labelText: Constants.caution,
                        labelStyle: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                        ),
                        hintText: Constants.short_plan_descp,
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          // fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    TextButton(
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (!_createPlanFormKey.currentState.validate() ||
                            childCategoryRadioTileGroupValue.value == 0 ||
                            durationRadioTileGroupValue.value == 0 ||
                            (_imageFile == null) ||
                            difficultyRadioTileGroupValue.value == 0) {
                          Get.snackbar(
                            "Invalid Input",
                            "Kindly fill all the values",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        } else if (_createPlanFormKey.currentState.validate()) {
                          _createPlanFormKey.currentState.save();
                          _con.workoutPlan.trainerId =
                              userRepo.currentUser.value.id;
                          _con.workoutPlan.status = 1;
                          if (_con.createdWorkoutPlanId.value.isEmpty) {
                            _con.createWorkoutPlan(context, _imageFile);
                          } else {
                            // call function to update plan
                            print("calling to update plan");
                            print(_con.workoutPlan.status);
                            _con.workoutPlan.id =
                                _con.createdWorkoutPlanId.value;
                            _con.updateWorkoutPlan(context, _imageFile);
                          }
                        }
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 50.0),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        overlayColor: MaterialStateProperty.all(
                          Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ),
                      child: Text(
                        Constants.next,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
