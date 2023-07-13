import 'package:equatable/equatable.dart';

class GetForceUpdateParams extends Equatable{
    const GetForceUpdateParams({
        required this.versionName,
        required this.versionNumber,
    });

    final String versionName;
    final String versionNumber;

    factory GetForceUpdateParams.fromJson(Map<String, dynamic> json) => GetForceUpdateParams(
        versionName: json["versionName"],
        versionNumber: json["versionNumber"],
    );

    Map<String, dynamic> toJson() => {
        "versionName": versionName,
        "versionNumber": versionNumber,
    };

    @override
    List<Object?> get props => [
        versionName,
        versionNumber,
    ];
    
    static const tParams = GetForceUpdateParams(versionName: "1.0.1",versionNumber: "1");
}
    