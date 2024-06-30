// database_service.dart
import 'package:mysql1/mysql1.dart';

class DatabaseService {
  MySqlConnection? _connection;

  Future<MySqlConnection> get connection async {
    if (_connection != null) return _connection!;
    _connection = await _initDb();
    return _connection!;
  }

  Future<MySqlConnection> _initDb() async {
    final settings = ConnectionSettings(
      host: 'localhost', 
      port: 3306,
      user: 'my_user',
      password: 'my_password',
      db: 'my_db',
    );

    return await MySqlConnection.connect(settings);
  }
}