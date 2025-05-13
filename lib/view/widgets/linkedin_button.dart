// LinkedIn branded button styles as per the design
import 'package:flutter/material.dart';

class LinkedInButtonStyle {
  // LinkedIn blue color - exact match from the image
  static const Color linkedInBlue = Color(0xFF0A66C2);
  static const Color linkedInWhite = Colors.white;

  // Button height and width as per specs
  static const double buttonHeight = 36.0;
  static const double loginButtonWidth = 100.0;
  static const double signupButtonWidth = 100.0;

  // Text styles for buttons
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // The exact shape seen in the image - a Stadium Border
  // This creates the pill-shaped rounded rectangle with equal radius on all sides
  static final StadiumBorder stadiumBorder = StadiumBorder(
    side: BorderSide.none,
  );

  static final StadiumBorder stadiumBorderWithOutline = StadiumBorder(
    side: const BorderSide(color: linkedInBlue, width: 1),
  );

  // Primary button - blue background with white text (Log In)
  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: linkedInBlue,
    foregroundColor: linkedInWhite,
    minimumSize: const Size(loginButtonWidth, buttonHeight),
    padding: const EdgeInsets.symmetric(horizontal: 7),
    elevation: 0,
    textStyle: buttonTextStyle,
  );

  // Secondary button - white background with blue text and blue border (Sign Up)
  static ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: linkedInWhite,
    foregroundColor: linkedInBlue,
    minimumSize: const Size(signupButtonWidth, buttonHeight),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: stadiumBorderWithOutline,
    elevation: 0,
    textStyle: buttonTextStyle,
  );
}

// Pre-styled button widgets that use the LinkedIn style
class LinkedInPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LinkedInPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: LinkedInButtonStyle.primaryButton,
      child: Text(text),
    );
  }
}

class LinkedInSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LinkedInSecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: LinkedInButtonStyle.secondaryButton,
      child: Text(text),
    );
  }
}
