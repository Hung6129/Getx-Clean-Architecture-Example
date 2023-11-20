abstract class UseCaseWithParams<T, Params> {
  Future<T> call(Params params);
}

abstract class UseCaseWithoutParams<T> {
  Future<T> call();
}
