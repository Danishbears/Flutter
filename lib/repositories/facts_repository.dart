import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:untitled3/data/model/fact_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

part 'facts_repository.g.dart';

@RestApi(baseUrl: "https://cat-fact.herokuapp.com")
abstract class RestClient {

  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("facts/random?animal_type=cat")
  Future<FactModel> getFact();
}

class FactsRepository{


  late final Box _factsBox;

  Future<void> init() async{
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(FactModelAdapter());
      _factsBox = await Hive.openBox<FactModel>('facts');
    }
    //_factsBox = await Hive.openBox<FactModel>('facts');
  }

  Box get factsBox => _factsBox;

 final String _baseUrl = "https://catfact.ninja/fact";
  Future<FactModel> getFact() async{
    final response = await http.get(Uri.parse(_baseUrl),);
    if(response.statusCode == 200){
      return factModelFromJson(response.body);
    }else{
      throw Exception("Failed to load fact ${response.statusCode}");
    }
  }

  List<FactModel> getFacts(){
    final facts = _factsBox.values.toList();
    return facts as List<FactModel>;
  }

  Future<List<FactModel>> addFact(FactModel newFact)async{
    await _factsBox.add(newFact);
    return getFacts();
  }

}