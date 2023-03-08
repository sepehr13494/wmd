import 'package:equatable/equatable.dart';

class GetForceUpdateEntity extends Equatable {
    const GetForceUpdateEntity({
        required this.apiVersion,
        required this.appVersion,
        required this.isForceUpdate,
    });

    final String apiVersion;
    final String appVersion;
    final bool isForceUpdate;


    Map<String, dynamic> toJson() => {
        "apiVersion": apiVersion,
        "appVersion": appVersion,
        "isForceUpdate": isForceUpdate,
    };

    @override
    List<Object?> get props => [
        apiVersion,
        appVersion,
        isForceUpdate,
    ];
}
    