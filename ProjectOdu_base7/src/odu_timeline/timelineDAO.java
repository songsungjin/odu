package odu_timeline;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import odu_member.MemberDAO;


public class timelineDAO implements ItimelineDAO {
   
   private boolean isS=true;
   private static timelineDAO timelinedao;
   
   private timelineDAO(){
      try {
         // 오라클 부분에 연동되는 코드
         Class.forName("oracle.jdbc.driver.OracleDriver");   
      } catch (ClassNotFoundException ex) {
         System.out.println(ex.getMessage());
         log("1/6 Fail", ex);
      }
   }
   
   public static timelineDAO getInstance(){
      if(timelinedao == null){
         timelinedao = new timelineDAO();
      }
      return timelinedao;
   }
   
   
   // 타임라인에 글 뿌리기
   @Override
   public List<timelineDTO> getTimeLineList(String id) {
      
      String sql = " SELECT SEQ, BBS_NUM, ID, CONTENT, F_NAME, T_LIKE, WDATE, DEL, T_LIKE_ID "
               + " FROM TIMELINE "
               + " WHERE ID=? AND DEL=0 "
               + " OR ID=(SELECT U_ID FROM MYPEOPLE WHERE M_ID=?) AND DEL=0 "
               + " ORDER BY SEQ DESC ";   // 여기에 이제 자기가 쓴 글과 친구가 쓴 글 아이디를 추가      
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      List<timelineDTO> list = new ArrayList<timelineDTO>();
      
      try{
         conn = MemberDAO.getConnection();
         log("2/6 Success getTimeLineList");
         
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, id);
         psmt.setString(2, id);
         log("3/6 Success getTimeLineList");
         
         rs = psmt.executeQuery();
         log("4/6 Success getTimeLineList");
         
         while(rs.next()){
            int i = 1;
            timelineDTO tdto = new timelineDTO(
                                 rs.getInt(i++),         // seq
                                 rs.getInt(i++),         // bbs_num
                                 rs.getString(i++),      // id
                                 rs.getString(i++),      // content
                                 rs.getString(i++),      // f_name
                                 rs.getInt(i++),         // t_like
                                 rs.getString(i++),      // wdate
                                 rs.getInt(i++),         // del
                                 rs.getString(i++)      // t_like_id
                              );
            list.add(tdto);
         }
         log("5/6 Success getTimeLineList");
      }catch (SQLException e) {
         log("Fail getTimeLineList", e);
      }finally {
         MemberDAO.close(conn, psmt, rs);
         log("6/6 Success getTimeLineList");
      }
      return list;
   }
   
   
   // 타임라인에 글 쓰기
   @Override
   public boolean writeTimeLine(timelineDTO tdto) {
      // L_NAME은 빼고 삽입함.
      String sql = " INSERT INTO TIMELINE "
               + " (SEQ, BBS_NUM, ID, CONTENT, F_NAME, T_LIKE, WDATE, DEL) "
               + " VALUES (SEQ_TIMELINE.NEXTVAL, "
               + " 1,"
               + " ?, ?, ?, 0, SYSDATE, 0) ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      
      int count = 0;
      System.out.println(sql);
      try{
         conn = MemberDAO.getConnection();
         log("2/6 Success writeTimeLine");
         
         psmt = conn.prepareStatement(sql);
         int i = 1;
         psmt.setString(i++, tdto.getId());
         psmt.setString(i++, tdto.getContent());
         psmt.setString(i++, tdto.getF_name());
         log("3/6 Success writeTimeLine");
         
         count = psmt.executeUpdate();
         log("4/6 Success writeTimeLine");
      }catch(SQLException e){
         log("Fail writeTimeLine", e);
      }finally {
         MemberDAO.close(conn, psmt, null);
         log("5/6 Success writeTimeLine");
      }   
      return count>0?true:false;
   }
   
   
   
   // 타임라인 글 삭제
   @Override
   public boolean delTimeLine(int seq, String id) {
      String sql = " UPDATE TIMELINE SET DEL=1 "
               + " WHERE SEQ=? AND ID=? ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      
      int count = 0;
      
      try{
         conn = MemberDAO.getConnection();
         log("2/6 Success delTimeLine");
         
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, seq);
         psmt.setString(2, id);
         log("3/6 Success delTimeLine");
         
         count = psmt.executeUpdate();
         log("4/6 Success delTimeLine");
         
      }catch(SQLException e){
         log("Fail delTimeLine", e);
      }finally{
         MemberDAO.close(conn, psmt, null);
         log("5/6 Success delTimeLine");
      }
      return count>0?true:false;
   }
   
   

   // 타임라인 좋아요
   @Override
   public boolean t_like(int seq, String id) {
      String sql = " SELECT T_LIKE_ID FROM TIMELINE"
               + " WHERE SEQ=? AND ID=? ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      int count = 0;
      
      try{
         conn = MemberDAO.getConnection();
         log("2/6 Success writeTimeLine");
         
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, seq);
         psmt.setString(2, id);
         log("3/6 Success writeTimeLine");
         
         rs = psmt.executeQuery();
         log("4/6 Success writeTimeLine");
         while(rs.next()){
            int i = 1;
            rs.getString(i++);
         }
         
         log("5/6 Success writeTimeLine");
      }catch(SQLException e){
         log("Fail writeTimeLine", e);
      }finally{
         MemberDAO.close(conn, psmt, rs);
         log("6/6 Success writeTimeLine");
      }
      
      return count>0?true:false;
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