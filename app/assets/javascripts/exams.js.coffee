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
