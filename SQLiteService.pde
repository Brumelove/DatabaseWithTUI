/**
 * @description A Simple SQLite Helper class
 **/

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

public class SQLiteService {
  private Connection connection;
  public SQLiteService() throws ClassNotFoundException {

    try {
      Class.forName("org.sqlite.JDBC");
      connection = DriverManager.getConnection("jdbc:sqlite:C:/brume/test.db");
    }
    catch(SQLException e) {
      print(e.getMessage());
    }
  }

  /**
   * @description Executes the single query
   **/
  public int execute(String text) throws SQLException {
    Statement query= connection.createStatement();
    query.setQueryTimeout(30);
    return query.executeUpdate(text);
  }
}
