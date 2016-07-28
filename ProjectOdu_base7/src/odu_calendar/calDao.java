package odu_calendar;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import odu_bbs.bbsDTO;
import odu_member.MemberDAO;

public class calDao implements IcalDao {

	
	private boolean isS=true;
	
	private static calDao caldao;
	
	public static calDao getInstance(){
		if(caldao == null){
			caldao = new calDao();
		}
		return caldao;
	}
	
	
	@Override
	public boolean addCalendar(CalendarDTO cal) {
		
		String sql=" INSERT INTO CALENDAR( "
				+ " SEQ, ID, TITLE, CONTENT, RDATE, WDATE, NM)"
				+ " VALUES(SEQ_CALENDAR.NEXTVAL, ?, ?, ?, ?, SYSDATE, 0) ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		int count=0;
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success addCalendar");
			
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, cal.getId());
			psmt.setString(2, cal.getTitle());
			psmt.setString(3, cal.getContent());
			psmt.setString(4, cal.getRdate());
			log("3/6 Success addCalendar");
			
			count=psmt.executeUpdate();
			log("4/6 Success addCalendar");
				
		}catch(SQLException e){
			log("Fail addCalendar", e);
			
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success addCalendar");
		}
		return count>0?true:false;
	}

	
	
	
	
	@Override
	public List<CalendarDTO> getCalendarList(String id, String yyyyMM) {
		
		String sql=" SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE, NM "
				+ " FROM( "
				+ " SELECT ROW_NUMBER() OVER(PARTITION BY SUBSTR(RDATE, 1, 8) ORDER BY RDATE ASC) RN, SEQ, ID, TITLE, CONTENT, RDATE, WDATE, NM FROM CALENDAR "
				+ " WHERE ID=? AND SUBSTR(RDATE, 1, 6)=?)"
				+ " WHERE RN BETWEEN 1 AND 5 ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		List<CalendarDTO> cdtos= new ArrayList<CalendarDTO>();
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success getCalendarList");
			
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, id.trim());
			psmt.setString(2, yyyyMM.trim());
			log("3/6 Success getCalendarList");
			
			rs=psmt.executeQuery();
			log("4/6 Success getCalendarList");
			
			while(rs.next()){
				CalendarDTO	cdto = new CalendarDTO();
				int i=1;
				cdto.setSeq(rs.getInt(i++));
				cdto.setId(rs.getString(i++));
				cdto.setTitle(rs.getString(i++));
				cdto.setContent(rs.getString(i++));
				cdto.setRdate(rs.getString(i++));
				cdto.setWdate(rs.getString(i++));
				cdtos.add(cdto);
			}
			log("5/6 Success getCalendarList");
			
			
		}catch(SQLException e){
			log("Fail getCalendarList", e);
			
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getCalendarList");
			
		}
		return cdtos;
	}


	
	
	@Override
	public List<CalendarDTO> getDayList(String id, String yyyymmdd) {
		
		String sql=" SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE, NM "
				+ " FROM CALENDAR "
				+ " WHERE ID=? AND SUBSTR(RDATE, 1, 8)=? "
				+ " ORDER BY RDATE ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		List<CalendarDTO> callist = new ArrayList<CalendarDTO>();
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success getDayList");
			
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyymmdd);
			log("3/6 Success getDayList");
			
			rs=psmt.executeQuery();
			log("4/6 Success getDayList");
			
			while(rs.next()){
				int i=1;
				CalendarDTO cd=new CalendarDTO(
						rs.getInt(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++),
						rs.getString(i++)
						);
				callist.add(cd);
			}
			log("5/6 Success getDayList");
			
		}catch(SQLException e){
			log("Fail getDayList");
			
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getDayList");
		}
		
		
		return callist;
	}


	@Override
	public boolean modcal(CalendarDTO cal, int seq) {
		String sql = " UPDATE CALENDAR "
				+ " SET TITLE=?, CONTENT=?, RDATE=? "
				+ " WHERE SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		
		int count=0;
		
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success modCalendar");
			
			psmt=conn.prepareStatement(sql);
			psmt.setString(1, cal.getTitle());
			psmt.setString(2, cal.getContent());
			psmt.setString(3, cal.getRdate());
			psmt.setInt(4, seq);
			log("3/6 Success modCalendar");
			
			count=psmt.executeUpdate();
			log("4/6 Success modCalendar");
			

			
		}catch(SQLException e){
			log("Fail modCalendar", e);
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success modCalendar");
			
		}
		
		
		return count>0?true:false;
	}


	@Override
	public boolean deleteCal(int seq) {
		
		String sql=" DELETE FROM CALENDAR WHERE SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		
		int count=0;
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success deleteCal");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 Success deleteCal");
			
			count=psmt.executeUpdate();
			log("4/6 Success deleteCal");
			
		}catch(SQLException e){
			log("Fail deleteCal");
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success deleteCal");
		}
		
		return count>0?true:false;
	}


	@Override
	public CalendarDTO getCal(int seq) {
		
		
		
		String sql = " SELECT SEQ, ID, TITLE, CONTENT, RDATE, WDATE, NM "
				+ " FROM CALENDAR "
				+ " WHERE SEQ=? ";
		
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs=null;
		
		CalendarDTO cdto=null;
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success getCal");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			log("3/6 Success getCal");
			
			rs=psmt.executeQuery();
			log("4/6 Success getCal");
			
			while(rs.next()){
				int i=1;
				cdto = new CalendarDTO(
						rs.getInt(i++),			//seq
						rs.getString(i++),		//id
						rs.getString(i++),		//title
						rs.getString(i++),		//content
						rs.getString(i++),		//rdate
						rs.getString(i++)		//wdate
						);
			}
			log("5/6 Success getCal");	
		}catch(SQLException e){
			log("Fail getCal", e);
			
		}finally{
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getCal");
			
		}
		return cdto;
	}


	public void	log(String msg) {
		if(isS){
			System.out.println(getClass() + ": " + msg);
		}		
	}	
	public void	log(String msg, Exception e) {
		if(isS){
			System.out.println(e + ": " + getClass() + ": " + msg);
		}		
	}
	
	
}
