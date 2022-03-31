import 'package:flutter/material.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({ Key? key }) : super(key: key);

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        physics:BouncingScrollPhysics(),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:<Widget>[
            SafeArea(
              child:Padding(
                padding:EdgeInsets.only(left:16,right:16,top:10),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children:<Widget> [
                    Text("Feedback",style:TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                      color: Colors.purple[50]),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.add,color: Colors.purple,size:20,),
                          SizedBox(width:2,),
                          Text("Add New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      
                      ),
                  ]
                ),
              ),
              
            ),

          ]
        ),

      )
      
      
    );
  }
}