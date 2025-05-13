import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/landing_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      final viewModel = Provider.of<LandingViewModel>(context, listen: false);
      viewModel.navigateToWelcome();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/174/174857.png',
              height: 100,
            ),
            const SizedBox(height: 24),
            const Text(
              'LinkedIn Clone',
              style: TextStyle(
                color: Color(0xFF0077B5),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
