import 'package:mysql1/mysql1.dart';
class MYSQL {
    static var settings = ConnectionSettings(
        host: 'sql6.freemysqlhosting.net',
        port: 3306,
        user: 'sql6457997',
        password: 'GeBiTq6TPJ',
        db: 'sql6457997'
    );
    static var _connected = false;
    static late MySqlConnection _connection;

    static bool get connected => _connected;

    static Future<void> connect()async{
      _connection=await MySqlConnection.connect(settings);
      _connected = true;
      print("Connected");
    }

    static Future<Results> query(query)async{
      return await _connection.query(query);
    }
}