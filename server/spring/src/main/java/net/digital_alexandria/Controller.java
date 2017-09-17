package net.digital_alexandria;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.sql.*;

/**
 * @author Simon Dirmeier {@literal mail@simon-dirmeier.net}
 */
@RequestMapping("/")
@RestController
public class Controller
{
    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public String index()
    {
        return "Hello World";
    }


    @RequestMapping(
      path = "db",
      method = RequestMethod.GET)
    @ResponseBody
    public String db()
    {
        Connection conn = null;
        StringBuilder sb = new StringBuilder();
        try
        {
            String url = "JDBC:sqlite:/Users/simondi/PHD/data/data" +
                         "/target_infect_x" +
                         "/database/tix_index.db";
            conn = DriverManager.getConnection(url);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * from META;");
            int columnCount = rs.getMetaData().getColumnCount();
            while (rs.next())
            {
                for (int i = 0; i < columnCount; i++)
                {
                    sb.append(rs.getString(i + 1) + "\t");
                }
                sb.append("\n");
            }
            rs.close();
            stmt.close();
        }
        catch (SQLException e)
        {
            System.out.println(e.getMessage());
        }
        finally
        {
            try
            {
                if (conn != null)
                {
                    conn.close();
                }
            }
            catch (SQLException ex)
            {
                System.out.println(ex.getMessage());
            }
        }
        return sb.toString();
    }
}
