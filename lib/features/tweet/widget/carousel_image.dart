import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  final List<String> imagelinks;
  const CarouselImage({super.key, required this.imagelinks});

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _Imageindex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            CarouselSlider(
              items: widget.imagelinks.map((link) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(link, fit: BoxFit.cover),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                  height: 400,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _Imageindex = index;
                    });
                  }),
            ),
            const SizedBox(
              height: 14,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.imagelinks.asMap().entries.map((e) {
                  return Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(
                        _Imageindex == e.key ? 0.9 : 0.4,
                      ),
                    ),
                  );
                }).toList())
          ],
        )
      ],
    );
  }
}
