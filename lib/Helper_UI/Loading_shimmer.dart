
import '../constants/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SafeArea(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          offset += 5;
          time = 800 + offset;

          print(time);

          return Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(10, 10),
                        color: Colors.black38,
                        blurRadius: 20),
                    BoxShadow(
                        offset: Offset(-10, -10),
                        color: Colors.white.withOpacity(0.85),
                        blurRadius: 20)
                  ]),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: ShimmerLayout(),
                period: Duration(milliseconds: time),
              ));
        },
      ),
    );
  }
}
class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return Container(
   child: Row(

     children: [
       Container(
         margin: EdgeInsets.symmetric(vertical: 4),
         width: SizeConfig.widthMultiplier * 20,
         height: SizeConfig.widthMultiplier * 20,
         decoration: BoxDecoration(
             border: Border.all(),
             color: Colors.grey,
             borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier * 10)
         ),
       ),
       Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             margin: EdgeInsets.all(8),
             padding: EdgeInsets.all(4),
             width: SizeConfig.screenWidth * 0.6,

             decoration: BoxDecoration(
                 border: Border.all(),
                 //color: Colors.grey.withOpacity(0.3),
                 borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier )
             ),

           ),
           Container(
             margin: EdgeInsets.only(left: 4,bottom: 2),
             width: SizeConfig.screenWidth * 0.5,
             height: SizeConfig.heightMultiplier * 2,
             decoration: BoxDecoration(
                 border: Border.all(),
                 color: Colors.grey,
                 borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier )
             ),
           ),
           Container(
             margin: EdgeInsets.only(left: 4,bottom: 2),
             width: SizeConfig.screenWidth * 0.5,
             height: SizeConfig.heightMultiplier * 2,
             decoration: BoxDecoration(
                 border: Border.all(),
                 color: Colors.grey,
                 borderRadius: BorderRadius.circular(SizeConfig.widthMultiplier )
             ),
           ),

         ],
       ),
     ],
   ),
    );
  }
}