import 'package:equatable/equatable.dart';

abstract class Success extends Equatable{
  final String message;

  const Success({required this.message});

  @override
  List<Object?> get props => [message];

}

class AppSuccess extends Success{
  const AppSuccess({required String message}) : super(message: message);

  static const tAppSuccess = AppSuccess(message: "test success");
}