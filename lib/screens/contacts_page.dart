import 'package:flutter/material.dart';

import '../core/services/locator.dart';
import '../models/profile.dart';
import '../view_models.dart/contacts_model.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recently Connected"),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: ContactSearchDelegate());
              },
              icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Container(color: Colors.amber, child: const ContactsList()),
    );
  }
}

class ContactsList extends StatelessWidget {
  final String? query;
  const ContactsList({Key? key, this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
    return FutureBuilder(
        future: model.getContacts(query),
        builder: ((BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("hata"),
            );
          }

          return snapshot.hasData
              ? ListView(
                  children: [
                    ...snapshot.data!
                        .map(
                          (profile) => ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green,
                                backgroundImage: NetworkImage(profile.image),
                              ),
                              title: Text(profile.username),
                              onTap: () => model.startConversation(profile)),
                        )
                        .toList()
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        }));
  }
}

class ContactSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);

    return theme.copyWith(
        primaryColor: const Color(0xff075e54),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        hintColor: Colors.white70);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ContactsList(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text("Start searching"),
    );
  }
}
