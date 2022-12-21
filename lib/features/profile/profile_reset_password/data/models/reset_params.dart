import 'package:equatable/equatable.dart';

class ResetParams extends Equatable{
    const ResetParams({
       required this.oldPassword,
       required this.newPassword,
       required this.confirmPassword,
    });

    final String oldPassword;
    final String newPassword;
    final String confirmPassword;

    factory ResetParams.fromJson(Map<String, dynamic> json) => ResetParams(
        oldPassword: json["oldPassword"],
        newPassword: json["newPassword"],
        confirmPassword: json["confirmPassword"],
    );

    Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
    };

    @override
    List<Object?> get props => [
        oldPassword,
        newPassword,
        confirmPassword,
    ];
    
    static const tParams = ResetParams(newPassword: "Pass123!",confirmPassword: "Pass123!",oldPassword: "testPassword");
}
    