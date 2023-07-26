using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PromericaLogin
{
    public partial class login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbConexion"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {


                string usuario = Usuario.Text;
                string pass = Password.Text;
                if (string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(pass))
                {
                    Label1.Text = "INGRESE USUARIO Y/0 CONTRASEÑA VALIDO";
                    Label1.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    con.Open();
                    string qry = $"select 'true' FROM Usuarios where UserName = '{usuario}' and Password= '{pass}'";
                    SqlCommand cmd = new SqlCommand(qry, con);

                    SqlDataReader drlector = cmd.ExecuteReader();
                    bool acceso = false;
                    if (drlector.HasRows)
                    {
                        while (drlector.Read())
                        {
                            var uno = drlector[0];
                            acceso = bool.Parse(drlector[0].ToString());
                        }
                    }

                    if (acceso)
                    {
                        Response.Redirect("Home.aspx");
                    }
                    else
                    {
                        Label1.Text = "Datos Incorrectos";
                        Label1.ForeColor = System.Drawing.Color.Red;

                    }

                    drlector.Close();
                    con.Close();
                }

            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

    }
}