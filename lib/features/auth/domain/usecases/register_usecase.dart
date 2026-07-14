import 'package:joojo_chat/features/auth/domain/repositories/auth_repository_interface.dart';

class RegisterUseCase {
  final AuthRepositoryInterface _repository;

  RegisterUseCase(this._repository);

  Future<bool> call({
    required String username,
    required String phone,
    required String email,
    required String password,
    required String gender,
    required String country,
  }) async {
    return await _repository.registerNewUser(
      username: username,
      phone: phone,
      email: email,
      password: password,
      gender: gender,
      country: country,
    );
  }
}
