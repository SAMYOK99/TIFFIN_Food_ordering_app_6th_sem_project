import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/riders_app/homeScreens/order_details_screen.dart';
import 'package:my_tiffin/models/items.dart';
class OrderCard extends StatelessWidget {
  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? separateQuantitiesList;
   const OrderCard({
     super.key,
     required this.itemCount,
     required this.data,
     required this.orderID,
     required this.separateQuantitiesList
   });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (c)=>OrderDetailsScreen(orderID: orderID)));

      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0,0,0,20),
      width: 380,
        height: 135,
        child: ListView.builder(
        itemCount: itemCount,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index)
        {
        Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
        return placeOrderDesignWidget(model, context, separateQuantitiesList![index]);
        },
      ),
      ),
    );
  }
}

Widget placeOrderDesignWidget(Items model, BuildContext context, separateQuantitiesList)
{
  return Column(
    children: [
      Padding(padding: const EdgeInsets.symmetric(vertical: 9),
        child: Container(
          width: 370,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0,3),

              )
            ],
          ),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.network(
                  model.thumbnailUrl!,
                  height: 80,
                  width: 150,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: 180,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(model.itemTitle!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                    Text(model.shortInfo!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),),
                    Text("\$"+model.itemPrice!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),),
                  ],
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all((5)),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),

                  ) ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(CupertinoIcons.minus,
                        color: Colors.white,

                      ),
                      Text(separateQuantitiesList,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,

                        ),
                      ),

                      const Icon(CupertinoIcons.minus,
                        color: Colors.white,

                      ),
                    ],
                  ),
                ),)


            ],
          ),
        ),
      ),

    ],
  );

}
