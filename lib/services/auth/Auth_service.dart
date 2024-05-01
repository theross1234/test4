import 'package:test4/services/auth/auth_provider.dart';
import 'package:test4/services/auth/auth_user.dart';



class AuthSevice implements AuthProvider {
  final AuthProvider provider;
  const AuthSevice(this.provider);

  @override
  Future<AuthUser> createUser({required String email, required String password}) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> login({
    required String email,
    required String password}) =>
      provider.login(
          email: email,
          password: password);


  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
}