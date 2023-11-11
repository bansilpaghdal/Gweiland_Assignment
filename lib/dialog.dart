import 'dart:async';

import 'package:flutter/material.dart';

import 'main.dart';

// ignore: unused_element
class ShowDialog {
  static Future<String?> showOptionsDialog(BuildContext context) async {
    Completer<String?> option = Completer<String?>();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Sort Based On',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Price'),
                onTap: () {
                  temp.sort((a, b) => (b['quote']['USD']['price'] as Comparable)
                      .compareTo(a['quote']['USD']['price']));
                  option.complete('Price');

                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Volume (24 Hours)'),
                onTap: () {
                  option.complete('Volume');
                  temp.sort((a, b) =>
                      (b['quote']['USD']['volume_24h'] as Comparable)
                          .compareTo(a['quote']['USD']['volume_24h']));

                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Price Change (24 Hours)'),
                onTap: () {
                  option.complete('Price Change');
                  temp.sort((a, b) =>
                      (b['quote']['USD']['percent_change_24h'] as Comparable)
                          .compareTo(a['quote']['USD']['percent_change_24h']));

                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Market Cap'),
                onTap: () {
                  option.complete('MCap');
                  temp.sort((a, b) =>
                      (a['cmc_rank'] as Comparable).compareTo(b['cmc_rank']));

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: OutlinedButton(
                onPressed: () {
                  option.complete(null);
                  // Handle Cancel button
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
            ),
          ],
        );
      },
    );
    return option.future;
  }
}
