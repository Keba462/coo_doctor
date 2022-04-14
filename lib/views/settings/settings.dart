import 'package:coo_doctor/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext content) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              SettingsGroup(
                title: 'GENERAL',
                children: <Widget>[
                  buildDeleteAccount(),
                  buildReportBug(context),
                  buildSendFeedback(context),
                ],
              ),
            ],
          ),
        ),
      );
  Widget buildDeleteAccount() => SimpleSettingsTile(
      title: 'Delete Account',
      subtitle: '',
      leading: const IconWidget(icon: Icons.delete, color: Colors.purple),
      onTap: () {} //=> Utils.showSnackBar(context,'Clicked delete'),
      );

  Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
      title: 'Report A Bug',
      subtitle: '',
      leading: const IconWidget(icon: Icons.bug_report, color: Colors.purple),
      onTap: () {} //=> Utils.showSnackBar(context,'Clicked delete'),
      );

  Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
      title: 'Send Feedback',
      subtitle: '',
      leading: const IconWidget(icon: Icons.thumb_up, color: Colors.purple),
      onTap: () {} // => Utils.showSnackBar(context,'Clicked delete'),
      );
}
