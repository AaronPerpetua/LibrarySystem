$(document).ready(function () {
  var t;
  //datatables for the user
  const getDatatable = () => {
    t = $("#datatable").DataTable({
      order: [[0, "desc"]],
      processing: true,
      serverSide: false,
      cache: false,
      destroy: true,
      scrollY: "500px",
      dataSrc: "data",
      ajax: "http://localhost:8080/LibrarySystem/feedback/getAllUsersFeedback", //endpoint to get all the users feedback
      columns: [
        { data: "id" },
        { data: "user_id" },
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
      { width: "4%", targets: 0 },
       { width: "11%", targets: 1 },
         { width: "11%", targets: 2 },
        {
          targets: 3,
          render: function (data, type, row) {
            return data.substr(0, 60);
          },
        },

        {
          targets: 4,
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
      url: "http://localhost:8080/LibrarySystem/feedback/getSingleFeedback", //url for getting feedback using feedback id
      type: "GET",
      data: { id: data.id },
      cache: false,
      success: function (response) {
        $("[name='id']").val(response.id);
        $("[name='user_id']").val(data.user_id);
        $("[name='username']").val(data.username);
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

  //button for deleting the user feedback
  $("#datatable").on("click", "#btn-delete", function () {
    var data = t.row($(this).parents("tr")).data();

    alertify
      .confirm(
        "Are you sure you want to remove this feedback ? ",
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/feedback/deleteSingleFeedback", //endpoint for delete feedback
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
