import 'package:equatable/equatable.dart';

class GetCurrencyParams extends Equatable{
    final String userId;
    const GetCurrencyParams({required this.userId,});

    factory GetCurrencyParams.fromJson(Map<String, dynamic> json) => GetCurrencyParams(
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "userId" : userId
    };

    @override
    List<Object?> get props => [
        userId
    ];
    
    static const tParams = GetCurrencyParams(
        userId: "userId"
    );
}
    