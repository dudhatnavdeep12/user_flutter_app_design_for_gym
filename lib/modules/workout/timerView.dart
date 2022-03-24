import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_gym_app/common_widgets/common_widgets.dart';
import 'package:user_gym_app/utility/colors_utility.dart';
import 'dart:math' as math;

import 'package:user_gym_app/utility/screen_size_utility.dart';
import 'package:user_gym_app/utility/text_theme_utility.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key}) : super(key: key);

  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController? controller;

  String get timerString {
    Duration duration = (controller!.duration)! * (controller!.value);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  Widget timerSetsView({String? title, subTitleCount, subTitle}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonHeaderTitle(title: title,fontWeight: 0),
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(text: subTitleCount, style: primary18PxW700),
                TextSpan(
                  text: subTitle,
                  style: primary14PxNormal.apply(color: titleColor)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: commonSearchAppBar(context: context, elevation: 1.0,title: "TimeSet",leadingWidget: InkWell(
        onTap: (){
          Get.back();
        },
        child: const Icon(Icons.arrow_back,color: primaryColor),
      )),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       Container(
      //         // height: 100,
      //         color: secondaryPrimaryColor,
      //         padding: const EdgeInsets.all(10.0),
      //         child: Row(
      //           children: [
      //             Container(
      //               child: Icon(Icons.pause),
      //             )
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: AnimatedBuilder(
          animation: controller!,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child:
                //   Container(
                //     color: Colors.amber,
                //     height:
                //     (controller!.value) * MediaQuery.of(context).size.height,
                //   ),
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    commonVerticalSpacing10(height: 30),
                    commonHeaderTitle(title: "Time Started",fontSize: 1.3,ourFontColor: primaryColor),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          width: getScreenWidth(context) / 2,
                          height: getScreenHeight(context) / 3,
                          child: Align(
                            alignment: FractionalOffset.center,
                            child: AspectRatio(
                              aspectRatio: 1.0,
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Positioned.fill(
                                    child: CustomPaint(
                                        painter: CustomTimerPainter(
                                          animation: controller!,
                                          backgroundColor: Colors.grey,
                                          color: secondaryPrimaryColor,
                                        )),
                                  ),
                                  Align(
                                    alignment: FractionalOffset.center,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          timerString,
                                          style: const TextStyle(
                                              fontSize: 80.0,
                                              color: primaryColor),textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        commonDivider(),
                        timerSetsView(title: "Time Set",subTitleCount: "30",subTitle: " Sec"),
                        commonDivider(),
                        timerSetsView(title: "Time Interval",subTitleCount: "10",subTitle: " Sec"),
                        commonDivider(),
                        timerSetsView(title: "Sound",subTitleCount: "",subTitle: " Beep"),
                        Container(
                          color: secondaryPrimaryColor,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: whiteColor)
                                ),
                                child: const Icon(Icons.pause,color: whiteColor),
                              ),
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: darkPurpleColor
                                ),
                                child: const Icon(Icons.stop,color: whiteColor),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: whiteColor)
                                ),
                                child: const Icon(Icons.sync,color: whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                    // AnimatedBuilder(
                    //     animation: controller!,
                    //     builder: (context, child) {
                    //       return FloatingActionButton.extended(
                    //           onPressed: () {
                    //             if (controller!.isAnimating) {
                    //               controller!.stop();
                    //             } else {
                    //               controller!.reverse(
                    //                   from: controller!.value == 0.0
                    //                       ? 1.0
                    //                       : controller!.value);
                    //             }
                    //           },
                    //           icon: Icon(controller!.isAnimating
                    //               ? Icons.pause
                    //               : Icons.play_arrow),
                    //           label: Text(
                    //               controller!.isAnimating ? "Pause" : "Play"));
                    //     }),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}