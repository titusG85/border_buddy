// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'port_node.dart';
import 'rss_fetcher.dart';
import 'dialog_util.dart';
import '../utils/app_localizations.dart'; // Import localization helper

class BorderList extends StatefulWidget {
  const BorderList({super.key});

  @override
  State<BorderList> createState() => _BorderListState();
}

class _BorderListState extends State<BorderList> {
  Future<List<PortNode>>? _portNodes;
  String? lastUpdatedTime;

  void _fetchData() {
    setState(() {
      _portNodes = RssFetcher().fetchPortNodes();
    });
    RssFetcher().getLastUpdatedTime().then((value) {
      setState(() {
        lastUpdatedTime = value;
        print('Last updated time: $lastUpdatedTime');
      });
    });
  }

  void _onRefreshPressed() {
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!; // Get localized strings

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          localizations.translate('list_of_ports'), // Use localized key
          style: const TextStyle(fontFamily: 'Gravitas'),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Display the last updated time at the top
              if (lastUpdatedTime != null)
                Container(
                  width: double.infinity,
                  color: Colors.grey[200], // Light background color
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${localizations.translate('last_updated')}: $lastUpdatedTime', // Localized text
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              // The scrollable ListView
              Expanded(
                child: FutureBuilder<List<PortNode>>(
                  future: _portNodes ??= RssFetcher().fetchPortNodes(), // Fetch data only when the widget is built
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${localizations.translate('error')}: ${snapshot.error}', // Localized error message
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(localizations.translate('no_data_available')), // Localized no data message
                      );
                    } else {
                      final portNodes = snapshot.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 80), // Add padding to avoid overlap with the button
                        itemCount: portNodes.length,
                        itemBuilder: (context, index) {
                          final portNode = portNodes[index];
                          final localizedTitle = localizations.translate(portNode.titleKey); // Fetch localized title

                          return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                localizedTitle,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "${localizations.translate('general_lanes')}: ${portNode.generalLanes}\n"
                                "${localizations.translate('ready_lanes')}: ${portNode.readyLanes}\n"
                                "${localizations.translate('sentri_lanes')}: ${portNode.sentriLanes}\n"
                                "${localizations.translate('click_for_more_details')}", // Localized text
                              ),
                              trailing: const Icon(Icons.info_outline),
                              onTap: () => showPortDetails(context, portNode),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          // Position the FloatingActionButton above the navigation bar
          Positioned(
            bottom: 95.0, // Adjust the distance from the bottom
            right: 16.0, // Adjust the distance from the right
            child: FloatingActionButton(
              onPressed: _onRefreshPressed,
              tooltip: localizations.translate('refresh'), // Localized tooltip
              child: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
    );
  }
}