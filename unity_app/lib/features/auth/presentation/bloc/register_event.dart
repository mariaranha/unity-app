abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String username;
  final String password;
  final String birthDate;

  RegisterSubmitted({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.birthDate,
  });
}
