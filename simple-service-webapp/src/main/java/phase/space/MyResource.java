package phase.space;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.io.PrintWriter;

import javax.naming.InitialContext;
import javax.naming.Context;
import javax.sql.DataSource;
import javax.naming.NamingException;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.ResultSet;

import java.io.*;

/**
 * Root resource (exposed at "myresource" path)
 */
@Path("myresource")
public class MyResource {

    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getIt() throws Exception{
         Context context = new InitialContext();
                Context envCtx = (Context) context.lookup("java:comp/env");
                DataSource   ds =  (DataSource)envCtx.lookup("jdbc/govhack");
                Connection c=ds.getConnection();
                Statement st=c.createStatement();
                ResultSet rs=st.executeQuery("select suburb,postcode from suburbs;");
 
		String res=new String();

		//Quick and dirty: add XML header
		res="<?xml version=\"1.0\" standalone='yes'?>\n\n";
                while(rs.next()){
                        String name=rs.getString(1);
                        String postcode=rs.getString(2);
			Suburb tempSuburb = new Suburb(name, postcode);
			res=res+"<suburb>\n";
			res=res+"\t<name>"+tempSuburb.name+"</name>\n";
			res=res+"\t<postcode>"+tempSuburb.postcode+"</postcode>\n";
			res=res+"</suburb>\n";
			//'res' is a string. Should be using Append? 
			// syntax below is wrong
			//res.append(tempSuburb.name);
                }

                rs.close();
                st.close();

       return res;
    }
}
