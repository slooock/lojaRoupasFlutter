import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/cart_model.dart';
class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite o seu cumpom"
              ),
              initialValue: CartModel.of(context).coupomCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("coupons").document(text).get().then(
                    (docSnap){
                      print(docSnap);
                      if(docSnap.data != null){
                        CartModel.of(context).setCupon(text, docSnap.data["percent"]);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Desconto de ${docSnap.data["percent"]}% aplicado!"
                            ),
                            backgroundColor: Theme.of(context).primaryColor,
                          )
                        );
                      } else {
                        CartModel.of(context).setCupon(null, 0);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Cupom não existente!"
                              ),
                              backgroundColor: Colors.redAccent,
                            )
                        );
                      }
                    }
                );
              },
            ),
          )
        ],
      )
    );
  }
}
