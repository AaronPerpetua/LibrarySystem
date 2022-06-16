$(document).ready(function () {
  var booksTable;

  var user_id = $("#user_id").val();

  $(document).on("click", "#refresh", function () {
    $("#datatable").DataTable().ajax.reload();
  });

  const refreshDatatables = () => {
    // function to refresh the table
    $("#datatable").DataTable().ajax.reload();
  };

  //datatables for the books
  const getDatatable = () => {
    booksTable = $("#datatable").DataTable({
      order: [[0, "desc"]],
      processing: true,
      serverSide: false,
      cache: false,

      destroy: true,
      scrollY: "500px",
      dataSrc: "data", //endpoint to get all the books associated with the active user
      ajax:
        "http://localhost:8080/LibrarySystem/user/getBorrowBooks?user_id=" +
        user_id,
      columns: [
        { data: "id" },
        { data: "username" },
        { data: "book_id" },
        { data: "book_title" },
        { data: "status" },
        { data: "transaction_date" },

        {
          data: null,
          sortable: false,
          searchable: false,
          render: function (data, type, full) {
            return ` <button type="button" class="btn btn-dark btn-sm"   name="btn-view" id="btn-view">
                             <i class="bi bi-eye-fill"></i>
                             </button> `;
          },
        },
      ],
      columnDefs: [
        { width: "20%", targets: 5 },

        {
          targets: 3,
          render: function (data, type, row) {
            return data.substr(0, 40);
          },
        },

        {
          targets: 5,
          width: "20%",
          render: function (data) {
            return moment(data).format("LLL"); // to change the date format
          },
        },
      ],
    });
  };

  //button for viewing the book details
  $("#datatable").on("click", "#btn-view", function () {
    var data = booksTable.row($(this).parents("tr")).data();

    $("#viewbook-modal").modal("show");

    $("[name='log_id']").val(data.id);

    $.ajax({
      url: "http://localhost:8080/LibrarySystem/book/viewBorrowBookStatus",
      type: "GET",
      data: { id: data.id },
      cache: false,
      success: function (response) {
        $("[name='book_id']").val(response.id);
        $("[name='title']").val(response.title);
        $("[name='author']").val(response.author);
        $("[name='publisher']").val(response.publisher);
        $("[name='description']").val(response.description);
        $("[name='category']").val(response.category);
        $("[name='pagetotal']").val(response.page_total);
        $("[name='status']").val(response.status);
        $("[name='created_at']").val(moment(response.created_at).format("LLL"));

        if (response.status == "For Confirmation") {
          $("[name='cancel_btn']").prop("disabled", false);
        } else {
          $("[name='cancel_btn").prop("disabled", true);
        }
      },
      error: function () {
        alert(
          "Error: Please Contact System Admnistrator \n Or Refresh this Page."
        );
      },
    });
  });

  $(document).on("click", "#cancel_btn", function (e) {
    e.preventDefault();

    var log_id = $("#log_id").val();
    var book_id = $("#book_id").val();

    alertify
      .confirm(
        "Are you sure you want to cancel this book ?",
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/log/setToCancelled", //cancel request
            type: "GET",
            data: { id: log_id },
            cache: false,
            success: function (response) {
              refreshDatatables();
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });

          $.ajax({
            url: "http://localhost:8080/LibrarySystem/book/setToAvailable", //change status to available
            type: "GET",
            data: { id: book_id },
            cache: false,
            success: function (response) {
              refreshDatatables();
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });
          alertify.success("Borrow Cancelled !");
          $("#viewbook-modal").modal("hide");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
  });

  getDatatable();
});
