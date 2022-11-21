import 'package:rxdart/rxdart.dart';

// 1. Could drain them when reset
// 2. Orrr could scope repositories using Provider and just close everything
// -> way easier and also easier to retry maybe?
abstract class BaseRepository {
  final _initialized = BehaviorSubject<bool>();

  Future<bool> get ready => _initialized.first;
  bool get initialized => _initialized.valueOrNull ?? false;

  // That way we get guaranteed idempotency
  Future<void> initialize() async {
    _initialized.add(true);
  }

  Future<void> reset() async {
    _initialized.drain();
  }
}
