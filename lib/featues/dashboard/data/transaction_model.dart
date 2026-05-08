class TransactionModel {
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;

  TransactionModel({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isCredit,
  });
}

final List<TransactionModel> transactions = [
  TransactionModel(
    title: "Netflix Subscription",
    subtitle: "Entertainment",
    amount: "5,000",
    isCredit: false,
  ),
  TransactionModel(
    title: "Salary",
    subtitle: "Company Transfer",
    amount: "250,000",
    isCredit: true,
  ),
  TransactionModel(
    title: "Uber Ride",
    subtitle: "Transport",
    amount: "3,200",
    isCredit: false,
  ),
];