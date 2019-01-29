$(function() {
  // object for autocomplete data processing
  new app.Search_Exercises;
});


$(function() {
  // setup edit buttons for workout tasks
  $("#task_card_list").on('click', '.edit_button', function() {
    $(this).parent().parent().find(".show_form").css('display', 'none');
    $(this).parent().parent().find(".edit_form").css('display', 'inline-block');
  });
  
  // setup done buttons after editing a workout task
  $("#task_card_list").on('click', '.done_button', function() {
    var show_form = $(this).parent().parent().find(".show_form");
    var edit_form = $(this).parent().parent().find(".edit_form");
    
    var new_sets_val = edit_form.find(".sets_edit").val();
    var new_reps_val = edit_form.find(".reps_edit").val();
    var new_weight_val = edit_form.find(".weight_edit").val();
    
    show_form.find(".sets_info").text(new_sets_val);
    show_form.find(".reps_info").text(new_reps_val);
    show_form.find(".weight_info").text(new_weight_val);
    
    show_form.css('display', 'inline-block');
    edit_form.css('display', 'none');
    
    
  });
});

$(function() {
  var dialog, form,
  name = $( "#exercise-search-txt" )
  number = $( "#dist" ),
  units = $( "#units" ),
  allFields = $( [] ).add(name).add(number).add(units);

  function checkLength( o, n, min, max ) {
    if ( o.val().length > max || o.val().length < min ) {
      o.addClass( "ui-state-error" );
      return false;
    } else {
      return true;
    }
  }

  function make_strength_task(name, sets, reps, weight, units) {
    var task_name = "<span>" + name + " </span>";
    
    var sets_info = "<span class='sets_info'>" + sets + "</span>";
    var reps_info = "<span class='reps_info'>" + reps + "</span>";
    var weight_info = "<span class='weight_info'>" + weight + "</span>";
    
    var task_info = " - " + sets_info + " sets, " + reps_info + " reps, at " + weight_info + " " + units;
    var edit_button = '<button type="button" class="btn btn-info btn-sm edit_button"><span class="glyphicon glyphicon-pencil"></span></button>';
    var delete_button = '<button type="button" class="btn btn-info btn-sm delete_button"><span class="glyphicon glyphicon-trash"></span></button>';
    var show_form =  "<span class='show_form'>" + task_info + edit_button + delete_button + "</span>";
    
    var sets_edit = '<label for="sets_edit">sets: </label><input name="sets_edit" class="sets_edit" type="number" value="' + sets + '"></input>';
    var reps_edit = '<label for="reps_edit">reps: </label><input name="reps_edit" class="reps_edit" type="number" value="' + reps + '"></input>';
    var weight_edit = '<label for="weight_edit">weight: </label><input name="weight_edit" class="weight_edit" type="number" value="' + weight + '"></input>';
    var done_button = '<button type="button" class="btn btn-info btn-sm done_button"><span class="glyphicon glyphicon-ok"></span></button>';
    var edit_form = '<span class="edit_form" hidden>' + 
                      sets_edit + 
                      reps_edit +
                      weight_edit +
                      done_button +
                    '</span>';
    var markup = "<div>" + 
                task_name + 
                show_form + 
                edit_form + 
              "</div>";
    return markup;
  }
  function make_task_card() {
    var markup = "";
    var form_type = $('#form_type').text().trim();
    var name = $("#exercise-search-txt").val();
    
    if (form_type == "Strength") {
      var sets = $("#sets").val();
      var reps = $("#reps").val();
      var weight = $("#weight").val();
      var units = $("#units").val();
      markup = make_strength_task(name, sets, reps, weight, units);
      
      
    } else if (form_type == "Cardio") {
      var distance_time = $("#distance_time").val();
      var units = $("#units").val();
      markup = "<div>" + name + " " + distance_time + " " + units + "</div>";
      
    }
    
    return markup;
  }
  
  function create_exercise_set() {
    var valid = true;
    allFields.removeClass( "ui-state-error" );
  
    var selectedExercise = document.getElementById("exercise-search-txt").value;
      
      $( "#task_card_list" ).append(make_task_card());
      dialog.dialog( "close" );
    
    return valid;
  } 
  
  

  $( "#add" ).button().on( "click", function() {
    dialog.dialog( "open" );
  });

  dialog = $( "#dialog-form" ).dialog({
    autoOpen: false,
    height: 400,
    width: 350,
    modal: true,
    buttons: {
      "Enter exercise": create_exercise_set,
      Cancel: function() {
        dialog.dialog( "close" );
      }
    },
    close: function() {
      form[ 0 ].reset();
      $("#exercise-category-data").html("");
      allFields.removeClass( "ui-state-error" );
    }
  });
    
  form = dialog.find( "form" ).on( "submit", function( event ) {
    event.preventDefault();
    create_exercise_set();
  });
});

function get_task_card_data() {
  var results = [];
  $("#")
  
}

$("#finish").click(function() {
  var task_card_data = get_task_card_data();
  
  $.ajax({
      type:"POST",
      url:"/process_create_workout",
      data: {
        task_card_data
      }
  });
});







