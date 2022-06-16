$(document).ready(function () {
  $.ajax({
    url: "http://localhost:8080/LibrarySystem/admin/countAvailableBooks",
    type: "GET",
    cache: false,
    success: function (response) {
      var countAvailable = response[0].countAvailable;
      var countBorrowed = response[0].countBorrowed;
      var countForConfirmation = response[0].countForConfirmation;
      var countUsers = response[0].countUsers;

      $("#available-books").html(countAvailable);
      $("#borrowed-books").html(countBorrowed);
      $("#for-confirmation").html(countForConfirmation);
      $("#all-users").html(countUsers);
    },
    error: function () {
      alert(
        "Error: Please Contact System Admnistrator \n Or Refresh this Page."
      );
    },
  });

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
      ajax: "http://localhost:8080/LibrarySystem/book/getAllBooks", //endpoint to get all the books data
      columns: [
        { data: "id" },
        { data: "category" },
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
                              <button type="button" class="btn btn-dark btn-sm"  value="${data.id}" name="btn-edit" id="btn-edit">
                              <i class="bi bi-pencil"></i>
                              </button> 
                              
                              <button type="button" class="btn btn-dark btn-sm" value="${data.id}" id="btn-delete" name="btn-delete" >
                              <i class="bi bi-trash"></i>
                              </button> `;
          },
        },
      ],
      columnDefs: [
        { width: "10%", targets: 1 },
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
        { width: "20%", targets: 2 },

        {
          targets: 3,
          render: function (data, type, row) {
            return data.substr(0, 20);
          },
        },

        {
          targets: 4,
          render: function (data, type, row) {
            return data.substr(0, 20);
          },
        },

        { width: "13%", targets: 4 },
        {
          targets: 6,
          width: "13%",
          render: function (data) {
            return moment(data).format("Do MMMM  YYYY"); // to change the date format
          },
        },
      ],
    });
  };

  //botton for displaying add book modal form
  $(document).on("click", "#btn-add", function () {
    $("#addbook-modal").modal("show");
    $("#title").val("");
    $("#author").val(""); //we add this to avoid cache coming from the web
    $("#publisher").val("");
    $("#description").val("");
    $("#pagetotal").val("");
  });

  //button to refresh the tables
  $(document).on("click", "#refresh", function () {
    $("#datatable").DataTable().ajax.reload();
    console.log("sad");
  });

  const refreshDatatables = () => {
    // function to refresh the table
    $("#datatable").DataTable().ajax.reload();
  };

  //button for submiting the new book
  $("#addbook-form").submit(function (e) {
    e.preventDefault();

    const data = {
      title: $("#title").val(),
      author: $("#author").val(),
      publisher: $("#publisher").val(),
      description: $("#description").val(),
      pagetotal: $("#pagetotal").val(),
      category: $("#category").val(),
    };

    alertify
      .confirm(
        "Are you sure you want to Add this Book ?",
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/book/createSingleBook",
            dataType: "json",
            cache: false,
            data: data,
            success: function (response) {},
            error: function (response) {
              console.log(response);
            },
          });

          refreshDatatables();
          $("#datatable").DataTable().ajax.reload();

          $("#addbook-modal").modal("hide");
          alertify.success("Added Successfully !");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
  });

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
        $("[name='category']").val(response.category);
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

  //button for displaying book details to edit
  $("#datatable").on("click", "#btn-edit", function () {
    var data = booksTable.row($(this).parents("tr")).data();

    $("#editbook-modal").modal("show");

    $.ajax({
      url: "http://localhost:8080/LibrarySystem/book/getSingleBook",
      type: "GET",
      data: { id: data.id },
      cache: false,
      success: function (response) {
        $("[name='id']").val(response.id);
        $("[name='category']").val(response.category);
        $("[name='title']").val(response.title);
        $("[name='author']").val(response.author);
        $("[name='publisher']").val(response.publisher);
        $("[name='status']").val(response.status);
        $("[name='description']").val(response.description);
        $("[name='pagetotal']").val(response.page_total);
        $("[name='created_at']").val(response.created_at);
      },
      error: function () {
        alert(
          "Error: Please Contact System Admnistrator \n Or Refresh this Page."
        );
      },
    });
  });

  //botton for submitting the updated book details
  $("#updatebook-form").submit(function (e) {
    e.preventDefault();

    const sdata = $(this).serialize();

    alertify
      .confirm(
        "Are you sure you want to update this book ? ",
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/book/updateSingleBook",
            type: "GET",
            data: sdata,
            cache: false,
            success: function (response) {
              console.log(response);
              $("#editbook-modal").modal("hide");
            },
            error: function () {
              alert(
                "Error: Please Contact System Admnistrator \n Or Refresh this Page."
              );
            },
          });

          refreshDatatables();
          $("#datatable").DataTable().ajax.reload();
          alertify.success("Updated Successfully !");
        },
        function () {
          alertify.error("Cancelled");
        }
      )
      .setHeader("Confirmation ");
  });

  //button for deleting the book
  $("#datatable").on("click", "#btn-delete", function () {
    var data = booksTable.row($(this).parents("tr")).data();

    alertify
      .confirm(
        "Are you sure you want to delete this book ? " + data.title,
        function () {
          $.ajax({
            url: "http://localhost:8080/LibrarySystem/book/deleteSingleBook", //url for removing the book
            type: "GET",
            data: { id: data.id },
            cache: false,
            success: function (response) {
              console.log("book deleted");
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
