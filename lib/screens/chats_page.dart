import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../models/conversation.dart';
import '../view_models.dart/chats_model.dart';
import 'conversation_page.dart';

class ChatsPage extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var model = GetIt.instance<ChatsModel>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("My Chats"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () async => await model.signOut(context), icon: const Icon(Icons.logout)),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => model,
        child: StreamBuilder<List<Conversation>>(
          stream: model.conversations(userId),
          builder: (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
            return snapshot.hasData
                ? ListView(
                    children: snapshot.data!
                        .map((doc) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(doc.profileImage),
                              ),
                              title: Text(doc.name),
                              subtitle: Text(doc.displayMessage),
                              trailing: Column(
                                children: <Widget>[
                                  const Text("19:30"),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    margin: const EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Theme.of(context).colorScheme.primary),
                                    child: const Center(
                                      child: Text(
                                        "16",
                                        textScaleFactor: 0.8,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ConversationPage(
                                        userId: userId,
                                        conversation: doc,
                                      ),
                                    ));
                              },
                            ))
                        .toList(),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
