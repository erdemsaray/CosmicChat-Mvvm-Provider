import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  final String userId;
  final String conversationId;
  const ConversationPage({super.key, required this.userId, required this.conversationId});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late CollectionReference _ref;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    _ref = FirebaseFirestore.instance.collection('conversations/${widget.conversationId}/messages');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        title: Row(
          children: const <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage("https://placekitten.com/200/200"),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text("Conversations Page"),
            ),
          ],
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(onTap: () {}, child: const Icon(Icons.phone)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(onTap: () {}, child: const Icon(Icons.camera)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(onTap: () {}, child: const Icon(Icons.more_vert)),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://placekitten.com/200/200"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: _ref.orderBy('timeStamp').snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const CircularProgressIndicator()
                        : ListView(
                            children: snapshot.data!.docs
                                .map(
                                  (document) => ListTile(
                                    title: Align(
                                        alignment: widget.userId == document['senderId']
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.horizontal(
                                                  left: Radius.circular(10), right: Radius.circular(10)),
                                            ),
                                            child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius: const BorderRadius.horizontal(
                                                          left: Radius.circular(10), right: Radius.circular(10)),
                                                      color: Theme.of(context).colorScheme.primary,
                                                    ),
                                                    child: Text(
                                                      document['message'],
                                                      style: const TextStyle(color: Colors.white),
                                                    ))))),
                                  ),
                                )
                                .toList(),
                          );
                  }),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Container(
                        margin: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.horizontal(left: Radius.circular(25), right: Radius.circular(25))),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Icon(Icons.tag_faces),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _textEditingController,
                                decoration: const InputDecoration(border: InputBorder.none, hintText: "Type a message"),
                              ),
                            ),
                            const InkWell(
                              child: Icon(Icons.attach_file),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ))),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: IconButton(
                      onPressed: () async {
                        _ref.add({
                          'senderId': widget.userId,
                          'message': _textEditingController.text,
                          'timeStamp': DateTime.now(),
                        });
                        _textEditingController.text = '';
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
