package odu_timeline;

import java.io.Serializable;

public class timelineDTO {
   private int seq;
   private int bbs_num;
   private String id;
//   private String title;
   private String content;
   private String f_name;
//   private String l_name;
   private int t_like;
   private String wdate;
   private int del;
   private String t_like_id;
   

   public timelineDTO(){}
   
   
   public timelineDTO(int seq, int bbs_num, String id, String content, String f_name, int t_like, String wdate, int del, String t_like_id) {
      super();
      this.seq = seq;
      this.bbs_num = bbs_num;
      this.id = id;
      this.content = content;
      this.f_name = f_name;
      this.t_like = t_like;
      this.wdate = wdate;
      this.del = del;
      this.t_like_id = t_like_id;
   }


   public timelineDTO(String id, String content, String f_name) {
      super();
      this.id = id;
      this.content = content;
      this.f_name = f_name;
//      this.t_like = t_like;
//      this.wdate = wdate;
   }


   @Override
   public String toString() {
      return "timelineDTO [seq=" + seq + ", bbs_num=" + bbs_num + ", id=" + id + ", content="
            + content + ", f_name=" + f_name + ", t_like=" + t_like + ", wdate=" + wdate
            + ", del=" + del + ", t_like_id=" + t_like_id + "]";
   }


   public int getSeq() {
      return seq;
   }


   public void setSeq(int seq) {
      this.seq = seq;
   }


   public int getBbs_num() {
      return bbs_num;
   }


   public void setBbs_num(int bbs_num) {
      this.bbs_num = bbs_num;
   }


   public String getId() {
      return id;
   }


   public void setId(String id) {
      this.id = id;
   }


/*   public String getTitle() {
      return title;
   }


   public void setTitle(String title) {
      this.title = title;
   }
*/

   public String getContent() {
      return content;
   }


   public void setContent(String content) {
      this.content = content;
   }


   public String getF_name() {
      return f_name;
   }


   public void setF_name(String f_name) {
      this.f_name = f_name;
   }


   public int getT_like() {
      return t_like;
   }


   public void setT_like(int t_like) {
      this.t_like = t_like;
   }


   public String getWdate() {
      return wdate;
   }


   public void setWdate(String wdate) {
      this.wdate = wdate;
   }


   public int getDel() {
      return del;
   }


   public void setDel(int del) {
      this.del = del;
   }


   public String getT_like_id() {
      return t_like_id;
   }


   public void setT_like_id(String t_like_id) {
      this.t_like_id = t_like_id;
   }   
   
   
}