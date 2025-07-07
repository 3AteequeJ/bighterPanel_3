import 'package:bighter_panel/Admin/Cards/docProducts_card.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:flutter/material.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class DocProductsScreen extends StatefulWidget {
  const DocProductsScreen({super.key});

  @override
  State<DocProductsScreen> createState() => _DocProductsScreenState();
}

class _DocProductsScreenState extends State<DocProductsScreen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final isWide = currentWidth > 600;
    final products = glb.Models.docProducts_lst.where((product) {
      final docName = glb.Models.AllDocs_lst
          .firstWhere(
            (doc) => doc.ID == product.doc_id,
            orElse: () => glb.Models.AllDocs_lst.isNotEmpty
                ? glb.Models.AllDocs_lst[0]
                : AllDoc_model(
                    ID: '',
                    branch_doc: '',
                    name: '',
                    mobno: '',
                    mail: '',
                    pswd: '',
                    img: '',
                    speciality: '',
                    Degree: '',
                    clinicID: '',
                    available: '',
                    rating: '',
                    verified: '',
                    idImg: '',
                    CertImg: '',
                    CouncilCertImg: '',
                    img2: '',
                    img3: '',
                    img4: '',
                    img5: '',
                  ), // Provide a default AllDoc_model instance
          )
          .name
          .toLowerCase();
      return product.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          docName.contains(searchQuery.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search products or doctors...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: isWide
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        DocProductsCard(product: products[index]),
                  )
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        DocProductsCard(product: products[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
