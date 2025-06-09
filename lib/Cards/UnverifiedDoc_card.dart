import 'package:bighter_panel/Admin/SideMenuPages/doctors/unverifiedDoctors/UnverifiedDocDet.dart';
import 'package:bighter_panel/Utilities/colours.dart';
import 'package:bighter_panel/Utilities/text/txt.dart';
import 'package:bighter_panel/models/AllDoc_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnverifiedDoc_card extends StatefulWidget {
  const UnverifiedDoc_card({
    super.key,
    required this.ad,
    required this.idx,
  });
  final int idx;
  final AllDoc_model ad;
  @override
  State<UnverifiedDoc_card> createState() => _UnverifiedDoc_cardState();
}

class _UnverifiedDoc_cardState extends State<UnverifiedDoc_card> {
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    return Visibility(
      visible: widget.ad.verified == '0',
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Container(
          // height: 13.706.h,
          color: widget.idx.isOdd
              ? Colours.blue.withOpacity(.5)
              : Colours.orange.withOpacity(.5),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: currentWidth <= 600
                ? Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            "${widget.ad.img}",
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/images/doc.png");
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            text: widget.ad.name,
                            fntWt: FontWeight.bold,
                          ),
                          Txt(text: widget.ad.speciality),
                          Container(
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UnverifiedDocDet(
                                                  deg: widget.ad.Degree,
                                                  mail: widget.ad.mail,
                                                  mobno: widget.ad.mobno,
                                                  name: widget.ad.name,
                                                  sep: widget.ad.speciality,
                                                  cert_img: widget.ad.CertImg,
                                                  conCert_img:
                                                      widget.ad.CouncilCertImg,
                                                  doc_img: widget.ad.img,
                                                  id_img: widget.ad.idImg,
                                                  doc_id: widget.ad.ID,
                                                )));
                                  },
                                  child: Txt(text: "View"),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                "${widget.ad.img}",
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/images/doc.png");
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                text: widget.ad.name,
                                fntWt: FontWeight.bold,
                              ),
                              Txt(text: widget.ad.speciality),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UnverifiedDocDet(
                                              deg: widget.ad.Degree,
                                              mail: widget.ad.mail,
                                              mobno: widget.ad.mobno,
                                              name: widget.ad.name,
                                              sep: widget.ad.speciality,
                                              cert_img: widget.ad.CertImg,
                                              conCert_img:
                                                  widget.ad.CouncilCertImg,
                                              doc_img: widget.ad.img,
                                              id_img: widget.ad.idImg,
                                              doc_id: widget.ad.ID,
                                            )));
                              },
                              child: Txt(text: "View"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
