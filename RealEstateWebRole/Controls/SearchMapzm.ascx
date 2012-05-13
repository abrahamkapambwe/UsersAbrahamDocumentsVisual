<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchMapzm.ascx.cs"
    Inherits="RealEstateWebRole.Controls.SearchMapzm" %>
<div class="map_search">
    <script type="text/javascript">
        function showArea(value) {
            switch (value) {
                case 1:
                    document.getElementById('gautenglink').style.border = '0px solid #bbb';
                    document.getElementById('gautenglink').style.background = '#FFFFFF'
                    break;
                case 2:
                    document.getElementById('kwazulunatallink').style.border = '0px solid #bbb';
                    document.getElementById('kwazulunatallink').style.background = '#FFFFFF'
                    break;
                case 3:
                    document.getElementById('easterncapelink').style.border = '0px solid #bbb';
                    document.getElementById('easterncapelink').style.background = '#FFFFFF'
                    break;
                case 4:
                    document.getElementById('mpumalangalink').style.border = '0px solid #bbb';
                    document.getElementById('mpumalangalink').style.background = '#FFFFFF'
                    break;
                case 5:
                    document.getElementById('limpopolink').style.border = '0px solid #bbb';
                    document.getElementById('limpopolink').style.background = '#FFFFFF'
                    break;
                case 6:
                    document.getElementById('freestatelink').style.border = '0px solid #bbb';
                    document.getElementById('freestatelink').style.background = '#FFFFFF'
                    break;
                case 7:
                    document.getElementById('northwestlink').style.border = '0px solid #bbb';
                    document.getElementById('northwestlink').style.background = '#FFFFFF'
                    break;
                case 8:
                    document.getElementById('northerncapelink').style.border = '0px solid #bbb';
                    document.getElementById('northerncapelink').style.background = '#FFFFFF'
                    break;
                case 9:
                    document.getElementById('westerncapelink').style.border = '0px solid #bbb';
                    document.getElementById('westerncapelink').style.background = '#FFFFFF'
                    break;
            }
        }
        function hideArea(value) {
            switch (value) {
                case 1:
                    document.getElementById('gautenglink').style.background = 'none';
                    document.getElementById('gautenglink').style.border = '0px solid #EAEAEA';
                    break;
                case 2:
                    document.getElementById('kwazulunatallink').style.background = 'none';
                    document.getElementById('kwazulunatallink').style.border = '0px solid #EAEAEA';
                    break;
                case 3:
                    document.getElementById('easterncapelink').style.background = 'none';
                    document.getElementById('easterncapelink').style.border = '0px solid #EAEAEA';
                    break;
                case 4:
                    document.getElementById('mpumalangalink').style.background = 'none';
                    document.getElementById('mpumalangalink').style.border = '0px solid #EAEAEA';
                    break;
                case 5:
                    document.getElementById('limpopolink').style.background = 'none';
                    document.getElementById('limpopolink').style.border = '0px solid #EAEAEA';
                    break;
                case 6:
                    document.getElementById('freestatelink').style.background = 'none';
                    document.getElementById('freestatelink').style.border = '0px solid #EAEAEA';
                    break;
                case 7:
                    document.getElementById('northwestlink').style.background = 'none';
                    document.getElementById('northwestlink').style.border = '0px solid #EAEAEA';
                    break;
                case 8:
                    document.getElementById('northerncapelink').style.background = 'none';
                    document.getElementById('northerncapelink').style.border = '0px solid #EAEAEA';
                    break;
                case 9:
                    document.getElementById('westerncapelink').style.background = 'none';
                    document.getElementById('westerncapelink').style.border = '0px solid #EAEAEA';
                    break;
            }
        }
    </script>
    <asp:Label runat="server" ID="lblTitle"></asp:Label>
    <div class="searchmaplinks" style="border: 0px">
        <table>
            <tr>
                <td style="width: 500px; margin-right: 30px">
                    <div style="font-size: 16px; color: #000000; font-weight: bolder; margin-bottom: 10px;
                        margin-left: 10px">
                        Featured Agent</div>
                    <br />
                    <asp:ListView runat="server" ID="ltvThumbnail" OnItemDataBound="ltvThumbnail_itemDataBound"
                        GroupItemCount="2">
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
                            <td style="padding: 5px">
                                <asp:HyperLink runat="server" Width="90px" Height="90px" ID="imgLogoEstate" />
                            </td>
                        </ItemTemplate>
                    </asp:ListView>
                    <div runat="server" visible="false">
                        <img src="/images/SouthAfricaMap.jpg" alt="South Africa" usemap="#imagemap" border="0" />
                        <map id="" name="imagemap">
                            <area alt="Eastern Cape" id="areaEasternCape" onmouseout="javascript:hideArea(3);"
                                onmouseover="javascript:showArea(3);" coords="225,204,225,211,219,215,202,228,194,236,182,240,183,248,171,259,187,268,193,277,207,280,243,274,284,245,319,219,311,207,301,196,304,207,292,201,286,196,273,207,265,199,251,204,231,202"
                                href="../Public/SearchResult?SearchTerm=Eastern Cape&SearchType=5" shape="poly" />
                            <area alt="KwaZulu Natal" id="areaNatal" coords="316,131,316,145,304,157,310,166,306,179,299,193,313,192,328,211,345,176,369,157,376,122,366,119,359,129"
                                href="../Public/SearchResult?SearchTerm=KwaZulu Natal&SearchType=5" shape="poly"
                                onmouseover="javascript:showArea(2);" onmouseout="javascript:hideArea(2);" />
                            <area alt="Free State" id="areaFreeState" onmouseover="javascript:showArea(6);" onmouseout="javascript:hideArea(6);"
                                coords="220,140,218,158,211,171,231,193,253,194,269,189,262,170,289,148,301,152,313,126,287,115,262,111,237,129,224,136"
                                href="../Public/SearchResult?SearchTerm=Free State&SearchType=5" shape="poly" />
                            <area alt="Gauteng" id="areaGauteng" onmouseover="javascript:showArea(1);" onmouseout="javascript:hideArea(1);"
                                coords="290,76,277,84,259,89,267,107,294,113,311,98" href="../Public/SearchResult?SearchTerm=Gauteng&SearchType=5"
                                shape="poly" />
                            <area alt="Mpumalanga" id="areaMpumalanga" onmouseover="javascript:showArea(4);"
                                onmouseout="javascript:hideArea(4);" coords="296,79,310,68,322,76,344,61,351,73,361,73,356,53,367,54,373,77,401,77,401,92,382,90,376,97,381,111,379,115,367,114,370,97,351,89,343,102,347,123,329,126,316,123,297,115,312,98"
                                href="../Public/SearchResult.aspx?SearchTerm=Mpumalanga&SearchType=5" shape="poly" />
                            <area alt="Limpopo" id="areaLimpopo" onmouseover="javascript:showArea(5);" onmouseout="javascript:hideArea(5);"
                                coords="252,61,288,73,310,63,321,69,342,56,366,46,354,12,316,6,297,14,273,27"
                                href="../Public/SearchResult.aspx&SearchType=5" shape="poly" />
                            <area alt="North West" id="areaNorthWest" onmouseover="javascript:showArea(7);" onmouseout="javascript:hideArea(7);"
                                coords="166,97,179,109,186,121,217,137,263,107,254,88,275,82,282,76,240,62,226,82,210,85,179,72"
                                href="../Public/SearchResult?SearchTerm=North West&SearchType=5" shape="poly" />
                            <area alt="Northern Cape" id="areaNorthernCape" onmouseover="javascript:showArea(8);"
                                onmouseout="javascript:hideArea(8);" coords="45,154,74,207,89,191,106,238,115,232,125,248,159,217,174,223,184,219,197,219,222,199,199,175,207,159,207,141,178,122,162,102,140,115,127,110,125,100,127,81,112,64,112,144,99,159,83,159,67,152,58,141"
                                href="../Public/SearchResult?SearchTerm=Northern Cape&SearchType=5" shape="poly" />
                            <area alt="Western Cape" id="areaWesternCape" onmouseover="javascript:showArea(9);"
                                onmouseout="javascript:hideArea(9);" coords="70,214,82,241,75,256,89,278,114,297,127,285,149,282,180,278,164,258,174,244,174,234,184,234,181,226,165,226,156,225,126,254,114,239,105,244,88,202"
                                href="../Public/SearchResult?SearchTerm=Western Cape&SearchType=5" shape="poly" />
                        </map>
                    </div>
                </td>
                <td class="searchprovince" style="background: #fff; background-image: none; border: 0px">
                    <div style="padding: 10px">
                        <div id="gautenglink">
                            <a class="search_links" href="../Public/SearchResult.aspx?SearchTerm=Lusaka&SearchType=5">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Lusaka </a>
                        </div>
                        <div id="kwazulunatallink">
                            <a class="search_links" href="../Public/SearchResult.aspx?SearchTerm=Copperbelt&SearchType=5">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copperbelt</a>
                        </div>
                        <div id="easterncapelink">
                            <a class="search_links" href="../Public/SearchResult.aspx?SearchTerm=Eastern&SearchType=5">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Eastern</a>
                        </div>
                        <div id="mpumalangalink">
                            <a class="search_links" href="../Public/SearchResult.aspx?SearchTerm=Luapula&SearchType=5">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Luapula</a>
                        </div>
                        <div id="limpopolink">
                            <a class="search_links" href="../Public/SearchResult.aspx?SearchTerm=NorthWest&SearchType=5">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;North West</a></div>
                        <div id="freestatelink">
                            <a class="search_links" href="../Public/SearchResult.aspx?SearchTerm=Northern&SearchType=5">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Northern</a></div>
                        <div id="northwestlink">
                            <a class="search_links" href="../Public/SearchResult.aspx?SearchTerm=Western&SearchType=5">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Western</a>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</div>
