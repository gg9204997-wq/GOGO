import 'package:joojo_chat/features/auth/domain/repositories/auth_repository_interface.dart';

class LoginUseCase {
  final AuthRepositoryInterface _repository;

  LoginUseCase(this._repository);

  Future<bool> call({
    required String email,
    required String password,
  }) async {
    return await _repository.loginWithEmail(
      email: email,
      password: password,
    );
  }
}
