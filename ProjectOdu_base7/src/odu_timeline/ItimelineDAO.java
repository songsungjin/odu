package odu_timeline;

import java.util.List;


public interface ItimelineDAO {

   // 타임라인에 글 가져오기
   List<timelineDTO> getTimeLineList(String id);
   
   // 타임라인에 글 쓰기
   boolean writeTimeLine(timelineDTO tdto);
   
   // 타임라인 글 삭제
   boolean delTimeLine(int seq, String id);
   
   // 타임라인 좋아요 버튼
   boolean t_like(int seq, String id);
}