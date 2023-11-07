import 'package:bood_donate/ui/reusable/text_button.dart';
import 'package:bood_donate/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'sign_in_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends State<IntroScreen> {
  late double widthScale, heightScale;
  int currentPageIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  final list = [
    IntroData(
        'Donate blood, save lives', 'Your contribution can make a world of difference. Donate blood and be the reason someone smiles today', 'assets/images/bd_intro.png'),
    IntroData(
        'Every drop counts.', 'Be a hero, donate blood today. Your blood has the power to save lives. Share a part of you, donate blood.', 'assets/images/blood_bag.png'),
    IntroData('Giving blood is giving life.', 'Join the cause and be someones hero. Be a regular blood donor and impact countless lives.', 'assets/images/intro_drop.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: TextButtonWidget(
                    text: 'Skip',
                    color: Colors.white,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (
                          context) => SignInScreen()));
                    }),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          setState(() {
                            currentPageIndex = value;
                          });
                        },
                        pageSnapping: true,
                        allowImplicitScrolling: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) =>
                            IntroItem(intro:list[currentPageIndex])),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 32.h,bottom: 32.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: <Widget>[
                      for (int i = 0; i <
                          list.length; i++) _pageIndexIndicator(
                          currentPageIndex == i)
                    ],
                  ),
                  // next button
                  SizedBox(
                    // width: 150.w,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: (){
                        if (currentPageIndex < (list.length - 1)) {
                          setState(() {
                            currentPageIndex++;
                          });
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => SignInScreen()));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentColor,
                        shape: currentPageIndex == (list.length - 1) ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r)
                        ) : const CircleBorder(),
                      ),
                      child: currentPageIndex == (list.length - 1) ? Text(
                        'Get started',
                        style: TextStyle(fontSize: 15.w,fontWeight: FontWeight.w600,color: Colors.white),
                      ) : Icon(Icons.arrow_forward,color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pageIndexIndicator(bool isCurrentPage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      height: 10,
      width: isCurrentPage ? 10.w : 10.w,
      decoration: BoxDecoration(
        color: isCurrentPage ? AppColors.accentColor : AppColors.accentColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(10.w)),
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final IntroData intro;

  const IntroItem({super.key, required this.intro});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          intro.img,
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        30.verticalSpace,
        Text(
          intro.title,
          style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.w600,color: AppColors.accentColor),
        ),
        Padding(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 16.h),
          child: Text(
            intro.desc,
            style: TextStyle(fontSize: 14.w,color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class IntroData {
  String title;
  String desc;
  String img;

  IntroData(this.title, this.desc, this.img);
}