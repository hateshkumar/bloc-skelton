
import '../domain/entites/reliable_enum.dart';

abstract class Query {
  const Query();
  Map<String, String?> queryMap();
}

class PaginationSortOperator extends ReliableEnum<String> {
  const PaginationSortOperator(value) : super(value);
  toString() => value;

  static const lt = PaginationSortOperator('lt');
  static const gt = PaginationSortOperator('gt');
}

abstract class PageRequest extends Query {
  final int limit;
  final String sortKey;
  final PaginationSortOperator sortOperator;
  final String? lastValue;

  PageRequest({
    required this.limit,
    required this.sortKey,
    required this.sortOperator,
    this.lastValue,
  });

  String constructSortKey() => '$sortKey:$sortOperator';

  Map<String, String?> queryMap() => {
        'limit': limit.toString(),
        constructSortKey(): lastValue,
      };

  // String constructSortKeyValue() =>
}
