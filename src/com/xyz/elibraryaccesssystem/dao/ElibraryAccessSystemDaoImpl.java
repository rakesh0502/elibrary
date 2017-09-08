package com.xyz.elibraryaccesssystem.dao;

import java.io.File;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ConnectionCallback;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.support.rowset.ResultSetWrappingSqlRowSet;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.xyz.elibraryaccesssystem.beans.Document;
import com.xyz.elibraryaccesssystem.beans.DocumentDiscipline;
import com.xyz.elibraryaccesssystem.beans.DocumentType;
import com.xyz.elibraryaccesssystem.beans.FileData;
import com.xyz.elibraryaccesssystem.beans.Registration;
import com.xyz.elibraryaccesssystem.beans.User;
import com.xyz.elibraryaccesssystem.exception.ElibraryException;
import com.xyz.elibraryaccesssystem.logging.ElibraryLogging;


@SuppressWarnings("unchecked")
@Repository("eLibDao")
public class ElibraryAccessSystemDaoImpl extends JdbcDaoSupport implements ElibraryAccessSystemDaoInterface {

	@Autowired
	private DataSource dataSource;
	
Logger myLog;
	
	public ElibraryAccessSystemDaoImpl()
	{
		myLog = Logger.getLogger(ElibraryLogging.class);
	}

	@PostConstruct
	private void initialize() {
		setDataSource(dataSource);
	}

	@Override
	public boolean getMembership(String userId) {
		return false;
	}

	/*
	 * *********************************************************
	 * Add Document Module
	 * Developed By -Shraddha Verma
	 * 
	 * ************* ************************** *************
	 */
	
	public boolean fileUpload(FileData fileData) throws IOException
	{
		
		boolean checkUpload=false;
		MultipartFile file = fileData.getFileData();
        String fileName = null;
        InputStream inputStream = null;
        OutputStream outputStream = null;
        String basePath="D:/MOCK PROJECT/Final project/ElibraryAccessSystem/FileUploaded/";
        if (file.getSize() > 0)
        {
                inputStream = file.getInputStream();
                if (file.getSize() > 26246000) 
                {
                	
                        return checkUpload;
                }
                System.out.println("size::" + file.getSize());
                fileName =basePath+file.getOriginalFilename();
                outputStream = new FileOutputStream(fileName);
               // System.out.println("fileName:" + file.getOriginalFilename());

                int readBytes = 0;
                byte[] buffer = new byte[26246000];
                while ((readBytes = inputStream.read(buffer, 0, 26246000)) != -1)
                {
                        outputStream.write(buffer, 0, readBytes);
                }
                outputStream.close();
                inputStream.close();
		
        }
        
        if (file.getSize() == 0)
        {
        	checkUpload=false;
        	
        }
        else
        {
        	checkUpload=true;
        }
        
        	return checkUpload;
  	
        	
}
	
	
	
	public String getPath(MultipartFile file)
	{
		String path="D:/MOCK PROJECT/Final project/ElibraryAccessSystem/FileUploaded/"+file.getOriginalFilename();
		//System.out.println(path);
		return path;
	}

	@Override
	public boolean addDocument(final Document doc) {
		
		final String path=getPath(doc.getFileData());
		Object params1[] = new Object[]{doc.getDocName().toUpperCase()};
		List<Document> list = getJdbcTemplate().query("SELECT Document_Id,document_name,title,author,price,document_type_id FROM document_details_g2 WHERE upper(document_name)=?",params1, new DocumentRowMapper());
		if(list.isEmpty())
		{
		
		getJdbcTemplate().execute(new ConnectionCallback() {

			public Object doInConnection(Connection conn) throws SQLException,DataAccessException {
				PreparedStatement ps = conn
						.prepareStatement("insert into Document_Details_g2 values(elib_document_id.nextval,?,?,?,?,?,?,?,sysdate,?)");
				try {
					
					File file = new File(path);
					FileInputStream f = new FileInputStream(file);
					ps.setString(1, doc.getDocName());
					ps.setString(2, doc.getDocDescription());
					ps.setBinaryStream(3, f, (int) doc.getFileData().getSize());
					ps.setLong(4, Long.parseLong(doc.getDocTypeId()));
					ps.setLong(5, Long.parseLong(doc.getDiscplineId()));
					ps.setString(6, doc.getTitle());
					ps.setString(7, doc.getAuthor());
					ps.setDouble(8, Double.parseDouble(doc.getPrice()));
				} catch (SQLException e) {
					e.printStackTrace();
				}
				catch (FileNotFoundException e)
				{
					e.printStackTrace();
				}
				catch (DataAccessException e)
				{
					
				}
				int i = ps.executeUpdate();
				//System.out.println("ros" + i);
				return null;
			}
		});
		myLog.info("Document added successfully!!!!");
		return true;
		
		}
		
		else
		{
			return false;
		}
	}

	/*
	 * ***************************************************************************************************************
	 */
	
	
	/*
	 * *********************************************************
	 * Edit Document Module
	 * Developed By -Karun Wadhera
	 * 
	 * ************* ************************** *************
	 */
	

	@Override
	public boolean editDocument(Document doc) {
		Object params[] = new Object[]{doc.getDocName(),doc.getDocDescription(),doc.getDocTypeId(),doc.getDiscplineId(),doc.getTitle(),doc.getAuthor(),doc.getPrice(),doc.getDocId()};
		int x=getJdbcTemplate().update("update document_details_g2 SET Document_name=?,Document_description=?,document_type_id=?,discipline_id=?,title=?,author=?,price=? where Document_id=?",params);
		if(x!=0){
			
			return true;
		}
		else{
			
			return false;
		}
	}

	/*
	 * ********************************
	 * Search Module * 
	 * Developed by :Sheela Shree*
	 * ********************************
	 */

	@Override
	public List<Document> searchDocument(Document doc) {
		String param = "";

		List<Document> result = null;
		String sql = "SELECT Document_Id,document_name,title,author,price,document_type_id FROM document_details_g2 WHERE ";
		String order=" ORDER BY document_name";
		if (!doc.getDocId().isEmpty()) {
			param = param + doc.getDocId() + ",";
			sql = sql + "Document_Id = ? AND ";
		}
		
		if (!doc.getDocName().isEmpty()) {

			param = param + "%" + doc.getDocName().toUpperCase() + "%" + ",";
			sql = sql + "upper(document_name) like ? AND ";
		}
		
		if (!doc.getAuthor().isEmpty()) {
			param = param + "%" + doc.getAuthor().toUpperCase() + "%" + ",";
			sql = sql + "upper(author) like ? AND ";
		}
		
		if (!doc.getTitle().isEmpty()) {
			param = param + "%" + doc.getTitle().toUpperCase() + "%" + ",";
			sql = sql + "upper(title) like ? AND ";
		}
		
		if (!doc.getDiscplineId().isEmpty()) {
			if (new Integer(doc.getDiscplineId()) != 100) {
				param = param + doc.getDiscplineId() + ",";
				sql = sql + "discipline_id=? AND ";
			} else {
				param = param + "1" + "," + "2" + "," + "3"
						+ "," + "4" + ",";
				sql = sql
						+ "(discipline_id=? OR discipline_id=? OR discipline_id=? OR discipline_id=?) AND ";
			}
		}

		if (doc.getDocTypeId() != null) {
			if (new Integer(doc.getDocTypeId()) != 100) {
				param = param + doc.getDocTypeId() + ",";
				sql = sql + "Document_Type_id=?";

			} else {
				param = param + "10002" + "," + "10001";
				sql = sql + "(Document_Type_id=? OR Document_Type_id=?)";
			}
		}

		Pattern pattern1 = Pattern.compile(",");
		String[] str = pattern1.split(param);
		Object[] params = new Object[str.length];
		for (int i = 0; i < str.length; i++) {
			params[i] = str[i];
		}
		sql=sql + order;
		result = getJdbcTemplate().query(sql, params, new DocumentRowMapper());
		myLog.info("search completed");
		return result;
	}

	class DocumentRowMapper implements RowMapper {

		@Override
		public Object mapRow(ResultSet rs, int index) throws SQLException {
			Document doc = new Document();
			doc.setDocId(rs.getInt(1) + "");
			doc.setDocName(rs.getString(2));
			doc.setTitle(rs.getString(3));
			doc.setAuthor(rs.getString(4));
			doc.setPrice(rs.getString(5));
			doc.setDocTypeId(rs.getInt(6) + "");

			return doc;
		}

	}

	/*
	 * ********************************************** Search Module
	 * Ends********
	 * ******************************************************************
	 */

	
	
	
	@Override
	public Document payment(Document doc) {
		Object[] params = new Object[]{doc.getDocId()};
		Document doc1=(Document) getJdbcTemplate().queryForObject("SELECT d.Document_Id,d.Document_Name,d.Title,d.Author,d.Price,s.Discipline_Name,t.Documeny_Type_Name,d.DOCUMENT_DESCRIPTION  from Document_details_g2 d,Disciplines_g2 s,Document_Type_Details_g2 t where d.document_id=? and d.Document_Type_Id=t.Document_Type_Id and d.Discipline_Id=s.Discipline_Id", new DocumentRowMapper1(), params);
		return doc1;
	}

	class DocumentRowMapper1 implements RowMapper {

		@Override
		public Object mapRow(ResultSet rs, int index) throws SQLException {
			Document doc = new Document();
			doc.setDocId(rs.getInt(1) + "");
			doc.setDocName(rs.getString(2));
			doc.setTitle(rs.getString(3));
			doc.setAuthor(rs.getString(4));
			doc.setPrice(rs.getString(5));
			doc.setDiscipline(rs.getString(6));
			doc.setDocumentTypeName(rs.getString(7));
			doc.setDocDescription(rs.getString(8));
			return doc;
		}

	}

	/*
	 * ********************************
	 * Login Module
	 * Developed by :Pravicha Verma
	 * Registration Module 
	 * Developed by :Sheela Shree
	 * ********************************
	 */

	@Override
	public User authenticate(User user) {
		Object params[] = new Object[] { user.getUserId(), user.getPassword() };
		List<User> li = getJdbcTemplate()
				.query("SELECT  user_id,password,user_type,first_name,last_name FROM  User_Details_g2 WHERE user_id=? AND password=?",
						params, new LoginRowMapper());
		for (User u : li) {
			if (u.getUserId() != null)
			{
				myLog.info("User successfully Logged In" +new java.util.Date().toString());
				return u;
		}}
		return null;
	}

	class LoginRowMapper implements RowMapper {
		@Override
		public Object mapRow(ResultSet rs, int index) throws SQLException {
			User user = new User();
			user.setUserId(rs.getString(1));
			user.setPassword(rs.getString(2));
			user.setUserType(rs.getString(3));
			user.setFirstName(rs.getString(4));
			user.setLastName(rs.getString(5));
			return user;
		}
	}

	class UserRowMapper implements RowMapper
	{
		@Override
		public Object mapRow(ResultSet rs,int index) throws SQLException
		{
			Registration user = new Registration();
			user.setFirstName(rs.getString(1));
			user.setLastName(rs.getString(2));
			return user;
			
		}
	}
	@SuppressWarnings("deprecation")
	@Override
	public boolean addUser(Registration user) {
		Object[] params = new Object[] { user.getUserId(), user.getFirstName(),
				user.getLastName(),
				new java.sql.Date(new Date(user.getDateOfBirth()).getTime()),
				user.getAddress(), user.getLandLineNumber(),
				user.getMobileNumber(), 
				user.getAreaOfInterest(), user.getGender() + "",
				user.getUserType(), user.getPassword(),user.getEmail() };
		Object[] params1 = new Object[] { user.getFirstName().toUpperCase(),user.getLastName().toUpperCase(),new java.sql.Date(new Date(user.getDateOfBirth()).getTime())};
		List<Registration> list = getJdbcTemplate().query("select first_name,last_name from user_details_g2 where upper(first_name)=? AND upper(last_name)=? AND Date_of_birth=?",params1, new UserRowMapper());
		if(list.isEmpty())
		{
		int addingUser = getJdbcTemplate()
				.update("INSERT INTO user_details_g2 VALUES(?,?,?,?,?,?,?,?,?,?,sysdate,?,?)",
						params);
		if (addingUser != 0) {
			return true;
		} else {
			return false;
		}
		}
		else
		{
			return false;
		}

	}

	@Override
	public List<DocumentDiscipline> getdId() {
		List<DocumentDiscipline> d = getJdbcTemplate().query(
				"select * from Disciplines_g2", new dIdRowMapper());
		return d;
	}

	class dIdRowMapper implements RowMapper {

		@Override
		public DocumentDiscipline mapRow(ResultSet rs, int index)
				throws SQLException {
			DocumentDiscipline d = new DocumentDiscipline();
			d.setDisciplineId(rs.getInt(1));
			d.setDisciplineName(rs.getString(2));
			return d;
		}
	}

	@Override
	public List<DocumentType> getdocumentId() {
		List<DocumentType> doct = getJdbcTemplate()
				.query("select * from Document_Type_Details_g2",
						new docTypeIdRowMapper());
		return doct;
	}

	class docTypeIdRowMapper implements RowMapper {
		@Override
		public DocumentType mapRow(ResultSet rs, int index) throws SQLException {
			DocumentType doct = new DocumentType();
			doct.setDocumenttypeId(rs.getInt(1));
			doct.setDocumenttypeName(rs.getString(2));
			return doct;
		}
	}

	@Override
	public String getUserId() {
		String userId = getJdbcTemplate().queryForObject(
				"SELECT elib_user_id.nextval FROM dual", String.class);
		return userId;
	}

	
	/*
	 * ********************************
	 * Subscription Module
	 * Developed by :Shikhar Bajpai
	 * ********************************
	 */
	
	
	@Override
	public boolean doSubscription(String userId) {
		Object[] params = new Object[] {userId };
		int check=getJdbcTemplate().update("update user_details_g2 set user_type='sub' where user_id=?",params);
		if(check>0)
			return true;
		else 
			return false;
	}
	/*
	 * ********************************
	 * Download Module
	 * Developed by :Shikhar Bajpai
	 * ********************************
	 */
	
	

	@Override
	public InputStream download(String docId) {
		String q = "select document_path from document_details_g2 where document_id= "+docId;
		SqlRowSet srs = getJdbcTemplate().queryForRowSet(q);
		ResultSet rs = ((ResultSetWrappingSqlRowSet) srs).getResultSet();
		InputStream x = null;
		try{
			while(rs.next()){
				x= rs.getBinaryStream(1);
			}
		}catch(Exception e){
			//System.out.println(e);
		}
		myLog.info("Document Downloaded successfully"+" "+docId);
		return x;
	}


}
