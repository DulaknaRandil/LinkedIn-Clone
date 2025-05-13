import 'package:flutter/material.dart';

class LinkedInStackedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback onTap;
  final double height;
  final double width;

  const LinkedInStackedButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    required this.onTap,
    this.height = 36.0,
    this.width = 100.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(height / 2),
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                  width: borderWidth,
                )
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

// Example of a Sign Up button (white with blue border)
class LinkedInSignUpButton extends StatelessWidget {
  final VoidCallback onTap;
  // Exact LinkedIn blue from the image
  static const Color linkedInBlue = Color(0xFF0A66C2);

  const LinkedInSignUpButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 100.0,
        width: 160,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/siginup.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(28.0),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(28.0),
          ),
        ),
      ),
    );
  }
}

// Example of a Log In button (blue with white text)
class LinkedInLoginButton extends StatelessWidget {
  final VoidCallback onTap;
  // Exact LinkedIn blue from the image
  static const Color linkedInBlue = Color(0xFF0A66C2);

  const LinkedInLoginButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 180,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/login.png'),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(28.0),
        ),
      ),
    );
  }
}

class LinkedInButtonGroup extends StatelessWidget {
  final VoidCallback onSignUp;
  final VoidCallback onLogIn;

  const LinkedInButtonGroup({
    Key? key,
    required this.onSignUp,
    required this.onLogIn,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LinkedInSignUpButton(
          onTap: onSignUp,
        ),
        const SizedBox(height: 20),
        LinkedInLoginButton(
          onTap: onLogIn,
        ),
      ],
    );
  }
}
