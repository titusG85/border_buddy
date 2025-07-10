import 'package:flutter/material.dart';
import 'port_node.dart';
import '../utils/app_localizations.dart'; // Import localization helper

void showPortDetails(BuildContext context, PortNode portNode) {
  final localizations = AppLocalizations.of(context)!; // Get localized strings

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(localizations.translate(portNode.titleKey)), // Localized title
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('${localizations.translate('hours')}: ${portNode.hours}'),
              Text('${localizations.translate('date')}: ${portNode.date}'),
              Text('${localizations.translate('max_lanes')}: ${portNode.maxLanes}'),
              Text('${localizations.translate('general_lanes')}: ${portNode.generalLanes}'),
              Text('${localizations.translate('sentri_lanes')}: ${portNode.sentriLanes}'),
              Text('${localizations.translate('ready_lanes')}: ${portNode.readyLanes}'),
              Text('${localizations.translate('notice')}: ${portNode.borderNotice}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(localizations.translate('close')), // Localized "Close" button
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}