sealed class AppResult<T> {
  const AppResult();

  bool get isSuccess => this is AppSuccess<T>;

  bool get isFailure => this is AppFailure<T>;

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Object error, StackTrace? stackTrace) onFailure,
  }) {
    return switch (this) {
      AppSuccess<T>(:final value) => onSuccess(value),
      AppFailure<T>(:final error, :final stackTrace) => onFailure(
          error,
          stackTrace,
        ),
    };
  }
}

final class AppSuccess<T> extends AppResult<T> {
  const AppSuccess(this.value);

  final T value;
}

final class AppFailure<T> extends AppResult<T> {
  const AppFailure(
    this.error, [
    this.stackTrace,
  ]);

  final Object error;
  final StackTrace? stackTrace;
}
