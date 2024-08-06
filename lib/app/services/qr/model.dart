class PaymentResponse {
  static String success = "CONFIRMED";
}

class PaymentApprove {
  String status;
  String message;
  int totalPrice;

  PaymentApprove({
    required this.status,
    required this.message,
    required this.totalPrice,
  });

  factory PaymentApprove.fromJson(Map<String, dynamic> json) {
    return PaymentApprove(
      status: json["status"],
      message: json["message"],
      totalPrice: json["totalPrice"],
    );
  }
}
