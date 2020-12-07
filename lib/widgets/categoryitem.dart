import 'package:flutter/material.dart';
import 'package:TheSpecialParty/screens/productslist.dart';
class CategoryItem extends StatelessWidget {
  CategoryItem({this.txt, this.img, this.id});

  final String txt;
  final String img;
  final int id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsList(
                                      pagetitle:txt ,
                                      id: id,
                                    )));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => ProductsOfCategory(
        //               selectedcategory: txt,
        //               id: id,
        //             )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x29000000),
              offset: Offset(0, 0),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 5,child:
              Padding(
                padding: const EdgeInsets.only(bottom: 6,top: 4,right: 10,left: 10),
                child: Container(
                  // height: MediaQuery.of(context).size.height*0.4,
                  //  width: MediaQuery.of(context).size.width*0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://specialparty.ga'+
                        img),
                      fit: BoxFit.fill
                    ),
                    
                  ),
                ),
              )
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Center(
                    child: Text(
                     
                      txt,
                       overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'sukarbold',
                        fontSize: MediaQuery.of(context).size.width*0.032,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,

                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
