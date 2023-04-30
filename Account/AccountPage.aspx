<%@ Page Title="Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AccountPage.aspx.cs" Inherits="siteSQL.AccountPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <form id="accountUpdateForm" runat="server">
        
        <asp:Label runat="server">Username: </asp:Label>
        <asp:TextBox ID="usernameText" runat="server"></asp:TextBox>
        <br />
        <asp:Label runat="server">Email: </asp:Label>
        <asp:TextBox ID="emailText" runat="server"></asp:TextBox>
        <br />
        <asp:Label runat="server">Phone: </asp:Label>
        <asp:TextBox ID="phoneText" runat="server"></asp:TextBox>
        <br />
        <asp:Label runat="server">First Name: </asp:Label>
        <asp:TextBox ID="firstNameText" runat="server"></asp:TextBox>
        <br />
        <asp:Label runat="server">Last Name: </asp:Label>
        <asp:TextBox ID="lastNameText" runat="server"></asp:TextBox>
        <br />
        <asp:Label runat="server">Address: </asp:Label>
        <asp:TextBox ID="addressText" runat="server"></asp:TextBox>

        
        <asp:SqlDataSource ID="accountData" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Id], [Email], [UserName], [FirstName], [LastName], [Address], [userId], [PhoneNumber] FROM [AspNetUsers] WHERE ([Id] = @Id)">
            <SelectParameters>
                <asp:SessionParameter Name="Id" SessionField="userID" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <br />

        <asp:Button ID="updateInfoButton" Text="Update" runat="server" OnClick="updateInfoButton_Click"/>
        <asp:Button ID="logoutButton" Text="Logout" runat="server" OnClick="logoutButton_Click"/>
    </form>

</asp:Content>
