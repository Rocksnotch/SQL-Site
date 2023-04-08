<%@ Page Title="Quote" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Quote.aspx.cs" Inherits="siteSQL.WebForm1" %>

<asp:Content ID="quoteContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="js/bootstrap.bundle.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
        <script>

            function formValidate() {
                $letter = /^[a-zA-Z]+$/;
                $number = /^[0-9.]+$/;
                $errMsg = "";
                $sqft = $("#sqft").val();
                $state = $("#selectState").val();
                $panel = $("#selectPanel").val();
                $sales = $("#salesTax").val();
                $woods = $("#woodedArea").is(':checked');
                $errCount = 0;

                $("#err").html("");

                if ($sqft.match($number) == null) {
                    if ($sqft == "") {
                        $errMsg += "Field required - [Roof Square Foot]<br />";
                        $errCount++;
                    } else {
                        $errMsg += "Please input only numbers! - [Roof Square Foot]<br />";
                        $errCount++;
                    }
                }

                if ($state == 'out') {
                    if ($sales.match($number) == null) {
                        if ($sales == "") {
                            $errMsg += "Field required - [State Sales Tax]<br />";
                            $errCount++;
                        } else {
                            $errMsg += "Please input only numbers! - [State Sales Tax]<br />";
                            $errCount++;
                        }
                    }
                }

                if ($errCount > 0) {
                    $("#err").append($errMsg);
                } else {
                    calculateData($sqft, $state, $panel, $sales, $woods);
                }
            }

            function calculateData($sqft, $state, $panel, $sales, $woods) {
                //housekeeping
                audio = document.getElementById("doneAudio");
                audio.pause();
                audio.currentTime = 0;

                //variables to use for math
                $lowPanel = 69.99;
                $medPanel = 169.99;
                $highPanel = 399.99;
                $inState = 59.99;
                $outOfState = 599.99;
                $inWoodsCost = 199.99;
                $unknownRoof = 500;
                $miTax = 0.06;
                $finalCost = 0;
                $salesCost = 0;

                $("#costArea").hide();

                if ($sqft == 0) {
                    $finalCost += $unknownRoof / 10;
                } else {
                    $finalCost += $sqft / 10;
                }

                if ($panel == 'panel1') {
                    $finalCost *= $lowPanel;
                } else if ($panel == 'panel2') {
                    $finalCost *= $medPanel;
                } else if ($panel == 'panel3') {
                    $finalCost *= $highPanel;
                }

                if ($woods == true) {
                    $finalCost += $inWoodsCost;
                }

                if ($state == 'out') {
                    $salesCost = $finalCost * $sales;
                } else if ($state == 'in') {
                    $salesCost = $finalCost * $miTax;
                }

                $finalCost += $salesCost;

                $finalCost = parseFloat($finalCost).toFixed(2);

                $("#costArea").val('$' + $finalCost);

                audio.volume = 0.1;
                audio.play();
                $("#costArea").slideDown(1000, 'linear');
            }

            function createForm() {

                var arrState = [
                    { val: 'in', text: 'In State' },
                    { val: 'out', text: 'Out of State'}
                ];

                var arrPanel = [
                    { val: 'panel1', text: 'Low-Cost Panel' },
                    { val: 'panel2', text: 'Standard Panel' },
                    { val: 'panel3', text: 'Efficient Panel' },
                ];

                $("#formArea").append(
                    $("<form/>", {
                        action: '#',
                        method: '#'
                    }).append(
                        $("<input/>", {
                            type: 'text',
                            id: 'sqft',
                            name: 'sqft',
                            placeholder: 'Roof Square Foot',
                        }),
                        $("<select/>", {
                            id: 'selectState',
                            name: 'state'
                        }),
                        $("<select/>", {
                            id: 'selectPanel',
                            name: 'panel'
                        }),
                        $("<input/>", {
                            type: 'text',
                            id: 'salesTax',
                            name: 'salestax',
                            class: 'inline'
                        }),
                        $("<input/>", {
                            type: 'checkbox',
                            id: 'woodedArea',
                            name: 'woodedBox',
                        }),
                        $("<button/>", {
                            type: 'button',
                            id: 'submit',
                            text: 'Submit'
                        })
                    )
                )

                $("#cost").append(
                    $("<form/>", {
                        action: '#',
                        method: '#'
                    }).append(
                        $("<input/>", {
                            type: 'text',
                            id: 'costArea',
                            name: 'costArea',
                        })
                    )
                )

                $("#sqft").before("Roof Square Foot (0 if unknown): ");
                $("#sqft").after("<br />");

                $("#selectState").before("In or Out of State (Michigan): ");
                $("#selectState").after("<br />");

                $("#woodedArea").before("Is the house located near woods (Check if Yes): ");
                $("#woodedArea").after("<br />");

                $("#selectPanel").before("Which type of panel to be installed: ");
                $("#selectPanel").after("<br />");

                $("#salesTax").before('<p style="display:inline" id="salesText">State Sales Tax (in cents): </p>');
                $("#salesTax").after('<br />');

                var selState = $("#selectState");
                var selPanel = $("#selectPanel");

                $("#costArea").before('Final Estimated Quote Cost (Will appear next to this): ');
                $("#costArea").after("<br />");

                $(arrState).each(function () {
                    selState.append($("<option>").attr('value', this.val).text(this.text));
                });

                $(arrPanel).each(function () {
                    selPanel.append($("<option>").attr('value', this.val).text(this.text));
                });

                $("#salesTax").attr('disabled', true);
                $("#salesTax").val("Not Applicable");
                $("#costArea").attr('readonly', true);
                $("#costArea").hide();

                
            }

            $(document).on('change', '#selectState', function () {
                var selectedOpt = $(this).children('option:selected').val();
                if (selectedOpt == 'in') {
                    $("#salesTax").attr('disabled', true);
                    $("#salesTax").val("Not Applicable");
                } else if (selectedOpt == 'out') {
                    $("#salesTax").attr('disabled', false);
                    $("#salesTax").val("");
                }
            });

            $(document).on('click', '#submit', function () {
                formValidate();
            });

            $(document).ready(function () {
                createForm();
                

            });
        </script>

        <audio src="/audio/chime.mp3" type="audio/mp3" id="doneAudio"></audio>

    <div class="mainContent">
            <p>Wanting to get solar installed on your home? Hate having to use calculators?</p>
            <p>Hate having to wait to get a quote from an email 3 weeks after you want solar?</p>
            <p>Want to get the estimated* quoted cost of what a quote would cost?</p>
            <p>Great! Getting a quote has never been easier when using the</p>
            <h1>Aperture Science Solar Quote Non-Calculator Calculator™</h1>
            <div id="formArea"></div>
            <br />
            <br />
            <div id="err" style="color:firebrick"></div>
            <br />
            <div id="cost"></div>
        </div>

</asp:Content>
