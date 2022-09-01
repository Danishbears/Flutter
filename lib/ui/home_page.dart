
import 'dart:io';
import 'dart:developer' as developer;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:untitled3/bloc/cat_bloc/fact_bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_event.dart';
import 'package:untitled3/bloc/cat_bloc/fact_states.dart';
import 'package:untitled3/data/db/fact_database.dart';
import 'package:untitled3/data/model/fact_model.dart';
import 'package:untitled3/repositories/facts_repository.dart';
import 'package:untitled3/ui/facts_page.dart';
import 'package:untitled3/ui/facts_screen.dart';

class HomePage extends StatelessWidget {
  //final String _boxName = "Facts";

  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) =>FactBloc(
      RepositoryProvider.of<FactsRepository>(context),)..add(LoadFactEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Facts App'),
        ),
        body: BlocBuilder<FactBloc,FactState>(
          builder: (context, state){
            if(state is FactLoadingState){
              return const Center(
                child: AnimatedCircularProgress(),
              );
            }
            if(state is FactLoadedState){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ExpansionTile(title: Text(
                      state.fact.fact,
                      textAlign: TextAlign.center,
                      maxLines: 5,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:Text(
                          state.fact.length.toString(),
                          //state.fact.updatedAt,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],),
                    const SizedBox(height: 10),
                    Image.network("https://cataas.com/cat?t=${DateTime.now().millisecond}",
                    fit: BoxFit.cover,
                    height: 160.0,width: 160.0,),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: (){
                      BlocProvider.of<FactBloc>(context).add(LoadFactEvent());
                    }, child: const Text('Another Fact')),
                    const SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const FactsScreen(),
                        ),
                      );
                    }, child: const Text("Facts history")),
                    const SizedBox(height: 10,),
                    ElevatedButton(onPressed: (){
                      BlocProvider.of<FactBloc>(context).add(
                          AddFactEvent(factModel: state.fact)
                      );
                    }, child: const Text("Save me"))
                  ],
                ),
              );
            }
            if(state is FactErrorState){
              return Center(
                child: Text(state.error.toString()),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

 /* Future<Box> factBox() async{
    var box = await Hive.box(_boxName);
    return box;
  }

  Future<List<FactModel>?> getListOfFacts() async{
    final box = await factBox();
    List<FactModel>?facts = box.values.cast<FactModel>().toList();
    return facts;
  }

  Future<void> addToBox(FactModel fact) async{
    final box = await factBox();
    await box.add(fact);
  }*/

  /*Future<void> saveToDatabase(String id,String text, String updatedAt) async{
    Box<FactModel> _facts;
    Hive.registerAdapter(FactModelAdapter());
    _facts = await Hive.box(_boxName);
    await _facts.add(FactModel(id: id, text: text, updatedAt: updatedAt));
  }*/
}

class AnimatedCircularProgress extends StatefulWidget {
  const AnimatedCircularProgress({Key? key}) : super(key: key);


  @override
  State<AnimatedCircularProgress> createState() => _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress> {
  double targetValue = 24.0;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1),
      duration: const Duration(milliseconds: 3500),
      builder: (context, value, _) => CircularProgressIndicator(value: value),
    );
  }
}

/*class CircularAnimation extends StatefulWidget {
  const CircularAnimation({Key? key}) : super(key: key);

  @override
  State<CircularAnimation> createState() => _CircularAnimationState();
}

class _CircularAnimationState extends State<CircularAnimation> {
  double _targetSize = 300;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.purple[900],
        child: TweenAnimationBuilder(
          tween: Tween<double>(
            begin: 50,
            end: _targetSize,
          ),
          duration: const Duration(seconds: 2),
          onEnd: () {
            setState(() {
              if (_targetSize == 50) {
                _targetSize = 300;
              } else {
                _targetSize = 50;
              }
            });
          },
          curve: Curves.linear,
          builder: (BuildContext _, double size, Widget? __) {
            return Container(
              width: size,
              height: size,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                      center: Alignment.center,
                      colors: [Colors.yellow, Colors.red]),
                  shape: BoxShape.circle),
            );
          },
        ),
      ),
    );
  }
}*/
