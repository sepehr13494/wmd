

import 'package:equatable/equatable.dart';

class ResetResponse extends Equatable{
    ResetResponse({
        this.message,
        this.success,
    });

    final String? message;
    final bool? success;

    factory ResetResponse.fromJson(Map<String, dynamic> json) => ResetResponse(
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
    };

    @override
    List<Object?> get props => [
        message,
        success,
    ];
    
    static final tResponse = ResetResponse.fromJson({"message":"Password change is successful","success":true});


}
    