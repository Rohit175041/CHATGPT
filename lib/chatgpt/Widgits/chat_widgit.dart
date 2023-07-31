import 'package:flutter/cupertino.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intern/chatgpt/Widgits/text_widgit.dart';
import 'package:intern/text_speach/tts.dart';
import '../../firebase/QuesAns.dart';
import '../Service/assets_manager.dart';
import '../constants/constant.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget(
      {super.key,
      required this.ques,
      required this.msg,
      required this.chatIndex,
      this.shouldAnimate = false});
  final dynamic ques;
  final String msg;
  final int chatIndex;
  final bool shouldAnimate;

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

bool spk = false;

class _ChatWidgetState extends State<ChatWidget> {
  Position?position;
  late bool isLoaded;
  @override
  Widget build(BuildContext context) {
    if (widget.ques != widget.msg) {
      // Future.delayed(const Duration(seconds: 4));
      //send data to firebase
      // QuesAns.uploadtofirebase(widget.ques, widget.msg);
    }
    return Column(
      children: [
        Material(
          color: widget.chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  widget.chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: widget.chatIndex == 0
                      ? TextWidget(
                          label: widget.msg,
                        )
                      : widget.shouldAnimate
                          ? DefaultTextStyle(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                              child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      widget.msg.trim(),
                                    ),
                                  ]),
                            )
                          : Text(
                              widget.msg.trim(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                ),
                widget.chatIndex == 0
                    ? const SizedBox.shrink()
                    : Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          //spaek
                          IconButton(
                            onPressed: () async {
                              if (spk == false) {
                                setState(() {
                                  ttsspeach.speak(widget.msg);
                                  spk = true;
                                });
                              } else {
                                ttsspeach.stop();
                                setState(() {
                                  spk = false;
                                });
                              }
                            },
                            icon: Icon(spk ? Icons.mic : Icons.mic_off),
                            color: Colors.white,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
