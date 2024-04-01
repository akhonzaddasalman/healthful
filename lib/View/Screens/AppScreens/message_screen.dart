import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:healthful/Controller/Functions/make_phone_call.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/Controller/Provider/chat_provider.dart';
import 'package:healthful/View/Utils/snack_bar.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String doctorImage;
  final String doctorPhone;
  final String appointmentId;
  const MessagesScreen(
      {super.key,
      required this.doctorId,
      required this.doctorName,
      required this.doctorImage,
      required this.doctorPhone,
      required this.appointmentId});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController chatController = TextEditingController();

  AuthProvider? authProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final chatProvider = context.read<ChatProvider>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 133, 41, 41),
          leadingWidth: 30,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_outlined,
              size: 27,
              color: LightColor.white,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    widget.doctorImage.toString(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.doctorName.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 30),
              child: const Icon(
                Icons.call,
                color: Colors.white,
                size: 26,
              ).ripple(
                () {
                  print('phone number is ${widget.doctorPhone}');
                  callNumber(widget.doctorPhone.toString());
                },
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 8, right: 10),
            //   child: Icon(
            //     Icons.video_call,
            //     color: Colors.white,
            //     size: 30,
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 8, right: 10),
            //   child: Icon(
            //     Icons.more_vert,
            //     color: Colors.white,
            //     size: 26,
            //   ),
            // ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.appointmentId.toString())
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                print(snapshot.toString());
                if (snapshot.connectionState == ConnectionState.done) {
                  return const Center(
                      child: SizedBox(
                          height: 70,
                          width: 70,
                          child: CircularProgressIndicator(
                            color: LightColor.marron,
                          ))); // Display a loading indicator while data is being
                  // fetched.
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty ?? true) {
                  return const Center(
                    child: Text('No messages found'),
                  );
                }
                final List<Message> messages = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return Message.fromJson(data); // Assuming Chat.fromJson is correct
                }).toList();
                return Container(
                  padding: EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSender = message.senderId == authProvider.uid.toString();

                      return !isSender
                          ? Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(right: 80),
                              child: ClipPath(
                                clipper: UpperNipMessageClipper(MessageType.receive),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 25, right: 20),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE1E1E2),
                                  ),
                                  child: Text(
                                    message.message,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(top: 10, left: 80),
                              child: ClipPath(
                                clipper: LowerNipMessageClipper(MessageType.send),
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20, top: 10, bottom: 25, right: 20),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 133, 41, 41),
                                  ),
                                  child: Text(
                                    message.message,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  ),
                );
              },
            ),
          )),
        ],
      ),
      bottomSheet: Container(
        height: 65,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            // const Padding(
            //   padding: EdgeInsets.only(left: 8),
            //   child: Icon(
            //     Icons.add,
            //     size: 30,
            //   ),
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 5),
            //   child: Icon(
            //     Icons.emoji_emotions_outlined,
            //     color: Colors.amber,
            //     size: 30,
            //   ),
            // ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width / 1.6,
                child: TextFormField(
                  controller: chatController,
                  decoration: const InputDecoration(
                    hintText: "Type Something",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () async {
                  await chatProvider
                      .sendMessage(widget.appointmentId, authProvider.uid.toString(), widget.doctorId, chatController.text)
                      .then((value) async {
                    if (value) {
                      chatController.clear();
                    } else {
                      openSnackBar(context, "Something went wrong! Please try again", Colors.redAccent);
                    }
                  });
                },
                child: const Icon(
                  Icons.send,
                  size: 30,
                  color: Color.fromARGB(255, 133, 41, 41),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
