package odu_poll;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.List;

import odu_member.MemberDAO;

public class PollDAO implements IPollDAO {
	
	private boolean isS = true;
	private static PollDAO pollDAO;
	
	public static PollDAO getInstance(){ 
		// 어디에서 접근할 수 있게 singleton 형식을 만든다. 
		if(pollDAO == null){
			pollDAO = new PollDAO();
		}
		return pollDAO;
	}
	
	
	@Override
	public List<pollDTO> getPollAllList() {
		
		String sql = " SELECT POLLID, ID, QUESTION, "
				   + " SDATE, EDATE, ITEMCOUNT, "
				   + " POLLTOTAL, REGIDATE "
				   + " FROM SIST_POLL "
				   + " ORDER BY SDATE DESC ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<pollDTO> pLists = new ArrayList<pollDTO>();
		
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success getPollAllList");
			
			psmt=conn.prepareStatement(sql);
			log("3/6 Success getPollAllList");
			
			rs=psmt.executeQuery();
			log("4/6 Success getPollAllList");
			
			while(rs.next()){
				int i = 1;
				pollDTO dto = new pollDTO(
							rs.getInt(i++),			// pollid
							rs.getString(i++),		// id
							rs.getString(i++),		// question
							rs.getDate(i++),		// sdate
							rs.getDate(i++),		// edate
							rs.getInt(i++),			// itemcount
							rs.getInt(i++),			// polltotal
							rs.getDate(i++) 		// regidate
						);
				pLists.add(dto);
			}
		}catch(SQLException e){
			log("Fail getPollAllList");
		}finally {
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getPollAllList");
		}
		return pLists;
	}
	
	
	@Override
	public boolean isVote(VoterDTO dto) {	//투표를 했는지 않했는지 구분해준다
		
		String sql = " SELECT VOTERID, POLLSUBID, ID, REGIDATE "
				   + " FROM SIST_VOTER "
				   + " WHERE POLLID = ? AND ID = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		boolean isS = false;
		try{
			conn=MemberDAO.getConnection();
			log("2/6 Success isVote");
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, dto.getPollid());
			psmt.setString(2, dto.getId());
			log("3/6 Success isVote");
			
			rs=psmt.executeQuery();
			log("4/6 Success isVote");
			
			if(rs.next()){
				isS=true;		// 투표를 했다.
			}
			log("5/6 Success isVote");
		}catch(SQLException e){
			log("Fail isVote");
		}finally {
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success isVote");
		}
		return isS;
	}
	
	@Override
	public boolean makePoll(PollBean dto) {
		
		// 문제
		String sql1 = " INSERT INTO SIST_POLL "
				    + " (POLLID, ID, QUESTION, SDATE, EDATE, "
				    + " ITEMCOUNT, POLLTOTAL, REGIDATE) "
				    + " VALUES(SIST_POLL_SEQ.NEXTVAL, "
				    + " ?, ?, ?, ?, ?, "
				    + " 0, SYSDATE) ";
		String sql2 = " SELECT NVL(MAX(POLLID), 0) FROM SIST_POLL ";
		
		// 보기
		String sql3 = " INSERT INTO SIST_POLLSUB "
					+ " (POLLSUBID, POLLID, ANSWER, ACOUNT) "
					+ " VALUES(SIST_POLLSUB_SEQ.NEXTVAL, "
					+ " ?, ?, 0) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int pollsubid = -1;
		int count = 0;
		try{
			conn=MemberDAO.getConnection();
			conn.setAutoCommit(false);			
			log("2/6 Success makePoll");
			
			psmt=conn.prepareStatement(sql1);
			int i=1;
			psmt.setString(i++, dto.getId());
			psmt.setString(i++, dto.getQuestion());
			psmt.setDate(i++, toDate(dto.getSyear(), dto.getSmonth(), dto.getSday()));
			psmt.setDate(i++, toDate(dto.getEyear(), dto.getEmonth(), dto.getEday()));
			psmt.setInt(i++, dto.getItemcount());			
			count=psmt.executeUpdate();
			
			psmt.clearParameters();
			
			psmt=conn.prepareStatement(sql2);
			rs=psmt.executeQuery();
			if(rs.next()){
				pollsubid=rs.getInt(1);
			}
			
			psmt.clearParameters();
			
			psmt=conn.prepareStatement(sql3);
			
			String[] pollnums=dto.getPollnum();
			
			for(int j = 0;j < dto.getItemcount(); j++){
				i = 1;
				psmt.setInt(i++, pollsubid);
				psmt.setString(i++, pollnums[j]);
				psmt.addBatch();
			}
			log("3/6 Success makePoll");
			psmt.executeBatch();
			
			log("4/6 Success makePoll");
			conn.commit();
		}catch(SQLException e){
			log("Fail makePoll");
			try {
				conn.rollback();
			} catch (SQLException e1) {}
		}finally {
			try{
				conn.setAutoCommit(true);
			}catch(SQLException e){}
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success makePoll");
		}
		return count > 0? true:false;
	}
	
	@Override
	public pollDTO getPoll(int pollid) {
		
		String sql = " SELECT POLLID, ID, QUESTION, "
				   + " SDATE, EDATE, ITEMCOUNT, "
				   + " POLLTOTAL, REGIDATE "
				   + " FROM SIST_POLL "
				   + " WHERE POLLID = ?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		pollDTO pdto = null;
		try{
			conn=MemberDAO.getConnection();			
			log("2/6 Success getPoll");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, pollid);
			log("3/6 Success getPoll");
			
			rs = psmt.executeQuery();
			log("4/6 Success getPoll");
			while(rs.next()){
				int i = 1;
				pdto = new pollDTO(
						rs.getInt(i++),			// pollid
						rs.getString(i++),		// id
						rs.getString(i++),		// question
						rs.getDate(i++),		// sdate
						rs.getDate(i++),		// edate
						rs.getInt(i++),			// itemcount
						rs.getInt(i++),			// polltotal
						rs.getDate(i++) 		// regidate
							
						);
			}
			log("5/6 Success getPoll");
		}catch(SQLException e){
			log("Fail getPoll");
		}finally {
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getPoll");
		}
		return pdto;
	}

	@Override
	public List<pollSubDTO> getPollSubList(int pollid) {
		
		String sql = " SELECT POLLSUBID, POLLID, ANSWER, ACOUNT "
				   + " FROM SIST_POLLSUB "
				   + " WHERE POLLID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<pollSubDTO> pLists = new ArrayList<pollSubDTO>();
		try{
			conn=MemberDAO.getConnection();			
			log("2/6 Success getPollSubList");
			
			psmt=conn.prepareStatement(sql);
			psmt.setInt(1, pollid);
			log("3/6 Success getPollSubList");
			rs = psmt.executeQuery();
			log("4/6 Success getPollSubList");
			while(rs.next()){
				int i = 1;
				pollSubDTO dto = new pollSubDTO(
							rs.getInt(i++),
							rs.getInt(i++),
							rs.getString(i++),
							rs.getInt(i++)
						);
				pLists.add(dto);
			}
			log("5/6 Success getPollSubList");
		}catch(SQLException e){
			log("Fail getPollSubList");
		}finally {
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success getPollSubList");
		}
		return pLists;
	}

	@Override
	public boolean polling(VoterDTO dto) {
		// 투표한 사람의 정보 저장
		String sql1 = " INSERT INTO SIST_VOTER( "
					+ " VOTERID, POLLID, POLLSUBID, "
					+ " ID, REGIDATE) "
					+ " VALUES( "
					+ " SIST_VOTER_SEQ.NEXTVAL, "
					+ " ?, ?, ?, SYSDATE) ";
		// 보기들을 가지고 있는 PollSubDTO의  카운트를 올려준다
		String sql2 = " UPDATE SIST_POLLSUB SET "
					+ " ACOUNT=ACOUNT+1 "
					+ " WHERE POLLID=? AND POLLSUBID=? ";
		// PollDTO 투표할 주제로 해당 투표항목에 투표를 몇명이 했는지
		String sql3 = " UPDATE SIST_POLL SET "
					+ " POLLTOTAL = POLLTOTAL + 1 "
					+ " WHERE POLLID = ? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		int count = 0;
		try{
			conn=MemberDAO.getConnection();			
			conn.setAutoCommit(false);
			log("2/6 Success polling");
			
			psmt=conn.prepareStatement(sql1);
			int i = 1;
			psmt.setInt(i++, dto.getPollid());		// 문제번호
			psmt.setInt(i++, dto.getPollsubid());	// 선택한 보기
			psmt.setString(i++, dto.getId()); 		// 투표한 사람정보
			log("3/6 Success polling - 1");
			count=psmt.executeUpdate();
			log("4/6 Success polling - 1");
			// ------------------------------------------ sql1
			psmt.clearParameters();
			psmt=conn.prepareStatement(sql2);
			i = 1;
			psmt.setInt(i++, dto.getPollid());
			psmt.setInt(i++, dto.getPollsubid());
			log("3/6 Success polling - 2");
			count = count*psmt.executeUpdate();
			log("4/6 Success polling - 2");
			// ------------------------------------------ sql2
			psmt.clearParameters();
			psmt=conn.prepareStatement(sql3);
			i = 1;
			psmt.setInt(i++, dto.getPollid());
			log("3/6 Success polling - 3");
			count = count*psmt.executeUpdate();
			log("4/6 Success polling - 3");
			// ------------------------------------------ sql3
			
			conn.commit();
			log("5/6 Success polling");
		}catch(SQLException e){
			log("Fail polling");
			try {
				conn.rollback();
			} catch (SQLException e1) {}
		}finally {
			try {
				conn.setAutoCommit(true);
			} catch (SQLException e) {}
			MemberDAO.close(conn, psmt, rs);
			log("6/6 Success polling");
		}
		return count > 0? true:false;
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
	
	public static String str(String msg){
		return msg == null? "":msg.trim();
	}
	
	public Date toDate(int year, int month, int day){
		String s = year + "-" + two(month + "") + "-" + two(day + "");
		Date d = Date.valueOf(s);
		return d;
	}
	public String two(String msg){	// 2 -> 02
		return msg.trim().length() < 2? "0"+msg : msg.trim();
	}
}
