class User {
  final int id;
  final String name;
  final String email;
  // final int emailVerified;
  // final int upgradedAccount;

  User({
    required this.id,
    required this.name,
    required this.email,
    // required this.emailVerified,
    // required this.upgradedAccount,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];
  //    emailVerified = json['email_verified'],
  //  upgradedAccount = json['upgraded_account']

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        //'email_verified': emailVerified,
        // 'upgraded_account': upgradedAccount,
      };

  // String get isUpgradedAccount => upgradedAccount == 1 ? 'true' : 'false';
  // String get isEmailVerified => emailVerified == 1 ? 'true' : 'false';
}
