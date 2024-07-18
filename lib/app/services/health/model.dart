class Health {
  String? status;
  String? message;

  Health({this.status, this.message});

  factory Health.fromJson(Map<String, dynamic> json) {
    return Health(
      status: json["status"],
      message: json["message"],
    );
  }
}
