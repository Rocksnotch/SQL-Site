<%@ Page Title="Departments" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="siteSQL.Employees" %>

<asp:Content ID="employeesContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="js/bootstrap.bundle.min.js"></script>
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
            <script>

                var xmlDoc;
                var allLoad = 0;


                function parseXML(xml) {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.open("GET", xml, false);
                    xmlhttp.send(null);
                    if (xmlhttp.responseXML == null) {
                        alert("Bad XML");
                        return -1;
                    }
                    xmlDoc = xmlhttp.responseXML;
                    if (xmlDoc.nodeName == "parsererror") {
                        alert(xmlDoc.childNodes[0].nodeValue);
                        return -1;
                    }
                }

                function loadContent(element) {
                    var allDept = xmlDoc.getElementsByTagName("Department");
                    var allEmp = xmlDoc.getElementsByTagName("Employee");
                    var allPos = xmlDoc.getElementsByTagName("Position");
                    var allPic = xmlDoc.getElementsByTagName("Picture");
                    var exCount = 0;
                    var deptCount = 0;

                    var content = "";
                    if (allLoad == 0) { //default, loads all the content on page load
                        for (var i = 0; i < allEmp.length; i++) {

                            content += '<div class="row border border-dark border-3">';
                            content += '<div class="col">';
                            content += '<img class="employeePic" src="' + allPic[i].childNodes[0].nodeValue + '">';
                            content += '</div>';
                            content += '<div class="col">';
                            content += '<h1>' + allEmp[i].getAttribute("name") + '</h1>';
                            content += '<h2>Position: ' + allPos[i].childNodes[0].nodeValue + '</h2>';
                            content += '</div>';
                            content += '</div>';
                            content += '<br />';
                        }
                        document.getElementById("departInfo").innerHTML = content;
                        allLoad++;
                    } else {
                        var e = document.getElementById("selectDepart").value;
                        if (e == "all") {
                            allLoad = 0;
                            loadContent(null);
                        } else {
                            //print the actual stuff here

                            for (var i = 0; i < allDept.length; i++) {
                                if (allDept[i].getAttribute("attribute") == element.value) { //department found! Print out everyone!
                                    exCount = deptCount * 3;
                                    for (var i = 0; i < 3; i++) {

                                        content += '<div class="row border border-dark border-3">';
                                        content += '<div class="col">';
                                        content += '<img class="employeePic" src="' + allPic[exCount].childNodes[0].nodeValue + '">';
                                        content += '</div>';
                                        content += '<div class="col">';
                                        content += '<h1>' + allEmp[exCount].getAttribute("name") + '</h1>';
                                        content += '<h2>Position: ' + allPos[exCount].childNodes[0].nodeValue + '</h2>';
                                        content += '</div>';
                                        content += '</div>';
                                        content += '<br />';
                                        exCount++;
                                    }
                                    document.getElementById("departInfo").innerHTML = content;
                                    break;
                                } else {
                                    deptCount++; //if department isnt found, add to the counter
                                }
                            }

                        }
                    }
                }

                $(window).on("load", function () {
                    parseXML("/xml/employees.xml");
                    loadContent(null);
                });
            </script>

    <div class="mainContent">
                <p>Please select a department </p>
                <select id="selectDepart" onchange="loadContent(this)">
                    <option value="all">All</option>
                    <option value="admin">Administration</option>
                    <option value="market">Marketing</option>
                    <option value="develop">Product Development</option>
                    <option value="testing">Product Testing</option>
                    <option value="research">Research and Development</option>
                </select>

                <div id="departInfo" class="container-fluid contentEmp" style="display: inline-block"></div>

            </div>

</asp:Content>