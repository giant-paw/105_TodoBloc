import 'package:flutter/material.dart';
import 'package:tugas_bloc/bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  final _key = GlobalKey<FormState>();
  final _controller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Todo List'),

              Row(
                children: [
                  Column(
                    children: [
                      Text('Pilih Tanggal'),

                      BlocBuilder<TodoBloc, TodoState>(
                        builder: (context, state) {
                          if (state is TodoLoaded) {
                            if (state.selectDate != null) {
                              return Text(
                                '${state.selectDate!.day}/${state.selectDate!.month}/${state.selectDate!.year}',
                              );
                            }
                          }
                          return Text('Tidak ada tanggal yang dipilih');
                        },
                      ),
                    ],
                  ),

                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            context.read<TodoBloc>().add(
                              TodoSelectDate(date: selectedDate),
                            );
                          }
                        });
                      },
                      child: Text('Pilih Tanggal'),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              Form(
                key: _key,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Todo',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukan data todo';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(width: 10),
                    FilledButton(
                      onPressed: () {
                        if(_key.currentState!.validate()){
                          final selectDate = context.read<TodoBloc>().state;

                          if(selectDate is TodoLoaded) {
                            context.read<TodoBloc>().add(
                              TodoEventAdd(
                                title: _controller.text, 
                                date: selectDate.selectDate!
                              )
                            );
                            _controller.clear();
                            selectDate.selectDate = null;
                          }
                        }
                      }, 
                      child: Text('Tambah')
                      )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
