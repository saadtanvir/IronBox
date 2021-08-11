class PlanRequest {
  String id;
  String trainerId;
  String traineeId;
  String date;
  // 1 = pending, 2 = accepted, 3 = rejected, 4 = in process, 5 = completed
  int reqStatus;
  int category; // 1 = workout, 2 = diet
  int paymentStatus; // 0 and 1
  double price;

  PlanRequest();
}
