import 'package:equatable/equatable.dart';

class OtpSentEntity extends Equatable {
  const OtpSentEntity({this.identifier});

  final String? identifier;

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
      };

  @override
  List<Object?> get props => [
        identifier,
      ];
}
