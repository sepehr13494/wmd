import 'package:dartz/dartz.dart';
import 'package:wmd/core/domain/usecases/usercase.dart';
import 'package:wmd/core/error_and_success/failures.dart';
import 'package:wmd/features/help/faq/data/models/faq.dart';
import 'package:wmd/features/help/faq/domain/repositories/faq_repository.dart';

class GetFaqUseCase extends UseCase<List<Faq>, NoParams> {
  final FaqRepository faqRepository;

  GetFaqUseCase(this.faqRepository);
  @override
  Future<Either<Failure, List<Faq>>> call(NoParams params) =>
      faqRepository.getFAQs(params);
}
