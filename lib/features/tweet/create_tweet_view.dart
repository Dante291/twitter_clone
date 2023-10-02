import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/asset_constants.dart';
import 'package:twitter_clone/core/utils.dart';
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
  int _currentImageIndex = 0;

  List<File> images = [];
  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void onpickImages() async {
    final List<File> selectedImages = await pickImage();
    if (selectedImages.isNotEmpty) {
      images = selectedImages;
      setState(() {});
    }
  }

  void _removeCurrentImage() {
    setState(() {
      images.removeAt(_currentImageIndex);
      if (_currentImageIndex >= images.length && _currentImageIndex > 0) {
        _currentImageIndex--;
      }
    });
  }

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
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
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
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (images.isNotEmpty)
                    CarouselSlider(
                      items: images.map((file) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Stack(
                            children: <Widget>[
                              Image.file(file, fit: BoxFit.cover),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(50)),
                                  child: IconButton(
                                    icon: const Icon(Icons.close,
                                        size: 25, color: Colors.white),
                                    onPressed: _removeCurrentImage,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                          height: 400,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          }),
                    )
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
              child: GestureDetector(
                onTap: onpickImages,
                child: SvgPicture.asset(
                  AssetsConstants.galleryIcon,
                  height: 35,
                ),
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
