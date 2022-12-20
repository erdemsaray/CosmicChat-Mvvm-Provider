import 'package:flutter/material.dart';

import 'core/services/locator.dart';
import 'screens/calls_page.dart';
import 'screens/chats_page.dart';
import 'screens/contacts_page.dart';
import 'screens/status_page.dart';
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
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
    _tabController?.addListener(() {
      _showMessage = _tabController?.index != 0;
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
                onPressed: () async {
                  await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ContactsPage(),
                  ));
                  ;
                },
                child: const Icon(
                  Icons.message,
                  color: Colors.white,
                ))
            : null,
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(
            child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      actions: <Widget>[
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                      ],
                      floating: true,
                      title: Text("Whatsapp Clone"),
                    )
                  ];
                },
                body: Column(
                  children: [
                    TabBar(controller: _tabController, tabs: const <Widget>[
                      Tab(
                        icon: Icon(Icons.camera),
                      ),
                      Tab(
                        text: "Chats",
                      ),
                      Tab(
                        text: "Status",
                      ),
                      Tab(
                        text: "Calls",
                      ),
                    ]),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: TabBarView(
                            controller: _tabController,
                            children: const <Widget>[CallsPage(), ChatsPage(), StatusPage(), CallsPage()]),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
