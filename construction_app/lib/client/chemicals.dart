import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sealtech/client/cardToolChemicals.dart';
import 'package:sealtech/client/product.dart';

class Chemical extends StatelessWidget {
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
        title: Text('Chemicals'),
        actions: [
          IconButton(
            icon: Image.asset('lib/images/logoIconBlack.png'),
            onPressed: () {},
          ),
        ],
      ),
      body: _buildChemicalList(context),
    );
  }

  Widget _buildChemicalList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chemicals').snapshots(),
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

        final List<DocumentSnapshot> documents = snapshot.data!.docs;

        return SingleChildScrollView(
          child: Column(
            children: [
              for (int i = 0; i < documents.length; i += 2)
                _buildChemicalRow(context, documents, i),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChemicalRow(
      BuildContext context, List<DocumentSnapshot> documents, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ToolsChemCard()),
            );
          },
          child: _buildChemicalContainer(documents[index]),
        ),
        if (index + 1 < documents.length)
          _buildChemicalContainer(documents[index + 1]),
      ],
    );
  }

  Widget _buildChemicalContainer(DocumentSnapshot document) {
    final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    final title = data['name'] ?? '';
    final price = data['price'] ?? '';
    final imageUrl = data['imageUrl'] ?? '';

    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10),
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
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Chemical',
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
