import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegistrationSuccessScreen extends StatelessWidget {
  const RegistrationSuccessScreen({super.key});

  void _navigateToLogin(BuildContext context) {
    // Navigate to LoginScreen directly without routes
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background container with gradient
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 49, 48, 48),
                  Color.fromARGB(255, 0, 0, 0),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Registration\nSuccessful!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Main container for the success content
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: ClipPath(
              clipper:
                  SymmetricWaveClipper(), // Custom clipper for symmetric wavy design
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      // Image (e.g., checked icon)
                      Image.asset(
                        'assets/img/checked.png', // Path to your checked image
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 20),

                      // "Registration Success" Text
                      const Text(
                        'Registration Success!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Congratulatory message
                      const Text(
                        'Congratulations! Your account has been\n successfully registered.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Proceed to Login Button
                      GestureDetector(
                        onTap: () => _navigateToLogin(context),
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 49, 48, 48),
                                Color.fromARGB(255, 0, 0, 0),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Proceed to Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SymmetricWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0); // Start at the top-left
    path.lineTo(0, size.height - 20); // Bottom-left corner

    // Create symmetric waves with more frequency
    double waveHeight = 20; // Control wave height (amplitude)
    double waveWidth =
        size.width / 6; // Control the width (more waves, increase this value)

    // First wave
    path.quadraticBezierTo(
      waveWidth / 2, size.height - waveHeight, // Control point for first wave
      waveWidth, size.height, // Peak of first wave
    );
    // Second wave
    path.quadraticBezierTo(
      waveWidth * 1.5,
      size.height + waveHeight, // Control point for second wave
      waveWidth * 2, size.height, // Peak of second wave
    );
    // Third wave
    path.quadraticBezierTo(
      waveWidth * 2.5, size.height - waveHeight, // Control point for third wave
      waveWidth * 3, size.height, // Peak of third wave
    );
    // Fourth wave
    path.quadraticBezierTo(
      waveWidth * 3.5,
      size.height + waveHeight, // Control point for fourth wave
      waveWidth * 4, size.height, // Peak of fourth wave
    );
    // Fifth wave
    path.quadraticBezierTo(
      waveWidth * 4.5, size.height - waveHeight, // Control point for fifth wave
      waveWidth * 5, size.height, // Peak of fifth wave
    );
    // Sixth wave
    path.quadraticBezierTo(
      waveWidth * 5.5, size.height + waveHeight, // Control point for sixth wave
      waveWidth * 6, size.height, // Peak of sixth wave
    );

    // Bottom-right corner
    path.lineTo(size.width, size.height - 20);
    path.lineTo(size.width, 0); // Top-right corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
