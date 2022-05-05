import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';

class MessagesView extends StatefulWidget {
  final String peerId;
  final String peerNickname;
  const MessagesView({
    Key? key,
    required this.peerNickname,
    required this.peerId,
  }) : super(key: key);

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  late String currentUserId;

  List<QueryDocumentSnapshot> listMessages = [];

  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId = '';

  File? imageFile;
  bool isLoading = false;
  bool isShowSticker = false;
  String imageUrl = '';

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  late ChatProvider chatProvider;

  @override
  void initState() {
    super.initState();
    chatProvider = context.read<ChatProvider>();

    focusNode.addListener(onFocusChanged);
    scrollController.addListener(_scrollListener);
    readLocal();
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  void onFocusChanged() {
    if (focusNode.hasFocus) {
      setState(() {
        isShowSticker = false;
      });
    }
  }

  void readLocal() {
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
    if (currentUserId.compareTo(widget.peerId) > 0) {
      groupChatId = '$currentUserId - ${widget.peerId}';
    } else {
      groupChatId = '${widget.peerId} - $currentUserId';
    }
    chatProvider.updateFirestoreData(
        "users", currentUserId, {"feedbackWith": widget.peerId});
  }

  void getSticker() {
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future<bool> onBackPressed() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
      chatProvider
          .updateFirestoreData("users", currentUserId, {"FeedbackWith": null});
    }
    return Future.value(false);
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      textEditingController.clear();
      chatProvider.sendFeedbackMessage(
          content, type, groupChatId, currentUserId, widget.peerId);
      scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Nothing to send")));
    }
  }

  // checking if received message
  bool isMessageReceived(int index) {
    if ((index > 0 && listMessages[index - 1].get("idFrom") == currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  // checking if sent message
  bool isMessageSent(int index) {
    if ((index > 0 && listMessages[index - 1].get("idFrom") != currentUserId) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text('Feedback with  ${widget.peerNickname}'.trim()),
        backgroundColor: Colors.purple,
        centerTitle: true,
    
      ),
       body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              buildListMessage(),
              buildMessageInput(),
            ],
          ),
        ),
      ),
    );
  }
   Widget buildMessageInput() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(30),
            ),

          ),
          Flexible(
              child: TextField(
                focusNode: focusNode,
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                controller: textEditingController,
                decoration:
                const InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onSubmitted: (value) {
                  onSendMessage(textEditingController.text, MessageType.text);
                },
              )),
          Container(
            margin: const EdgeInsets.only(left:4),
            decoration: BoxDecoration(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: () {
                onSendMessage(textEditingController.text, MessageType.text);
              },
              icon: const Icon(Icons.send_rounded),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(int index, DocumentSnapshot? documentSnapshot) {
    if (documentSnapshot != null) {
      FeedbackChat feedbackMessages = FeedbackChat.fromDocument(documentSnapshot);
      if (feedbackMessages.idFrom == currentUserId) {
        // right side (my message)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                feedbackMessages.messageType == MessageType.text
                    ? messageBubble(
                  chatContent: feedbackMessages.messageContent,
                  color: Colors.purple,
                  textColor: Colors.white,
                  margin: const EdgeInsets.only(right: 10),
                )
                    : const SizedBox.shrink(),
                isMessageSent(index)
                    ? Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1597466765990-64ad1c35dafc",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext ctx, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.brown,
                          value: loadingProgress.expectedTotalBytes !=
                              null &&
                              loadingProgress.expectedTotalBytes !=
                                  null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, object, stackTrace) {
                      return const Icon(
                        Icons.account_circle,
                        size: 35,
                        color: Colors.white,
                      );
                    },
                  ),
                )
                    : Container(
                  width: 35,
                ),
              ],
            ),
            isMessageSent(index)
                ? Container(
              margin: const EdgeInsets.only(
                  right: 50,
                  top: 6,
                  bottom: 8),
              child: Text(
                DateFormat('dd MMM yyyy, hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(feedbackMessages.timestamp),
                  ),
                ),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            )
                : const SizedBox.shrink(),
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isMessageReceived(index)
                // left side (received message)
                    ? Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1597466765990-64ad1c35dafc",
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext ctx, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.brown,
                          value: loadingProgress.expectedTotalBytes !=
                              null &&
                              loadingProgress.expectedTotalBytes !=
                                  null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, object, stackTrace) {
                      return const Icon(
                        Icons.account_circle,
                        size: 35,
                        color: Colors.grey,
                      );
                    },
                  ),
                )
                    : Container(
                  width: 35,
                ),
                feedbackMessages.messageType == MessageType.text
                    ? messageBubble(
                  color: Colors.brown,
                  textColor: Colors.white,
                  chatContent:feedbackMessages.messageContent,
                  margin: const EdgeInsets.only(left: 10),
                )

                    : const SizedBox.shrink(),
              ],
            ),
            isMessageReceived(index)
                ? Container(
              margin: const EdgeInsets.only(
                  left: 50,
                  top: 6,
                  bottom: 8),
              child: Text(
                DateFormat('dd MMM yyyy, hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(
                    int.parse(feedbackMessages.timestamp),
                  ),
                ),
                style: const TextStyle(
                    color: Colors.purple,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
            )
                : const SizedBox.shrink(),
          ],
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
          stream: chatProvider.getFeedbackMessage(groupChatId, _limit),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              listMessages = snapshot.data!.docs;
              if (listMessages.isNotEmpty) {
                return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: snapshot.data?.docs.length,
                    reverse: true,
                    controller: scrollController,
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data?.docs[index]));
              } else {
                return const Center(
                  child: Text('No messages...'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.purpleAccent,
                ),
              );
            }
          })
          : const Center(
        child: CircularProgressIndicator(
          color: Colors.purpleAccent,
        ),
      ),
    );
  }
  Widget messageBubble(
      {required String chatContent,
        required EdgeInsetsGeometry? margin,
        Color? color,
        Color? textColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: margin,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        chatContent,
        style: TextStyle(fontSize: 16, color: textColor),
      ),
    );
  }
}


/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({Key? key}) : super(key: key);

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  String? _emailsender, _emailreceiver, _feedback;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
    title:const Text('Feedback'),
      backgroundColor: Colors.purple,
      centerTitle: true,
    ),
      body:Form(
        key: _formkey,
        child: Column(children: <Widget>[
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            validator: (input) {
              if (input == "" ||
                  !RegExp(r'^[A-Za-z0-9]+@([\w-]+\.)+[\w-]{2,}$')
                      .hasMatch(input!)) {
                return 'please type in correct email address';
              }
            },
            onSaved: (input) => _emailsender = input!,
            decoration: InputDecoration(
              labelText: 'YourEmail',
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.purple,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            validator: (input) {
              if (input == "" ||
                  !RegExp(r'^[A-Za-z0-9]+@([\w-]+\.)+[\w-]{2,}$')
                      .hasMatch(input!)) {
                return 'please type in correct email address';
              }
            },
            onSaved: (input) => _emailreceiver = input!,
            decoration: InputDecoration(
              labelText: 'ReceiversEmail',
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.purple,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          TextFormField(
            validator: (input) {
              if (input == "" ||
                  !RegExp(r'^[A-Za-z0-9]{1,100}').hasMatch(input!)) {
                return 'Message must be atleast a character long but not more than 100 characters';
              }
            },
            onSaved: (input) => _feedback = input!,
            decoration: InputDecoration(
              label: Center(child: Text('Feedback')),
                
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 40)
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
            onPressed: sendFeedback,
            child: const Text('Send'),
            style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                minimumSize: const Size(200, 50)),
          ),
        ]
        )
      )
    );
  }

  Future<void> sendFeedback() async {
    final formState = _formkey.currentState;
    if (formState!.validate()) {
      formState.save();
    try {
      await FirebaseFirestore.instance.collection('feedback').doc().set({
        "SenderEmail": _emailsender,
        "ReceiverEmail": _emailreceiver,
        "Message": _feedback,
      });
      if (kDebugMode) {
        print('Sent Feedback');
      }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MessagesView()));
    } catch (e) {
      print(e);
    }
  }
 }
}

*/