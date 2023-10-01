import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUSer = ref.watch(currentUserDetailsProvider).value;
    print('2 ' + currentUSer.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              size: 30,
            )),
        actions: [
          RoundedSmallButton(
            onTap: () {},
            label: 'Tweet',
            textColor: Colors.white,
            backgroundColor: Pallete.blueColor,
          )
        ],
      ),
      body: currentUSer == null
          ? const loader()
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(currentUSer.profilePic),
                      )
                    ],
                  )
                ],
              ),
            )),
    );
  }
}
