import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_practice2/pages/home_page.dart';
import 'package:amplify_practice2/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

class HidderDrawer extends StatefulWidget {
  const HidderDrawer({super.key});

  @override
  State<HidderDrawer> createState() => _HidderDrawerState();
}

class _HidderDrawerState extends State<HidderDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  final menuItemStyleActive = const TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
  final menuItemStyle = const TextStyle(
    fontSize: 18,
  );

  @override
  void initState() {
    super.initState();
    _configureAmplify();

    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Home',
          baseStyle: menuItemStyle,
          selectedStyle: menuItemStyleActive,
        ),
        const HomePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: 'Profile',
          baseStyle: menuItemStyle,
          selectedStyle: menuItemStyleActive,
        ),
        const SettingsPage(),
      ),
    ];
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      final graphQL = AmplifyAPI(modelProvider: ModelProvider.instance);
      final datastorePlugin =
          AmplifyDataStore(modelProvider: ModelProvider.instance);
      await Amplify.addPlugins([auth, datastorePlugin, graphQL]);

      await Amplify.configure(amplifyconfig);
      safePrint("Successfully configured");
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      initPositionSelected: 0,
      backgroundColorMenu: Colors.deepPurple.shade200,
      slidePercent: 60,
      elevationAppBar: 10,
    );
  }
}
