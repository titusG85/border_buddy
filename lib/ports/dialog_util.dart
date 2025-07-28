import 'package:flutter/material.dart';
import 'port_node.dart';
import '../utils/app_localizations.dart'; // Import localization helper
import '../utils/text_styles.dart';

void showPortDetails(BuildContext context, PortNode portNode) {
  final localizations = AppLocalizations.of(context)!; // Get localized strings

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          localizations.translate(portNode.titleKey), // Localized title
          style: AppTextStyles.sectionHeader,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                '${localizations.translate('hours')}: ${portNode.hours}',
                style: AppTextStyles.bodyText,
              ),
              Text(
                '${localizations.translate('date')}: ${portNode.date}',
                style: AppTextStyles.bodyText,
              ),
              Text(
                '${localizations.translate('max_lanes')}: ${portNode.maxLanes}',
                style: AppTextStyles.bodyText,
              ),
              Text(
                '${localizations.translate('general_lanes')}: ${portNode.generalLanes}',
                style: AppTextStyles.bodyText,
              ),
              Text(
                '${localizations.translate('sentri_lanes')}: ${portNode.sentriLanes}',
                style: AppTextStyles.bodyText,
              ),
              Text(
                '${localizations.translate('ready_lanes')}: ${portNode.readyLanes}',
                style: AppTextStyles.bodyText,
              ),
              Text(
                '${localizations.translate('notice')}: ${portNode.borderNotice}',
                style: AppTextStyles.bodyText,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              localizations.translate('close'), // Localized "Close" button
              style: AppTextStyles.buttonText.copyWith(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}