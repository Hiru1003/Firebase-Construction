import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sealtech/client/chat.dart';
import 'package:sealtech/client/chemicals.dart';
import 'package:sealtech/client/services.dart';
import 'package:sealtech/client/tools.dart';
import 'package:sealtech/components/button.dart';
import 'package:sealtech/components/theme.dart';

class Category extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text('Category'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset('lib/images/logoIconBlack.png'),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 18,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Service()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                'lib/images/catServiceImage.png',
                                height: 287,
                                width: 180,
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Services',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'Contact SEALTECH\nfor unbeatable\nwaterproofing solutions',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                    Button(
                                      buttonText: 'Contact Us',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Chat()),
                                        );
                                      },
                                      width: 150,
                                      isStroked: true,
                                      color: 'white',
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Tool()),
                            );
                          },
                          child: Container(
                            height: 130,
                            width: 180,
                            child: Stack(
                              children: [
                                Image.asset(
                                  'lib/images/catToolsImage.png',
                                  fit: BoxFit.cover,
                                ),
                                const Positioned(
                                  bottom: 16,
                                  left: 16,
                                  child: Text(
                                    'Tools',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chemical()),
                            );
                          },
                          child: Stack(
                            children: [
                              Image.asset(
                                'lib/images/catChemicalsImage.png',
                                height: 130,
                                width: 180,
                              ),
                              const Positioned(
                                bottom: 16,
                                left: 16,
                                child: Text(
                                  'Chemicals',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('Service',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                ),
                const SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 6),
                  child: ServicesList(),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('Tools',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                ),
                SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 6),
                  child: ToolsList(),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text('Chemicals',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor)),
                ),
                SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 6),
                  child: ChemicalsList(),
                ),
              ],
            ),
          ),
        ),
      );
}

class ServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('services').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Row(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data() as Map<String, dynamic>;
            final title =
                data['name'] ?? ''; // Retrieve title from 'name' field
            final price = data['price'] ?? ''; // Null check for price field
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/images/pro1.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 10), // Add vertical space
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Service',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class ToolsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tools').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Row(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data() as Map<String, dynamic>;
            final title =
                data['name'] ?? ''; // Retrieve title from 'name' field
            final price = data['price'] ?? ''; // Null check for price field
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/images/pro1.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 10), // Add vertical space
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Tool',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class ChemicalsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chemicals').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Row(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data() as Map<String, dynamic>;
            final title =
                data['name'] ?? ''; // Retrieve title from 'name' field
            final price = data['price'] ?? ''; // Null check for price field
            return ProductPage(
              imagePath: 'lib/images/pro1.png',
              title: title,
              subtitle: 'Chemical',
              price: price,
            );
          }).toList(),
        );
      },
    );
  }
}

class ProductPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;

  const ProductPage({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle onTap
      },
      child: Container(
        width: 180,
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 130,
              width: 180,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(subtitle),
                  Text(price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
