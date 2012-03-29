<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PropertyPictures.aspx.cs"
    Inherits="RealEstateWebRole.Members.maps.PropertyPictures" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div>
        <asp:HiddenField runat="server" ID="hdfpropertyid" />
        <table>
            <tr>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server" /><br />
                    <br />
                </td>
                <td>
                    <asp:FileUpload ID="FileUpload2" runat="server" /><br />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:FileUpload ID="FileUpload3" runat="server" /><br />
                    <br />
                </td>
                <td>
                    <asp:FileUpload ID="FileUpload4" runat="server" /><br />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:FileUpload ID="FileUpload5" runat="server" /><br />
                    <br />
                </td>
                <td>
                    <asp:FileUpload ID="FileUpload6" runat="server" /><br />
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:FileUpload ID="FileUpload7" runat="server" /><br />
                    <br />
                </td>
                <td>
                    <asp:FileUpload ID="FileUpload8" runat="server" /><br />
                    <br />
                </td>
            </tr>
        </table>
        <asp:Label runat="server" ID="lblImages" Text="Your images has been successfully uploaded"
            Visible="false"></asp:Label>
        <div style="margin-top: 5px; margin-bottom: 10px">
            <asp:Button runat="server" Text="Upload Image" CausesValidation="false" ID="btnUploadImages"
                OnClick="UploadImages_Click" /></div>
        <div>
            <asp:ListView runat="server" ID="ltvThumbnail" GroupItemCount="2">
                <LayoutTemplate>
                    <table id="Table1" runat="server">
                        <tr runat="server" id="groupPlaceHolder">
                        </tr>
                    </table>
                </LayoutTemplate>
                <GroupTemplate>
                    <tr id="Tr1" runat="server">
                        <td runat="server" id="itemPlaceHolder">
                        </td>
                    </tr>
                </GroupTemplate>
                <ItemTemplate>
                    <td>
                        <asp:Image runat="server" ID="imgThumbnail" ImageUrl='<%#Eval("thumbnailblob") %>' />
                        <asp:ImageButton runat="server" OnClientClick="return confirm('Delete image?');"
                            ID="imgDelete" ImageUrl="~/Images/DeleteIcon.gif" CommandArgument='<%#Eval("ImageUrlID") %>'
                            OnClick="ImgThumbDelete_Click" />
                    </td>
                </ItemTemplate>
            </asp:ListView>
        </div>
    </div>
    </form>
</body>
</html>
