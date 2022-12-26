import 'package:flutter/material.dart';

import '../core/services/locator.dart';
import '../models/profile.dart';
import '../view_models.dart/contacts_model.dart';

String searchText = '';
TextEditingController controllerSearch = TextEditingController();

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
    FocusNode focusNode = FocusNode();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Recently Connected"),
        actions: [
          IconButton(onPressed: () async => await model.signOut(context), icon: const Icon(Icons.logout)),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          final currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            focusNode.unfocus();
          }
        },
        child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/bluebackground.jpg'), fit: BoxFit.cover)),
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          onChanged: (value) => model.updateSearchText(controllerSearch.text),
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          focusNode: focusNode,
                          autofocus: false,
                          controller: controllerSearch,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            hintText: 'Search a contact...',
                            hintStyle: TextStyle(color: Colors.white70),
                            contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Expanded(child: ContactsList()),
              ],
            )),
      ),
    );
  }
}

String? query;

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
    return FutureBuilder(
        future: model.getContacts(),
        builder: ((BuildContext context, AsyncSnapshot<List<Profile>?> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("hata"),
            );
          }

          controllerSearch.addListener(() {
            query = controllerSearch.text;

            if (mounted) {
              setState(() {});
            }
          });

          return snapshot.hasData
              ? ListView(
                  padding: const EdgeInsets.all(4),
                  children: [
                    ...snapshot.data!
                        .where((element) => element.username.contains(query ?? ''))
                        .map(
                          (profile) => ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                backgroundImage: NetworkImage(profile.image),
                              ),
                              title: Text(
                                profile.username,
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: profile.timeStamp
                                          .toDate()
                                          .compareTo(DateTime.now().subtract(const Duration(hours: 1))) ==
                                      1
                                  ? const Text(
                                      "Online",
                                      style: TextStyle(color: Color.fromARGB(255, 145, 246, 148)),
                                    )
                                  : const Text(
                                      "Offline",
                                      style: TextStyle(color: Colors.red),
                                    ),
                              onTap: () async {
                                Future.delayed(const Duration(milliseconds: 500));
                                return model.startConversation(profile);
                              }),
                        )
                        .toList()
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        }));
  }
}
