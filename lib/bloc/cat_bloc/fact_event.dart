import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/data/model/fact_model.dart';
@immutable
abstract class FactEvent extends Equatable{
  const FactEvent();
  @override
  List<Object> get props =>[];
}

class LoadFactEvent extends FactEvent{
  @override
  List<Object> get props =>[];
}

class YourFactsState extends FactEvent{
  final List<FactModel> facts;

  const YourFactsState({required this.facts});

}

class InitFactsBox extends FactEvent{


}

class FetchAllFactsEvent extends FactEvent{

}

class AddFactEvent extends FactEvent{
    final FactModel factModel;

    const AddFactEvent({required this.factModel});
}