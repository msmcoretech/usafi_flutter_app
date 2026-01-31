import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/widgets/app_circle_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(
      message: 'Hello! Jhon abraham',
      time: '09:25 AM',
      isMe: true,
    ),
    ChatMessage(
      message: 'Hello! Nazrul How are you?',
      time: '09:25 AM',
      isMe: false,
    ),
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          message: _controller.text,
          time: _currentTime(),
          isMe: _messages.length%3==0,
        ),
      );
    });

    _controller.clear();
  }

  String _currentTime() {
    final now = TimeOfDay.now();
    return '${now.hourOfPeriod.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.period == DayPeriod.am ? 'AM' : 'PM'}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _appBar(),
      body: Column(
        children: [
          Expanded(child: _chatList()),
          _messageInput(),
          SizedBox(
            height: 04,
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: false,
      title: const Text(
        'Chat',
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: AppColors.secondary),
      ),
      actions: [
        AppCircleButton(profileImage: 'https://i.pravatar.cc/180', onTap: (){
          Navigator.pushNamed(context, AppRoutes.profile,);
        },profileIcon: true,),
        SizedBox(width: 10,),
      ],
    );
  }

  Widget _chatList() {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _messages.length,
      itemBuilder: (_, index) {
        final msg = _messages[index];
        return _animatedBubble(msg, index);
      },
    );
  }

  Widget _animatedBubble(ChatMessage message, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      builder: (_, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 20),
            child: child,
          ),
        );
      },
      child: _chatBubble(message),
    );
  }

  Widget _chatBubble(ChatMessage message) {
    return Align(
      alignment:
      message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 03),
            padding: const EdgeInsets.all(14),
            constraints: const BoxConstraints(maxWidth: 280),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(message.isMe ? 16 : 0),
                topRight: Radius.circular(message.isMe ? 0 : 16),
                bottomLeft:
                Radius.circular( 16),
                bottomRight:
                Radius.circular(16),
              ),
            ),
            child: Text(
              message.message,
              style: message.isMe ?TextStyle(
                color:AppColors.textPrimary,
                fontSize: 14,
              ):TextStyle(
                color:AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Text(
              message.time,
              style:TextStyle(
                fontSize: 11,
                color:AppColors.textSecondary,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _messageInput() {
    return Container(
      color: AppColors.secondary,
      // padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding:
        const EdgeInsets.only(right: 10, top: 8,bottom: 8,left: 0),
        decoration: BoxDecoration(
          color: AppColors.jobHeader,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                style: GoogleFonts.jost(
                  fontSize: 18,fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  hintText: 'Write your message...',
                  filled: true,
                  fillColor: AppColors.jobHeader,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ChatMessage {
  final String message;
  final String time;
  final bool isMe;

  ChatMessage({
    required this.message,
    required this.time,
    required this.isMe,
  });
}
