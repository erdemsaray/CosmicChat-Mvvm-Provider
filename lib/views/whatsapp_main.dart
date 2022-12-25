import 'package:flutter/material.dart';

import 'chats_page.dart';
import 'contacts_page.dart';

class WhatsappMain extends StatefulWidget {
  int initialIndex;
  WhatsappMain({super.key, this.initialIndex = 0});

  @override
  State<WhatsappMain> createState() => _WhatsappMainState();
}

class _WhatsappMainState extends State<WhatsappMain> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
                Tab(text: 'Contacts'),
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
