using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace siteSQL
{
    public partial class AccountPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bool loggedIn = (System.Web.HttpContext.Current.User != null) && System.Web.HttpContext.Current.User.Identity.IsAuthenticated;
            if (!loggedIn)
            {
                Response.Redirect("~/Home.aspx");
            }

            Session["userID"] = User.Identity.GetUserId();
            DataView dv = (DataView)accountData.Select(DataSourceSelectArguments.Empty);
            DataRowView drv = dv[0];

            if (Page.IsPostBack == false)
            {
                usernameText.Text = drv["userId"].ToString();
                emailText.Text = drv["UserName"].ToString();
                phoneText.Text = drv["PhoneNumber"].ToString();
                firstNameText.Text = drv["FirstName"].ToString();
                lastNameText.Text = drv["LastName"].ToString();
                addressText.Text = drv["Address"].ToString();
            }

        }

        protected void updateInfoButton_Click(object sender, EventArgs e)
        {
            string username = usernameText.Text;
            string email = emailText.Text;
            string phone = phoneText.Text;
            string firstName = firstNameText.Text;
            string lastName = lastNameText.Text;
            string address = addressText.Text;
            string userID = User.Identity.GetUserId();
            

            SqlConnection connection = new SqlConnection("Data Source=(LocalDb)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\aspnet-siteSQL-20230405080839.mdf;Initial Catalog=aspnet-siteSQL-20230405080839;Integrated Security=True");
            connection.Open();

            string sqlQuery = "UPDATE [AspNetUsers] SET [UserName] = @email, [userId] = @userId, [Email] = @email, [PhoneNumber] = @phone, [FirstName] = @firstName, [LastName] = @lastName,[Address] = @address WHERE ([Id] = @Id)";
            SqlCommand cmd = new SqlCommand(sqlQuery, connection);

            cmd.Parameters.AddWithValue("@userId", username);
            cmd.Parameters.AddWithValue("@email", email);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@firstName", firstName);
            cmd.Parameters.AddWithValue("@lastName", lastName);
            cmd.Parameters.AddWithValue("@address", address);
            cmd.Parameters.AddWithValue("@Id", userID);

            cmd.ExecuteNonQuery();

            connection.Close();
        }

        protected void logoutButton_Click(object sender, EventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
            Response.Redirect("~/Home.aspx");
        }

        protected void updateInfoButton_Click1(object sender, EventArgs e)
        {

        }
    }
}