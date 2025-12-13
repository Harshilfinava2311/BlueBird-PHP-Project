<?php
include '../config.php';

// fetch room data
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;

$sql = "SELECT * FROM roombook WHERE id = '$id'";
$re = mysqli_query($conn, $sql);
$row = mysqli_fetch_array($re);

if (!$row) {
    die("No record found.");
}

$Name = $row['Name'];
$Email = $row['Email'];
$Country = $row['Country'];
$Phone = $row['Phone'];
$cin = $row['cin'];
$cout = $row['cout'];
$noofday = $row['nodays'];
$stat = $row['stat'];

if (isset($_POST['guestdetailedit'])) {
    $EditName = $_POST['Name'] ?? '';
    $EditEmail = $_POST['Email'] ?? '';
    $EditCountry = $_POST['Country'] ?? '';
    $EditPhone = $_POST['Phone'] ?? '';
    $EditRoomType = $_POST['RoomType'] ?? '';
    $EditBed = $_POST['Bed'] ?? '';
    $EditNoofRoom = intval($_POST['NoofRoom'] ?? 1);
    $EditMeal = $_POST['Meal'] ?? '';
    $Editcin = $_POST['cin'] ?? '';
    $Editcout = $_POST['cout'] ?? '';

    // Update roombook table
    $sql = "UPDATE roombook SET Name = '$EditName', Email = '$EditEmail', Country='$EditCountry', Phone='$EditPhone', RoomType='$EditRoomType', Bed='$EditBed', NoofRoom='$EditNoofRoom', Meal='$EditMeal', cin='$Editcin', cout='$Editcout', nodays = DATEDIFF('$Editcout','$Editcin') WHERE id = '$id'";
    $result = mysqli_query($conn, $sql);

    // Room pricing
    $type_of_room = match($EditRoomType) {
        "Superior Room" => 3000,
        "Deluxe Room" => 2000,
        "Guest House" => 1500,
        "Single Room" => 1000,
        default => 0
    };

    $type_of_bed = match($EditBed) {
        "Single" => $type_of_room * 1 / 100,
        "Double" => $type_of_room * 2 / 100,
        "Triple" => $type_of_room * 3 / 100,
        "Quad" => $type_of_room * 4 / 100,
        "None" => 0,
        default => 0
    };

    $type_of_meal = match($EditMeal) {
        "Room only" => $type_of_bed * 0,
        "Breakfast" => $type_of_bed * 2,
        "Half Board" => $type_of_bed * 3,
        "Full Board" => $type_of_bed * 4,
        default => 0
    };

    // Get updated no of days
    $psql = "SELECT nodays FROM roombook WHERE id = '$id'";
    $presult = mysqli_query($conn, $psql);
    $prow = mysqli_fetch_array($presult);
    $Editnoofday = intval($prow['nodays']);

    $editttot = $type_of_room * $Editnoofday * $EditNoofRoom;
    $editmepr = $type_of_meal * $Editnoofday;
    $editbtot = $type_of_bed * $Editnoofday;

    $editfintot = $editttot + $editmepr + $editbtot;

    // Update payment table
    $psql = "UPDATE payment SET Name = '$EditName', Email = '$EditEmail', RoomType='$EditRoomType', Bed='$EditBed', NoofRoom='$EditNoofRoom', Meal='$EditMeal', cin='$Editcin', cout='$Editcout', noofdays = '$Editnoofday', roomtotal = '$editttot', bedtotal = '$editbtot', mealtotal = '$editmepr', finaltotal = '$editfintot' WHERE id = '$id'";
    $paymentresult = mysqli_query($conn, $psql);

    if ($paymentresult) {
        header("Location: roombook.php");
        exit;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Edit Reservation</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
    <!-- SweetAlert -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" href="./css/roombook.css" />
</head>
<body>
    <div id="editpanel">
        <form method="POST" class="guestdetailpanelform">
            <div class="head">
                <h3>Edit Reservation</h3>
                <a href="./roombook.php"><i class="fa-solid fa-circle-xmark"></i></a>
            </div>
            <div class="middle">
                <div class="guestinfo">
                    <h4>Guest Information</h4>
                    <input type="text" name="Name" placeholder="Enter Full name" value="<?php echo htmlspecialchars($Name); ?>" required />
                    <input type="email" name="Email" placeholder="Enter Email" value="<?php echo htmlspecialchars($Email); ?>" required />
                    <select name="Country" class="selectinput" required>
                        <option value="">Select your country</option>
                        <?php
                        $countries = ["Afghanistan","Albania","Algeria","India","United States","United Kingdom","Australia"]; // truncated for brevity
                        foreach($countries as $country):
                            $selected = ($Country == $country) ? "selected" : "";
                            echo "<option value=\"$country\" $selected>$country</option>";
                        endforeach;
                        ?>
                    </select>
                    <input type="text" name="Phone" placeholder="Enter Phone no" value="<?php echo htmlspecialchars($Phone); ?>" required />
                </div>

                <div class="line"></div>

                <div class="reservationinfo">
                    <h4>Reservation Information</h4>
                    <select name="RoomType" class="selectinput" required>
                        <option value="">Type Of Room</option>
                        <?php
                        $roomTypes = ["Superior Room", "Deluxe Room", "Guest House", "Single Room"];
                        foreach($roomTypes as $room) {
                            $selected = ($row['RoomType'] == $room) ? "selected" : "";
                            echo "<option value=\"$room\" $selected>$room</option>";
                        }
                        ?>
                    </select>

                    <select name="Bed" class="selectinput" required>
                        <option value="">Bedding Type</option>
                        <?php
                        $beds = ["Single", "Double", "Triple", "Quad", "None"];
                        foreach($beds as $bed) {
                            $selected = ($row['Bed'] == $bed) ? "selected" : "";
                            echo "<option value=\"$bed\" $selected>$bed</option>";
                        }
                        ?>
                    </select>

                    <select name="NoofRoom" class="selectinput" required>
                        <option value="">No of Room</option>
                        <?php
                        for ($i = 1; $i <= 5; $i++) {
                            $selected = ($row['NoofRoom'] == $i) ? "selected" : "";
                            echo "<option value=\"$i\" $selected>$i</option>";
                        }
                        ?>
                    </select>

                    <select name="Meal" class="selectinput" required>
                        <option value="">Meal</option>
                        <?php
                        $meals = ["Room only", "Breakfast", "Half Board", "Full Board"];
                        foreach($meals as $meal) {
                            $selected = ($row['Meal'] == $meal) ? "selected" : "";
                            echo "<option value=\"$meal\" $selected>$meal</option>";
                        }
                        ?>
                    </select>

                    <div class="datesection">
                        <span>
                            <label for="cin">Check-In</label>
                            <input name="cin" type="date" value="<?php echo htmlspecialchars($cin); ?>" required />
                        </span>
                        <span>
                            <label for="cout">Check-Out</label>
                            <input name="cout" type="date" value="<?php echo htmlspecialchars($cout); ?>" required />
                        </span>
                    </div>
                </div>
            </div>
            <div class="footer">
                <button class="btn btn-success" name="guestdetailedit">Edit</button>
            </div>
        </form>
    </div>
</body>
</html>
