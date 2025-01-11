import 'package:flutter/material.dart';
import 'cabin_service.dart';
import 'cabin_model.dart';

class SaroScreen extends StatefulWidget {
  const SaroScreen({super.key});

  @override
  SaroScreenState createState() => SaroScreenState();
}

class SaroScreenState extends State<SaroScreen> {
  late Future<List<Cabin>> futureCabins;

  @override
  void initState() {
    super.initState();
    futureCabins = CabinService().fetchCabins(); // Fetch cabin data using CabinService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Cabin Saro',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () {
              // Add action for info
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Cabin>>(
        future: futureCabins,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Cabin> cabins = snapshot.data!;

            // Filter cabins to only include the one with name 'Cabin Saro'
            List<Cabin> saroCabins = cabins.where((cabin) => cabin.name == 'Saro').toList();

            if (saroCabins.isEmpty) {
              return const Center(child: Text('No Cabin Saro available'));
            }

            return ListView.builder(
              itemCount: saroCabins.length,
              itemBuilder: (context, index) {
                Cabin cabin = saroCabins[index];
                return Card(
                  margin: const EdgeInsets.all(16.0), // Increased margin for better spacing
                  elevation: 10.0, // More elevation for better card depth
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0), // Rounded corners for the card
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the image at the top, covering the full width
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                        child: Image.network(
                          cabin.image,
                          width: double.infinity,
                          height: 250, // Increased height for the image
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cabin Name
                            Text(
                              cabin.name,
                              style: const TextStyle(
                                fontSize: 28, // Increased size for cabin name
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            // Description Section with Styled Container
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100, // Light background for description
                                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8.0,
                                    offset: Offset(0, 2), // Soft shadow effect
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Description:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    cabin.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.5, // Increased line height for better readability
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            // Cabin Amenities Header
                            const Text(
                              'Amenities:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8.0),

                            // Display the amenities in a grid or list style
                            Wrap(
                              spacing: 8.0, // Horizontal space between items
                              runSpacing: 8.0, // Vertical space between items
                              children: cabin.amenity.map((item) {
                                return Chip(
                                  label: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 12, // Slightly increased text size
                                    ),
                                  ),
                                  backgroundColor: Colors.blue.shade50, // Light blue background for chips
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  labelStyle: const TextStyle(color: Colors.black87),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 20.0),
                            // Button for booking or further actions with gradient
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your booking or further action logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12), backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ), // Button color
                                  side: const BorderSide(color: Colors.white, width: 2),
                                ),
                                child: const Text(
                                  'Book Now',
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No cabins available'));
          }
        },
      ),
    );
  }
}
