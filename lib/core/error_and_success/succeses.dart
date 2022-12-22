import 'package:equatable/equatable.dart';

abstract class Success extends Equatable{
  final String message;

  const Success({required this.message});

  @override
  List<Object?> get props => [message];

}

class AppSuccess extends Success{
  const AppSuccess({String? message}) : super(message: message??"Successfully done");

  static const tAppSuccess = AppSuccess();
}