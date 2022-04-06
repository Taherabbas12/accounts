import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/data_base_test.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb myDatabase=SqlDb();
List<Map> res=[];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: Column(children: [
          SizedBox(height: 10,),
          Expanded(
              flex: 2,
              child: Card(margin: EdgeInsets.all(0),
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Column(children: [
              Divider(height: 0),
              CupertinoButton(child: Text('This data'),
                  onPressed: ()async{
                    int response=
                    await myDatabase.insertData("INSERT INTO 'notes' ('note') VALUES ('notes') ");
                    print('$response');
                  }),
              CupertinoButton(child: Text('This data'),
                  onPressed: ()async{
                    var rese=  await myDatabase.readData("SELECT * FROM 'notes'");
                    setState(() {
                      res=rese;

                    });

                    print('$rese');
                  }),

            ],),
          )),
          Expanded(
            flex: 11,
              child: ListView(children: [
            for(int i=0;i<res.length;i++)
                Column(children: [
                  ListTile( title: Text('${res[i]}'),onTap: ()async{
                    var rese=  await myDatabase.readData("DELETE FROM 'notes' WHERE 'id' =${i+1}");

                    print('$rese');
                  },tileColor: i.isEven?Colors.red:Colors.cyan,),
                  Divider(height: 0,
                  thickness: 2,
                    color: Colors.black26,)
                ],)


          ],))

        ]),
      ),
    );
  }
}
