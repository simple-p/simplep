function handleChange(el) {
  url = $(el).data('request-url') + '.js'
  $.post(url, {completed: $(el).prop('checked')});
};
function handleDueDateChange(el) {
  console.log("Due date changed: " + $(el).val());
  url = $(el).data('request-url') + '.js'
  $.post(url, {due_date: $(el).val()});
};
