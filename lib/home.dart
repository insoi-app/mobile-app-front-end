import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cabin_gabo.dart';
import 'cabin_duwa.dart';
import 'cabin_saro.dart';

void main() => runApp(const HomeScreen());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 0, 0, 0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            elevation: 0,
            title: const Text(
              'CABINS VIEW',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 0, 0), // Dark color at the top
                Color.fromARGB(255, 0, 0, 0), // Slightly lighter at the bottom
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CarouselWithFullWidth(),
                const SizedBox(height: 20),
                cabinChoiceCard(
                  context,
                  'Cabin Gabo',
                  'Explore the stunning views and relaxation at Cabin Gabo.',
                  'assets/img/cabins11.jpeg',
                  const CabinGaboScreen(),
                ),
                const SizedBox(height: 20),
                cabinChoiceCard(
                  context,
                  'Cabin Duwa',
                  'A peaceful retreat with luxury and comfort at Cabin Duwa.',
                  'assets/img/cabins22.jpeg',
                  const CabinDuwaScreen(),
                ),
                const SizedBox(height: 20),
                cabinChoiceCard(
                  context,
                  'Cabin Saro',
                  'Enjoy the serene surroundings and tranquility at Cabin Saro.',
                  'assets/img/cabins3.jpeg',
                  const CabinSaroScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cabinChoiceCard(
    BuildContext context,
    String title,
    String description,
    String imagePath,
    Widget cabinScreen,
  ) {
    return Card(
      color: const Color.fromARGB(255, 168, 224, 241),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the respective cabin screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => cabinScreen),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Explore',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8), // Space between text and icon
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselWithFullWidth extends StatefulWidget {
  const CarouselWithFullWidth({super.key});

  @override
  CarouselWithFullWidthState createState() => CarouselWithFullWidthState();
}

class CarouselWithFullWidthState extends State<CarouselWithFullWidth> {
  int currentIndex = 0;

  final List<Widget> imageList = [
    Image.asset('assets/img/cabins11.jpeg', fit: BoxFit.cover),
    Image.asset('assets/img/cabins22.jpeg', fit: BoxFit.cover),
    Image.asset('assets/img/cabins3.jpeg', fit: BoxFit.cover),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 400.0, // Set the height of the carousel
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              enlargeFactor: 0.3,
              viewportFraction: 1.0, // This makes the images take up the full width
            ),
            items: imageList,
          ),
        ],
      ),
    );
  }
}
