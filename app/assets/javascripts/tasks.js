//   var fixHelperModified = function (e, tr){
//     var $originals = tr.children();
//     var $helper = tr.clone();
//
//     $helper.children().each(function(index){
//       $(this).width($originals.eq(index).width())
//     });
//     return $helper;
//   };
//
//   $("#tasks_list").sortable({
//     helper: fixHelperModified,
//     stop: function (event, ui) { renumber_table('#taks_list') }
//   }).disableSelection();
  var ready, set_positions;

  set_positions = function() {
    $('.item.item-task').each(function(index) {
      $(this).attr('data-pos', index+1 );
    });
  };

  ready = function() {
    set_positions();

    $('#tasks_list').sortable();

    $('#tasks_list').sortable().bind('sortupdate', function(e, ui) {
      var update_position = [];

      set_positions();

      $('.item.item-task').each(function(index) {
        update_position.push({ id: $(this).data("id"), position: index+1 })
      });

      $.ajax({
        type: "POST",
        dataType: 'JSONP',
        url: '/tasks/sort',
        data: { postition: update_position }
      });
    });
  };

  $( document ).on('turbolinks:load', ready);

// function renumber_table(tableID) {
//   $(tableID + "li").each(function() {
//     count = $(this).parent().children().index($(this)) + 1;
//     $(this).find('.task').html(count);
//   });
// };
//
 function handleChange(el) {
   url = $(el).data('request-url') + '.js'
   $.post(url, {completed: $(el).prop('checked')});
 };
 function handleDueDateChange(el) {
   console.log("Due date changed: " + $(el).val());
   url = $(el).data('request-url') + '.js'
   $.post(url, {due_date: $(el).val()});
 };
