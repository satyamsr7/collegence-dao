// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

shortAddress(String? address, {int i = 6}) {
  if (address == null) return '0x0000....0000';
  return '${address.substring(0, i)}....${address.substring(address.length - 6)}';
}

void saveToClipboard(String value) =>
    Clipboard.setData(ClipboardData(text: value));

Future<void> Toast(BuildContext context, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Chip(
        label: Text(message),
      ),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.transparent,
    ),
  );
}
