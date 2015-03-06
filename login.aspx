<%@ Page Language="C#" MasterPageFile="~/publicmaster.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" width="100%" onload="SetStatus();">
        <tr>
            <td height="150px" valign="top">
                <table width="100%" height="130" border="0" cellpadding="0" cellspacing="0">
                    <tr bgcolor="#2B62AB">
                        <td style="width: 715px;">
                            <img border="0" src="web/images/banner.jpg" height="227" style="width: 633px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td id="loginContent" valign="top" height="100%">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                    <tr>
                        <td valign="top" rowspan="2">
                            <h1 style="padding-left: 18px;">
                                <br />
                                <asp:Literal ID="lblWelcome" runat="server" Text="Welcome to Globe Telecom e-Sourcing Portal"></asp:Literal>
                            </h1>
                            <p>
                                <asp:Literal ID="lblWelcomeContents" runat="server">The Internet has provided unique opportunities for Globe Telecom to   interact with its suppliers, and partners as closely as if they were a   single entity. Termed as the &quot;new economy&quot;, the company is enhancing its   procurement approach and infrastructure in order to maximize the   benefits that can be derived in participating in this collaborative   environment.<br />
<br />
Globe's e-Sourcing Portal was developed in order to   provide our partners an effective means of joining in an &quot;ecosystem&quot;   that simplifies the procurement processes. Our vision is to build an   environment that promotes stronger business relationship by utilizing   the advancement in communication technology and enterprise mobility --   truly, this is e-Commerce in action! </asp:Literal>
                            </p>
                            <table width="135" border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td width="135" align="center" valign="top">
                                        <!--script src="https://seal.verisign.com/getseal?host_name=e-sourcing.globe.com.ph&size=M&use_flash=YES&use_transparent=YES&lang=en"></script>
                                        <br />
                                        <a href="http://www.verisign.com/ssl/ssl-information-center/" target="_blank" style="color: #000000; text-decoration: none; font: bold 7px verdana,sans-serif; letter-spacing: .5px; text-align: center;
                                            margin: 0px; padding: 0px;">ABOUT SSL CERTIFICATES</a>
					-->
				    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" style="width: 250px; border-left: dashed 1px #dcdcdc;">
                            <asp:MultiView ID="mView" runat="server" ActiveViewIndex="0">
                                <asp:View ID="viewLogin" runat="server">
                                    <div>
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="itemDetails">
                                            <tr>
                                                <th height="20px">
                                                    &nbsp;Login</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Username:
                                                        <asp:TextBox runat="server" ID="txtUserName" TabIndex="1" Width="150px" CausesValidation="True" Text=""></asp:TextBox>&nbsp;
                                                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUserName" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator></label></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Password:
                                                        <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" TabIndex="2" Height="20px" Width="150px" CausesValidation="True" Text=""></asp:TextBox>&nbsp;
                                                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="*" SetFocusOnError="True" Text=""></asp:RequiredFieldValidator></label></td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <asp:Label runat="server" ID="txtNote" ForeColor="#FF0000" Style="font-weight: bold"></asp:Label><asp:LinkButton
                                                        ID="lnkForceLogout" runat="server" OnClick="lnkForceLogout_Click" Visible="False" CausesValidation="false">Yes</asp:LinkButton>
                                                        <asp:LinkButton ID="lnkForceLogoutNo" runat="server" Visible="False" OnClick="lnkForceLogoutNo_Click" CausesValidation="false">No</asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp; &nbsp;<input type="submit" id="btnLogin" name="btnLogin" value="Login" runat="server" onserverclick="btnLogin_Click" tabindex="3" />
                                                    <input type="reset" id="btnClear" value="Clear" runat="server" onclick="Focus2();" tabindex="4" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="middle">
                                                    &nbsp;&nbsp;
                                                    <asp:LinkButton ID="lnkForgotPwd" runat="server" ToolTip="Click here if you want to retrieve your password" CausesValidation="false" OnClick="lnkForgotPwd_Click">Forgot your password? Click Here</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:View>
                                <asp:View ID="viewForgot" runat="server">
                                    <div>
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="itemDetails">
                                            <tr>
                                                <th height="20px">
                                                    &nbsp;Forgot Password</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Username:
                                                        <asp:TextBox runat="server" ID="txtUserName2" TabIndex="1" Width="150px" CausesValidation="True"></asp:TextBox>&nbsp;
                                                        <asp:RequiredFieldValidator ID="rfvUserName2" runat="server" ControlToValidate="txtUserName2" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <asp:Label runat="server" ID="txtNote2" ForeColor="#FF0000" Style="font-weight: bold"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;&nbsp;<input type="submit" id="btnSend" name="btnSend" value="Send" runat="server" onserverclick="btnSend_Click" tabindex="2" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="middle">
                                                    &nbsp;&nbsp;
                                                    <asp:LinkButton ID="lnkBackToLogin" runat="server" ToolTip="Click here to go back to login page" CausesValidation="false" OnClick="lnkBackToLogin_Click">Back to Login</asp:LinkButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:View>
                                <asp:View ID="viewChangePassword" runat="server">
                                    <div>
                                        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="itemDetails">
                                            <tr>
                                                <th height="20px">
                                                    &nbsp;Change Password</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <p style="padding-left: 5px;">
                                                        This is your first time to login.
                                                        <br />
                                                        Please change your password.
                                                        <br />
                                                        Password must be:
                                                        <br />
                                                        &nbsp;» Atleast 7 characters<br />
                                                        &nbsp;» Contains atleast 1 letter<br />
                                                        &nbsp;» Contains atleast 1 number<br />
                                                        &nbsp;» Contains atleast 1
                                                        <asp:Label ID="Label1" runat="server" Text="symbol" ToolTip="Allowed Symbols (-,+,?,*,$,.,|,!,@,#,%,&,_,=,:,)" ForeColor="blue" Style="cursor: hand;"></asp:Label>
                                                        <br />
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Current Password:<br />
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        <asp:TextBox ID="txtCurrentPwd" runat="server" CausesValidation="True" TabIndex="1" Width="150px" TextMode="Password"></asp:TextBox>&nbsp;
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCurrentPwd" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        New Password:&nbsp;<br />
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        <asp:TextBox ID="txtNewPwd" runat="server" CausesValidation="True" TabIndex="1" Width="150px" TextMode="Password"></asp:TextBox>&nbsp;
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNewPwd" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <label>
                                                        Confirm Password:
                                                        <br />
                                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                        <asp:TextBox ID="txtConfirmPwd" runat="server" CausesValidation="True" TabIndex="1" Width="150px" TextMode="Password"></asp:TextBox>&nbsp;
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtConfirmPwd" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                    </label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <asp:CompareValidator ID="cvPasswordCompare" runat="server" ErrorMessage="Passwords doesn't match.<br />" Display="Dynamic" ControlToValidate="txtConfirmPwd" ControlToCompare="txtNewPwd"></asp:CompareValidator>
                                                    <asp:CustomValidator ID="cvVerifyPasswords" runat="server" ControlToValidate="txtCurrentPwd" Display="Dynamic" ErrorMessage="Invalid current password.<br />" OnServerValidate="cvVerifyPasswords_ServerValidate"
                                                        SetFocusOnError="True"></asp:CustomValidator></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                    <input type="submit" id="btnContinue" name="btnContinue" value="Continue" runat="server" onserverclick="btnContinue_Click" tabindex="2" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="middle">
                                                    &nbsp; &nbsp;&nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:View>
                            </asp:MultiView>
                        </td>
                    </tr>
                    <tr>
                        <td style="border-left: dashed 1px #dcdcdc; height: 200" align="center" valign="top">
                            <div style="font-family: Arial; font-size: 11px; color: Gray; width: 250px;">
                                This site is best viewed on Microsoft Internet Explorer 5/6.
                            </div>
                            <br />
                            <asp:AdRotator ID="adRotator" runat="server" AdvertisementFile="~/App_Data/ads.xml" Target="_blank" />
                            <br />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
