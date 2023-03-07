import 'package:equatable/equatable.dart';

class GetForceUpdateEntity extends Equatable {
    const GetForceUpdateEntity({
        required this.apiVersion,
        required this.appVersion,
    });

    final String apiVersion;
    final String appVersion;


    Map<String, dynamic> toJson() => {
        "apiVersion": apiVersion,
        "appVersion": appVersion,
    };

    @override
    List<Object?> get props => [
        apiVersion,
        appVersion,
    ];
}
    