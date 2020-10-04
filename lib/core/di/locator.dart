
import 'package:flutter_app/core/network/dio_request_manager.dart';
import 'package:flutter_app/core/network/i_api_request_manager.dart';
import 'package:flutter_app/data/ip/ip_api_client.dart';
import 'package:flutter_app/data/ip/ip_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator (){
  
  locator.registerSingleton<IApiRequestManager>(DioRequestManager());
  
  locator.registerFactory<IpApiClient>(() => IpApiClient(requestManager: locator<IApiRequestManager>()));

  locator.registerFactory<IPRepository>(() => IPRepository(ipApiClient: locator<IpApiClient>()));
  
  
}