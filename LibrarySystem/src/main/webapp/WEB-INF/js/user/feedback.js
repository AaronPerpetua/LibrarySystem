$(document).ready(function () {
  var user_id = $("#user_id").val();

  var t;
  //datatables for the user
  const getDatatable = () => {
    t = $("#datatable").DataTable({
      order: [[0, "desc"]],
      processing: true,
      serverSide: false,
      cache: false,
      destroy: true,
      data: { user_id: user_id },
      scrollY: "500px",
      dataSrc: "data",
      ajax:
        "http://localhost:8080/LibrarySystem/feedback/getAllFeedback?user_id=" +
        user_id, //endpoint to get all the user data
      columns: [
        { data: "id" },
        { data: "username" },
        { data: "message" },
        { data: "created_at" },

        {
          data: null,
          sortable: false,
          searchable: false,
          render: function (data, type, full) {
            return ` <button type="button" class="btn btn-dark btn-sm" value="${data.id}" name="btn-view" id="btn-view">
                          <i class="bi bi-eye-fill"></i>
                          </button> 
                       
                          
                          <button type="button" class="btn btn-dark btn-sm" value="${data.id}" id="btn-delete" name="btn-delete" >
                          <i class="bi bi-trash"></i>
                          </button> `;
          },
        },
      ],
      columnDefs: [
        {
          targets: 0,
          render: function (data, type, row) {
            return data.substr(0, 5);
          },
        },
         { width: "4%", targets: 0 },
         { width: "7%", targets: 4 },

        {
          targets: 3,
          width: "20%",
          render: function (data) {
            return moment(data).format("LLL"); // to change the date format
          },
        },
      ],
    });
  };

  $(document).on("click", "#refresh", function () {
    $("#datatable").DataTable().ajax.reload();
  });

  const refreshDatatables = () => {
    // function to refresh the table
    $("#datatable").DataTable().ajax.reload();
  };

  //button for displaying feedback details
  $("#datatable").on("click", "#btn-view", function () {
    var data = t.row($(this).parents("tr")).data();

    $("#viewfeedback-modal").modal("show");

    $.ajax({
      url: "http://localhost:8080/LibrarySystem/feedback/getSingleFeedback", //getting feedback details
      type: "GET",
      data: { id: data.id },
      cache: false,
      success: function (response) {
        $("[name='id']").val(response.id);
        $("[name='user_id']").val(response.user_id);
        $("[name='username']").val(response.username);
        $("[name='message']").val(response.message);
        $("[name='created_at']").val(moment(response.created_at).format("LLL"));
      },
      error: function () {
        alert(
          "Error: Please Contact System Admnistrator \n Or Refresh this Page."
        );
      },
    });
  });

  $(document).on("click", "#add-feedback-btn", function () {
    $("#addfeedback-modal").modal("show");
    $("#message").val("");
   
  });

  $("#addfeedback-form").submit(function (e) {
    e.preventDefault();

    const sdata = $(this).serialize();

    alertify
      .confirm(
        "Are you sure you want to add this feedback ? ",
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/feedback/addFeedback",
            dataType: "json",
            cache: false,
            data: sdata,
            success: function (response) {
              console.log("Feedback Added");
            },
            error: function (response) {
              console.log("Feedback Added");
            },
          });
          $("#addfeedback-modal").modal("hide");
          refreshDatatables();
          $("#datatable").DataTable().ajax.reload();
          alertify.success("Added Successfully !");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
  });

  //button for deleting the feedback
  $("#datatable").on("click", "#btn-delete", function () {
    var data = t.row($(this).parents("tr")).data();

    alertify
      .confirm(
        "Are you sure you want to remove this feedback ? ",
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/feedback/deleteSingleFeedback", //get all the feedbacks
            type: "GET",
            data: { id: data.id },
            cache: false,
            success: function (response) {
              console.log("feedback deleted");
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });
          refreshDatatables();
          $("#datatable").DataTable().ajax.reload();
          alertify.success("Removed Successfully !");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
  });

  getDatatable();
});
