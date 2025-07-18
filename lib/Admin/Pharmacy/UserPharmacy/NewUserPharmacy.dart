import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:bighter_panel/Admin/Cards/products_card.dart';
import 'package:bighter_panel/Admin/Models/myProducts.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

class newUserPharmacy extends StatefulWidget {
  @override
  _newUserPharmacyState createState() => _newUserPharmacyState();
}

enum SingingCharacter { User, Doctor }

class _newUserPharmacyState extends State<newUserPharmacy> {
  final prodNM_cont = TextEditingController();
  final price_cont = TextEditingController();
  final desc_cont = TextEditingController();
  final searchController = TextEditingController();

  SingingCharacter? _character = SingingCharacter.User;
  String img1 = "", img2 = "", img3 = "", img4 = "", img5 = "";
  String dropDown_value = "All";
  final List<String> list = ['All', 'User', 'Doctor'];

  List<myProducts_model> admin_user_prod_list = [];
  List<myProducts_model> admin_doc_prod_list = [];

  bool showAddProduct = true;

  @override
  void initState() {
    super.initState();
    fetchAndSetProducts();
  }

  Future<void> fetchAndSetProducts() async {
    try {
      final products = await fetchProducts();
      setState(() {
        glb.Models.adminProducts_lst = products;
        seperateList(products);
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  List<myProducts_model> seperateList(List<myProducts_model> lst) {
    admin_user_prod_list = lst.where((p) => p.typ == '0').toList();
    admin_doc_prod_list = lst.where((p) => p.typ == '1').toList();
    return lst;
  }

  bool validateForm() {
    if (prodNM_cont.text.trim().isEmpty ||
        price_cont.text.trim().isEmpty ||
        desc_cont.text.trim().isEmpty ||
        img1.isEmpty) {
      glb.errorToast(context, "Enter all the details");
      return false;
    }
    return true;
  }

  void resetForm() {
    prodNM_cont.clear();
    price_cont.clear();
    desc_cont.clear();
    img1 = img2 = img3 = img4 = img5 = "";
  }

  Future<Uint8List> getImageBytes(String url) async {
    final res = await http.get(Uri.parse(url));
    return res.bodyBytes;
  }

  void selectImage(String typ) {
    final input = FileUploadInputElement()..accept = 'image/*';
    input.click();
    input.onChange.listen((event) {
      final files = input.files;
      if (files!.isNotEmpty) {
        final file = files[0];
        final reader = FileReader();
        reader.onLoad.listen((e) {
          final result = reader.result;
          if (result is Uint8List || result is ByteBuffer) {
            final blob = Blob([result]);
            final imageUrl = Url.createObjectUrlFromBlob(blob);
            setState(() {
              switch (typ) {
                case 'img1':
                  img1 = imageUrl;
                  break;
                case 'img2':
                  img2 = imageUrl;
                  break;
                case 'img3':
                  img3 = imageUrl;
                  break;
                case 'img4':
                  img4 = imageUrl;
                  break;
                case 'img5':
                  img5 = imageUrl;
                  break;
              }
            });
          }
        });
        reader.readAsArrayBuffer(file);
      }
    });
  }

  Future<void> addProduct() async {
    if (!validateForm()) return;
    glb.loading(context);

    final name = prodNM_cont.text.trim();
    final price = price_cont.text.trim();
    final desc = desc_cont.text.trim();
    final type = _character == SingingCharacter.User ? "0" : "1";
    final url = glb.API.baseURL + glb.API.add_admin_products;
    final images = [img1, img2, img3, img4, img5];

    final request = http.MultipartRequest('POST', Uri.parse(url));

    try {
      // Attach all image files
      for (int i = 0; i < images.length; i++) {
        final imageData = await getImageBytes(images[i]);
        final fieldName = i == 0 ? 'image' : 'img${i + 1}';
        request.files.add(http.MultipartFile.fromBytes(
          fieldName,
          imageData,
          filename: "${name}_${i + 1}.jpg",
        ));
      }

      // Attach form fields
      request.fields['product_name'] = name;
      request.fields['price'] = price;
      request.fields['type'] = type;
      request.fields['description'] = desc;

      final response = await request.send();
      final respStr = await response.stream.bytesToString();
      print("response hai: $respStr");
      Navigator.pop(context);

      if (response.statusCode == 200 && respStr.trim() == '1') {
        glb.SuccessToast(context, "Product added successfully");
        resetForm();
        await fetchAndSetProducts();
      } else {
        glb.errorToast(context, "Failed to add product");
      }
    } catch (e) {
      Navigator.pop(context);
      glb.errorToast(context, "Something went wrong");
      print("Upload error: $e");
    }
  }

  Future<List<myProducts_model>> fetchProducts() async {
    final url = Uri.parse(glb.API.baseURL + glb.API.GetAdminProducts);
    final res = await http.get(url);
    print(res.body);
    if (res.statusCode != 200) throw Exception("Failed to fetch products");
    print("Fetching products from API");
    final List data = jsonDecode(res.body);
    return data
        .map((item) => myProducts_model(
              ID: item['id'].toString(),
              name: item['product_name'].toString(),
              price: item['price'].toString(),
              desc: item['Description'].toString(),
              typ: item['type'].toString(),
              img: "${glb.API.baseURL}images/admin_pharmacy/${item['image']}",
              img2: "${glb.API.baseURL}images/admin_pharmacy/${item['img2']}",
              img3: "${glb.API.baseURL}images/admin_pharmacy/${item['img3']}",
              img4: "${glb.API.baseURL}images/admin_pharmacy/${item['img4']}",
              img5: "${glb.API.baseURL}images/admin_pharmacy/${item['img5']}",
              out_of_stock: item['out_of_stock'].toString(),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(text: showAddProduct ? "Add Product" : "My Products"),
                Switch(
                  value: showAddProduct,
                  onChanged: (val) => setState(() => showAddProduct = val),
                  activeColor: Colors.green,
                ),
              ],
            ),
            Divider(),
            Expanded(
              child: showAddProduct
                  ? SingleChildScrollView(child: buildAddProductCard())
                  : SingleChildScrollView(child: buildProductListCard()),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddProductCard() {
    final imageUrls = [img1, img2, img3, img4, img5];
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildFormField("Product Name", prodNM_cont),
            buildFormField("Price", price_cont),
            buildFormField("Description", desc_cont),
            Row(
              children: [
                Radio<SingingCharacter>(
                  value: SingingCharacter.User,
                  groupValue: _character,
                  onChanged: (val) => setState(() => _character = val),
                ),
                Text("User"),
                Radio<SingingCharacter>(
                  value: SingingCharacter.Doctor,
                  groupValue: _character,
                  onChanged: (val) => setState(() => _character = val),
                ),
                Text("Doctor"),
              ],
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(5, (index) {
                final label = 'img${index + 1}';
                final url = imageUrls[index];
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => selectImage(label),
                      child: Text("Upload $label"),
                    ),
                    if (url.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Image.network(url, width: 80, height: 80),
                      )
                  ],
                );
              }),
            ),
            SizedBox(height: 16),
            ElevatedButton(onPressed: addProduct, child: Txt(text: "ADD")),
          ],
        ),
      ),
    );
  }

  Widget buildProductListCard() {
    final filteredList = dropDown_value == "All"
        ? glb.Models.adminProducts_lst
        : dropDown_value == "User"
            ? admin_user_prod_list
            : admin_doc_prod_list;

    final searchQuery = searchController.text.toLowerCase();
    final searchedList = filteredList
        .where((p) => p.name.toLowerCase().contains(searchQuery))
        .toList();

    bool isMobile = MediaQuery.of(context).size.width < 600;

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: dropDown_value,
              items: list
                  .map((val) => DropdownMenuItem(
                        value: val,
                        child: Text(val),
                      ))
                  .toList(),
              onChanged: (val) => setState(() => dropDown_value = val!),
            ),
            SizedBox(height: 8),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search Products",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: searchedList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 2 : 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => Products_card(
                pm: searchedList[index],
                filter: dropDown_value,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFormField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
