import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/chat_provider.dart';
import 'package:healthful/View/Screens/AppScreens/message_screen.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> imgs = [
    "assets/doctor_1.png",
    "assets/doctor.png",
    "assets/doctor_3.png",
    "assets/doctor_4.png",
    "assets/doctor_1.png",
    "assets/doctor.png",
    "assets/doctor_3.png",
    "assets/doctor_4.png",
  ];
  @override
  void initState() {
    super.initState();
    // fetchAppointments(); // Call the method to fetch appointments
  }

  // Future<void> fetchAppointments() async {
  //   final snapshot = await FirebaseFirestore.instance.collection('chats').get();
  //   final chatIds = snapshot.docs.map((doc) => doc.id).toList();
  //   print('chats ids $chatIds');
  //   Provider.of<ChatProvider>(context, listen: false).fetchAppointments(chatIds);
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Inbox",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Consumer<ChatProvider>(
                      builder: (context, chatProvider, _) => TextFormField(
                        onChanged: (value) {
                          chatProvider.searchQuery = value;
                        },
                        decoration: const InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )),
                  const Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 133, 41, 41),
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 20),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: Text(
          //     "Active Now",
          //     style: TextStyle(
          //       fontSize: 20,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 10),
          // SizedBox(
          //   height: 90,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     physics: const BouncingScrollPhysics(),
          //     itemCount: imgs.length, // Corrected itemCount
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) {
          //       return Container(
          //         margin: const EdgeInsets.symmetric(horizontal: 12),
          //         width: 65,
          //         height: 65,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           shape: BoxShape.circle,
          //           boxShadow: <BoxShadow>[
          //             BoxShadow(
          //               offset: const Offset(4, 4),
          //               blurRadius: 10,
          //               spreadRadius: 2,
          //               color: LightColor.grey.withOpacity(.2),
          //             ),
          //             BoxShadow(
          //               offset: const Offset(-3, 0),
          //               blurRadius: 10,
          //               spreadRadius: 2,
          //               color: LightColor.grey.withOpacity(.1),
          //             )
          //           ],
          //         ),
          //         child: Stack(
          //           textDirection: TextDirection.rtl,
          //           children: [
          //             Center(
          //               child: Container(
          //                 height: 65,
          //                 width: 65,
          //                 child: ClipRRect(
          //                   borderRadius: BorderRadius.circular(30),
          //                   child: Image.asset(
          //                     "${imgs[index]}",
          //                     fit: BoxFit.cover,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Positioned(
          //               // Corrected positioning
          //               right: 3,
          //               top: 6,
          //               child: Container(
          //                 height: 14,
          //                 width: 14,
          //                 decoration: const BoxDecoration(
          //                   color: Colors.white,
          //                   shape: BoxShape.circle,
          //                 ),
          //                 child: Container(
          //                   height: 12,
          //                   width: 12,
          //                   decoration: const BoxDecoration(
          //                     color: Colors.green,
          //                     shape: BoxShape.circle,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //   ),
          // ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Recent Chat",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('chats').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: SizedBox(
                        child: CircularProgressIndicator(
                  color: LightColor.marron,
                ))); // Display a loading indicator while data is being
                // fetched.
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No Chat found'),
                );
              }
              final chatIds = snapshot.data!.docs.map((doc) => doc.id).toList();

              // Fetch appointments using the chatIds
              Provider.of<ChatProvider>(context, listen: false).fetchChats(chatIds);

              return Consumer<ChatProvider>(builder: (context, appointmentProvider, _) {
                final chats = appointmentProvider.chats;

                if (appointmentProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: LightColor.marron,
                    ),
                  );
                }
                print('Chat array length ${chats.length}');
                // Display appointments in the UI
                return appointmentProvider.searchQuery.isEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: chats.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: const Offset(4, 4),
                                  blurRadius: 10,
                                  color: LightColor.grey.withOpacity(.2),
                                ),
                                BoxShadow(
                                  offset: const Offset(-3, 0),
                                  blurRadius: 15,
                                  color: LightColor.grey.withOpacity(.1),
                                )
                              ],
                            ),
                            child: ListTile(
                              minVerticalPadding: 10,
                              onTap: () {
                                nextScreen(
                                    context,
                                    MessagesScreen(
                                      doctorId: chats[index].doctorId.toString(),
                                      doctorName: chats[index].doctorName.toString(),
                                      doctorImage: chats[index].photoUrl.toString(),
                                      doctorPhone: chats[index].phone.toString(),
                                      appointmentId: chats[index].appointmentId.toString(),
                                    ));
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  chats[index].photoUrl.toString(),
                                ),
                              ),
                              title: Text(
                                chats[index].doctorName.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                chats[index].lastMessage.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              trailing: Text(
                                chats[index].lastMessageTime.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: appointmentProvider.filteredChats.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final chat = appointmentProvider.filteredChats[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  offset: const Offset(4, 4),
                                  blurRadius: 10,
                                  color: LightColor.grey.withOpacity(.2),
                                ),
                                BoxShadow(
                                  offset: const Offset(-3, 0),
                                  blurRadius: 15,
                                  color: LightColor.grey.withOpacity(.1),
                                )
                              ],
                            ),
                            child: ListTile(
                              minVerticalPadding: 10,
                              onTap: () {
                                nextScreen(
                                    context,
                                    MessagesScreen(
                                      doctorId: chat.doctorId.toString(),
                                      doctorName: chat.doctorName.toString(),
                                      doctorImage: chat.photoUrl.toString(),
                                      doctorPhone: chat.phone.toString(),
                                      appointmentId: chat.appointmentId.toString(),
                                    ));
                              },
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  chat.photoUrl.toString(),
                                ),
                              ),
                              title: Text(
                                chat.doctorName.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                chat.lastMessage.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              trailing: Text(
                                chat.lastMessageTime.toString(),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          );
                        },
                      );
              });
            },
          ),
        ],
      ),
    );
  }
}
