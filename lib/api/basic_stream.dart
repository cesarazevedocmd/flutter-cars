import 'dart:async';

class BasicStream<T> {
  StreamController _basicStream = StreamController<T>();

  Stream<T> get stream => _basicStream.stream;

  void add(T data) {
    _basicStream.add(data);
  }

  void addError(dynamic error) {
    _basicStream.addError(error);
  }

  void dispose() {
    _basicStream.close();
  }
}
