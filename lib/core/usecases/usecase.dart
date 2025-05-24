import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

// UseCase 추상 클래스
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// 매개변수가 없는 UseCase
abstract class NoParamsUseCase<Type> {
  Future<Either<Failure, Type>> call();
}

// Stream UseCase
abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

// 매개변수가 없는 Stream UseCase
abstract class NoParamsStreamUseCase<Type> {
  Stream<Either<Failure, Type>> call();
}

// 매개변수 없음을 나타내는 클래스
class NoParams {
  const NoParams();
}
