abstract interface class UseCase<T, Params> {
  T call(Params params);
}

abstract interface class NoParamsUseCase<T> {
  T call();
}
