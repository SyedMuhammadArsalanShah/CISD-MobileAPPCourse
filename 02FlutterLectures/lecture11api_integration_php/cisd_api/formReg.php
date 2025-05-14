<?php



$hostname="localhost";
$username="root";
$password="";
$database="cisd";

$conn=mysqli_connect($hostname,$username,$password,$database);

if (!$conn) {
    die(json_encode(["message"=>"connection is failed"]));

}else{
    echo "success";
}



$name= $_POST["name"];
$email= $_POST["email"];
$pass=  password_hash(  $_POST["password"],PASSWORD_DEFAULT);

$sqlInsert="INSERT INTO `info`(`Name`, `Email`, `Password`) VALUES ('$name','$email','$pass')";

$res=mysqli_query($conn,$sqlInsert);


if ($res) {

    echo json_encode(["message"=>$res?"Successfully inserted":"error"]);
}



?>