import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart' show Failure;

// Base interface for Use Cases
abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

// Base interface for Stream-based Use Cases
abstract class BaseStreamUseCase<T, Params> {
  Stream<Either<Failure, T>> call(Params params);
}

// For use cases without parameters
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
