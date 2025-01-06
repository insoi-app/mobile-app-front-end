import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobile_app/reservation.dart'; // Assuming the reservation page is correctly defined

void main() {
  runApp(const CabinGaboScreen()); // Start the app with CabinGaboScreen
}

class CabinGaboScreen extends StatelessWidget {
  const CabinGaboScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScaffoldWithCarousel(); // Directly use ScaffoldWithCarousel
  }
}

class ScaffoldWithCarousel extends StatefulWidget {
  const ScaffoldWithCarousel({super.key});

  @override
  ScaffoldWithCarouselState createState() => ScaffoldWithCarouselState();
}

class ScaffoldWithCarouselState extends State<ScaffoldWithCarousel> {
  // List of 10 asset image paths
  List<String> imgList = [
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
    'assets/img/cabins3.jpeg',
  ];

  // Index of the currently displayed image
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color of the screen to black
      appBar: AppBar(
        backgroundColor: Colors.white, // Set app bar background color to white
        title: const Text(
          'CABIN GABO', // Title for the app bar
          style: TextStyle(color: Colors.black), // Set text color to black
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Back icon color
          onPressed: () {
            Navigator.of(context).pop(); // Go back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        // Make the body scrollable
        child: Column(
          children: [
            // Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true, // Auto-play carousel
                enlargeCenterPage: true, // Enlarge the center image
                aspectRatio: 16 / 9, // Aspect ratio of the images
                viewportFraction:
                    1.0, // Make sure the images fill the entire screen width
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index; // Update the index
                  });
                },
              ),
              items: imgList.map((item) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        0), // Rounded corners for better aesthetic
                    child: Image.asset(
                      item,
                      width: MediaQuery.of(context)
                          .size
                          .width, // Full screen width
                      height: double.infinity, // Flexible height
                      fit: BoxFit.cover, // Cover the screen entirely
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // AMENITIES Section (Centered Title)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'CABIN GABO AMENITIES',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white, // White color for the title
                    letterSpacing: 1.2, // Slight spacing between letters
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Updated Amenities Inclusions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInclusionTile(
                    icon: Icons.home,
                    text:
                        'Cabin Saro and Duwa (adjacent cabins) OVERLOOKING VIEW Fully airconditioned',
                  ),
                  _buildInclusionTile(
                    icon: Icons.pool,
                    text: '2 Overflow type pools (4 feet)',
                  ),
                  _buildInclusionTile(
                    icon: Icons.hot_tub,
                    text:
                        '2 Jacuzzi (3 feet) not heated but has a blower for bubble massage',
                  ),
                  _buildInclusionTile(
                    icon: Icons.nature,
                    text: 'Lanai and garden area',
                  ),
                  _buildInclusionTile(
                    icon: Icons.remove_circle_outline,
                    text:
                        'PARTITION in the pool and garden area will be REMOVED',
                  ),
                  _buildInclusionTile(
                    icon: Icons.kitchen,
                    text:
                        'Indoor kitchen with basic cooking & dining wares (additional 200.00 charge for use of gas range)',
                  ),
                  _buildInclusionTile(
                    icon: Icons.bathtub,
                    text: 'Toilet and bath (2)',
                  ),
                  _buildInclusionTile(
                    icon: Icons.shower,
                    text: 'Separate shower area with bathtub (w/heater) (2)',
                  ),
                  _buildInclusionTile(
                    icon: Icons.bed,
                    text:
                        'Four queen beds in the 2nd floor (w/extra mattress if needed)',
                  ),
                  _buildInclusionTile(
                    icon: Icons.bed,
                    text: 'Two double beds in the 3rd floor',
                  ),
                  _buildInclusionTile(
                    icon: Icons.weekend,
                    text:
                        'Two L-Shaped daybed with pullout bed in the ground floor area',
                  ),
                  // New Amenities
                  _buildInclusionTile(
                    icon: Icons.tv,
                    text: '55" SMART TV',
                  ),
                  _buildInclusionTile(
                    icon: Icons.wifi,
                    text: 'Unlimited Wi-Fi Access (Strong signal in the area)',
                  ),
                  _buildInclusionTile(
                    icon: Icons.mic,
                    text: 'Unlimited Videoke Access (No limit on usage)',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Make Reservation Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReservationScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      color: Colors.white, width: 2), // White border
                  padding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 30), // Button height
                ),
                child: const Text(
                  'PROCEED TO RESERVATION',
                  style: TextStyle(
                    color: Colors.white, // White text
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Adding some space below the button
          ],
        ),
      ),
    );
  }

  // Method to build each inclusion item with an icon
  Widget _buildInclusionTile({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white, // Icon color
            size: 28.0, // Icon size
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white, // Text color
              ),
            ),
          ),
        ],
      ),
    );
  }
} 