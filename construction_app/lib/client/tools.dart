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

        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return Column(
          children: [
            for (int i = 0; i < documents.length; i += 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: _buildToolContainer(documents[i]),
                  ),
                  if (i + 1 < documents.length)
                    Expanded(
                      child: _buildToolContainer(documents[i + 1]),
                    ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildToolContainer(QueryDocumentSnapshot document) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final title = data['name'] ?? ''; // Retrieve title from 'name' field
    final price = data['price'] ?? '';
    final imageUrl = data['imageUrl'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 10),
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
            child: ToolsList(),
          ),
        ),
      ),
    );
  }
}
