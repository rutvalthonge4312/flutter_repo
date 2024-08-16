class SignupRequest {
  final String fName;
  final String lName;
  final String email;
  final String phone;
  final String password;
  final String rePassword;
  final String userType;
  final String division;
  final String trains;
  final String coaches;

  SignupRequest({
    required this.fName,
    required this.lName,
    required this.email,
    required this.phone,
    required this.password,
    required this.rePassword,
    required this.userType,
    required this.division,
    required this.trains,
    required this.coaches,
  });

  Map<String, dynamic> toJson() {
    return {
      'f_name': fName,
      'l_name': lName,
      'email': email,
      'phone': phone,
      'password': password,
      're_password': rePassword,
      'user_type': userType,
      'division': division,
      'trains': trains,
      'coaches': coaches,
    };
  }
}
