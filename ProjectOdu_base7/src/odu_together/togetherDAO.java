package odu_together;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import odu_member.MemberDAO;

public class togetherDAO implements TOGETHER_INTERFACE {

private boolean isS = true;
   
   private static togetherDAO togerDAO;
   
   public static togetherDAO getInstance(){ 
      // 어디에서 접근할 수 있게 singleton 형식을 만든다. 
      if(togerDAO == null){
         togerDAO = new togetherDAO();
      }
      return togerDAO;
   }
   @Override
   public boolean writeTogether(togetherDTO dto) {
      String sql = " INSERT INTO TOGETHER(SEQ, BBS_NUM, ID, CATE, TITLE, "
               + " CONTENT, F_NAME, M_DATE, WDATE, DEAD, T_NUM, PARENT, READCOUNT, DEL) "
               + " VALUES(SEQ_TOGETHER.NEXTVAL, 3, ?, ?, ?, "
               + " ?, ?, ?, SYSDATE, 0, ?, 0, 0, 0) ";
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      int count = 0;
      
      try{
         conn = MemberDAO.getConnection();
         log("2/6 Success writeTogether");
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, dto.getId());
         psmt.setString(2, dto.getCate());
         psmt.setString(3, dto.getTitle());
         psmt.setString(4, dto.getContent());
         psmt.setString(5, dto.getF_name());
         psmt.setString(6, dto.getM_date());
         psmt.setInt(7, dto.getT_num());
         log("3/6 Success writeTogether");
         System.out.println(sql);
         count = psmt.executeUpdate();
         log("4/6 Success writeTogether");
      }catch(SQLException e){
         log("Fail writeTogether");
      }finally{
         MemberDAO.close(conn, psmt, rs);
         log("6/6 Success writeTogether");
      }
            
      return count > 0 ? true:false;
   }
   
   @Override
   public List<togetherDTO> getTogether() {
      String sql = " SELECT seq, bbs_num, id, cate, "
            + " title, content, f_name, m_date, wdate, dead, t_num, "
            + " parent, readcount, del FROM TOGETHER ORDER BY SEQ DESC ";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      List<togetherDTO> list = new ArrayList<togetherDTO>();
      try{
         conn = MemberDAO.getConnection();
         log("2/6 Success getTogether");
         psmt = conn.prepareStatement(sql);
         rs=psmt.executeQuery();
         log("3/6 Success getTogether");
         
         while(rs.next()){
            int i = 1;
            togetherDTO dto = new togetherDTO(
                     rs.getInt(i++),
                     rs.getInt(i++),
                     rs.getString(i++),
                     rs.getString(i++),
                     rs.getString(i++),
                     rs.getString(i++),
                     rs.getString(i++),
                     rs.getString(i++),
                     rs.getString(i++),
                     rs.getInt(i++),
                     rs.getInt(i++),
                     rs.getInt(i++),
                     rs.getInt(i++),
                     rs.getInt(i++)
                  );
            list.add(dto);
         }
         log("4/6 Success getTogether");
         System.out.println(list);
      }catch(SQLException e){
         log("Fail getTogether");
      }finally {
         MemberDAO.close(conn, psmt, rs);
         log("6/6 Success getTogether");
      }
      return list;
   }
   
   @Override
   public togetherDTO getToDTO(int seq) {
      String sql=" SELECT seq, bbs_num, id, cate, "
            + " title, content, f_name, m_date, wdate, dead, t_num, "
            + " parent, readcount, del FROM TOGETHER "
            + " WHERE SEQ = ?";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      togetherDTO tdto = null;
      
      try{
         conn = MemberDAO.getConnection();
         log("2/6 Success getToDTO");
         psmt = conn.prepareStatement(sql);
         psmt.setInt(1, seq);
         log("3/6 Success getToDTO");
         rs=psmt.executeQuery();
         log("4/6 Success getToDTO");
         
         while(rs.next()){
            int i = 1;
            tdto = new togetherDTO(
                  rs.getInt(i++),
                  rs.getInt(i++),
                  rs.getString(i++),
                  rs.getString(i++),
                  rs.getString(i++),
                  rs.getString(i++),
                  rs.getString(i++),
                  rs.getString(i++),
                  rs.getString(i++),
                  rs.getInt(i++),
                  rs.getInt(i++),
                  rs.getInt(i++),
                  rs.getInt(i++),
                  rs.getInt(i++)
               );
         }
         log("5/6 Success getToDTO");
      }catch(SQLException e){
         log("Fail getToDTO");
      }finally {
         MemberDAO.close(conn, psmt, rs);
         log("6/6 Success getToDTO");
      }
      return tdto;
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