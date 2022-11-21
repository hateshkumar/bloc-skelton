import 'dart:async';

mixin Validators {

  final validatePhone = StreamTransformer<String, String>.fromHandlers(
    handleData: (number, sink) {

      if(number.length == 11) {
        sink.add(number);
      }
      else {
        sink.addError("Please enter valid Phone no");
      }
    }
  );
  final validateEmpty = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {

      if(value.isNotEmpty) {
        sink.add(value);
      }
      else {
        sink.addError("Field is required");
      }
    }
  );
}