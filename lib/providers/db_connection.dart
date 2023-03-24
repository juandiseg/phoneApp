import 'package:mysql1/mysql1.dart';

class DatabaseConnection {
  MySqlConnection? _connection;

  DatabaseConnection() {
    _initConnection();
  }

  Future<void> _initConnection() async {
    _connection = await MySqlConnection.connect(
      ConnectionSettings(
        // ipconfig find the ip address of db server
        host: 'localhost',
        port: 3306,
        // change it to burak
        user: 'root',

        password: 'Onur@1996',
        db: 'beatneat',
      ),
    );
  }

  Future<MySqlConnection> getConnection() async {
    if (_connection == null) {
      await _initConnection();
    }
    return _connection!;
  }
}