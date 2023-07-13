import 'package:equatable/equatable.dart';

class GetPreferenceEntity extends Equatable {
  const GetPreferenceEntity({this.language, required this.showMobileBanner});

  final String? language;
  final bool showMobileBanner;

  Map<String, dynamic> toJson() =>
      {"language": language, "showMobileBanner": showMobileBanner};

  @override
  // TODO: implement props
  List<Object?> get props => [language, showMobileBanner];
}
