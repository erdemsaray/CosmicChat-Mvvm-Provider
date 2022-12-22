import 'package:flutter/material.dart';

import '../core/services/locator.dart';
import '../models/profile.dart';
import '../view_models.dart/contacts_model.dart';

String searchText = '';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
    TextEditingController controllerSearch = TextEditingController();
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
                image: DecorationImage(image: AssetImage('assets/darkbackground.jpg'), fit: BoxFit.cover)),
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
                          onChanged: (value) => model.updateSearchText(value),
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
                            hintText: 'Search a connect...',
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

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = getIt<ContactsModel>();
    return FutureBuilder(
        future: model.getContacts(),
        builder: ((BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("hata"),
            );
          }

          return snapshot.hasData
              ? ListView(
                  padding: const EdgeInsets.all(4),
                  children: [
                    ...snapshot.data!
                        .map(
                          (profile) => ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green,
                                backgroundImage: NetworkImage(profile.image),
                              ),
                              title: Text(
                                profile.username,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () => model.startConversation(profile)),
                        )
                        .toList()
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        }));
  }
}
