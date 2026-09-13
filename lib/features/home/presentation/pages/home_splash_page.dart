import 'package:flutter/material.dart';
import 'package:jayayudha/core/theme/theme.dart';

class HomeSplashPage extends StatefulWidget {
  const HomeSplashPage({super.key});

  @override
  State<HomeSplashPage> createState() {
    return _HomeSplashPageState();
  }
}

class _HomeSplashPageState extends State<HomeSplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              bottom: AppSize.xl4,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Kurniawan Try Yudha',
                      style: TextStyle(
                        fontSize: AppFont.sm,
                        fontWeight: AppFont.medium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
