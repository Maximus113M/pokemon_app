import 'package:flutter/material.dart';

import 'package:pokemon_app/core/util/app_assests.dart';
import 'package:pokemon_app/core/util/screen_size.dart';
import 'package:pokemon_app/features/sign_in/display/providers/sign_in_provider.dart';

import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SignInProvider>().checkAuthenticated(context);
    ScreenSize.init(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAssets.loadingLottie,
            ],
          ),
        ),
      ),
    );
  }
}
