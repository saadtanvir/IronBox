import 'package:get/get.dart';
import 'package:ironbox/src/models/reviews.dart';
import 'package:ironbox/src/models/user.dart';
import '../repositories/user_repo.dart' as userRepo;

class ReviewAndRatingController extends GetxController {
  List<Review> reviews = List<Review>().obs;

  var doneFetchingReviews = false.obs;

  void getTrainerReviews(String id) async {
    doneFetchingReviews.value = false;
    reviews.clear();
    final Stream<Review> stream = await userRepo.getTrainerReviews(id);
    stream.listen((Review _review) {
      reviews.add(_review);
    }, onError: (e) {
      print(e);
    }, onDone: () {
      print("done fetching reviews");
      doneFetchingReviews.value = true;
    });
  }
}
