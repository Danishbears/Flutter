import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_event.dart';
import '../repositories/facts_repository.dart';
import 'facts_page.dart';

class FactsScreen extends StatelessWidget {
  const FactsScreen({Key? key}) : super(key: key);

/*  _init() async{
    await Hive.openBox('factsBox');
  }*/

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FactsRepository(),
      child: BlocProvider(
        create: (context) => FactBloc(
          RepositoryProvider.of<FactsRepository>(context),
        )..add(LoadFactEvent()),
        child: const MaterialApp(
          home: FactsPage(),
        ),
      ),
    );
  }

    /*return Scaffold(
        appBar: AppBar(
        title: const Text('Facts list'),
    ),
    body: BlocProvider(
        create: (context) => FactBloc(RepositoryProvider.of<FactsRepository>(context))..add(LoadFactEvent()),
        child: BlocBuilder<FactBloc, FactState>(
        builder: (context, state) {
    if (state is FactLoadingState) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }
    if(state is FactLoadedState){
        return ListView(children: [
           state.fact.map(
                (e) => ListTile(
              title: Text(e.task),
              trailing: Checkbox(
                value: e.completed,
                onChanged: (val) {
                  BlocProvider.of<TodosBloc>(context).add(ToggleTodoEvent(e.task));
                },
              ),
            ),
          ),
          ListTile(
            title: Text('Create new task'),
            trailing: Icon(Icons.create),
            onTap: () async {
              final result = await showDialog<String>(
                  context: context,
                  builder: (context) => Dialog(
                    child: CreateNewTask(),
                  ));

              if (result != null) {
                BlocProvider.of<TodosBloc>(context).add(AddTodoEvent(result));
              }
            },
          )
        ]);
      }
  }*/
  }
//}