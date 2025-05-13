import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../routing/navigation_service.dart';
import '../widgets/stacked_button.dart';
import '../widgets/linkedin_button.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Linked",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0077B5),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Color(0xFF0077B5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            "in",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 180),
                  Center(
                    child: SvgPicture.asset(
                      'assets/images/Designer-_Two-Color.svg',
                      height: 220,
                      fit: BoxFit.contain,
                      placeholderBuilder: (BuildContext context) => SizedBox(
                        height: 220,
                        width: 220,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF0A66C2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0077B5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_right_alt_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Land your Job',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Connect, Apply and Get Hired with your\nfavorite job around the world',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 16,
                            height: 3,
                            decoration: BoxDecoration(
                              color: Color(0xFF0077B5),
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 3,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 6,
                            height: 3,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 16.0),
                    child: LinkedInButtonGroup(
                      onSignUp: () {
                        NavigationService().toSignup();
                      },
                      onLogIn: () {
                        NavigationService().toLogin();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
