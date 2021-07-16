import 'package:ironbox/src/controllers/plans_controller.dart';
import 'package:ironbox/src/models/plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ironbox/src/helpers/helper.dart';
import '../helpers/app_constants.dart' as Constants;
import 'package:ironbox/src/repositories/user_repo.dart' as userRepo;

class TrainerEditPlanWidget extends StatefulWidget {
  Plan plan;
  TrainerEditPlanWidget(this.plan);
  @override
  _TrainerEditPlanWidgetState createState() => _TrainerEditPlanWidgetState();
}

class _TrainerEditPlanWidgetState extends State<TrainerEditPlanWidget> {
  GlobalKey<FormState> _editPlanFormKey;
  PlansController _con = Get.put(PlansController());
  String planCategory;
  // File _imageFile;
  // var imageName = "".obs;
  // final ImagePicker _picker = ImagePicker();

  // void _selectImage() async {
  //   // await ImagePicker.getImage(source: imageSource, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
  //   final pickedFile =
  //       await _picker.getImage(source: ImageSource.gallery, imageQuality: 60);
  //   if (pickedFile != null) {
  //     print(pickedFile.path);
  //     _imageFile = File(pickedFile.path);
  //     imageName.value = _imageFile.path.split('/').last;
  //   }
  // }

  @override
  void initState() {
    _editPlanFormKey = new GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.plan.name}",
            style: TextStyle(color: Theme.of(context).primaryColor)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor, //change your color here
        ),
        actions: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              if (!_editPlanFormKey.currentState.validate()) {
                return;
              } else if (_editPlanFormKey.currentState.validate()) {
                _editPlanFormKey.currentState.save();
                _con.plan.createdBy = userRepo.currentUser.value.id;
                _con.editPlan(context, widget.plan);
              }
            },
            child: Icon(
              Icons.done,
              size: 25.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                key: _editPlanFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.name + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: widget.plan.name,
                      onSaved: (input) => widget.plan.name = input,
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      decoration: InputDecoration(
                        // labelText: widget.plan.name,
                        // labelStyle: TextStyle(
                        //   fontSize: 12.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Theme.of(context).accentColor.withOpacity(0.5),
                        // ),
                        hintText: Constants.weight_gain,
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.0,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.brief_descp + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: widget.plan.description,
                      onSaved: (input) => widget.plan.description = input,
                      validator: (input) =>
                          input.length < 1 ? "required" : null,
                      decoration: InputDecoration(
                        // labelText: widget.plan.description,
                        // labelStyle: TextStyle(
                        //   fontSize: 12.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Theme.of(context).accentColor.withOpacity(0.5),
                        // ),
                        hintText: Constants.short_plan_descp,
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          // fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.0,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.detail + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      constraints: BoxConstraints(maxHeight: 100.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        initialValue: widget.plan.detail,
                        textInputAction: TextInputAction.newline,
                        maxLines: null,
                        onSaved: (input) => widget.plan.detail = input,
                        validator: (input) =>
                            input.length < 1 ? "required" : null,
                        decoration: InputDecoration(
                          // labelText: widget.plan.detail,
                          // labelStyle: TextStyle(
                          //   fontSize: 12.0,
                          //   fontWeight: FontWeight.bold,
                          //   color:
                          //       Theme.of(context).accentColor.withOpacity(0.5),
                          // ),
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0.0,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.select_category + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DropdownButtonFormField(
                      onSaved: (input) => widget.plan.category = planCategory,
                      validator: (input) => planCategory == null
                          ? Constants.select_category
                          : null,
                      onChanged: (value) {
                        print(value);
                        int index = Constants.appCategoriesName.indexOf(value);
                        planCategory = Constants.appCategoriesName[index];
                      },
                      items: Constants.appCategoriesName.map((String priority) {
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
                        labelText: Constants.select_category,
                        labelStyle: TextStyle(
                            color: Theme.of(context).secondaryHeaderColor),
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.0,
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.2)),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.duration + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: widget.plan.duration,
                            onSaved: (input) =>
                                widget.plan.duration = input.toString(),
                            validator: (input) =>
                                input.length < 1 ? "required" : null,
                            decoration: InputDecoration(
                              // labelText: widget.plan.duration,
                              // labelStyle: TextStyle(
                              //   fontSize: 12.0,
                              //   fontWeight: FontWeight.bold,
                              //   color: Theme.of(context)
                              //       .accentColor
                              //       .withOpacity(0.5),
                              // ),
                              hintText: "42",
                              hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.3),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              border: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0.0,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            Constants.days,
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.price + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(
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
                        const SizedBox(
                          width: 5.0,
                        ),
                        SizedBox(
                          width: 200.0,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: widget.plan.price.toString(),
                            onSaved: (input) =>
                                widget.plan.price = double.parse(input),
                            validator: (input) =>
                                input.length < 1 ? "required" : null,
                            decoration: InputDecoration(
                              // labelText: widget.plan.price.toString(),
                              // labelStyle: TextStyle(
                              //   fontSize: 12.0,
                              //   fontWeight: FontWeight.bold,
                              //   color: Theme.of(context)
                              //       .accentColor
                              //       .withOpacity(0.5),
                              // ),
                              hintText: "20",
                              hintStyle: TextStyle(
                                fontSize: 12.0,
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.3),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              border: const OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0.0,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants.video_url + ":",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      initialValue: widget.plan.videoUrl,
                      onSaved: (input) => widget.plan.videoUrl = input,
                      validator: (input) =>
                          !input.contains(Helper.youtubeUrlRegExp())
                              ? "Not a valid youtube URL"
                              : null,
                      decoration: InputDecoration(
                        // labelText: "",
                        // labelStyle: TextStyle(
                        //   fontSize: 12.0,
                        //   fontWeight: FontWeight.bold,
                        //   color: Theme.of(context).accentColor.withOpacity(0.5),
                        // ),
                        hintText: Constants.youtube_your_video,
                        hintStyle: TextStyle(
                          fontSize: 12.0,
                          color: Theme.of(context).accentColor.withOpacity(0.3),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.0,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 40.0,
                    // ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     Constants.upload_image + ":",
                    //     style: TextStyle(
                    //       color: Theme.of(context).accentColor,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10.0,
                    // ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       flex: 1,
                    //       child: TextButton(
                    //         onPressed: () async {
                    //           _selectImage();
                    //         },
                    //         style: ButtonStyle(
                    //           padding: MaterialStateProperty.all(
                    //             EdgeInsets.symmetric(horizontal: 5.0),
                    //           ),
                    //           backgroundColor: MaterialStateProperty.all(
                    //             Colors.grey[300],
                    //           ),
                    //           shape: MaterialStateProperty.all<
                    //               RoundedRectangleBorder>(
                    //             RoundedRectangleBorder(
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(5.0)),
                    //             ),
                    //           ),
                    //         ),
                    //         child: Text(
                    //           Constants.choose_file,
                    //           style: TextStyle(
                    //             color: Theme.of(context).primaryColor,
                    //             fontSize: 12.0,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 10.0,
                    //     ),
                    //     Expanded(
                    //       flex: 3,
                    //       child: Obx(() {
                    //         return Text(
                    //           imageName.value,
                    //           style: TextStyle(
                    //             color: Theme.of(context).accentColor,
                    //             fontSize: 15.0,
                    //           ),
                    //         );
                    //       }),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 40.0),
                    // TextButton(
                    //   onPressed: () async {
                    //     FocusScope.of(context).requestFocus(new FocusNode());
                    //     if (!_editPlanFormKey.currentState.validate()) {
                    //       return;
                    //     } else if (_editPlanFormKey.currentState.validate()) {
                    //       _editPlanFormKey.currentState.save();
                    //       _con.plan.createdBy = userRepo.currentUser.value.id;
                    //       _con.createPlan(context, _imageFile);
                    //     }
                    //   },
                    //   style: ButtonStyle(
                    //     padding: MaterialStateProperty.all(
                    //       EdgeInsets.symmetric(horizontal: 50.0),
                    //     ),
                    //     backgroundColor: MaterialStateProperty.all(
                    //         Theme.of(context).primaryColor),
                    //     overlayColor: MaterialStateProperty.all(
                    //       Theme.of(context).accentColor.withOpacity(0.3),
                    //     ),
                    //     shape:
                    //         MaterialStateProperty.all<RoundedRectangleBorder>(
                    //       RoundedRectangleBorder(
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(15.0)),
                    //       ),
                    //     ),
                    //   ),
                    //   child: Text(
                    //     Constants.create_plan,
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       color: Theme.of(context).scaffoldBackgroundColor,
                    //     ),
                    //   ),
                    // ),
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
