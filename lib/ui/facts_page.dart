import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_states.dart';
import 'package:untitled3/ui/facts_tile.dart';
import 'dart:developer' as developer;
class FactsPage extends StatelessWidget {
  const FactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facts"),
      ),
      body: BlocBuilder<FactBloc,FactState>(
        builder: (context,state){
          if(state is FactLoadingState){
            return const Center(
              child:CircularProgressIndicator(),
            );
          }
          if(state is FactsLoadedState){
            if(state.facts.isNotEmpty){
              developer.log(state.facts.length.toString(), name:"Cheas");
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: 1,
                    endIndent: 20,
                    indent: 20,
                  ),
                  itemCount: state.facts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(state.facts.length.toString());
            },
              );
                  }
          }else{
            return const Center(
              child: Text("No Facts Found"),
            );
          }
          if(state is FactErrorState){
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
