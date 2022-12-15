part of 'faq_cubit.dart';

abstract class FaqState {}

class FaqLoaded extends Equatable with FaqState {
  final List<Faq> faqs;

  FaqLoaded({required this.faqs});

  @override
  List<Object?> get props => [faqs];
}
