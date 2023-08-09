class Payment {
  final String amount;
  final String currency;
  final String name;
  final String userEmail;
  final String description;
  final Map<String, dynamic> discount; // new field for discount info

  Payment({
    required this.amount,
    required this.currency,
    required this.name,
    required this.userEmail,
    required this.description,
    this.discount = const {}, // initialize discount to empty map
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
      'user_name': name,
      'user_email': userEmail,
      'payment_method_types': ['card'],
      'description': description,
    };
  }
}
