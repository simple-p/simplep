$( document ).on('turbolinks:load', function() {
  var fixHelperModified = function (e, tr){
    var $originals = tr.children();
    var $helper = tr.clone();

    $helper.children().each(function(index){
      $(this).width($originals.eq(index).width())
    });
    return $helper;
  };

  $("#tasks_list tbody").sortable({
    helper: fixHelperModified,
    stop: function (event, ui) { renumber_table('#taks_list') }
  }).disableSelection();
});

function renumber_table(tableID) {
  $(tableID + "tr").each(function() {
    count = $(this).parent().children().index($(this)) + 1;
    $(this).find('.task').html(count);
  });
};

function handleChange(el) {
  url = $(el).data('request-url') + '.js'
  $.post(url, {completed: $(el).prop('checked')});
};
function handleDueDateChange(el) {
  console.log("Due date changed: " + $(el).val());
  url = $(el).data('request-url') + '.js'
  $.post(url, {due_date: $(el).val()});
};
