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
      ajax: "http://localhost:8080/LibrarySystem/book/getBorrowedBook", //endpoint to get all borrowed book
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
            return ` <button type="button" class="btn btn-dark btn-sm" value="${data.id}" name="btn-return" id="btn-return">
                     	<i class="bi bi-back"></i>
                          </button>  `;
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

  //btn return
  $("#datatable").on("click", "#btn-return", function () {
    var data = booksTable.row($(this).parents("tr")).data();

    alertify
      .confirm(
        "Are you sure you want to return this book ?",
        function () {
          //set the book status to available
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/book/setToAvailable",
            type: "GET",
            data: { id: data.book_id },
            cache: false,
            success: function (response) {
              console.log("Status Updated");

              console.log(response);
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });

          //set the status to returned on logs
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/log/setToReturned",
            type: "GET",
            data: { id: data.id },
            cache: false,
            success: function (response) {
              console.log("Book Returned");
              console.log(response);
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });

          refreshDatatables();
          $("#datatable").DataTable().ajax.reload();
          alertify.success("Returned Successfully !");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
    console.log(data);
  });

  getDatatable();
});
