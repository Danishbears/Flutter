import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/data/model/fact_model.dart';

@immutable
abstract class FactState extends Equatable{}

class FactLoadingState extends FactState{
  @override
  List<Object?> get props => [];
}

class FactLoadedState extends FactState{
  final FactModel fact;

  FactLoadedState(this.fact);

  @override
  List<Object?> get props => [fact];
}

class FactsLoadedState extends FactState{
  final List<FactModel> facts;
  FactsLoadedState({required this.facts});
  @override
  // TODO: implement props
  List<Object?> get props => [facts];
}

class FactErrorState extends FactState{
  final String error;
  FactErrorState(this.error);

  @override
  List<Object?> get props => [error];
}