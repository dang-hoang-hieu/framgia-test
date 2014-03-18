// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap

$(function(){
  $("#add-answer").click(function(){
    checkboxes = $('form .checkbox');
    correct_answer = $("<input name='' type='hidden' value='0'>");
    correct_answer.attr('name', 'question[answers_attributes][' +  checkboxes.length + '][correct_answer]');
    checkbox = $("<input name='' type='checkbox' value='1'>");
    checkbox.attr('name', 'question[answers_attributes][' +  checkboxes.length + '][correct_answer]');
    text = $("<input name='' type='text'>");
    text.attr('name', 'question[answers_attributes][' +  checkboxes.length + '][answer]');
    label = $('<label class="checkbox">').append(correct_answer).append(checkbox).append(text);
    $('form #answers-list').append(label);
  })
})