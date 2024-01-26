import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:hello_world/api/chatgpt_api.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/.env';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Message> _messages = [];

  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage() async {
    Message message = Message(text: _textEditingController.text, isMe: true);

    _textEditingController.clear();

    setState(() {
      _messages.insert(0, message);
    });

    String response = await sendMessageToChatGpt(message.text);

    Message chatGpt = Message(text: response, isMe: false);
    setState(() {
      _messages.insert(0, chatGpt);
    });
  }

  Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 250,
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${APIKey.apikey}",
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse = json.decode(response.body);
        if (parsedResponse.containsKey('choices') &&
            parsedResponse['choices'].isNotEmpty &&
            parsedResponse['choices'][0].containsKey('message')) {
          return parsedResponse['choices'][0]['message']['content'] ??
              "No reply found.";
        } else {
          return "Error: Invalid response format.";
        }
      } else {
        return "Error: ${response.statusCode} - ${response.reasonPhrase}";
      }
    } catch (e) {
      // print("Error sending message to ChatGPT: $e");
      return "Error: Exception during API call.";
    }
  }

  Widget _buildMessage(Message message) {
    // تحديد مسار صورة المتحدث
    String imagePath =
        message.isMe ? 'assets/images/chat.png' : 'assets/images/robot.png';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isMe) // لعرض صورة الـ AI قبل الرسالة
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
            ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(15),
              child: Text(
                message.text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Cario',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (message.isMe) // لعرض صورة المستخدم بعد الرسالة
            const SizedBox(width: 6),
          if (message.isMe)
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
            ),
        ],
      ),
    );
  }

//! KEYBOARD STYLE HERE //!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 169, 223, 255),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 11, 64, 238),
                    Color.fromARGB(255, 169, 223, 255),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Divider(height: 4.0),
            ),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: '..... مرحبا',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onSendMessage,
                    icon: const Icon(
                      Icons.rocket_launch,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;
  Message({required this.text, required this.isMe});
}
