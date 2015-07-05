package phase.space;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.DefaultValue;
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


/**
 * Root resource (exposed at "myresource" path)
 */
@Path("answer")
public class Answer {

    /**
     * Method handling HTTP GET requests. The returned object will be sent
     * to the client as "text/plain" media type.
     *
     * @return String that will be returned as a text/plain response.
     */
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public String getIt(@DefaultValue("5000") @QueryParam("postcode1") int postcode1,@DefaultValue("5011") @QueryParam("postcode2") int postcode2, @DefaultValue("1") @QueryParam("question") int question_id) throws Exception{

	 // This section connects to the database and executes the query
         Context context = new InitialContext();
                Context envCtx = (Context) context.lookup("java:comp/env");
                DataSource   ds =  (DataSource)envCtx.lookup("jdbc/govhack");
                Connection c=ds.getConnection();
                PreparedStatement st=c.prepareStatement("select question.id, category.name,question.question,question.higher,question.source from question,category where question.category=category.id and question.id=?;");
		st.setInt(1,question_id);
		ResultSet rs=st.executeQuery();

		// Here's where the data is returned
       //         ResultSet rs=st.executeQuery("select question.id, category.name,question.question,question.higher from question,category where question.category=category.id;");
 
		String res=new String();


		//Creating an empty XML Document
            	DocumentBuilderFactory dbfac = DocumentBuilderFactory.newInstance();
            	DocumentBuilder docBuilder = dbfac.newDocumentBuilder();
            	Document doc = docBuilder.newDocument();		

		Element root = doc.createElement("answer");
		doc.appendChild(root);

		//Quick and dirty: add XML header
		//res="<?xml version=\"1.0\" standalone='yes'?>\n\n";
                
		if(rs.next()){
                        int id=rs.getInt(1);
                        String category=rs.getString(2);
                        String question=rs.getString(3);
			String higher=rs.getString(4);
			String source=rs.getString(5);

			//Add the suburbs to the XML file
           		Element q = doc.createElement("question");
            		q.setAttribute("category",category);
			if(higher.equalsIgnoreCase("H")){
            			q.setAttribute("higher", "higher");
			}
			else if(higher.equalsIgnoreCase("L")){
            			q.setAttribute("higher", "lower");
			}
			
			q.appendChild(doc.createTextNode(question));
            		root.appendChild(q);


			PreparedStatement st2=c.prepareStatement("select * from "+source+" where postcode in (?,?);");
                	st2.setInt(1,postcode1);
			st2.setInt(2,postcode2);
                	ResultSet rs2=st2.executeQuery();
			while (rs2.next()){
				int pcr=rs2.getInt(1);
				int val=rs2.getInt(2);
				Element pc = doc.createElement("postcode");
                     		pc.setAttribute("postcode",Integer.toString(pcr));
                     		pc.setAttribute("val",Integer.toString(val));
				root.appendChild(pc);
			}
                }
		else{
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

			//res=res+"<suburb>\n";
			//res=res+"\t<name>"+tempSuburb.name+"</name>\n";
			//res=res+"\t<postcode>"+tempSuburb.postcode+"</postcode>\n";
			//res=res+"</suburb>\n";
			//'res' is a string. Should be using Append? 
			// syntax below is wrong
			//res.append(tempSuburb.name);

                rs.close();
                st.close();

       return res;
    }
}
