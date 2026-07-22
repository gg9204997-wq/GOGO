class Pagination {
  final int page;

  final int limit;

  const Pagination({
    required this.page,
    required this.limit,
  });

  int get offset => (page - 1) * limit;
}