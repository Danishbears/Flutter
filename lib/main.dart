import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled3/bloc/cat_bloc/fact_bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_event.dart';
import 'package:untitled3/repositories/facts_repository.dart';
import 'package:untitled3/ui/facts_screen.dart';
import 'package:untitled3/ui/home_page.dart';

import 'data/model/fact_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //await Hive.openBox<FactModel>("Facts");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => FactsRepository(),
        child: BlocProvider(
          create: (context) => FactBloc(
          RepositoryProvider.of<FactsRepository>(context))..add(LoadFactEvent()),
          child: const MaterialApp(
            home: HomePage(),
          ),
        ),
        );
  }

}
