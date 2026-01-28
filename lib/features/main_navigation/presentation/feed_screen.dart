import 'package:flutter/material.dart';
import 'package:usafi_app/app/routes.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/widgets/feed_item_card.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {

  final List<FeedModel> _feeds = [
    FeedModel(
      author: 'Mint People',
      time: '6 hours ago',
      likes: 7,
      avatar:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVBmvQ0vWIbzrOhkQyUhU-iQ2M2NYbm9lnzg&s',
      content: '''
Hi everyone 👋

We’re currently looking for experienced Front of House Supervisors who are interested in working the season games at Etihad Stadium, starting from December.

New accreditations are required to work at the stadium and must be completed by tomorrow, 18th November, so please apply ASAP if you’re interested.

How to apply:
Email your CV to emily.greenwood@mint-people.co.uk

Please ensure your CV highlights your supervisory or management experience.

Kindly title your email “Etihad Supervisor”.

Thank you,
Emily @ MINT
''',
    ),
    FeedModel(
      author: 'Mint People',
      time: '6 hours ago',
      likes: 7,
      avatar:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVBmvQ0vWIbzrOhkQyUhU-iQ2M2NYbm9lnzg&s',
      content: '''
Hi everyone 👋

We’re currently looking for experienced Front of House Supervisors who are interested in working the season games at Etihad Stadium, starting from December.

New accreditations are required to work at the stadium and must be completed by tomorrow, 18th November, so please apply ASAP if you’re interested.

How to apply:
Email your CV to emily.greenwood@mint-people.co.uk

Please ensure your CV highlights your supervisory or management experience.

Kindly title your email “Etihad Supervisor”.

Thank you,
Emily @ MINT
''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: _appBar(),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 16, bottom: 20),
        itemCount: _feeds.length,
        separatorBuilder: (_, __) => const SizedBox(height: 20),
        itemBuilder: (_, index) {
          final feed = _feeds[index];
          return FeedItemCard(
            author: feed.author,
            time: feed.time,
            content: feed.content,
            likes: feed.likes,
            avatar: feed.avatar,
          );
        },
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: false,
      title: const Text(
        'Feeds',
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: AppColors.secondary),
      ),
      actions: [
        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, AppRoutes.profile,);
          },
          child: CircleAvatar(
            backgroundColor: AppColors.circleButton,
            child: Icon(Icons.menu,color: AppColors.secondary,size: 20,),
          ),
        ),SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class FeedModel {
  final String author;
  final String time;
  final String content;
  final int likes;
  final String avatar;

  FeedModel({
    required this.author,
    required this.time,
    required this.content,
    required this.likes,
    required this.avatar,
  });
}

