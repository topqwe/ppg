class ApiResponse<T> {
  Status status;
  T? data;
  dynamic exception;
  ApiResponse.completed(this.data) : status = Status.completed;
  ApiResponse.error(this.exception) : status = Status.error;

  @override
  String toString() {
    return "Status : $status \n Message : $exception \n Data : $data";
  }
}

enum Status { completed, error }
