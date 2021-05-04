import 'package:fitness_app/src/models/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// doubles
const double appBarIconSize = 20.0;

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
const String taskTitle = "Task Title";
const String title = "Title";
const String description = "Description";
const String task_desc = "Task Description";
const String creationDate = "Creation Date";
const String due_date = "Due Date";
const String taskTime = "Task Time";
const String create_a_task = "Create a task";
const String phoneHint = "+92**********";
const String experience = "Experience";
const String specializesIn = "Specializes in";
const String signup_with_email = "SIGN UP WITH EMAIL";
const String upcomingChallenges = "UPCOMING CHALLENGES";
const String pound = "Pound";
const String kg = "Kg";
const String none = "None";
const String joining_as_a = "Joining as a";

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
const String password_should_be_greater_than_seven =
    "Password should be greater than 7 characters";
const String get_alert_for_this_task = "Get alert for this task";
const String username_should_be_min_four_char =
    "Username should be between 3 to 20 char";
const String switch_to_trainer_mode = "Switch to Trainer mode";
const String change_user_mode = "Change user mode";
const String username_shouldnt_contain_spaces =
    "Username shouldnt contain spaces, @, +";
const String switch_to_trainee_mode = "Switch to Trainee mode";
const String this_field_cannt_be_empty = "This field cannt be empty";
const String pass_should_contain_special_char =
    "Password should contain a special character";
const String write_a_message = "Write a message";
const String no_message_to_show = "No message to show.";
const String check_internet_connection = "Check your internet connection !";

// Colors
const Color primaryColor = Color(0xffE13F3B);
const Color accentColor = Color(0xff2D2D2D);
const Color secondaryColor = Color(0xffD2D2D2);
const Color scaffoldColor = Colors.white;
const Color primaryTextColor = Colors.white;
const Color secondaryTextColor = Color(0xffE13F3B);
const Color messageSearchBarColor = Color(0xffF0F3F4);
// const Color signupOptionBGColor =

// Lists
List<Category> appCategories = [
  Category.fromJSON(trainingCategory),
  Category.fromJSON(workoutCategory),
  Category.fromJSON(dietCategory)
];
const List<String> appCategoriesName = ["training", "workout", "diet"];
const List<String> tabbarOptions = ["Sign Up", "Log In"];
const List<String> selectGender = ["Male", "Female"];
const List<String> joinAsA = ["Trainee", "Trainer"];
const List<String> weightUnits = ["Kg", "Pound"];

// Maps
Map<String, dynamic> trainingCategory = {
  "id": "0",
  "name": "Training",
  "bgImgUrl":
      "https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&w=1200&h=600&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F35%2F2019%2F04%2F03185915%2Fhow-to-build-circuit-workout-_0.jpg"
};

Map<String, dynamic> workoutCategory = {
  "id": "1",
  "name": "Workout",
  "bgImgUrl":
      "https://www.bodybuilding.com/images/2016/june/ultimate-beginners-machine-workout-for-women-header-v2-960x540.jpg"
};

Map<String, dynamic> dietCategory = {
  "id": "2",
  "name": "Diet",
  "bgImgUrl":
      "https://media3.s-nbcnews.com/i/newscms/2019_51/1406125/fruits-veggies-today-main-190130_5fce180c233a626539c5c65792a13462.jpg"
};

// enums
