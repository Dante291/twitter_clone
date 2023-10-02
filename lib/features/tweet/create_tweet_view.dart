import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/asset_constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final currentUSer = ref.watch(currentUserDetailsProvider).value;
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
                        radius: 30,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          onTapOutside: (_) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          controller: tweetTextController,
                          style: const TextStyle(fontSize: 22),
                          decoration: const InputDecoration(
                              hintText: "What's Happening?",
                              hintStyle: TextStyle(
                                  color: Pallete.greyColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                              border: InputBorder.none),
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Pallete.greyColor))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 10, right: 10),
              child: SvgPicture.asset(
                AssetsConstants.galleryIcon,
                height: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 10, right: 10),
              child: SvgPicture.asset(
                AssetsConstants.gifIcon,
                height: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 10, right: 15),
              child: SvgPicture.asset(
                AssetsConstants.emojiIcon,
                height: 35,
              ),
            )
          ],
        ),
      ),
    );
  }
}
