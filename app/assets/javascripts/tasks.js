function handleChange(el)
{
  console.log("URL: " + $(el).data('request-url')); 
  console.log("Completed: " + $(el).prop('checked'));
  $.post($(el).data('request-url'), {completed: $(el).prop('checked')});
}
