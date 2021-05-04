import 'package:fitness_app/src/models/category.dart';
import 'package:fitness_app/src/repositories/category_repo.dart'
    as categoryRepo;
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';

class HomeController extends GetxController {
  var categories = List<Category>().obs;

  HomeController() {
    // listenForStepCount();
  }

  // Future<void> listenForCategories() async {
  //   print("fetching categories from home controller");
  //   Stream<Category> stream = await categoryRepo.getCategories();

  //   stream.listen((Category _category) {
  //     print(_category.backgroundImgUrl);
  //     categories.add(_category);
  //   }, onError: (a) {
  //     print("Error thrown while getting categories");
  //     print(a);
  //   }, onDone: () {
  //     print("Done fetching categories");
  //   });
  // }
}
