<?php require 'includes/topnav.php';
    $sess = new SESSION();
   
?>

<main class="wrapper">
    <!-- Right side navigation -->
    <?php require 'includes/userSidenav.php'?>
    <!--  End of Right side navigation -->
    <div class="content container-fluid">
        <!-- User Dashboard -->
        <div class="row mt-2">
            <div class="col-lg-6 mx-auto">
                <?php
                    if (isset($_GET['message'])) {
                        if ($_GET['message'] == "resetsuccess") {
                            echo '<p class =" text-white text-center" style=" background-color: green;border-radius:5px">Password Update Successful</p>';
                        } elseif ($_GET['message'] == "updatesuccess") {
                            echo '<p class =" text-white text-center" style=" background-color: green;border-radius:5px"> Update Successful</p>';
                        }
                    }
                ?>
            </div>
        </div>
        <div class="row ">


            <?php

                    

                    $userOBJ = new USER();
                    //GET SESSION ID
                    $sessID = $userOBJ->getSessionID();
                    //CHECKIF LEADER
                   $data = $userOBJ->countSpecific('leaders_fk_user_id', 'leaders', $sessID);
                    if ($data['id'] == 0) {
                    } else {
                        $leaderdata = $userOBJ->getLeaderData($sessID);
                      
                        
                        echo '
                        <div class="col-sm-6 mt-1">
                        <div class="row">
                            <div class="col"> <div class="col ">Upload Your Image Here</div></div>
                        </div>
                        <div class="row"> 
                        <div class="col"> <input type="file" name="image" id="insert_image" accept="image/*" /></div>
                        </div>
                        
                        <form action="includes/update.inc.php" method="post">
                        <div class="card bg-transparent">
                            <div class="card-body bg-transparent">
                                <h5 class="card-title">Update Your Quote</h5>
                                <textarea name="quote" id="quote" cols="30" value="" rows="4" class="w-100 form-control"
                                        required> ' . $leaderdata['leaders_quote'] .' </textarea>
                                
                            </div>
                            <button type="submit" class="btn btn-success d-flex mx-auto " name="leaderquote">Update
                           </button>
                        </div>
                        
                    </form>
                    </div>
                        ';
                    }
                   
                    ?>


            <div class="col-sm-6 mt-1">
            <div class="col"></div>
                <div class="card bg-transparent ">
                    <div class="card-body bg-transparent">
                        <h5 class="card-title">Update Password</h5>
                        <form action="includes/reset.inc.php" method="post">
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control form-control-sm" id="password"
                                    placeholder="Password" name="password" required>

                            </div>
                            <div class="form-group">
                                <label for="confirmPassword">Password Confirm</label>
                                <input type="password" class="form-control form-control-sm" id="confirmPassword"
                                    placeholder="Password confirmation" name="passordconfirm" required>

                            </div>
                            <button type="submit" class="btn btn-success d-flex mx-auto " name="updatepassword">Update
                                Password</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</main>

<!-- //crop images -->
<div id="insertimageModal" class="modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Crop & Insert Image</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-8 text-center">
                        <div id="image_demo" style="width:350px; margin-top:30px"></div>
                    </div>
                    <div class="col-md-4" style="padding-top:30px;">
                        <br />
                        <br />
                        <br />
                        <button class="btn btn-success crop_image">Crop & Insert Image</button>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>





<script src="js/lib/bootstrap-validate.js"></script>
<script>
    bootstrapValidate('#quote', 'max:231:You can Only Enter A Maximum of 231 Characters');
    bootstrapValidate('#confirmPassword', 'matches:#password:Password Must Match');
    bootstrapValidate('#password', 'min:4:Weak Password');
</script>
<script src="js/lib/jquery-3.2.1.min.js"></script>
<script src="js/lib/popper.min.js"></script>
<script src="js/lib/bootstrap.min.js"></script>
<script src="js/lib/admin.js"></script>
<script src="js/lib/croppie.min.js"></script> 
<!-- Side Navigation Scripts -->
<script>

    $(document).ready(function() {
        $(pcs % quote~2# sidebarCollapsepcs % quote~2).on(pcs % quote~2 clickpcs % quote~2,
            function() {
                $(pcs % quote~2# sidebarpcs % quote~2).toggleClass(pcs % quote~2 activepcs %
                    quote~2);
            });
    });
    document.querySelector(pcs % quote~2. contentpcs % quote~2).addEventListener(pcs % quote~
        2 clickpcs % quote~2,
        function() {
            document.getElementById(pcs % quote~2 sidebarpcs % quote~2).classList.remove(pcs %
                quote~2 activepcs % quote~2);

        })
    document.querySelector(pcs % quote~2. navbar - navpcs % quote~2).addEventListener(pcs % quote~
        2 clickpcs % quote~2,
        function() {
            document.getElementById(pcs % quote~2 sidebarpcs % quote~2).classList.remove(pcs %
                quote~2 activepcs % quote~2);

        });
</script>
<script>  
$(document).ready(function(){

 $image_crop = $('#image_demo').croppie({
    enableExif: true,
    viewport: {
      width:200,
      height:200,
      type:'circle' //circle
    },
    boundary:{
      width:300,
      height:300
    }    
  });

  $('#insert_image').on('change', function(){
    var reader = new FileReader();
    reader.onload = function (event) {
      $image_crop.croppie('bind', {
        url: event.target.result
      }).then(function(){
        console.log('jQuery bind complete');
      });
    }
    reader.readAsDataURL(this.files[0]);
    $('#insertimageModal').modal('show');
  });

  $('.crop_image').click(function(event){
    $image_crop.croppie('result', {
      type: 'canvas',
      size: 'viewport'
    }).then(function(response){
      $.ajax({
        url:'includes/insertfile.php',
        type:'POST',
        data:{"image":response},
        success:function(data){
          $('#insertimageModal').modal('hide');
          load_images();
          alert(data);
        }
      })
    });
  });

  load_images();

  function load_images()
  {
    $.ajax({
      url:"fetch_images.php",
      success:function(data)
      {
        $('#store_image').html(data);
      }
    })
  }

});  
</script>








<?php

//database_connection.php

$connect = new PDO("mysql:host=localhost;dbname=testing", "root", "");

?>




</body>

</html>

<?php
/*this  code will pop up the modal immediately the page
 loads incase there is a new message in the form*/
// if (isset($_GET['message'])) {
//     echo '<script>
//         $("#confirmUser").modal();
    
//     </script>';
// }
