import 'package:flutter/material.dart';

import 'core/services/locator.dart';
import 'screens/chats_page.dart';
import 'screens/contacts_page.dart';
import 'view_models.dart/main_model.dart';

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
        floatingActionButton: _showMessage
            ? FloatingActionButton(
                onPressed: () {
                  
                },
                child: const Icon(
                  Icons.message,
                  color: Colors.white,
                ))
            : null,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 10,
          shape: const CircularNotchedRectangle(),
          child: TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.green,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Chats',
              ),
              Tab(text: 'Contact'),
            ],
          ),
        ),
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(controller: _tabController, children: <Widget>[ChatsPage(), const ContactsPage()]),
                ),
              ],
            ),
          ),
        ));
  }
}
