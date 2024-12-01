import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class todo1 extends StatefulWidget {
  const todo1({super.key});

  @override
  State<todo1> createState() => _todo1State();
}

class ToDoModelClass {
  String title;
  String description;
  String date;

  ToDoModelClass({
    required this.title,
    required this.description,
    required this.date,
  });
}

class _todo1State extends State<todo1> {
  List<ToDoModelClass> todoList = [];
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  void showBottomSheet(bool doedit, [ToDoModelClass? toDoModelObj]) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        isDismissible: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,

              ///TO AVOID THE KEYBOARD OVERLAP THE SCREEN
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Create Task",
                  // style: GoogleFonts.quicksand(
                  //   fontWeight: FontWeight.w600,
                  //   fontSize: 22,
                  // ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Title",
                      // style: GoogleFonts.quicksand(
                      //   color: const Color.fromRGBO(0, 139, 148, 1),
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: 15,
                      // ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Description",
                      // style: GoogleFonts.quicksand(
                      //   color: const Color.fromRGBO(0, 139, 148, 1),
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: 15,
                      // ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Date",
                      // style: GoogleFonts.quicksand(
                      //   color: const Color.fromRGBO(0, 139, 148, 1),
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: 15,
                      // ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.date_range_rounded),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 139, 148, 1),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.purpleAccent),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025),
                        );
                        String formatedDate =
                            DateFormat.yMMMd().format(pickeddate!);
                        setState(() {
                          dateController.text = formatedDate;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
                    ),
                    onPressed: () {
                      doedit ? submit(doedit, toDoModelObj) : submit(doedit);

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Submit",
                      // style: GoogleFonts.inter(
                      //   color: Colors.white,
                      //   fontWeight: FontWeight.w700,
                      //   fontSize: 20,
                      // ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }

  void submit(bool doedit, [ToDoModelClass? toDoModelObj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doedit) {
        setState(() {
          todoList.add(
            ToDoModelClass(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              date: dateController.text.trim(),
            ),
          );
        });
      } else {
        setState(() {
          toDoModelObj!.date = dateController.text.trim();
          toDoModelObj.title = titleController.text.trim();
          toDoModelObj.description = descriptionController.text.trim();
        });
      }
    }
    clearController();
  }

  ///TO CLEAR ALL THE TEXT EDITING CONTROLLERS
  void clearController() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  ///REMOVE NOTES
  void removeTasks(ToDoModelClass toDoModelObj) {
    setState(() {
      todoList.remove(toDoModelObj);
    });
  }

  void editTask(ToDoModelClass toDoModelObj) {
//ASSIGN THE TEXT EDITING CONTROLLERS WITH THE TEXT VALUES AND THEN OPEN THE BOTTOM SHEET
    titleController.text = toDoModelObj.title;
    descriptionController.text = toDoModelObj.description;
    dateController.text = toDoModelObj.date;
    showBottomSheet(true, toDoModelObj);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    dateController.dispose();
    descriptionController.dispose();
  }

  var listOfColors = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 45),
            child: Text(
              "Good Morning",
              // style: GoogleFonts.quicksand(
              //     fontSize: 22, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "Saurabh Gheware",
              // style: GoogleFonts.quicksand(
              //     fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Your to-do List",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: ListView.builder(
                            itemCount: todoList.length,
                            itemBuilder: (context, index) {
                              return Slidable(
                                useTextDirection: true,
                                closeOnScroll: true,
                                endActionPane: ActionPane(
                                  extentRatio: 0.2,
                                  motion: const ScrollMotion(),
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              editTask(todoList[index]);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    89, 57, 241, 1),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              removeTasks(todoList[index]);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    89, 57, 241, 1),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                key: ValueKey(index),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 16,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 90,
                                    //height: 618,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(2, 2),
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.08),
                                            spreadRadius: 0.8,
                                            blurRadius: 20,
                                          )
                                        ],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(40),
                                            //topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          height: 53,
                                          width: 53,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.network(
                                            "https://w7.pngwing.com/pngs/670/265/png-transparent-checkmark-done-exam-list-pencil-todo-xomo-basics-icon-thumbnail.png",
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              todoList[index].title,
                                              // style: GoogleFonts.quicksand(
                                              //   fontWeight: FontWeight.w600,
                                              //   fontSize: 15,
                                              //   color: const Color.fromRGBO(
                                              //       0, 0, 0, 1),
                                              // ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              todoList[index].description,
                                              // style: GoogleFonts.quicksand(
                                              //   fontSize: 12,
                                              //   fontWeight: FontWeight.w500,
                                              //   color: const Color.fromARGB(
                                              //       255, 0, 0, 0),
                                              // ),
                                            ),
                                            Text(
                                              todoList[index].date,
                                              // style: GoogleFonts.quicksand(
                                              //   fontSize: 12,
                                              //   fontWeight: FontWeight.w400,
                                              //   color: const Color.fromARGB(
                                              //       255, 0, 0, 0),
                                              // ),
                                            ),
                                          ],
                                        )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.check_circle,
                                              size: 20,
                                              color: Colors.green,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
        onPressed: () {
          clearController();
          showBottomSheet(false);
        },
        child: const Icon(
          size: 50,
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
