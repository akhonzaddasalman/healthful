import 'package:flutter/material.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/widgets/chat_sample.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 133, 41, 41),
          leadingWidth: 30,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_outlined,
              size: 27,
              color: LightColor.white,
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(
                    "assets/doctor.png",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Dr. John",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // actions: [
          //   const Padding(
          //     padding: EdgeInsets.only(top: 8, right: 15),
          //     child: Icon(
          //       Icons.call,
          //       color: Colors.white,
          //       size: 26,
          //     ),
          //   ),
          //   const Padding(
          //     padding: EdgeInsets.only(top: 8, right: 10),
          //     child: Icon(
          //       Icons.video_call,
          //       color: Colors.white,
          //       size: 30,
          //     ),
          //   ),
          //   const Padding(
          //     padding: EdgeInsets.only(top: 8, right: 10),
          //     child: Icon(
          //       Icons.more_vert,
          //       color: Colors.white,
          //       size: 26,
          //     ),
          //   ),
          // ],
        ),
      ),
      body: ListView.builder(
        itemCount: 6,
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 80),
        itemBuilder: (context, index) => const ChatSample(),
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
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width / 1.6,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Type Something",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.send,
                size: 30,
                color: Color.fromARGB(255, 133, 41, 41),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
