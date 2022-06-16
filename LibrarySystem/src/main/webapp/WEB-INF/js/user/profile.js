$(document).ready(function () {
  var user_id = $("#user_id").val();

  $.ajax({
    url: "http://localhost:8080/LibrarySystem/user/getSingleUser",
    type: "GET",
    data: { id: user_id },
    cache: false,
    success: function (response) {
      console.log(response);
      $("[name='user_id']").val(response.id);
      $("[name='username']").val(response.username);
      $("[name='password']").val(response.password);
      $("[name='email']").val(response.email);
      $("[name='firstname']").val(response.firstname);
      $("[name='lastname']").val(response.lastname);
      $("[name='gender']").val(response.gender);
      $("[name='age']").val(response.age);
      $("[name='contact_number']").val(response.contact_number);
      $("[name='address']").val(response.address);
      $("[name='created_at']").val(moment(response.created_at).format("LLL"));
    },
    error: function () {
      alert(
        "Error: Please Contact System Admnistrator \n Or Refresh this Page."
      );
    },
  });

  $("#update-form").submit(function (e) {
    e.preventDefault();

    var cnum = $("#contact_number").val();

    const data = $(this).serialize();

    if (cnum.length > 11 || cnum.length < 11) {
      alertify.error("Invalid contact number, must be 11 digits");
    } else {
      alertify
        .confirm(
          "Are you sure you want to update your profile ? ",
          function () {
            $.ajax({
              url: "http://localhost:8080/LibrarySystem/user/UpdateProfile",
              dataType: "json",
              cache: false,
              data: data,
              success: function (response) {
                console.log(response);
              },
              error: function (response) {
                console.log(response);
              },
            });
            alertify.success("Updated Successfully !");
          },
          function () {
            alertify.error("Cancelled");
          }
        )
        .setHeader("Confirmation ");
    }
  });
});
