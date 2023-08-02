abstract class IUseCase<INPUT, RETURN> {
  RETURN execute(INPUT input);
}

abstract class IUseCaseAsync<INPUT, RETURN> {
  Future<RETURN> execute(INPUT input);
}
