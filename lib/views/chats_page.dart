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
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("My Chats"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/blackbackground.jpg'), fit: BoxFit.cover)),
        child: ChangeNotifierProvider(
          create: (BuildContext context) => model,
          child: StreamBuilder<List<Conversation>>(
            stream: model.conversations(userId),
            builder: (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
              return snapshot.hasData
                  ? ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            
                          } //model.goContactPage()
                          ,
                          leading: const CircleAvatar(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.chat),
                          ),
                          title: const Text(
                            "Start a New Chat",
                            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),
                        ...snapshot.data!
                            .map((doc) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(doc.profileImage),
                                  ),
                                  title: Text(
                                    doc.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    doc.displayMessage,
                                    style: const TextStyle(color: Colors.white70),
                                  ),
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
                      ],
                    )
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
