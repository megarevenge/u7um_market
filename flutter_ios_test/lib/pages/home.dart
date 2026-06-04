import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Map<String, String>> cardData = [
    {
      'title': 'Photo 1',
      'image': 'assets/images/pic_placeholder.png',
    },
    {
      'title': 'Photo 2',
      'image': 'assets/images/pic_placeholder.png',
    },
    {
      'title': 'Photo 3',
      'image': 'assets/images/pic_placeholder.png',
    },
  ];

  final List<Map<String, String>> productData = List.generate(10, (index) => {
    'title' : 'Product #${index + 1}',
    'subtitle' : 'See the price',
    'image': 'assets/images/pic_placeholder.png',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('U7UM market'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 100.0,
                enlargeCenterPage: false, // Makes the center card pop out
                autoPlay: true, // Enables automatic sliding
                autoPlayAnimationDuration: const Duration(milliseconds: 100),
                //autoPlayCurve: Curves.linear,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: cardData.map((data) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        image: DecorationImage(
                          image: AssetImage(data['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        // Dark gradient overlay to make text readable
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        padding: const EdgeInsets.all(20.0),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          data['title']!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 24.0),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Our Products',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // GridView
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                shrinkWrap: true, // Crucial inside SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
                itemCount: productData.length, 
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, 
                  crossAxisSpacing: 12, 
                  mainAxisSpacing: 12, 
                  childAspectRatio: 0.72, // Slightly adjusted to prevent any text clipping
                ),
                itemBuilder: (context, index) {
                  final product = productData[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias, // Clips top photo corners to the Card borders
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // The Photo
                        Expanded(
                          child: Image.asset(
                            product['image']!, 
                            width: double.infinity,
                            fit: BoxFit.cover,

                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Container(
                                color: Colors.grey[200], // Background for the fallback area
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.broken_image_outlined, 
                                      color: Colors.grey[500], 
                                      size: 40,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Image unavailable',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        
                        // The Content Area
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Title and Subtitle Stack
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      product['title']!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product['subtitle']!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Action Icon (e.g., Favorite button)
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                visualDensity: VisualDensity.compact, // Makes icon hit-box fit snugly
                                constraints: const BoxConstraints(), 
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  // Action when user favors an item
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24.0), // Bottom padding for comfortable scrolling
          ],
        ),
      ),
    );
  }
}
