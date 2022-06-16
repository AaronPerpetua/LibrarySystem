$(document).ready(function () {
  var booksTable;

  //datatables for the books
  const getDatatable = () => {
    booksTable = $("#datatable").DataTable({
      order: [[0, "desc"]],
      processing: true,
      serverSide: false,
      cache: false,
      destroy: true,
      scrollY: "500px",
      dataSrc: "data",
      ajax: "http://localhost:8080/LibrarySystem/book/getToBorrowBook", //endpoint to get all to borrow books
      columns: [
        { data: "id" },
        { data: "book_id" },
        { data: "book_title" },
        { data: "user_id" },
        { data: "username" },
        { data: "firstname" },
        { data: "lastname" },
        { data: "status" },
        { data: "transaction_date" },

        {
          data: null,
          sortable: false,
          searchable: false,
          render: function (data, type, full) {
            return `
                          <button type="button" class="btn btn-dark btn-sm"  value="${data.id}" name="btn-confirm" id="btn-confirm">
                          <i class="bi bi-bag-check-fill"></i>
                          </button>
                          <button type="button" class="btn btn-dark btn-sm"  value="${data.id}" name="btn-cancel" id="btn-cancel">
                          <i class="bi bi-x-square-fill"></i>
                          </button> `;
          },
        },
      ],
      columnDefs: [
        {
          targets: 1,
          render: function (data, type, row) {
            return data.substr(0, 20);
          },
        },
        {
          targets: 2,
          render: function (data, type, row) {
            return data.substr(0, 20);
          },
        },
        {
          targets: 3,
          render: function (data, type, row) {
            return data.substr(0, 20);
          },
        },

        { width: "12%", targets: 8 },
        {
          targets: 8,
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

  //button for cancel
  $("#datatable").on("click", "#btn-cancel", function () {
    var data = booksTable.row($(this).parents("tr")).data();

    alertify
      .confirm(
        "Are you sure you want to cancel this book ?",
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/book/setToAvailable", //endpoint for changing status to available
            type: "GET",
            data: { id: data.book_id },
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

          //set the status to cancelled on logs
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/log/setToCancelled",
            type: "GET",
            data: { id: data.id },
            cache: false,
            success: function (response) {
              console.log(response);
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });
          refreshDatatables();
          alertify.success("Borrow Cancelled !");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
  });

  //button confirm the book to borrow
  $("#datatable").on("click", "#btn-confirm", function () {
    var data = booksTable.row($(this).parents("tr")).data();

    alertify
      .confirm(
        "Are you sure you want to Borrow this book ?",
        function () {
          //changing to Borrowed status
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/book/confirmToBorrow",
            type: "GET",
            data: { id: data.book_id },
            cache: false,
            success: function (response) {
              console.log("from first request");
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });

          //adding the transaction log
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/log/updateLogs",
            type: "GET",
            data: { id: data.id },
            cache: false,
            success: function (response) {
              console.log("Logs Updated");
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });

          refreshDatatables();
          $("#datatable").DataTable().ajax.reload();
          alertify.success("Borrowed Successfully !");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
  });

  getDatatable();
});
