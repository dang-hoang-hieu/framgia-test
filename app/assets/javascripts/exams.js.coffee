$(document).on "page:change", ->
    $("#add-subject").click ->
      $.ajax '/admin/exams/new',
        type: 'GET'
        data: {'subject_number': ($("fieldset").length + 1)}
        success: (subject)->
          last = $(subject).find("fieldset").last()
          last.find(".remove-subject").click ->
            $(this).parent().next().remove()
            $(this).parent().remove()
          last.appendTo($('#subject-list'))
    
    $(".remove-subject").click ->
      $(this).parent().next().remove()
      $(this).parent().remove()

    $("#exams-list").on "click", "label.btn-link", ->
      exam_id = $(this).data("exam-id")
      $.ajax '/admin/exams/' + exam_id + '/user_list/edit',
        type: 'GET'
        success: (user_list)->
          $("#user-list").html(user_list)
    
    $("#user-list").on "click", "#close-model", ->
      $("#assign-user-model").modal('hide')
