class DataState<T> {
  final T? data;
  final Object? exception;

  const DataState({this.data, this.exception});

  factory DataState.success(T data) {
    return DataSuccess<T>(data);
  }

  factory DataState.error(Object exception) {
    return DataFailed(exception);
  }

  R when<R>({
    required R Function(T data) success,
    required R Function(Object exception) failure,
  }) {
    if (data != null) {
      return success(data!);
    } else {
      return failure(exception!);
    }
  }
}

class DataSuccess<T> extends DataState<T> {
  final T data;

  const DataSuccess(this.data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  final Object exception;

  const DataFailed(this.exception) : super(exception: exception);
}
