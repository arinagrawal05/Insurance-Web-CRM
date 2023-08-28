import 'package:flutter/material.dart';
import 'package:health_model/shared/style.dart';

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
        heading("Invested Date", 18),
        heading("Maturaty Date", 18),
        heading("Investment", 18),
        heading("Maturated Amt", 18),
      ],
    );
  }

  static Widget lifeTransactionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        heading("S. No", 18),
        heading("Life No", 18),
        heading("From", 18),
        heading("To", 18),
        heading("Premium", 18),
        heading("paid Term", 18),
      ],
    );
  }
}
