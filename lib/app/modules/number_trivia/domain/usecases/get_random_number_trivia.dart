import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_annotations.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

part 'get_random_number_trivia.g.dart';

@Injectable()
class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia(
    this.repository,
  );
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await this.repository.getRandomNumberTrivia();
  }
}
