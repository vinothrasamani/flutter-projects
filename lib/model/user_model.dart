class UserModel {
  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
}
