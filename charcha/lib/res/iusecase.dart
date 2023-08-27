abstract class IUseCase<INPUT, RETURN> {
  RETURN execute(INPUT input);
}

abstract class IUseCaseAsync<INPUT, RETURN> {
  Future<RETURN> execute(INPUT input);
}

abstract class IMultipleInputUseCase<INPUT1, INPUT2, RETURN> {
  RETURN execute(INPUT1 input1, INPUT2 input2);
}

abstract class IMultipleInputUseCaseAsync<INPUT1, INPUT2, RETURN> {
  Future<RETURN> execute(INPUT1 input1, INPUT2 input2);
}
