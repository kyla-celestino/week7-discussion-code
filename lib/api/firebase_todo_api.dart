import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTodoAPI { //class na nag coconnect sa firebase
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addTodo(Map<String, dynamic> todo) async {
    try { //kapag coconnect palaging asynch
      //await ng connecttion sa database
      final docRef = await db.collection("todos").add(todo);
      await db.collection("todos").doc(docRef.id).update({'id': docRef.id});

      return "Successfully added todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllTodos() {
    //naka connect sa database at kinukuha yung mga todos
    //snapshot is kinukuha yung current state ng database
    //string nirereturn kapag snapshot kinukuha
    return db.collection("todos").snapshots();
  }

  Future<String> deleteTodo(String? id) async {
    try {
      //id kinukuha kapag magdedelete
      await db.collection("todos").doc(id).delete();

      return "Successfully deleted todo!";
    } on FirebaseException catch (e) {
      return "Failed with error '${e.code}: ${e.message}";
    }
  }
}