package odu_pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import odu_member.MemberDAO;

public class PdsDAO implements IPdsDAO{
	
	boolean isS = true;
	
	private static PdsDAO pdsDAO;
	
	public static PdsDAO getInstance(){ 
		// 어디에서 접근할 수 있게 singleton 형식을 만든다. 
		if(pdsDAO == null){
			pdsDAO = new PdsDAO();
		}
		return pdsDAO;
	}

	@Override
	public List<PdsDTO> getPDSList() {
		

		String sql=" SELECT SEQ, ID, TITLE, CONTENT, "
				+ " FILENAME, READCOUNT, DOWNCOUNT, REGIDATE "
				+ " FROM PDS "
				+ " ORDER BY SEQ ASC ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		List<PdsDTO> list= new ArrayList<PdsDTO>(); 
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success getPDSList");
			
			psmt=conn.prepareStatement(sql);
			log("3/6 Success getPDSList");
			
			rs=psmt.executeQuery();
			log("4/6 Success getPDSList");
			
			while(rs.next()){
				int i=1;
				PdsDTO pd= new PdsDTO(
							rs.getInt(i++),		// seq
							rs.getString(i++),  // id
							rs.getString(i++), 	// title
							rs.getString(i++), 	// content
							rs.getString(i++), 	// filename
							rs.getInt(i++),		// readcount
							rs.getInt(i++),		// downcount
							rs.getString(i++) 	// regidate
						);
				list.add(pd);
			}
			log("5/6 Success getPDSList");
		}catch(SQLException e){
			log("Fail getPDSList", e);
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getPDSList");
		}
		
		return list;
	}
	
	@Override
	public boolean uploadPDS(PdsDTO pds) {

		String sql = " INSERT INTO PDS( "
				+ " SEQ, ID, TITLE, CONTENT, FILENAME, "
				+ " READCOUNT, DOWNCOUNT, REGIDATE) "
				+ " VALUES(SEQ_PDS.NEXTVAL, "
				+ " ?, ?, ?, ?, 0, 0, SYSDATE) ";
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		try{
			conn = MemberDAO.getConnection();
			log("2/6 Success writePDS");
			
			psmt = conn.prepareStatement(sql);
			log("3/6 Success writePDS");
			
			int i=1;
			psmt.setString(i++, pds.getId());
			psmt.setString(i++, pds.getTitle());
			psmt.setString(i++, pds.getContent());
			psmt.setString(i++, pds.getFilename());
			log("4/6 Success writePDS");
			count = psmt.executeUpdate();
			log("5/6 Success writePDS");
		}catch(SQLException	 e){
			log("Fail writePDS");
		}finally {
			MemberDAO.close(conn, psmt, null);
			log("6/6 Success writePDS");
		}
		
		return count>0? true:false;
	}

	@Override
	public boolean downloadCount(int pdsid) {
		String sql = " UPDATE PDS SET "
				   + " DOWNCOUNT = DOWNCOUNT+1 "
				   + " WHERE SEQ = ? ";
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		try{
			conn = MemberDAO.getConnection();
			log("2/6 Success downloadCount");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pdsid);
			log("3/6 Success downloadCount");
			
			count = psmt.executeUpdate();
			log("4/6 Success downloadCount");
		}catch(SQLException e){
			log("Fail downloadCount");
		}finally {
			MemberDAO.close(conn, psmt, null);
			log("6/6 Success downloadCount");
		}
		return count>0? true:false;
	}

	@Override
	public boolean writePDS(PdsDTO pds) {
		String sql = " INSERT INTO PDS "
				   + " (SEQ, ID, TITLE, CONTENT, "
				   + " FILENAME, READCOUNT, DOWNCOUNT, REGIDATE) "
				   + " VALUES(SEQ_PDS.NEXTVAL, ?, ?, ?, ?, 0, 0, SYSDATE) ";
		
		/*사용안함.*/
		return false;
	}

	@Override
	public PdsDTO detailPDS(int seq) {
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, FILENAME, READCOUNT, DOWNCOUNT, REGIDATE FROM PDS "
				   + " where seq = " + seq +" ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		PdsDTO pd = null;
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success detailPDS");
			
			psmt=conn.prepareStatement(sql);
		
			log("3/6 Success detailPDS");
			
			rs=psmt.executeQuery();
			log("4/6 Success detailPDS");
			
			while(rs.next()){
				int i=1;
				int seq1 = rs.getInt(i++);
				String id = rs.getString(i++);
				String title = rs.getString(i++);
				String content = rs.getString(i++);
				String filename = rs.getString(i++);
				int readcount = rs.getInt(i++);
				int downcount = rs.getInt(i++);
				String regidate = rs.getString(i++);
	
				pd = new PdsDTO(seq1, id, title, content, filename, readcount, downcount, regidate);
			}
			System.out.println(pd.toString());
			log("5/6 Success detailPDS");
		}catch(SQLException e){
			log("Fail detailPDS");
		}finally {
			MemberDAO.close(conn, psmt, null);
			log("6/6 Success detailPDS");
		}
		
		return pd;
	}

	public void log(String msg){
		if(isS){
			System.out.println(getClass() + ": " + msg);
		}
	}

	public void log(String msg, Exception e){
		if(isS){
			System.out.println(e + ": " + getClass() + ": " + msg);
		}
	}
}
