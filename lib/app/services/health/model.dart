class Health {
  String? name;
  String? status;
  String? message;

  Health({this.name, this.status, this.message});

  factory Health.fromJson(Map<String, dynamic> json) {
    return Health(
      name: json["name"],
      status: json["status"],
      message: json["message"],
    );
  }
}
