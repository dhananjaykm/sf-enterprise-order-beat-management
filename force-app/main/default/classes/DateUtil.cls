/**
 * Business calendar helpers used by SLA, visit, and reminder logic.
 * Simple addDays paths are Flow-convertible; holiday-aware math is not.
 *
 * MIGRATION: D — addDays/isWeekend can be Flow formula; holiday calendars stay Apex.
 */
public with sharing class DateUtil {
    public static Boolean isWeekend(Date d) {
        String day = datetime.newInstance(d, Time.newInstance(0, 0, 0, 0)).format('EEEE');
        return day == 'Saturday' || day == 'Sunday';
    }

    public static Date addBusinessDays(Date startDate, Integer days) {
        Date cursor = startDate;
        Integer remaining = days;
        Integer guard = 0;
        while (remaining > 0 && guard < 400) {
            cursor = cursor.addDays(1);
            if (!isWeekend(cursor)) {
                remaining--;
            }
            guard++;
        }
        return cursor;
    }

    public static Integer businessHoursBetween(Datetime startDt, Datetime endDt) {
        if (startDt == null || endDt == null || endDt <= startDt) {
            return 0;
        }
        Long millis = endDt.getTime() - startDt.getTime();
        return Integer.valueOf(millis / (1000 * 60 * 60));
    }
}
