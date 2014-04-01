$(document).on "page:change", ->
    $("#add-answer").click ->
      $.ajax '/admin/questions/new',
        type: 'GET'
        data: {'answer_number': ($("label.checkbox").length + 1)}
        success: (question)->
        	$(question).find("label.checkbox").last().appendTo($('#answers-list'))
    