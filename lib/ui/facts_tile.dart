import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_bloc.dart';
import 'package:untitled3/bloc/cat_bloc/fact_event.dart';
import 'package:untitled3/data/model/fact_model.dart';
class FactsTile extends StatelessWidget {
  const FactsTile({
    Key? key,
    required this.fact,
    required this.index,
  }) : super(key: key);
  final FactModel fact;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(fact.fact.toString()),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (_) {
        BlocProvider.of<FactBloc>(context).add(
          AddFactEvent(
            factModel: fact
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    Text(fact.fact
                    ),
              ),
            );
          },
        ),
      ),
    );
  }
}