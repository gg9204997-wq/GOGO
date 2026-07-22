mixin LoadingMixin {
  bool _loading = false;

  bool get isLoading => _loading;

  void startLoading() {
    _loading = true;
  }

  void stopLoading() {
    _loading = false;
  }
}