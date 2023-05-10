import 'package:riverpod_fake_store_api/common/enum/status.dart';

class StateData<T> {
  Status status;
  T data;
  String errorMessage;

  StateData({
    required this.status,
    required this.data,
    required this.errorMessage,
  });

  factory StateData.loading(T initialValue) =>
      StateData(status: Status.loading, data: initialValue, errorMessage: "");

  StateData<T> copyWith({
    Status? status,
    T? data,
    String? errorMessage,
  }) {
    return StateData<T>(
        status: status ?? this.status,
        data: data ?? this.data,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
