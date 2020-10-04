
import 'package:flutter/material.dart';
import 'package:flutter_app/core/di/locator.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';
import 'package:flutter_app/data/ip/ip_repository.dart';
import 'package:flutter_app/data/ip/models/ip_model.dart';
import 'package:flutter_app/providers/ip_provider.dart';
import 'package:provider/provider.dart';

class IPPage extends StatefulWidget {
  @override
  _IPPageState createState() => _IPPageState();
}

class _IPPageState extends State<IPPage> {

  IPProvider _ipProvider = IPProvider(locator<IPRepository>());

  @override
  void initState() {
    super.initState();
    _ipProvider.fetchIp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('IP Page'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          // child: ChangeNotifierProvider<LiveData<UIState<IpModel>>>.value(
          //   value: _ipProvider.ipLiveData,
          //   builder: (ctx,_){
          //     return _bodyWidget();
          //   },
          // )
          child: ChangeNotifierProvider<IPProvider>(
            create: (ctx){
              return _ipProvider;
            },
            child: _bodyWidget(),
          ),
        ),
      ),
    );
  }


  Widget _bodyWidget(){
    return Consumer<IPProvider>(
      builder: (ctx,data,_){
        var state = data.getIpLiveData().getValue();
        if(state is Initial || state is IsLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        else if (state is Success){
          var data = state.data as IpModel;
          return Column(
            mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('IP is : '),
              SizedBox(height: 15,),
              Text('${data.ip}')
            ],
          );
        }
        else if(state is Failure){
          return Center(child: Text('${state.error}'),);
        }
        else{
          return Container();
        }
      },
    );
    // return Consumer<LiveData<UIState<IpModel>>>(
    //   builder: (ctx,liveData,_){
    //     var state = liveData.getValue();
    //     print('------ state is ---> ${state}');
    //     if(state is Initial || state is IsLoading){
    //       return Center(child: CircularProgressIndicator(),);
    //     }
    //     else if (state is Success){
    //       var data = state.data as IpModel;
    //       return Column(
    //         mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text('IP is : '),
    //           SizedBox(height: 15,),
    //           Text('${data.ip}')
    //         ],
    //       );
    //     }
    //     else if(state is Failure){
    //       return Center(child: Text('${state.error}'),);
    //     }
    //     else{
    //       return Container();
    //     }
    //   },
    // );
  }
}
