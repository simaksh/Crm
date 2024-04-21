class LoginViewModel {
  final String userName;
  final String password;
  final int id;
  final bool isSeller;
  final String firstName;
  final String lastName;

  LoginViewModel({ required this.id,  required this.isSeller, required this.firstName, required this.lastName, required this.userName, required this.password});

  factory LoginViewModel.fromJson(final Map<String, dynamic> json) =>
      LoginViewModel(userName: json['userName'], password: json['password'], id: json['id'], isSeller: json['isSeller'], firstName:json['firstName'], lastName:json['lastName']);
}


