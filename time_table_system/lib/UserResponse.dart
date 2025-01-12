class UserResponse {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserResponse({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}