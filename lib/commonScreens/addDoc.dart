import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:bighter_panel/Admin/Home_pg.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/customSizedBox.dart';
import 'package:bighter_panel/Utilities/sizer.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:js/js.dart' as js;
import 'package:bighter_panel/Utils/global.dart' as glb;
import 'package:http/http.dart' as http;

class addDoc extends StatefulWidget {
  const addDoc({super.key});

  @override
  State<addDoc> createState() => _addDocState();
}

const List<String> list = <String>[
  'Dermatology',
  'Cosmetology',
  'Dietician',
  'Dentist',
  'Eye or Opthalmology',
  'Trichology',
  'Plastic surgon'
];

class _addDocState extends State<addDoc> {
  TextEditingController nm_cont = TextEditingController();
  TextEditingController mail_cont = TextEditingController();
  TextEditingController mobno_cont = TextEditingController();
  TextEditingController degree_cont = TextEditingController();
  TextEditingController pswd_cont = TextEditingController();

  String dropdownValue = list.first;

  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 2.h,
            ),
            Txt(
              text: "Add Doctor",
              size: 22,
              fontColour: Colours.RussianViolet,
              fntWt: FontWeight.bold,
            ),
            Divider(
              color: Colours.divider_grey,
            ),
            SizedBox(
              child: Material(
                // elevation: 5,
                color: Colors.transparent,
                shadowColor: Colours.RussianViolet,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Sizer.radius_10),
                    topRight: Radius.circular(Sizer.radius_10),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colours.icn_white,
                    // border: Border(
                    //   top: BorderSide(color: Colours.divider_grey),
                    //   left: BorderSide(color: Colours.divider_grey),
                    //   right: BorderSide(color: Colours.divider_grey),
                    // ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizer.radius_10),
                      topRight: Radius.circular(Sizer.radius_10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 2.w,
                          runSpacing: 3.h,
                          // runSpacing: 10.w,
                          children: [
                            SizedBox(
                              width:
                                  currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
                              child: TextField(
                                controller: nm_cont,
                                decoration: InputDecoration(
                                  prefixText: "Dr. ",
                                  labelText: "Full name",
                                  hoverColor: Colours.HunyadiYellow,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: currentWidth <= 600 ? 100.w : 3.255.w * 6,
                              constraints: BoxConstraints(minWidth: 200),
                              child: TextField(
                                controller: mail_cont,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              width: currentWidth <= 600 ? 100.w : 3.255.w * 6,
                              constraints: BoxConstraints(minWidth: 200),
                              child: TextField(
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                controller: mobno_cont,
                                decoration: InputDecoration(
                                  labelText: "Mobile number",
                                  hintText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),
                            // *password textfield
                          ],
                        ),
                        SizedBox(
                          height: Sizer.h_10 * 2,
                        ),
                        Wrap(
                          spacing: 2.w,
                          runSpacing: 3.h,
                          children: [
                            //pswd tf
                            SizedBox(
                              width:
                                  currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
                              child: TextField(
                                controller: pswd_cont,
                                obscureText: obscure,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hintText: "123",
                                  hoverColor: Colours.HunyadiYellow,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscure = !obscure;
                                      });
                                    },
                                    icon: Icon(obscure
                                        ? Iconsax.eye
                                        : Iconsax.eye_slash),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),

                            // speciality dropdown
                            w200SizedBox(
                              wd: currentWidth <= 600 ? 100.w : (3.255 * 6).w,
                              child: Container(
                                // width: (3.255 * 6).w,
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius:
                                        BorderRadius.circular(0.55.w)),
                                child: Padding(
                                  padding: EdgeInsets.all(5.sp),
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    dropdownColor: Colours.scaffold_white,
                                    value: dropdownValue,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: list.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            // Degree TF
                            Container(
                              width: currentWidth <= 600 ? 100.w : 3.255.w * 6,
                              constraints: BoxConstraints(minWidth: 200),
                              child: TextField(
                                controller: degree_cont,
                                decoration: InputDecoration(
                                  labelText: "Degree",
                                  hintText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Sizer.radius_10 / 5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Sizer.h_10 * 2,
                        ),
                        Wrap(
                          spacing: 2.w,
                          runSpacing: 3.h,
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colours.HunyadiYellow.withOpacity(0.3),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child:
                                        // Center(
                                        // child: _imageFile == null
                                        //     ? Text('No image selected')
                                        //     : Image.file(io.File(_imageFile!.path)),
                                        Image.network(
                                      // "${glb.clinic.img2}",
                                      "$profileP",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.image);
                                      },
                                    ),
                                  ),
                                  // ),
                                  InkWell(
                                    onTap: () async {
                                      // _pickImage();
                                      selectImage('pp');
                                    },
                                    child: Container(
                                      color: Colours.HunyadiYellow.withOpacity(
                                          0.6),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Txt(text: "Profile photo"),
                                          Icon(Icons.upload_file),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colours.HunyadiYellow.withOpacity(0.3),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child:
                                        // Center(
                                        // child: _imageFile == null
                                        //     ? Text('No image selected')
                                        //     : Image.file(io.File(_imageFile!.path)),
                                        Image.network(
                                      // "${glb.clinic.img2}",
                                      "$IDp",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.image);
                                      },
                                    ),
                                  ),
                                  // ),
                                  InkWell(
                                    onTap: () async {
                                      // _pickImage();
                                      selectImage('idp');
                                    },
                                    child: Container(
                                      color: Colours.HunyadiYellow.withOpacity(
                                          0.6),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Txt(text: "Upload ID proof"),
                                          Icon(Icons.upload_file),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colours.HunyadiYellow.withOpacity(0.3),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child:
                                        // Center(
                                        // child: _imageFile == null
                                        //     ? Text('No image selected')
                                        //     : Image.file(io.File(_imageFile!.path)),
                                        Image.network(
                                      // "${glb.clinic.img2}",
                                      "$certificateP",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.image);
                                      },
                                    ),
                                  ),
                                  // ),
                                  InkWell(
                                    onTap: () async {
                                      // _pickImage();
                                      selectImage('cp');
                                    },
                                    child: Container(
                                      color: Colours.HunyadiYellow.withOpacity(
                                          0.6),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Txt(text: "Upload certificate"),
                                          Icon(Icons.upload_file),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colours.HunyadiYellow.withOpacity(0.3),
                                border: Border.all(),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child:
                                        // Center(
                                        // child: _imageFile == null
                                        //     ? Text('No image selected')
                                        //     : Image.file(io.File(_imageFile!.path)),
                                        Image.network(
                                      // "${glb.clinic.img2}",
                                      "$councilCertificate",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Icon(Icons.image);
                                      },
                                    ),
                                  ),
                                  // ),
                                  InkWell(
                                    onTap: () async {
                                      // _pickImage();
                                      selectImage('ccp');
                                    },
                                    child: Container(
                                      color: Colours.HunyadiYellow.withOpacity(
                                          0.6),
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Txt(text: "Medical council "),
                                          Icon(Icons.upload_file),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //
                          ],
                        ),
                        SizedBox(
                          height: Sizer.h_10 * 2,
                        ),
                        // =====================================================================

                        // =====================================================================
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colours.green,
                              fixedSize: Size(
                                  currentWidth <= 600 ? 100.w : Sizer.w_50 * 6,
                                  Sizer.h_10),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizer.radius_10 / 5),
                              ),
                            ),
                            onPressed: () {
                              var n = "Dr. " + nm_cont.text.trim();
                              var m = mobno_cont.text.trim();
                              var p = pswd_cont.text.trim();
                              var s = dropdownValue;
                              var d = degree_cont.text.trim();
                              var ml = mail_cont.text.trim();
                              print(n);
                              print(m);
                              print(p);
                              print(s);
                              print(d);
                              print(ml);
                              if (n.isEmpty ||
                                  m.isEmpty ||
                                  p.isEmpty ||
                                  s.isEmpty ||
                                  d.isEmpty ||
                                  ml.isEmpty ||
                                  profileP.isEmpty ||
                                  IDp.isEmpty ||
                                  certificateP.isEmpty ||
                                  councilCertificate.isEmpty) {
                                glb.errorToast(
                                    context, "Enter all the details");
                              } else {
                                glb.loading(context);
                                registerForRequest(profileP, IDp, certificateP,
                                    councilCertificate, n, m, ml, p, s, d);
                              }
                            },
                            child: Txt(
                              text: "Add",
                              size: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  io.File? _imageFile;
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = io.File(pickedFile.path);
        print("vv");
        print(_imageFile!.path);
        // glb.loading(context);

        // _senddocImage1();
      });
    }
  }

  String profileP = "", IDp = "", certificateP = '', councilCertificate = '';
  String tempurl = "";
  void selectImage(String typ) {
    final input = FileUploadInputElement()..accept = 'image/*';

    input.click();

    input.onChange.listen((event) {
      final files = input.files;
      if (files!.length == 1) {
        final file = files[0];
        final reader = FileReader();

        reader.onLoad.listen((e) {
          final result = reader.result;
          if (result is Uint8List) {
            final blob = Blob([result]);
            final imageUrl = Url.createObjectUrlFromBlob(blob);
            // Use the imageUrl to display the image in an Image widget
            // or any other way you prefer.
            setState(() {
              if (typ == 'pp') {
                profileP = imageUrl;
              } else if (typ == 'idp') {
                IDp = imageUrl;
              } else if (typ == 'cp') {
                certificateP = imageUrl;
              } else if (typ == 'ccp') {
                councilCertificate = imageUrl;
              }
              // tempurl = imageUrl;
            });
            print(imageUrl);
          }
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  Future<void> registerForRequest(
    String pathProfile,
    String pathId,
    String pathDegreeCert,
    String pathCouncilCert,
    String name,
    String mobile,
    String email,
    String password,
    String speciality,
    String degree,
  ) async {
    final url = Uri.parse(glb.API.baseURL + glb.API.new_reg_doc);
    print("Registering doctor with documents...");

    try {
      // Load image files
      final imageDataProfile =
          (await http.get(Uri.parse(pathProfile))).bodyBytes;
      final imageDataId = (await http.get(Uri.parse(pathId))).bodyBytes;
      final imageDataDegCert =
          (await http.get(Uri.parse(pathDegreeCert))).bodyBytes;
      final imageDataCouncilCert =
          (await http.get(Uri.parse(pathCouncilCert))).bodyBytes;

      final request = http.MultipartRequest('POST', url)
        ..files.add(http.MultipartFile.fromBytes(
          'doctor_img',
          imageDataProfile,
          filename: '${mobile}_profile.jpg',
        ))
        ..files.add(http.MultipartFile.fromBytes(
          'id_img',
          imageDataId,
          filename: '${mobile}_id.jpg',
        ))
        ..files.add(http.MultipartFile.fromBytes(
          'degC_img',
          imageDataDegCert,
          filename: '${mobile}_degree.jpg',
        ))
        ..files.add(http.MultipartFile.fromBytes(
          'CouncilC_img',
          imageDataCouncilCert,
          filename: '${mobile}_council.jpg',
        ))
        ..fields.addAll({
          'name': name,
          'mobile': mobile,
          'password': password,
          'email': email,
          'speciality': speciality,
          'degree': degree,
          'verified': '1',
        });

      final response = await request.send();

      // Read the response body
      final responseBody = await response.stream.bytesToString();
      print("Status code: ${response.statusCode}");
      print("vvvvvvvvvvvvvv");

      print("Response body: ${responseBody}");
      print("^^^^^^^^^^^^");
      if (response.statusCode == 200) {
        // You should parse actual server response to determine outcome
        if (responseBody == 'User Already Exists') {
          Navigator.pop(context);
          glb.ConfirmationBox(
            context,
            "You have already registered,\nplease wait for our team to verify your details",
            () => Navigator.pop(context),
          );
        } else if (responseBody == '1' || responseBody.contains('inserted')) {
          print("request sent");
          glb.SuccessToast(context, "Request sent successfully");

          // Clear all fields
          setState(() {
            nm_cont.clear();
            mobno_cont.clear();
            mail_cont.clear();
            pswd_cont.clear();
            degree_cont.clear();
            profileP = "";
            IDp = "";
            certificateP = '';
            councilCertificate = '';
          });

          getAllDocs_async();
        } else {
          glb.errorToast(context, "Unknown response from server");
        }
      } else {
        glb.errorToast(context, "Failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
      glb.errorToast(
          context, "An error occurred while submitting. Please try again.");
    } finally {
      Navigator.pop(context); // Close any loading/dialog
    }

    print("Register doctor process completed.");
  }

  List<AllDoc_model> ad = [];
  getAllDocs_async() async {
    ad = [];
    print("get all docs async ");
    Uri url = Uri.parse(glb.API.baseURL + glb.API.getAllDocs);
    print("url>>>>??? $url");
    try {
      var res = await http.post(url, headers: {
        'accept': 'application/json',
      }, body: {
        'all_docs': '1',
        'clinic_id': '0',
      });
      print(res.statusCode);
      var bdy = jsonDecode(res.body);
      List b = jsonDecode(res.body);
      print(bdy);
      print(b.length);
      print(bdy[0]['clinic_name']);
      for (int i = 0; i < b.length; i++) {
        ad.add(
          AllDoc_model(
            ID: bdy[i]['ID'].toString(),
            name: bdy[i]['Name'].toString(),
            mobno: bdy[i]['mobile_no'].toString(),
            img: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['doctor_img'].toString(),
            img2: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img1'].toString(),
            img3: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img2'].toString(),
            img4: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img3'].toString(),
            img5: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['img4'].toString(),
            mail: bdy[i]['email_id'].toString(),
            pswd: bdy[i]['pswd'].toString(),
            speciality: bdy[i]['Speciality'].toString(),
            Degree: bdy[i]['Degree'].toString(),
            clinicID: bdy[i]['clinic_id'].toString(),
            available: bdy[i]['available'].toString(),
            rating: bdy[i]['Rating'].toString(),
            verified: bdy[i]['verified'].toString(),
            idImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['ID_proof'].toString(),
            CertImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['degree_certificate'].toString(),
            CouncilCertImg: "${glb.API.baseURL}images/doctor_images/" +
                bdy[i]['medical_council_certificate'].toString(),
            branch_doc: '0',
          ),
        );
      }
      setState(() {
        glb.Tdocs = b.length.toString();
        glb.Models.AllDocs_lst = ad;
        if (glb.usrTyp == '0') {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => adminHome_pg(
                        pgNO: 1,
                      )));
        }
      });
    } catch (e) {
      print("Exception => $e");
    }
  }
}
