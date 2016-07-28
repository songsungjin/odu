package odu_bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import odu_member.MemberDAO;

public class bbsDAO implements ibbsDAO {
	
	private boolean isS=true;
	private static bbsDAO tbbsdao;

	private bbsDAO() {
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			log("1/6 Success");
		}catch(ClassNotFoundException ex){
			log("1/6 Fail", ex);
			System.out.println(ex.getMessage());
		}
	}	

	public static bbsDAO getInstance() {
		if(tbbsdao == null){
			tbbsdao = new bbsDAO();
		}
		return tbbsdao;
	}

	@Override
	public List<bbsDTO> getbbslist() {
		String sql = " SELECT SEQ, BBS_NUM, ID, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, F_NAME, L_NAME, F_LIKE, WDATE, PARENT, "
				+ " READCOUNT, DEL "
				+ " FROM FREEBBS "
				+ " ORDER BY REF DESC, STEP ASC ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		List<bbsDTO> bbslist = new ArrayList<bbsDTO>();
		
		try{
			System.out.println("conn 저장 전.");
			conn=MemberDAO.getConnection();
			log("2/6 Success getBBSList");
			
			System.out.println("conn 저장 완료 .");
			
			psmt=conn.prepareStatement(sql);
			log("3/6 Success getBBSList");
			
			rs=psmt.executeQuery();
			log("4/6 Success getBBSList");
			while(rs.next()){
				int i=1;
				bbsDTO bb=new bbsDTO(
							rs.getInt(i++),		// seq
							rs.getInt(i++),		// bbs_num
							rs.getString(i++),	// id
							rs.getInt(i++),		// ref
							rs.getInt(i++),		// step
							rs.getInt(i++),		// depth
							rs.getString(i++),	// title
							rs.getString(i++),	// content
							rs.getString(i++),	// f_name
							rs.getString(i++),	// l_name
							rs.getInt(i++),	// f_like
							rs.getString(i++),	// wdate
							rs.getInt(i++),		// parent
							rs.getInt(i++),		// readcount
							rs.getInt(i++)		// del							
						);
				bbslist.add(bb);				
			}		
			log("5/6 Success getBBSList");
		}catch(SQLException e){
			log("Fail getBBSList", e);
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getBBSList");
		}			
		
		return bbslist;

	}
	
	//---------------------------------------------------------------
	//bbs 글쓰기
	
	@Override
	public boolean writeBBS(bbsDTO tbbs) {
		String sql=" INSERT INTO FREEBBS "
				+ " (SEQ, BBS_NUM, ID, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, F_NAME, L_NAME, F_LIKE, WDATE, PARENT, "
				+ " READCOUNT, DEL) "
				+ " VALUES(SEQ_FREEBBS.NEXTVAL, 2, 'aaa', "
				+ " 0, "
				+ " 0, 0, ?, ?, 0, 0, 0, SYSDATE, 0, 0, 0) ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		int count=0; 
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success writeBBS");
			
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, tbbs.getTitle());
			psmt.setString(2, tbbs.getContent());
			log("3/6 Success writeBBS");
			
			count=psmt.executeUpdate();
			log("4/6 Success writeBBS");
		}catch(SQLException e){
			log("Fail writeBBS", e);
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success writeBBS");
		}		
		
		return count>0?true:false;
	}

	@Override
	public void readCount(int seq) {
		String sql=" UPDATE FREEBBS SET "
				+ " READCOUNT=READCOUNT+1 "
				+ " WHERE SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success readCount");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 Success readCount");
			
			psmt.executeUpdate();
			log("4/6 Success readCount");			
			
		}catch(SQLException e){
			log("Fail readCount", e);
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success readCount");
		}		
	}
//------------------------------------------------------------------------------------
	@Override
	public bbsDTO getBBS(int seq) {
		
		String sql= " SELECT SEQ, BBS_NUM, ID, REF, STEP, DEPTH, "
				+ " TITLE, CONTENT, F_NAME, L_NAME, F_LIKE, WDATE, PARENT, "
				+ " READCOUNT, DEL "
				+ " FROM FREEBBS "
				+ " WHERE SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		bbsDTO bbs=null;
		
		try{
			conn=MemberDAO.getConnection();	
			log("2/6 Success getBBS");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 Success getBBS");
			
			rs=psmt.executeQuery();
			log("4/6 Success getBBS");
			
			while(rs.next()){
				int i=1;
				bbs = new bbsDTO(
						rs.getInt(i++),		// seq
						rs.getInt(i++),		// bbs_num
						rs.getString(i++),	// id
						rs.getInt(i++),		// ref
						rs.getInt(i++),		// step
						rs.getInt(i++),		// depth
						rs.getString(i++),	// title
						rs.getString(i++),	// content
						rs.getString(i++),	// f_name
						rs.getString(i++),	// l_name
						rs.getInt(i++),		// f_like
						rs.getString(i++),	// wdate
						rs.getInt(i++),		// parent
						rs.getInt(i++),		// readcount
						rs.getInt(i++)		// del
				);
				System.out.println("확인용 = " + rs.getInt(i++));
			}		
			log("5/6 Success getBBS");
		}catch(SQLException e){
			log("Fail getBBS");
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getBBS");
		}
		
		return bbs;
	}
	
	@Override
	public boolean repleInsert(int bbsnum, int seq, String id, String reple) {
		String sql=" INSERT INTO BBSREPLE "
				+ " (SEQ, BBS_NUM, ID, REF, STEP, "
				+ " CONTENT, WDATE, DEL) "
				+ " VALUES(SEQ_BBSREPLE.NEXTVAL, ?, ?, "
				+ " ?, "
				+ " (SELECT NVL(MAX(STEP), 0) FROM BBSREPLE WHERE SEQ=?)+1, ?, SYSDATE , 0) ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		int count=0; 
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success repleInsert");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, bbsnum);	//BBS_NUM
			psmt.setString(2, id);	//ID
			psmt.setInt(3, seq);	//REF	//원글(답글을 단 게시물의 seq)
			psmt.setInt(4, seq);	// +1
			psmt.setString(5, reple);	//reple
			
			log("3/6 Success repleInsert");
			
			count=psmt.executeUpdate();
			log("4/6 Success repleInsert");
		}catch(SQLException e){
			log("Fail repleInsert", e);
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success repleInsert");
		}		
		
		return count>0?true:false;
	}

	//---------------------------------------------------------------------
	//------리플 리스트 가져오기
	
	@Override
	public List<bbsRepleDTO> getreplelist(int bbsnum, int seq) {
		String sql = " SELECT SEQ, BBS_NUM, ID, REF, STEP, "
				+ " CONTENT, WDATE, DEL "
				+ " FROM BBSREPLE "
				+ " WHERE DEL=0 and BBS_NUM= ? and REF = ? "
				+ " ORDER BY WDATE ASC ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		List<bbsRepleDTO> replelist = new ArrayList<bbsRepleDTO>();
		
		try{
			System.out.println("conn 저장 전.");
			conn=MemberDAO.getConnection();
			log("2/6 Success getreplelist");
			
			System.out.println("conn 저장 완료 .");
			
			psmt=conn.prepareStatement(sql);
			log("3/6 Success getreplelist");
			
			psmt.setInt(1, bbsnum);
			psmt.setInt(2, seq);
			
			rs=psmt.executeQuery();
			log("4/6 Success getreplelist");
			while(rs.next()){
				int i=1;
				bbsRepleDTO bb=new bbsRepleDTO(
							rs.getInt(i++),		// seq
							rs.getInt(i++),		// bbs_num
							rs.getString(i++),	// id
							rs.getInt(i++),		// ref
							rs.getInt(i++),		// step
							rs.getString(i++),	// content
							rs.getString(i++),	// wdate
							rs.getInt(i++)		// del							
						);
				replelist.add(bb);				
			}		
			log("5/6 Success getreplelist");
		}catch(SQLException e){
			log("Fail getreplelist", e);
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getreplelist");
		}				
		return replelist;
	}
	
	//---------------------------------------------------------
	public boolean login(String loginid, String loginpw) {
		
		String sql=" SELECT ID, PW FROM MEMBER "
				+ " WHERE ID=? and pw=? ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		int count = 0;
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success login");
			
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, loginid);
			psmt.setString(2, loginpw);
			log("3/6 Success login");
			
			rs=psmt.executeQuery();
			log("4/6 Success login");
			while(rs.next()){
				count = 1;			
			}
			log("5/6 Success login");
		}catch(SQLException e){
			log("Fail login", e);
		}finally{
			MemberDAO.close(conn, psmt, rs);	
			log("6/6 Success login");
		}	
		
		return count > 0?true:false;
	}
	
	public void	log(String msg) {		
		if(isS){
			System.out.println(getClass() + ": " + msg);
		}		
	}	

	public void	log(String msg, Exception e) {
		boolean isS=true;
		if(isS){
			System.out.println(e + ": " + getClass() + ": " + msg);
		}		
	}
	
	
}
