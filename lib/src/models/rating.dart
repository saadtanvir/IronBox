class Rating {
  int oneStarCount;
  int twoStarCount;
  int threeStarCount;
  int fourStarCount;
  int fiveStarCount;
  int totalCount;
  double rating;

  Rating();

  Rating.fromJSON(Map<String, dynamic> jsonMap) {
    // print("rating object: $jsonMap");
    try {
      oneStarCount = jsonMap["one_star"] != null
          ? int.parse(jsonMap["one_star"].toString())
          : 0;
      twoStarCount = jsonMap["two_star"] != null
          ? int.parse(jsonMap["two_star"].toString())
          : 0;
      threeStarCount = jsonMap["three_star"] != null
          ? int.parse(jsonMap["three_star"].toString())
          : 0;
      fourStarCount = jsonMap["four_star"] != null
          ? int.parse(jsonMap["four_star"].toString())
          : 0;
      fiveStarCount = jsonMap["five_star"] != null
          ? int.parse(jsonMap["five_star"].toString())
          : 0;
      totalCount = jsonMap["rating_count"] != null
          ? int.parse(jsonMap["rating_count"].toString())
          : 0;

      rating = jsonMap["avg_rating"] != null
          ? double.parse(jsonMap["avg_rating"].toString())
          : 0.0;
    } catch (e) {
      print("Rating Model Error: $e");
    }
  }
}
