class AuthStatus {
  final bool success;
  final String message;
  final String status;

  AuthStatus({
    this.success = true,
    required this.message,
    this.status = ''
  });
}
