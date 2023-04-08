<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="siteSQL.Products" %>
    

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <asp:SqlDataSource ID="productTab1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Product], [Refurbished], [Year], [Price] FROM [Table] WHERE ([Type] = @Type) ORDER BY [Year]">
            <SelectParameters>
                <asp:ControlParameter ControlID="dropdownlist" DefaultValue="NULL" Name="Type" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="productTab2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [Product], [Refurbished], [Year], [Price], [Image] FROM [Table] WHERE ([Product] = @Product)">
            <SelectParameters>
                <asp:ControlParameter ControlID="productTable1" DefaultValue="NULL" Name="Product" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="productList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [Type] FROM [Table]"></asp:SqlDataSource>

    <form id="listForm" runat="server">

        <div class="dropdownDiv">
            <asp:DropDownList ID="dropdownlist" runat="server" Width="100px" DataSourceID="productList" DataTextField="Type" DataValueField="Type" AutoPostBack="True" OnSelectedIndexChanged="dropdownlist_SelectedIndexChanged"></asp:DropDownList>
        </div>
        <div class="tableOneDiv">
        <asp:GridView ID="productTable1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="productTab1" ForeColor="#333333" GridLines="None" DataKeyNames="Product">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" />
                <asp:BoundField DataField="Refurbished" HeaderText="Refurbished" SortExpression="Refurbished" />
                <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>

        </div>

        <div class="tableTwoDiv">
        <asp:DetailsView ID="detailProduct" runat="server" AutoGenerateRows="False" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" DataSourceID="productTab2" ForeColor="Black" GridLines="Vertical">
            <AlternatingRowStyle BackColor="#CCCCCC" />
            <EditRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <Fields>
                <asp:BoundField DataField="Product" HeaderText="Product" SortExpression="Product" />
                <asp:BoundField DataField="Refurbished" HeaderText="Refurbished" SortExpression="Refurbished" />
                <asp:BoundField DataField="Year" HeaderText="Year" SortExpression="Year" />
                <asp:BoundField DataField="Price" HeaderText="Price" SortExpression="Price" />
                <asp:ImageField DataImageUrlField="Image" HeaderText="Image" SortExpression="Image" />
            </Fields>
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
        </asp:DetailsView>
        </div>
    </form>

</asp:Content>
