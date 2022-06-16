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
      ajax: "http://localhost:8080/LibrarySystem/log/getAllLogs", //endpoint to get all the logs
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
      ],
      columnDefs: [
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

  getDatatable();
});
