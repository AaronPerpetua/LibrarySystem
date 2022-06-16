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
      ajax: "http://localhost:8080/LibrarySystem/book/getAvailableBook", //endpoint to get all the books data
      columns: [
        { data: "id" },
        { data: "title" },
        { data: "author" },
        { data: "publisher" },
        { data: "status" },
        { data: "created_at" },

        {
          data: null,
          sortable: false,
          searchable: false,
          render: function (data, type, full) {
            return ` <button type="button" class="btn btn-dark btn-sm" value="${data.id}" name="btn-view" id="btn-view">
                              <i class="bi bi-eye-fill"></i>
                              </button> 
                              <button type="button" class="btn btn-dark btn-sm"  value="${data.id}" name="btn-borrow" id="btn-borrow">
                              <i class="bi bi-bag-plus-fill"></i>
                              </button> 
`;
          },
        },
      ],
      columnDefs: [
        {
          targets: 1,
          render: function (data, type, row) {
            return data.substr(0, 30);
          },
        },
        {
          targets: 2,
          render: function (data, type, row) {
            return data.substr(0, 30);
          },
        },
        {
          targets: 3,
          render: function (data, type, row) {
            return data.substr(0, 30);
          },
        },

        { width: "13%", targets: 6 },
        {
          targets: 5,
          width: "13%",
          render: function (data) {
            return moment(data).format("MMMM Do YYYY"); // to change the date format
          },
        },
      ],
    });
  };

  //button for viewing the book details
  $("#datatable").on("click", "#btn-view", function () {
    var data = booksTable.row($(this).parents("tr")).data();
    //console.log( data.id );

    $("#viewbook-modal").modal("show");

    $.ajax({
      url: "http://localhost:8080/LibrarySystem/book/getSingleBook",
      type: "GET",
      data: { id: data.id },
      cache: false,
      success: function (response) {
        $("[name='id']").val(response.id);
        $("[name='title']").val(response.title);
        $("[name='author']").val(response.author);
        $("[name='publisher']").val(response.publisher);
        $("[name='description']").val(response.description);
        $("[name='pagetotal']").val(response.page_total);
        $("[name='status']").val(response.status);
        $("[name='created_at']").val(moment(response.created_at).format("LLL"));
      },
      error: function () {
        alert(
          "Error: Please Contact System Admnistrator \n Or Refresh this Page."
        );
      },
    });
  });

  //button for borrowing the book then the status will be For Confirmation
  $("#datatable").on("click", "#btn-borrow", function () {
    var tr = booksTable.row($(this).parents("tr")).data();

    var data = {
      book_id: tr.id,
      book_title: tr.title,
      user_id: $("#user_id").val(),
    };

    alertify
      .confirm(
        "Are you sure you want to Borrow this book ?",
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/book/setToForConfirmation",
            type: "GET",
            data: { id: tr.id },
            cache: false,
            success: function (response) {
              console.log("book updated");
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });

          $.ajax({
            url: "http://localhost:8080/LibrarySystem/log/createLog", //create transaction log
            type: "GET",
            data: data,
            cache: false,
            success: function (response) {
              console.log("log created");
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });
          $("#datatable").DataTable().ajax.reload();
          alertify.success("Borrow Successfully !");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
  });

  $(document).on("click", "#refresh", function (e) {
    e.preventDefault();

    $("#datatable").DataTable().ajax.reload();
  });

  getDatatable();
});
