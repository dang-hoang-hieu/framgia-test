$(document).on "page:change", ->
  $("#examination-list").on "click", "label[id^='start-exam']", ->
    that = $(this)
    $.ajax '/admin/examinations',
      type: 'POST'
      data: { 'user_id': that.data('user-id'), 'exam_id': that.data('exam-id')}
      success: ->
        span = $("<span>").addClass("label label-warning").text("being taken")
        $("#start-exam-holder-" + that.data('exam-id')).html(span)
   $("#examination-list").on "click", "span[id^='retake']", ->
     that = $(this)
     user_id = that.data('user-id')
     exam_id = that.data('exam-id')
     $.ajax '/admin/examinations',
       type: 'POST'
       data: { 'user_id': user_id, 'exam_id': exam_id}
       success: ->         
         span = $("<span>").addClass("label label-warning").text("being taken")         
         li = $("<li>")
         li.append(span)
         $("#retake-holder-" + exam_id).append(li)