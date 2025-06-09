import 'package:bighter_panel/Admin/SideMenuPages/Clinic_pages/clinic_dets_pg.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllClinics_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bighter_panel/Utils/global.dart' as glb;

class AllClinics_card extends StatefulWidget {
  const AllClinics_card({super.key, required this.AM});
  final AllClinics_model AM;
  @override
  State<AllClinics_card> createState() => _AllClinics_cardState();
}

class _AllClinics_cardState extends State<AllClinics_card> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colours.divider_grey,
            ),
            left: BorderSide(
              width: (1.302 / 5).w,
              // color: index.isEven
              //     ? Colours.green
              //     : Colours.orange
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(7.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              currentWidth <= 600
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 0.651.w,
                        ),
                        CircleAvatar(
                          radius: currentWidth <= 600 ? 10.w : 2.77.w,
                          foregroundImage: NetworkImage(getImg1(widget.AM.ID)),
                          onForegroundImageError: (exception, stackTrace) {
                            Image.asset("assets/images/clinic.png");
                          },
                          // backgroundImage: NetworkImage(getImg1(widget.AM.ID)),
                          // onBackgroundImageError: (exception, stackTrace) {
                          //   Image.asset("assets/images/clinic.png");
                          // },
                          // child: Image.asset("assets/images/clinic.png"),
                        ),
                        // Txt(text: widget.AM.img1),
                        SizedBox(
                          width: 0.651.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Txt(
                              text: "${widget.AM.name}",
                              fntWt: FontWeight.bold,
                            ),
                            Txt(
                              text: "${widget.AM.address}",
                              size: 10,
                            ),
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Icon(Icons.star);
                                  }),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colours.nonPhoto_blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.55.w),
                                ),
                              ),
                              onPressed: () {
                                print(widget.AM.ID);
                                print(widget.AM.name);
                                if (glb.usrTyp == "0") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClinicDets_pg(
                                        ClinicID: widget.AM.ID,
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Txt(text: "Details"),
                            )
                          ],
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: 0.651.w,
                        ),
                        CircleAvatar(
                          radius: currentWidth <= 600 ? 10.w : 2.77.w,
                          foregroundImage: NetworkImage(getImg1(widget.AM.ID)),
                          onForegroundImageError: (exception, stackTrace) {
                            Image.asset("assets/images/clinic.png");
                          },
                          // backgroundImage: NetworkImage(getImg1(widget.AM.ID)),
                          // onBackgroundImageError: (exception, stackTrace) {
                          //   Image.asset("assets/images/clinic.png");
                          // },
                          // child: Image.asset("assets/images/clinic.png"),
                        ),
                        // Txt(text: widget.AM.img1),
                        SizedBox(
                          width: 0.651.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Txt(
                              text: "${widget.AM.name}",
                              fntWt: FontWeight.bold,
                            ),
                            Txt(
                              text: "${widget.AM.address}",
                              size: 10,
                            ),
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Icon(Icons.star);
                                  }),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colours.nonPhoto_blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.55.w),
                            ),
                          ),
                          onPressed: () {
                            print(widget.AM.ID);
                            print(widget.AM.name);
                            if (glb.usrTyp == "0") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClinicDets_pg(
                                    ClinicID: widget.AM.ID,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Txt(text: "Details"),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

getImg1(String ClinicID) {
  String a = "";
  for (int i = 0; i < glb.Models.AllClinics_lst.length; i++) {
    if (ClinicID == glb.Models.AllClinics_lst[i].ID) {
      a = glb.Models.AllClinics_lst[i].img1;
      break;
    }
  }
  return a;
}
