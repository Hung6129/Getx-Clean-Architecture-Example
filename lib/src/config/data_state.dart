import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;
  const DataState._({required this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super._(data: data);
}

class DataError<T> extends DataState<T> {
  const DataError(DioException error) : super._(error: error, data: null);
}
