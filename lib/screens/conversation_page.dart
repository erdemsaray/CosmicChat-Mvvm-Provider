import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../core/services/locator.dart';
import '../models/conversation.dart';
import '../view_models.dart/conversation_model.dart';

class ConversationPage extends StatefulWidget {
  final String userId;
  final Conversation conversation;
  const ConversationPage({super.key, required this.userId, required this.conversation});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  late CollectionReference _ref;
  final TextEditingController _textEditingController = TextEditingController();
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  @override
  void initState() {
    _ref = FirebaseFirestore.instance.collection('conversations/${widget.conversation.id}/messages');
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = getIt<ConversationModel>();
    return ChangeNotifierProvider(
      create: (context) => model,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: -5,
          title: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.conversation.profileImage),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(widget.conversation.name),
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
                child: GestureDetector(
                  onTap: () => _focusNode.unfocus(),
                  child: StreamBuilder(
                      stream: model.getConversation(widget.conversation.id),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? const CircularProgressIndicator()
                            : ListView(
                                controller: _scrollController,
                                children: snapshot.data!.docs
                                    .map(
                                      (document) => ListTile(
                                        title: document['media'] == null || document['media'].isEmpty
                                            ? Container()
                                            : Align(
                                                alignment: Alignment.bottomRight,
                                                child: SizedBox(height: 150, child: Image.network(document['media'])),
                                              ),
                                        subtitle: Align(
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
              ),
              Consumer<ConversationModel>(
                builder: (context, value, child) {
                  return model.mediaUrl.isEmpty
                      ? Container()
                      : SizedBox(
                          width: 200,
                          child: Align(alignment: Alignment.bottomRight, child: Image.network(model.mediaUrl)));
                },
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
                                  focusNode: _focusNode,
                                  controller: _textEditingController,
                                  decoration:
                                      const InputDecoration(border: InputBorder.none, hintText: "Type a message"),
                                ),
                              ),
                              InkWell(
                                child: const Icon(Icons.attach_file),
                                onTap: () async => model.uploadMedia(ImageSource.gallery),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                  onTap: () async => model.uploadMedia(ImageSource.camera),
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
                          await model.add({
                            'senderId': widget.userId,
                            'message': _textEditingController.text,
                            'timeStamp': DateTime.now(),
                            'media': model.mediaUrl
                          }, widget.conversation.id);
                          _scrollController.animateTo(_scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
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
      ),
    );
  }
}
