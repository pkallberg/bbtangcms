$(function($) {
  $('input.user_statistics_filter').datepicker(
    {
      format: 'yyyy-mm-dd'
  }
  )
  $('input#quiz_end_date').datepicker(
    {
      format: 'yyyy-mm-dd'
  }
  )
});
