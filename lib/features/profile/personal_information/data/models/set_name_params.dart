import 'package:equatable/equatable.dart';

class SetNameParams extends Equatable{
    const SetNameParams({
        required this.firstName,
        this.lastName,
    });

    final String firstName;
    final String? lastName;

    factory SetNameParams.fromJson(Map<String, dynamic> json) => SetNameParams(
        firstName: json["firstName"],
        lastName: json["lastName"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
    };

    @override
    List<Object?> get props => [
        firstName,
        lastName,
    ];

    static const tParams = SetNameParams(firstName: "sepehr", lastName: "marashi");
}
    