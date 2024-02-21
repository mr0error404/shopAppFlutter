// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/models/boardingModel.dart';
import 'package:shopapp/modules/login/loginScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingScreen extends StatefulWidget {
  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // const OnBordingScreen({super.key});
  var boardController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
      image: "assets/images/Finances.png",
      title: "Yves Saint Laurent",
      body: "Style is a way to say who you are without having to speak",
    ),
    BoardingModel(
      image: "assets/images/Finances-1.png",
      title: "Giambattista Valli",
      body: "Fashion is like eating, you shouldn't stick to the same menu",
    ),
    BoardingModel(
      image: "assets/images/Finances-2.png",
      title: "Kate Spade",
      body: "I don't do fashion. I am fashion",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            isLast
                ? const Text("")
                : TextButton(
                    onPressed: () {
                      navigateAndFinish(
                        context,
                        LoginScreen(),
                      );
                    },
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                        color: HexColor("#FFBF2F"),
                      ),
                    ),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  physics: const BouncingScrollPhysics(),
                  // reverse: true,
                  // pageSnapping: false,
                  // allowImplicitScrolling: true,
                  // padEnds: false,
                  itemBuilder: (context, index) => buildBoardingItem(
                    boarding[index],
                  ),
                  controller: boardController,
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController, // PageController
                      count: 3,
                      // effect: WormEffect(), // your preferred effect
                      effect: ExpandingDotsEffect(
                        activeDotColor: defaultColor,
                      ),
                      onDotClicked: (index) {}),
                  // AnimatedSmoothIndicator(
                  //   activeIndex: 0,
                  //   count: 6,
                  //   effect: WormEffect(),
                  // ),
                  // const Text(
                  //   "Indictor",
                  // ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        navigateAndFinish(
                          context,
                          LoginScreen(),
                        );
                      } else {
                        boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 900,
                          ),
                          curve: Curves.easeOutCubic,
                        );
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
