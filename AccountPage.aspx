<%@ Page Title="Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AccountPage.aspx.cs" Inherits="siteSQL.AccountPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <form id="accountUpdateForm" runat="server">
        <asp:Label ID="usernameLabel" runat="server">
            Username:
        </asp:Label>
        <asp:TextBox ID="usernameTextBox" runat="server">
            
        </asp:TextBox>
        <br />
        <asp:Label ID="emailLabel" runat="server">
            Email:
        </asp:Label>
        <asp:TextBox ID="emailTextBox" runat="server">
            
        </asp:TextBox>
        <br />
        <asp:Button ID="updateInfoButton" Text="Update" ToolTip="Update" runat="server" OnClick="updateInfoButton_Click"></asp:Button>
        <asp:Button ID="logoutButton" Text="Logout" runat="server" OnClick="logoutButton_Click" />
    </form>

</asp:Content>
