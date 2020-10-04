import 'package:flutter/material.dart';
import 'package:flutter_app/utils/route_transitions.dart';
import 'package:flutter_app/views/pages/ip_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Page'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: _bodyWidget(context),
        ),
      ),
    );
  }


  Widget _bodyWidget(BuildContext context){
    return Column(
      mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FlatButton(
          onPressed: (){
            Navigator.push(context, FadeRoute(page: IPPage()));
          },
          color: Colors.red,
          child: Text('IP PAGE',style: TextStyle(color: Colors.white),),
        )
      ],
    );
  }


}
