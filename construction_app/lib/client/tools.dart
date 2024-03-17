import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          return const CircularProgressIndicator();
        }

        return Row(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            final data = document.data() as Map<String, dynamic>;
            final title =
                data['name'] ?? ''; // Retrieve title from 'name' field
            final price = data['price'] ?? '';
            final imageUrl = data['imageUrl'] ?? '';
            // Null check for price field
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    imageUrl,
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                  const SizedBox(height: 10), // Add vertical space
                  Text(
                    title,
                    style: const TextStyle(
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
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class Tool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Tools'),
        actions: [
          IconButton(
            icon: Image.asset('lib/images/logoIconBlack.png'),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToolsList(),
                    ToolsList(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToolsList(),
                    ToolsList(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
