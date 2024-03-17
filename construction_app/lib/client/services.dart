import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('services').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: (documents.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              final startIndex = index * 2;
              final endIndex = (index + 1) * 2;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = startIndex;
                      i < endIndex && i < documents.length;
                      i++)
                    Expanded(
                      child: _buildServiceContainer(documents[i]),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildServiceContainer(QueryDocumentSnapshot document) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final title = data['name'] ?? ''; // Retrieve title from 'name' field
    final price = data['price'] ?? ''; // Null check for price field
    final imageUrl = data['imageUrl'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 30),
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
            'Service',
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
  }
}
