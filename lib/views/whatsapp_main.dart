import 'package:flutter/material.dart';

import '../core/services/locator.dart';
import '../view_models.dart/main_model.dart';
import 'chats_page.dart';
import 'contacts_page.dart';

class WhatsappMain extends StatefulWidget {
  const WhatsappMain({super.key});

  @override
  State<WhatsappMain> createState() => _WhatsappMainState();
}

class _WhatsappMainState extends State<WhatsappMain> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _showMessage = true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    _tabController?.addListener(() {
      _showMessage = _tabController?.index != 1;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = getIt<MainModel>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          shape: const CircularNotchedRectangle(),
          child: Material(
            color: Colors.black,
            child: TabBar(
              indicatorColor: Colors.blue,
              labelColor: Colors.white,
              controller: _tabController,
              tabs: const [
                Tab(
                  text: 'Chats',
                ),
                Tab(text: 'Contact'),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(controller: _tabController, children: <Widget>[ChatsPage(), const ContactsPage()]),
            ),
          ],
        ));
  }
}
