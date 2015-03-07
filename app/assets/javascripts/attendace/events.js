var rollCallInit = function() {
  var index = 0;
  var options = $("#event_attendances_user_ids option");
  var selectTag = $("#event_attendances_user_ids");
  var selections = [];

  $("#display_roll_call").click(function() {
    $("#roll_call").toggle();
  });

  $("#name_display").text(options[index].text);

  $("#absent").click(function () {
    nextName();
  });

  $("#present").click(function () {
    if (index < options.length) {
      selections.push(options[index].value);
      options.filter("[value=\"" + options[index].value + "\"]")
             .prop("selected", true);
    }
    nextName();
  });

  function nextName() {
    if (index >= options.length) {
      alert("You have reached the end of roll call!");
    } else {
      index++;
      selectTag.val(selections).trigger("change");
      if (index < options.length) {
        $("#name_display").text(options[index].text);
      }
    }
  }
};

$(document).ready(rollCallInit);
$(document).on("page:load", rollCallInit);
