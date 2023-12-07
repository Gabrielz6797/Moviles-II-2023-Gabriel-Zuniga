part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final bool isAuth;
  final bool isLoading;
  final bool isCreatingAccount;
  final bool error;
  final String errorMessage;
  final String email;
  final String username;
  final int score;

  const AuthState({
    this.isAuth = false,
    this.isLoading = false,
    this.isCreatingAccount = false,
    this.error = false,
    this.errorMessage = '',
    this.email = '',
    this.username = '',
    this.score = 0,
  });

  AuthState copyWith({
    bool? isAuth,
    bool? isLoading,
    bool? isCreatingAccount,
    bool? error,
    String? errorMessage,
    String? email,
    String? username,
    int? score,
  }) =>
      AuthState(
        isAuth: isAuth ?? this.isAuth,
        isLoading: isLoading ?? this.isLoading,
        isCreatingAccount: isCreatingAccount ?? this.isCreatingAccount,
        error: error ?? this.error,
        errorMessage: errorMessage ?? this.errorMessage,
        email: email ?? this.email,
        username: username ?? this.username,
        score: score ?? this.score,
      );

  @override
  List<Object> get props => [
        isAuth,
        isLoading,
        isCreatingAccount,
        error,
        errorMessage,
        email,
        username,
        score,
      ];
}
