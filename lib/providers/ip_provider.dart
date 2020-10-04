
import 'package:flutter/material.dart';
import 'package:flutter_app/core/di/locator.dart';
import 'package:flutter_app/core/livedata/live_data.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';
import 'package:flutter_app/data/ip/ip_repository.dart';
import 'package:flutter_app/data/ip/models/ip_model.dart';

class IPProvider with ChangeNotifier {

  final IPRepository ipRepository;
  IPProvider(this.ipRepository);

  var _ipModel = IpModel();
  LiveData<UIState<IpModel>> _ipLiveData = LiveData<UIState<IpModel>>();

  LiveData<UIState<IpModel>> getIpLiveData (){
    return this._ipLiveData;
  }

  void fetchIp()async{
    _ipLiveData.setValue(IsLoading());
    await Future.delayed(Duration(seconds: 1));
    try{
      _ipModel = await ipRepository.getIp();
      _ipLiveData.setValue(Success(_ipModel));
    }
    on FormatException catch (exc){
      _ipLiveData.setValue(Failure(exc.message));
    }
    finally{
      notifyListeners();
    }
  }


}