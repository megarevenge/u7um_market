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
      'title': 'Explore Mountains',
      'image': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=500',
    },
    {
      'title': 'Deep Oceans',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=500',
    },
    {
      'title': 'Serene Deserts',
      'image': 'https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?w=500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('U7UM market'), 
        centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          
          CarouselSlider(
            options: CarouselOptions(
              height: 100.0,
              enlargeCenterPage: false, // Makes the center card pop out
              autoPlay: true,          // Enables automatic sliding
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
                        image: NetworkImage(data['image']!),
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
                          color: Colors.white,
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
          const SizedBox(height: 16.0),

        ],
      ),
    );
  }
}
