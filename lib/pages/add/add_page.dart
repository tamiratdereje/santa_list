import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:santa_list/data/ChildrenRepository.dart';
import 'package:santa_list/model/child.dart';
import 'package:santa_list/model/status.dart';
import 'package:santa_list/pages/add/bloc/add/add_child_bloc.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key, this.child});

  final Child? child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditChildBloc(context.read<ChildrenRepository>()),
      child: _AddPage(child: child),
    );
  }
}

class _AddPage extends StatefulWidget {
  const _AddPage({required this.child}) : isEditing = child != null;

  final Child? child;
  final bool isEditing;

  @override
  State<_AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<_AddPage> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  var _status = Status.nice;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.child != null) {
      final child = widget.child!;
      _nameController.text = child.name;
      _countryController.text = child.country;
      _status = child.status;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditChildBloc, AddEditChildState>(
      listener: (BuildContext context, AddEditChildState state) {
        state.maybeWhen(
          orElse: () {},
          saved: () => Navigator.of(context).pop(),
          error: (String error) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            ),
        );
      },
      builder: (BuildContext context, AddEditChildState state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.isEditing ? "Edit Child" : "Add Child"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    controller: _nameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the child's name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Country',
                    ),
                    controller: _countryController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the child's country name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownMenu<Status>(
                    dropdownMenuEntries: const [
                      DropdownMenuEntry<Status>(
                        value: Status.nice,
                        label: "Nice",
                      ),
                      DropdownMenuEntry<Status>(
                          value: Status.naughty, label: "Naughty"),
                    ],
                    initialSelection: _status,
                    onSelected: (value) {
                      setState(() {
                        _status = value!;
                      });
                    },
                    hintText: "Hint",
                  ),
                  const SizedBox(height: 16),
                  FilledButton.tonal(
                    onPressed: () {
                      // Validate form
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      final newChild = Child(
                        _nameController.text,
                        _countryController.text,
                        _status,
                        widget.child?.id,
                      );

                      if (widget.isEditing) {
                        context
                            .read<AddEditChildBloc>()
                            .add(AddEditChildEvent.update(newChild));
                      } else {
                        context
                            .read<AddEditChildBloc>()
                            .add(AddEditChildEvent.save(newChild));
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
