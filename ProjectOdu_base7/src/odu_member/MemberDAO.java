package odu_member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class MemberDAO implements Member_INTERFACE {
   
   private boolean isS = true;
   private static MemberDAO memberDAO;
   private MemberDAO(){ //생성자 부분에서 오라클드라이버를 찾는다.
      try{
         Class.forName("oracle.jdbc.driver.OracleDriver");
      }catch(ClassNotFoundException e){
         System.out.println(e.getMessage());
      }
   }
   

   public static Connection getConnection() throws SQLException{
      // 본격적인 DB Connection부분.
      Connection conn = null;
      String url = "jdbc:oracle:thin:@211.238.142.172:1521:hr";
      String user= "scott";
      String pw = "hr";
      
      conn = DriverManager.getConnection(url, user, pw);
      
      return conn;
   }

   public static void close(Connection conn, Statement psmt, ResultSet rs){
      // DB Close부분.
      if(rs != null){
         try {
            rs.close();
         } catch (SQLException e) {}
      }
      if(psmt != null){
         try {
            psmt.close();
         } catch (SQLException e) {}
      }
      if(conn != null){
         try {
            conn.close();
         } catch (SQLException e) {}
      }
   }
   
   public static MemberDAO getInstance(){ 
      // 어디에서 접근할 수 있게 singleton 형식을 만든다. 
      if(memberDAO == null){
         memberDAO = new MemberDAO();
      }
      return memberDAO;
   }
   
   @Override
   public boolean insertMember(MemberDTO dto) {
      String sql = "";
      if(dto.getGender() == 1){
      sql = " insert into MEMBER (id, pw, name, gender, birth, "
            + " address, job, email, image, log) "
            + " values(?, ?, ?, 1, ?, ?, ?, ?, 'image', 0) "; // insert sql문.
      }else if(dto.getGender() == 2){
      sql = " insert into MEMBER (id, pw, name, gender, birth, "
            + " address, job, email, image, log)"
            + " values(?, ?, ?, 2, ?, ?, ?, ?, 'image', 0) ";   
      }

      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      
      int count = 0;
      
      try{
         conn = MemberDAO.getConnection();
         
         psmt = conn.prepareStatement(sql);
         
         int i = 1;
         psmt.setString(i++, dto.getId());
         psmt.setString(i++, dto.getPw());
         psmt.setString(i++, dto.getName());
         psmt.setString(i++, dto.getBirth());
         psmt.setString(i++, dto.getAddress());
         psmt.setString(i++, dto.getJob());
         psmt.setString(i++, dto.getEmail());
         
         count = psmt.executeUpdate();
      }catch(SQLException e){
         System.out.println(e.getMessage());
      }finally{
         MemberDAO.close(conn, psmt, rs);
      }
      return count > 0 ? true:false;
   }

   @Override
   public MemberDTO login(MemberDTO dto) {
      String sql = " SELECT id, pw, name, birth, address, job, email, image FROM MEMBER "
            + " WHERE id = ? and pw=?";
      
      Connection conn = null;
      PreparedStatement psmt = null;
      ResultSet rs = null;
      MemberDTO mem = null;
      
      try{
         conn=MemberDAO.getConnection();
         log("2/6 Success login");
         psmt = conn.prepareStatement(sql);
         psmt.setString(1, dto.getId());
         psmt.setString(2, dto.getPw());
         log("3/6 Success login");
         rs=psmt.executeQuery();
         log("4/6 Success login");
         while(rs.next()){
            int i = 1;
            String id = rs.getString(i++);
            String pw = rs.getString(i++);
            String name = rs.getString(i++);
            String birth = rs.getString(i++);
            String address = rs.getString(i++);
            String job = rs.getString(i++);
            String email = rs.getString(i++);
            String image = rs.getString(i++);
            mem = new MemberDTO(id, pw, name,  birth, address, job, email, image);
         }log("5/6 Success login");
         System.out.println(mem  + "다오속");
      }catch(SQLException e){
         log("Fail login");
      }finally {
         MemberDAO.close(conn, psmt, rs);
         log("6/6 Success login");
      }
      return mem;
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