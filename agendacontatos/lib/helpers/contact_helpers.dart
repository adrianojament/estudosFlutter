import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

class ContactHelper {
  
  //Padrao Singleton
  static final ContactHelper _instance = ContactHelper.internal();
  factory ContactHelper() => _instance;
  ContactHelper.internal();
  //Padrao Singleton

  Database _db;

  Future<Database> get db async{
    if (_db == null) {
      _db = await initDb();
    }    
    return _db;
  }

  Future<Database> initDb() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contacts.db");

    return await openDatabase( path, version: 1, onCreate: (Database db, int newVersion) async{
      await db.execute("CREATE TABLE $contactTable( $idColumn INTEGER PRIMARY KEY, $nameColumn Text, $emailColumn TEXT, $phoneColumn TEXT, $imgColumn TEXT)");    
    });     
  }
}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;

  Contact.fromMap(Map map) {
    this.id = map[idColumn];
    this.name = map[nameColumn];
    this.email = map[emailColumn];
    this.phone = map[phoneColumn];
    this.img = map[imgColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: this.name,
      emailColumn: this.email,
      phoneColumn: this.phone,
      imgColumn: this.img
    };

    if (this.id != null) {
      this.id = map[idColumn];
    }

    return map;
  }

  @override
  String toString()=> "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
}
