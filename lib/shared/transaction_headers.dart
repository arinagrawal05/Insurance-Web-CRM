import '/shared/exports.dart';

class TransactionHeaders {
  static Widget healthTransactionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        heading("S. No", 18),
        heading("Policy No", 18),
        heading("From", 18),
        heading("To", 18),
        heading("Premium", 18),
        heading("Members", 18),
      ],
    );
  }

  static Widget fDTransactionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        heading("S. No", 18),
        heading("Fd No", 18),
        heading("Investment Date", 18),
        heading("Maturity Date", 18),
        heading("Investment", 18),
        heading("Maturity Amt", 18),
      ],
    );
  }

  static Widget lifeTransactionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        heading("S. No", 18),
        heading("Life No", 18),
        heading("Comm Date", 18),
        heading("Next Due Date", 18),
        heading("Premium", 18),
        heading("paid Term", 18),
      ],
    );
  }

  static Widget motorTransactionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        heading("S. No", 18),
        heading("General No", 18),
        heading("From", 18),
        heading("To", 18),
        heading("Premium", 18),
        heading("paid Term", 18),
      ],
    );
  }
}
