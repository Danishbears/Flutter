import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_event.dart';
import 'package:untitled3/bloc/cat_bloc/fact_states.dart';
import 'package:untitled3/repositories/facts_repository.dart';



class FactBloc extends Bloc<FactEvent,FactState>{
  final FactsRepository factsRepository;

  FutureOr<void> _initFactsBox(
      InitFactsBox event, Emitter<FactState> emit) async {
    await factsRepository.init();
    add(FetchAllFactsEvent());
  }

  FutureOr<void> _fetchAllFact(
      FetchAllFactsEvent event, Emitter<FactState> emit
      )async{
    try{
      emit(FactLoadingState());
      final factsList = factsRepository.getFacts();
      emit(FactsLoadedState(facts: factsList));
    }catch(e){
      emit(FactErrorState("Error fetch"));
    }
  }

  FutureOr<void> _addNewFact(
      AddFactEvent event,Emitter<FactState> emit) async{
    emit(FactLoadingState());
    try{
      final updatedFactsList = await factsRepository.addFact(event.factModel);
      //updatedFactsList as List<FactModel>;
      emit(FactsLoadedState(facts: updatedFactsList));
    }catch(e){
      emit(FactErrorState("Check ${e.toString()}"));
    }
  }

  FactBloc(this.factsRepository):super(FactLoadingState()) {
    on<InitFactsBox>(_initFactsBox);
    on<AddFactEvent>(_addNewFact);
    on<FetchAllFactsEvent>(_fetchAllFact);
    on<LoadFactEvent>((event, emit) async {
      emit(FactLoadingState());
      try {
        factsRepository.init();
        final fact = await factsRepository.getFact();
        emit(FactLoadedState(fact));
      } catch (e) {
        emit(FactErrorState(e.toString()));
      }
    });
  }
}
//}