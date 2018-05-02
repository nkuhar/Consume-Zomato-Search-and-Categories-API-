<%-- 
    Document   : consume
    Created on : May 1, 2018, 6:05:35 AM
    Author     : nishu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="paging.js"></script>
        <!--These Script helps to call the 2 Zomato.com and return data
            USE THE FOLLOWING URL TO CREATE YOUR API KEY AND THE SERVICES U NEED TO CONSUME
            URL: https://developers.zomato.com/documentation#/
        --> 
        <script>
            //Getting the JSON FOR CATEGORIES DATA
            var url = "https://developers.zomato.com/api/v2.1/categories";
            //url += '/1/classes/birthday';
            var data_obj;
            var geturl = fetch(url, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'user-key': 'YOUR API KEY',
                    'Content-Type': 'application/json',
                },
            })
            //PROMISES TO GET DATA AND PARSE THE JSON FORMAT
                    .then(function (response) {
                        return response.text();
                    })
                    .then(function (data) {
                        console.log(data); //this will just be text

                        // document.getElementById("encoded").innerHTML = data;
                        return data;
                    })
                    .then(function (data) {

                        var arr = JSON.parse(data);
                        console.log(arr);
                        var i;
                        //MAKING A DROPDOWN LIST FOR CATEGORIES YOU GET
                        var out = "<select id = 'category' class='form-control' style='cornflowerblue'>";
                        var array = arr.categories;
                        for (i = 0; i < arr.categories.length; i++) {
                            out += "<option value=" +
                                    array[i].categories.name +
                                    ">" + array[i].categories.name + "</option>";
                        }
                        out += "</select>";
                        document.getElementById("demo").innerHTML = out;
                        return arr;


                    });

        </script>
        <script>
            //FUNCTION TO HIT THE SECOND API CALL TO GET THE SEARCH RESULTS FOR THE CATEGORY SELECTED
            function SearchClick() {


                var url = "https://developers.zomato.com/api/v2.1/search?category=";
                url += document.getElementById("category").value + "%100up";
                var data_obj;
                var geturl = fetch(url, {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json',
                        'user-key': 'YOUR API KEY',
                        'Content-Type': 'application/json',
                    },
                })
                //PARSING THE DATA INTO A HTML TABLE
                        .then(function (response) {
                            return response.text();
                        })
                        .then(function (data) {
                            console.log(data); //this will just be text

                            // document.getElementById("encoded").innerHTML = data;
                            return data;
                        })
                        .then(function (data) {

                            var arr = JSON.parse(data);
                            console.log(arr);
                            var i, j;
                            var out = "<table id='tblData' cellpadding = '1' class='table table-bordered table-striped table-hover'>";
                            out += "<tr><thead><th>" +
                                    "Restaurant Name" +
                                    "</th><th>" +
                                    "Zomato Restaurant URL" +
                                    "</th><th>" +
                                    "Cuisines" +
                                    "</th><th>" +
                                    "Average Cost For Two" +
                                    "</th><th>" +
                                    "Street Address" +
                                    "</th><th>" +
                                    "User Average Ratings" +
                                    "</th></tr></thead>"
                            var array = arr.restaurants;
                            for (i = 0; i < array.length; i++) {

                                out += "<tr class ='active'><td>" +
                                        array[i].restaurant.name +
                                        "</td><td><a href ='" +
                                        array[i].restaurant.url +
                                        "'>"+array[i].restaurant.url +"</a></td><td>" +
                                        array[i].restaurant.cuisines +
                                        "</td><td>$" +
                                        array[i].restaurant.average_cost_for_two +
                                        "</td><td>" +
                                        array[i].restaurant.location.address + "," +
                                        array[i].restaurant.location.city + "," +
                                        array[i].restaurant.location.zip +
                                        "</td><td>" +
                                        array[i].restaurant.user_rating.aggregate_rating +
                                        "</td></tr>";
                            }
                            out += "</table>";
                            document.getElementById("restaurantable").innerHTML = out;
                            return arr;
                        });
            }

        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="jumbotron text-center">
            <h1>Search Restaurants by Category from Zomato REST API</h1>
            <p>Select category</p> 
        </div>
        <div class="col-sm-2">
        </div>
        <div class="col-sm-8">
            <h3>Magic Happens Here Select Your Choice</h3>
            <div id="demo"size="50">  </div>
            </br>
            <button type="button" class="btn btn-default btn-success" onclick="SearchClick()">Search</button>
            <br/>
            <div  id="restaurantable" style="margin-top:2%;"></div>
            <div id="pageNavPosition"></div>
        </div>
        <div class="col-sm-2" style="color: cornflowerblue">
        </div>
    </div>
</div>

</body>
</html>

