package org.project.eis;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;

public class DBConnection {
    private Connection conn = null;
    private Statement stmt = null;

    public void AutoConnection() {
        try {
            Context initContext = new InitialContext();
            Context envContext = (Context)initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource)envContext.lookup("jdbc/uni");
            try {
                this.conn = ds.getConnection();
                this.stmt = this.conn.createStatement(1004, 1007);
            } catch (SQLException sqle) {
                sqle.printStackTrace();
            }
        } catch (NamingException e) {
            e.printStackTrace();
        }
    }
}
