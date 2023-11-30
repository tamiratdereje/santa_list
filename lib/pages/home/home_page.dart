import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_list/data/ChildrenRepository.dart';
import 'package:santa_list/pages/add/add_page.dart';

import 'bloc/list/children_list_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildrenListBloc(context.read<ChildrenRepository>()),
      child: const _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Santa's List"),
      ),
      body: Center(
        child: BlocBuilder<ChildrenListBloc, ChildrenListState>(
          builder: (BuildContext context, ChildrenListState state) =>
              state.maybeWhen(
            orElse: () => const CircularProgressIndicator(),
            loaded: (children) {
              if (children.isEmpty) {
                return const Center(child: Text("No children yet"));
              }
              return ListView.builder(
                itemCount: children.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                  title: Text(
                    "${children[index].name} • ${children[index].country}",
                  ),
                  subtitle: Text(
                    "Status: ${children[index].status.name}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddPage(child: children[index]),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddItemDialog(context),
        tooltip: 'Add Child',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddItemDialog(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddPage(),
      ),
    );
  }
}
