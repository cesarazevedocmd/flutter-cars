class ApiResponse<T> {
  bool success = false;
  String error;
  T result;

  ApiResponse.ok(this.result) {
    success = true;
  }

  ApiResponse.error(this.error) {
    success = false;
  }
}
