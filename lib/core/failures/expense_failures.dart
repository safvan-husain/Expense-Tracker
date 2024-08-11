class Failure implements Exception {
  const Failure({this.message, this.responseCode});

  final String? message;
  final String? responseCode;
}

sealed class ExpenseFailures extends Failure {
  const ExpenseFailures();
}

final class ExpenseApiFailure extends ExpenseFailures {
  const ExpenseApiFailure();
}
