class Customer {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String username;
  final String email;

  String get name => "$firstName $lastName";

  const Customer({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.username,
    required this.email,
  });
}
