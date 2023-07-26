<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="PromericaLogin.login" %>


<!DOCTYPE html>
 
<html xmlns="http://www.w3.org/1999/xhtml">  
<head runat="server">  
    <title></title>  
    <style type="text/css">  .auto-style1 {  width: 100%;  }
    </style><link href="style.css" rel="stylesheet" />
</head>  
  <body>
    <div class="card">
      <form id="form1" runat="server" class="formData">
        <div>
          <table style="width: 100%" class="contentT">
            <h1>Login</h1>
 

            <tr>
              <td> Usuario:</td>
              <td>
                <asp:TextBox ID="Usuario" placeholder="Usuario" runat="server"></asp:TextBox>
              </td>
              <td> </td>
            </tr>
            <tr>
              <td>Password:</td>
              <td>
                <asp:TextBox ID="Password" TextMode="Password" runat="server" placeholder="password" ></asp:TextBox>
              </td>
              <td> </td>
            </tr>

            <tr>
              <td> </td>
              <td>
                <asp:Button class="btnLogin" ID="btnLogin" runat="server" Text="Acceder" onclick="btnLogin_Click"/>
              </td>
              <td> </td>
            </tr>
            <tr>
              <td> </td>
              <td>
                <asp:Label ID="Label1" runat="server" class="warningTitle" ></asp:Label>
              </td>
              <td> </td>
            </tr>
          </table>
        </div>
      </form>
    </div>
  </body>
</html>