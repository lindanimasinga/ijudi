abstract class Transaction {

    final DateTime date;
    final double amount;
    final String description;
    final String type;
    final String subType;

  Transaction(this.date, this.amount, this.description, this.type, this.subType);
}