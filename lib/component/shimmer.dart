import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemBuilder: (context, index) {
      return Shimmer.fromColors(
          baseColor: Colors.grey.shade50,
          highlightColor: Colors.black12,
          child: Container(decoration:BoxDecoration(border: Border.all(width: 0.5),borderRadius: BorderRadius.circular(10)) ,
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Container(height: 10,width: 90,color: Colors.white,),
                  Row(
                    children: [
                      Container(height: 10,width: 70,color: Colors.white,),
                      Container(height: 10,width: 30,color: Colors.white,),
                    ],
                  )
                ],
              ),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [  SizedBox(height: 5,),
                  Container(height: 10,width: 60,color: Colors.white,), SizedBox(height: 5,),
                  /* Text("Pay Mehtod: ",
                                style: TextStyle(fontSize: 12, color: Colors.grey)),*/
                  Container(height: 10,width: 50,color: Colors.white,),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 10,width: 30,color: Colors.white,),
                  SizedBox(height: 10,),
                  Container(height: 10,width: 20,color: Colors.white,),
                ],
              ),
            ),
          )
      );
    },);
  }
}
