class VerifyEmailResponse {
  VerifyEmailResponse({
    required this.success,
  });

  bool success;

  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) => VerifyEmailResponse(
    success: json["success"]??"",
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}
