package phase.space;

import javax.ws.rs.*;
//import javax.ws.rs.Path;
//import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.io.PrintWriter;

import javax.naming.InitialContext;
import javax.naming.Context;
import javax.sql.DataSource;
import javax.naming.NamingException;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.io.*;

import org.w3c.dom.*;

import javax.xml.parsers.*;

import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;


@Path("getsuburbsbystate")
public class SuburbsByState {

    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
    @GET
    @Produces(MediaType.TEXT_XML)
//    @Produces(MediaType.TEXT_PLAIN)
    public String getSuburbsByState(
		@DefaultValue("SA") @QueryParam("state") String requestedState) throws Exception{
		
		requestedState.toUpperCase();

		// This section connects to the database and executes the query
		Context context = new InitialContext();
                Context envCtx = (Context) context.lookup("java:comp/env");
                DataSource   ds =  (DataSource)envCtx.lookup("jdbc/govhack");
                Connection c=ds.getConnection();

		PreparedStatement st = c.prepareStatement("select * from postcode_and_state where state like ?;");

		st.setString(1,requestedState);

                ResultSet rs=st.executeQuery();

		// This function assumes the standard format for a query on the Suburbs table
		String result = suburbsToXML(rs, requestedState);

                rs.close();
                st.close();


	//return query;
       return result;
    }

    protected String suburbsToXML(ResultSet rs, String state){

	String res = "";	
	//Creating an empty XML Document
	try {
		DocumentBuilderFactory dbfac = DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder = dbfac.newDocumentBuilder();
		Document doc = docBuilder.newDocument();		

		Element root = doc.createElement("xml");
		root.setAttribute("version", "1.0");
		root.setAttribute("encoding", "UTF-8");
		doc.appendChild(root);
		
		Element wrapper = doc.createElement("suburbs");
		wrapper.setAttribute("state", state);
		root.appendChild(wrapper);

		while(rs.next()){
			String name=rs.getString(1);
			String postcode=rs.getString(2);
			Suburb tempSuburb = new Suburb(name, postcode);

			//Add the suburbs to the XML file
			Element suburb = doc.createElement("suburb");
			suburb.setAttribute("name", name);
			suburb.setAttribute("postcode", postcode);
			wrapper.appendChild(suburb);

		}

		// Convert the XML file back into a string.. 

		//set up a transformer
		TransformerFactory transfac = TransformerFactory.newInstance();
		Transformer trans = transfac.newTransformer();
		trans.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
		trans.setOutputProperty(OutputKeys.INDENT, "yes");

		//create string from xml tree
		StringWriter sw = new StringWriter();
		StreamResult result = new StreamResult(sw);
		DOMSource source = new DOMSource(doc);
		trans.transform(source, result);
		res = sw.toString();

	} catch (Exception e) {
		res = "Error creating XML doc";
		res = res + e.getMessage();
	}


	return res;
    } 
}
