import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app_bloc/bloc/note_bloc.dart';
import 'package:notes_app_bloc/bloc/note_event.dart';
import 'package:notes_app_bloc/bloc/note_state.dart';
import 'package:notes_app_bloc/screens/add_note_page.dart';
import 'package:notes_app_bloc/screens/note_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Color> colorList = [
    Colors.blue.shade300,
    Colors.amber.shade200,
    Colors.blue.shade200,
    Colors.blueGrey.shade300,
    Colors.cyan.shade300,
    Colors.deepOrange.shade300,
    Colors.greenAccent.shade200,
    Colors.green.shade300,
    Colors.grey.shade300,
    Colors.indigoAccent.shade200,
    Colors.lightBlue.shade400,
    Colors.lime.shade200,
    Colors.orange.shade300,
    Colors.pink.shade200,
    Colors.pinkAccent.shade100,
    Colors.red.shade300,
    Colors.teal.shade300,
    Colors.purple.shade300,
    Colors.white54,
    Colors.yellow.shade200,
    Colors.yellowAccent.shade100
  ];

  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(GetAllDataEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.5),
          elevation: 10,
          title: Text(
            "Smart Notes",
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNotePage()));
          },
          child: Icon(Icons.add),
        ),
        body: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            if (state is LoadedState)
              return MasonryGridView.builder(
                  itemCount: state.dataList.length,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return GridTile(
                        child: InkWell(
                      onLongPress: () {
                        bool deleted;
                        showMenu(
                                context: context,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                color: Colors.grey.shade800,
                                position: RelativeRect.fromDirectional(
                                    textDirection: TextDirection.ltr,
                                    start: 150,
                                    top: double.infinity,
                                    end: 150,
                                    bottom: 0),
                                items: [
                              PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ],
                                  ))
                            ])
                            .then((value) async => {if (value == 'delete') {
                              context.read<NoteBloc>().add(DeleteDataEvent(noteId: state.dataList[index].id!))
                        }});
                      },
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteDetailsPage(noteModel: state.dataList[index], index: index,)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorList[state.dataList[index].mColor].withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.dataList[index].title,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                state.dataList[index].date,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  });
            else
              return Center(
                child: Text(
                  "Loading...", style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              );
          },
        ));
  }
}
