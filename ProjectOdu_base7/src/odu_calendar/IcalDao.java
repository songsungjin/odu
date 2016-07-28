package odu_calendar;

import java.util.List;


public interface IcalDao {
	boolean addCalendar(CalendarDTO cal);
	boolean modcal(CalendarDTO cal, int seq);
	List<CalendarDTO> getCalendarList(String id, String yyyyMM);
	CalendarDTO getCal(int seq);
	List<CalendarDTO> getDayList(String id, String yyyymmdd);
	boolean deleteCal(int seq);
}
