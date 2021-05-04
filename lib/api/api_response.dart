class ApiResponse<T> {
  bool success;
  String error;
  T result;

  ApiResponse.ok(this.result) {
    success = true;
  }

  ApiResponse.error(this.error) {
    success = false;
  }
}
