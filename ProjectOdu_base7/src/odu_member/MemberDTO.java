package odu_member;

import java.io.Serializable;

public class MemberDTO {
   
   private String id;
   private String pw;
   private String name;
   private int gender;
   private String birth;
   private String address;
   private String job;
   private String email;
   private String image;
   private int log;
   
   public MemberDTO() {}

   public MemberDTO(String id, String pw, String name, int gender, String birth, String address, String job,
         String email, String image, int log) {
      this.id = id;
      this.pw = pw;
      this.name = name;
      this.gender = gender;
      this.birth = birth;
      this.address = address;
      this.job = job;
      this.email = email;
      this.image = image;
      this.log = log;
   }
   public MemberDTO(String id, String pw, String name, int gender, String birth, String address, String job,
         String email, int log) {
      this.id = id;
      this.pw = pw;
      this.name = name;
      this.gender = gender;
      this.birth = birth;
      this.address = address;
      this.job = job;
      this.email = email;
      this.log = log;
   }

   public MemberDTO(String id, String pw){
       this.id = id;// 회원가입 정보를 확인하기 위한 생성자
       this.pw = pw;
   }
   
   public MemberDTO(String id, String pw, String name, String birth, String address, String job, String email,String image) {
      this.id = id;
      this.pw = pw;
      this.name = name;
      this.birth = birth;
      this.address = address;
      this.job = job;
      this.email = email;
      this.image = image;
   }

   public String getId() {
      return id;
   }

   public void setId(String id) {
      this.id = id;
   }

   public String getPw() {
      return pw;
   }

   public void setPw(String pw) {
      this.pw = pw;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }

   public int getGender() {
      return gender;
   }

   public void setGender(int gender) {
      this.gender = gender;
   }

   public String getBirth() {
      return birth;
   }

   public void setBirth(String birth) {
      this.birth = birth;
   }

   public String getAddress() {
      return address;
   }

   public void setAddress(String address) {
      this.address = address;
   }

   public String getJob() {
      return job;
   }

   public void setJob(String job) {
      this.job = job;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public String getImage() {
      return image;
   }

   public void setImage(String image) {
      this.image = image;
   }

   public int getLog() {
      return log;
   }

   public void setLog(int log) {
      this.log = log;
   }

   @Override
   public String toString() {
      return "MemberDTO [id=" + id + ", pw=" + pw + ", name=" + name + ", gender=" + gender + ", birth=" + birth
            + ", address=" + address + ", job=" + job + ", email=" + email + ", image=" + image + ", log=" + log
            + "]";
   }
   
}