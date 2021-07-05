import 'package:ironbox/src/helpers/connectionState.dart';

import '../models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Strings
const String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
const String enterEmail = "Enter Email";
const String enterEmailPhoneUsername = "Enter Email/Phone/Username";
const String enterPassword = "Enter Password";
const String confirmPassord = "Confirm Password";
const String enterName = "Enter Name";
const String login = "Log In";
const String nameHint = "John";
const String emailHint = "abc@example.com";
const String signup = "Sign Up";
const String buyNow = "Buy Now";
const String capitalRecommended = "RECOMMENDED";
const String search = "Search";
const String search_video = "Search Video";
const String trainers = "Trainers";
const String success = "Success";
const String failed = "Failed !";
const String taskTitle = "Task Title";
const String weight_gain = "Weight Gain";
const String eg_abs_legs = "e.g Abs";
const String shoulder_and_legs = "Shoulder & Legs";
const String super_set = "Super Set";
const String push_ups = "Push Ups";
const String title = "Title";
const String min_calories_burn = "Min Calories Burn";
const String max_calories_burn = "Max Calories Burn";
const String no_of_sets = "Number of Sets";
const String no_of_reps = "Number of Reps";
const String no_of_rounds = "Number of Rounds";
const String name = "Name";
const String detail = "Details";
const String video_url = "Video URL";
const String select_video = "Select Video";
const String description = "Description";
const String reviews = "Reviews";
const String view_all = "View All";
const String brief_descp = "Brief Description";
const String caution = "Caution";
const String short_plan_descp = "Short plan description";
const String plan_details = "Plan Details";
const String task_desc = "Task Description";
const String creationDate = "Creation Date";
const String select_category = "Select Category";
const String select_sub_category = "Select Sub Category";
const String select_child_category = "Select Child Category";
const String price = "Price";
const String plan_name = "Plan Name";
const String muscle_type = "Muscle Type";
const String supporting_video_url = "Supporting video Url";
const String youtube_your_video = "youtube.com/yourvideo";
const String youtube_video_link = "Youtube video link";
const String something_went_wrong = "Something went wrong";
const String choose_file = "Choose file";
const String upload_image = "Upload Image";
const String due_date = "Due Date";
const String taskTime = "Task Time";
const String duration = "Duration";
const String duration_in_min = "Duration in Min";
const String difficultly_level = "Difficulty Level";
const String create_a_task = "Create a task";
const String create_plan = "Create Plan";
const String next = "Next";
const String done = "Done";
const String add = "Add";
const String subscribe = "Subscribe";
const String unsubscribe = "Unsubscribe";
const String forty_two_days = "42 Days";
const String plan_duration = "Plan duration";
const String days = "Days";
const String phoneHint = "+92**********";
const String experience = "Experience";
const String experience_in_years = "Experience in years";
const String introductory_video = "Introductory video";
const String specializesIn = "Specializes in";
const String signup_with_email = "SIGN UP WITH EMAIL";
const String upcomingChallenges = "UPCOMING CHALLENGES";
const String pound = "Pound";
const String kg = "Kg";
const String contact = "contacts";
const String none = "None";
const String joining_as_a = "Joining as a";
const String dateStringFormat = "yyyy-MM-dd";

// Messages
const String invalidEmail = "Invalid email";
const String invalidNumber = "Invalid number";
const String enter_username = "Enter User name";
const String incorrectPassword = "Incorrect Password";
const String password_doesnt_match = "Password doesnt match";
const String invalidInput = "Invalid input";
const String enterAge = "Enter Age";
const String enterWeight = "Enter Weight (in Kg)";
const String enterWeightPound = "Enter Weight (in Pound)";
const String enterHeight = "Enter Height (in inches)";
const String enterBmi = "Enter BMI";
const String enterPhone = "Enter Phone";
const String injuryIfAny = "Injury (If any)";
const String familyMedicalBG = "Family medical background";
const String medicalBackground = "MedicalBackground";
const String alreadyHaveAnAcc = "Already have an account ?";
const String name_should_be_min_three_char =
    "Name should be minimum 3 characters";
const String invalid_age = "Invalid age";
const String enter_height_in_inches = "Enter height in inches";
const String enter_weight_in_cm = "Enter weight in kg";
const String invalid_bmi = "Invalid BMI";
const String choose_background_image = "Choose Background Image";
const String password_should_be_greater_than_seven =
    "Password should be greater than 7 characters";
const String get_alert_for_this_task = "Get alert for this task";
const String login_failed = "Login Failed !";
const String user_not_found = "User not found";
const String registration_failed = "Registration Failed!";
const String username_should_be_min_four_char =
    "Username should be between 3 to 20 char";
const String switch_to_trainer_mode = "Switch to Trainer mode";
const String change_user_mode = "Change user mode";
const String enter_video_name = "Enter Video Name";
const String username_shouldnt_contain_spaces =
    "Username shouldnt contain spaces, @, +";
const String switch_to_trainee_mode = "Switch to Trainee mode";
const String tell_us_about_yourself = "Tell us about yourself";
const String this_field_cannt_be_empty = "This field cannt be empty";
const String pass_should_contain_special_char =
    "Password should contain a special character";
const String write_a_message = "Write a message";
const String no_message_to_show = "No message to show.";
const String you_have_no_challenges_to_meet_hurrah =
    "You have no challenges to meet. Hurrah!";
const String user_already_exist = "User already exist";
const String check_internet_connection = "Check your internet connection !";
const String user_registered_successfully_you_can_login_now =
    "User registered successfully. You can login now.";

// Colors
const Color primaryColor = Color(0xffE13F3B);
const Color accentColor = Color(0xff2D2D2D);
const Color secondaryColor = Color(0xffD2D2D2);
const Color scaffoldColor = Colors.white;
const Color primaryTextColor = Colors.white;
const Color secondaryTextColor = Color(0xffE13F3B);
const Color messageSearchBarColor = Color(0xffF0F3F4);

// controllers tags
const String createWorkoutPlanController = "createWorkoutPlanController";

// Lists

// List<Category> appCategories = [
//   Category.fromJSON(trainingCategory),
//   Category.fromJSON(workoutCategory),
//   Category.fromJSON(dietCategory)
// ];
List<Category> appCategories = [];
List<Category> subCategories = [];
List<Category> childCategories = [];
const List<String> appCategoriesName = ["training", "workout", "diet"];
const List<String> tabbarOptions = ["Sign Up", "Log In"];
const List<String> selectGender = ["Male", "Female"];
const List<String> joinAsA = ["Trainee", "Trainer"];
const List<String> weightUnits = ["Kg", "Pound"];

// Maps
// Map<String, dynamic> trainingCategory = {
//   "id": "0",
//   "name": "Training",
//   "bgImgUrl":
//       "https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&w=1200&h=600&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F35%2F2019%2F04%2F03185915%2Fhow-to-build-circuit-workout-_0.jpg"
// };

// Map<String, dynamic> workoutCategory = {
//   "id": "1",
//   "name": "Workout",
//   "bgImgUrl": "http://ironbox.mindwhizdev.co/storage/images/red1.jpg"
// };

// Map<String, dynamic> dietCategory = {
//   "id": "2",
//   "name": "Diet",
//   "bgImgUrl":
//       "https://media3.s-nbcnews.com/i/newscms/2019_51/1406125/fruits-veggies-today-main-190130_5fce180c233a626539c5c65792a13462.jpg"
// };

// doubles
const double appBarIconSize = 20.0;

// connection state
ConnectionStatusSingleton connectionStatus =
    ConnectionStatusSingleton.getInstance();

// enums
