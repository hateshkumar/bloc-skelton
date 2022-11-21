
abstract class ReliableEnum<T> {
  final T value;

  const ReliableEnum(this.value);

  @override
  bool operator ==(dynamic other) {
    if (other is ReliableEnum<T>) {
      return value == other.value;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}
