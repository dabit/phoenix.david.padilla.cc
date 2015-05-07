$(function() {
  "use strict";

  $('.archive-link a').bind('click', {'category': 'archive-link'}, sendAnalyticsEvent);
  $('.more-link a').bind('click', {'category': 'more-link'}, sendAnalyticsEvent);

  function sendAnalyticsEvent(e, category){
    ga('send', 'event', e.data.category, 'click', $(e.currentTarget).text());
  }
});

