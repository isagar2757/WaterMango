<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WaterDetails.aspx.cs" Inherits="WaterMango.WaterDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>WaterMango</title>

    <link runat="server" href="~/Content/CSS/bootstrap.css" rel="stylesheet" />
    <style>
        .myProgress {
            width: 100%;
            background-color: #ddd;
        }

        .myBar {
            width: 0%;
            height: 30px;
            background-color: #4CAF50;
            text-align: center;
            line-height: 30px;
            color: white;
        }
    </style>
    <script src="Content/Script/jquery-3.1.1.js" type="text/javascript"></script>
    <script type="text/javascript">

        function WaitFor30(remainingTime) {
            alert("Wait for " + remainingTime + " Seconds");
        }

        function NoProcess() {
            alert("It's Already done...!!!\n You're Late..!!");
        }


        function move(index) {

            var elem = document.getElementById("myBar"+index);
            var width = 10;
            var id = setInterval(frame, 100);
            function frame() {
                if (width >= 100) {
                    clearInterval(id);
                } else {
                    width++;
                    elem.style.width = width + '%';
                    elem.innerHTML = width * 1 + '%';
                }
            }

        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="grdPlants" runat="server" AutoGenerateColumns="False" OnRowCommand="grdPlants_RowCommand" CssClass="table table-bordered" HeaderStyle-CssClass="bg-primary">
                <Columns>
                    <asp:BoundField HeaderText="Plant" DataField="plantID" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                    <asp:BoundField HeaderText="Start Time" DataField="waterStartTime" DataFormatString="{0:T}" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                    <asp:BoundField HeaderText="Expected End Time" DataField="waterEndTime" DataFormatString="{0:T}" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
                    <asp:TemplateField HeaderText="Start | Stop">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkStart" runat="server" CommandArgument='<%# Container.DataItemIndex%>' CommandName="STRT" Text="Start"></asp:LinkButton>
                            | 
                    <asp:LinkButton ID="lnkStop" runat="server" CommandArgument='<%# Container.DataItemIndex %>' CommandName="STOP" Text="Stop" OnClientClick="return confirm('Are you sure to stop?');"></asp:LinkButton>
                        </ItemTemplate>
                        <HeaderStyle CssClass="text-center" />
                        <ItemStyle CssClass="text-center" />
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="bg-primary"></HeaderStyle>
            </asp:GridView>
        </div>

        <table id="progressBar" class="table table-bordered">
            <tr id="plant1">
                <td class="col-md-2 text-center">Plant 1</td>
                <td class="col-md-10">
                    <div class="myProgress">
                        <div class="myBar" id="myBar1">0%</div>
                    </div>
                </td>
            </tr>
            <tr id="plant2">
                <td class="col-md-2 text-center">Plant 2</td>
                <td class="col-md-10">
                    <div class="myProgress">
                        <div class="myBar" id="myBar2">0%</div>
                    </div>
                </td>
            </tr>
            <tr id="plant3">
                <td class="col-md-2 text-center">Plant 3</td>
                <td class="col-md-10">
                    <div class="myProgress">
                        <div class="myBar" id="myBar3">0%</div>
                    </div>
                </td>
            </tr>
            <tr id="plant4">
                <td class="col-md-2 text-center">Plant 4</td>
                <td class="col-md-10">
                    <div class="myProgress">
                        <div class="myBar" id="myBar4">0%</div>
                    </div>
                </td>
            </tr>
            <tr id="plant5">
                <td class="col-md-2 text-center">Plant 5</td>
                <td class="col-md-10">
                    <div class="myProgress">
                        <div class="myBar" id="myBar5">0%</div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
